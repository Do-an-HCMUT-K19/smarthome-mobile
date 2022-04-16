import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:smart_home/models/return_msg.dart';
import 'package:smart_home/models/sensor_info.dart';
import 'package:smart_home/models/sensor_list.dart';
import 'package:smart_home/models/statistic_data.dart';
import 'package:smart_home/models/timer.dart';
import 'package:smart_home/models/timer_info.dart';
import 'package:smart_home/models/timer_list.dart';
import 'package:smart_home/models/user_info.dart';
import 'package:smart_home/models/statistic_logsensor_data.dart';
import 'package:intl/intl.dart';

class FirebaseUtils {
  // request: JSON(AccountName, Password)
  static signIn(request) async {
    if (request["AccountName"] == null) {
      return ReturnMessage(400, "Missing Account Name Value");
    } else if (request["Password"] == null) {
      return ReturnMessage(400, "Missing Password Value");
    }

    var bytes = utf8.encode(request['Password']);
    var pwd = sha256.convert(bytes);

    var querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('account_name', isEqualTo: request['AccountName'])
        .get();

    if (querySnapshot.docs.isEmpty) {
      return ReturnMessage(200, "User doesn't exists");
    } else {
      if (pwd.toString() == querySnapshot.docs[0]["password"]) {
        print(querySnapshot.docs[0]["first_name"]);
        return ReturnMessage.data(
            200,
            "Login Successfully",
            UserInform(
                querySnapshot.docs[0]["account_name"],
                querySnapshot.docs[0]["first_name"],
                querySnapshot.docs[0]["last_name"]));
      } else {
        return ReturnMessage(200, "Wrong Password");
      }
    }
  }

  // request: JSON(AccountName, Password, FirstName, LastName)
  static signUp(request) async {
    if (request["AccountName"] == null) {
      return ReturnMessage(400, "Missing Account Name Value");
    } else if (request["Password"] == null) {
      return ReturnMessage(400, "Missing Password Value");
    }

    var querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('account_name', isEqualTo: request['AccountName'])
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      return ReturnMessage(200, "User exists");
    } else {
      var bytes = utf8.encode(request['Password']);
      var pwd = sha256.convert(bytes);

      FirebaseFirestore.instance.collection("users").add({
        "account_name": request['AccountName'],
        "password": pwd.toString(),
        "first_name": request["FirstName"],
        "last_name": request["LastName"]
      });

      return ReturnMessage(200, "Sign up Successfully");
    }
  }

  // request: JSON(AccountName)
  static getUserInform(request) async {
    if (request["AccountName"] == null) {
      return ReturnMessage(400, "Missing Account Name Value");
    }

    var querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('account_name', isEqualTo: request['AccountName'])
        .get();

    if (querySnapshot.docs.isEmpty) {
      return ReturnMessage(200, "User not found");
    } else {
      return ReturnMessage.data(
          200,
          "User exists",
          UserInform(
              querySnapshot.docs[0]["account_name"],
              querySnapshot.docs[0]["first_name"],
              querySnapshot.docs[0]["last_name"]));
    }
  }

  // request: JSON(AirHumidity, EnvTemperature, LandHumidity, AccountName)
  static addRealtimeDatabase(request) async {
    var timestamp = Timestamp.now();

    if (request['AirHumidity'] == null) {
      return ReturnMessage(400, 'Missing Air Humidity Value');
    } else if (request['EnvTemperature'] == null) {
      return ReturnMessage(400, 'Missing Environment Temperature Value');
    } else if (request['LandHumidity'] == null) {
      return ReturnMessage(400, 'Missing Land Humidity Value');
    } else if (request['AccountName'] == null) {
      return ReturnMessage(400, 'Missing Account Name Value');
    }

    await FirebaseFirestore.instance.collection('realtime_db').add({
      'timestamp': timestamp,
      'air_humidity': request['AirHumidity'],
      'env_temperature': request['EnvTemperature'],
      'land_humidity': request['LandHumidity'],
      'account_name': request['AccountName'],
      'area': request['Area'],
    });

    return ReturnMessage(200, 'Add Data Successfully');
  }

  // request: JSON(AccountName)
  static getLastestRealtimeDatabase(request) async {
    if (request["AccountName"] == null) {
      return ReturnMessage(400, "Missing Account Name Value");
    }

    Stream<QuerySnapshot> realtimeChanges = FirebaseFirestore.instance
        .collection('realtime_db')
        .where('account_name', isEqualTo: request['AccountName'])
        .where('area', isEqualTo: request['Area'])
        .orderBy('timestamp', descending: true)
        .limit(1)
        .snapshots(includeMetadataChanges: true);

    return ReturnMessage.data(200, "Get Data Successfully", realtimeChanges);
  }

  static getStatisticData(request) async {
    if (request["AccountName"] == null) {
      return ReturnMessage(400, "Missing Account Name Value");
    } else if (request['Timestamp'] == null) {
      return ReturnMessage(400, 'Missing timestamp');
    } else if (request['Area'] == null) {
      return ReturnMessage(400, 'Missing area');
    }

    // double a = 5.toDouble()

    var querySnapshot = await FirebaseFirestore.instance
        .collection('realtime_db')
        .where('account_name', isEqualTo: request['AccountName'])
        .where('area', isEqualTo: request['Area'])
        // .where('timestamp', isLessThan: request['Timestamp'])
        .get();

    List<EnvData> rsTmp = [];
    querySnapshot.docs.forEach(
      (element) {
        if (element['timestamp'].compareTo(request['Timestamp']) < 0) {
          rsTmp.add(EnvData(
              hour: element['timestamp'].toDate().hour,
              humid: element['air_humidity'].toDouble(),
              temp: element['env_temperature'].toDouble()));
        }
      },
    );

    if (rsTmp.isEmpty) return ReturnMessage(200, []);
    rsTmp.sort((a, b) => a.hour.compareTo(b.hour));
    List<EnvData> rs = [];
    int curHour = rsTmp[0].hour;
    double sumHumid = 0;
    double sumTemp = 0;
    int count = 0;
    for (var i in rsTmp) {
      if (curHour == i.hour) {
        count++;
        sumHumid += i.humid;
        sumTemp += i.temp;
      } else {
        rs.add(EnvData(
          hour: curHour,
          temp: sumTemp / count,
          humid: sumHumid / count,
        ));
        count = 1;
        curHour = i.hour;
        sumHumid = i.humid;
        sumTemp = i.temp;
      }
    }
    rs.add(EnvData(
      hour: curHour,
      temp: sumTemp / count,
      humid: sumHumid / count,
    ));
    rs.sort((a, b) => a.hour.compareTo(b.hour));
    return ReturnMessage(200, rs);
  }

  // request: JSON(AccountName)
  static getAllSensors(request) async {
    if (request["AccountName"] == null) {
      return ReturnMessage(400, "Missing Account Name Value");
    }

    var querySnapshot = await FirebaseFirestore.instance
        .collection('sensor_information')
        .where('account_name', isEqualTo: request['AccountName'])
        .get();

    List<SensorInform> sensors = [];

    querySnapshot.docs.forEach((snapshot) {
      sensors.add(SensorInform(snapshot["area"], snapshot["name"],
          snapshot["sensor_id"], snapshot["account_name"], snapshot["state"]));
    });

    return ReturnMessage.data(
        200, "Get Information Successfully", Sensors(sensors));
  }

  // request: JSON(AccountName, Area)
  // Area: ['living_room', 'bedroom', 'kitchen', 'garden', 'bathroom']
  static getAreaSensors(request) async {
    List<String> rooms = [
      'living_room',
      'bed_room',
      'kitchen',
      'garden',
      'bath_room'
    ];

    if (request["AccountName"] == null) {
      return ReturnMessage(400, "Missing Account Name Value");
    } else if (request["Area"] == null) {
      return ReturnMessage(400, "Missing Area Value");
    } else if (!rooms.contains(request["Area"])) {
      return ReturnMessage(400, "Wrong Area Parameter");
    }

    var querySnapshot = await FirebaseFirestore.instance
        .collection('sensor_information')
        .where('account_name', isEqualTo: request['AccountName'])
        .where('area', isEqualTo: request['Area'])
        .snapshots();

    List<SensorInform> sensors = [];
    querySnapshot.listen((event) {
      print(event);
    });

    // querySnapshot.docs.forEach((snapshot) {
    //   sensors.add(SensorInform(snapshot["area"], snapshot["name"],
    //       snapshot["sensor_id"], snapshot["account_name"], snapshot["state"]));
    // });

    // return ReturnMessage.data(
    //     200, "Get Information Successfully", Sensors(sensors));
    return ReturnMessage.data(200, "Get info success", querySnapshot);
  }

  // request: JSON(AccountName)
  static getAllTimers(request) async {
    if (request["AccountName"] == null) {
      return ReturnMessage(400, "Missing Account Name Value");
    }

    var querySnapshot = await FirebaseFirestore.instance
        .collection('timer')
        .where('account_name', isEqualTo: request['AccountName'])
        .get();

    List<Timer> timers = [];
    querySnapshot.docs.forEach((snapshot) {
      timers.add(Timer(
        id: snapshot['timer_id'],
        dayOfWeek: snapshot['timestamp'],
        duration: Duration(hours: snapshot['duration']),
        isAutoOff: snapshot['state'] == 'off',
        name: snapshot['name'],
        sensor_id: snapshot['sensor_id'],
        timeOfDay: snapshot['time_of_day'],
      ));
    });

    return ReturnMessage.data(200, "Get Timer Successfully", timers);
  }

  // request: JSON(AccountName, Duration, Frequency, State, SensorId)
  // State: ['on', 'off']
  static setTimer(request) async {
    List<String> states = ['on', 'off'];

    if (request["AccountName"] == null) {
      return ReturnMessage(400, "Missing Account Name Value");
    } else if (request["Duration"] == null) {
      return ReturnMessage(400, "Missing Duration Value");
    } else if (request["State"] == null) {
      return ReturnMessage(400, "Missing State Value");
    } else if (request["SensorId"] == null) {
      return ReturnMessage(400, "Missing SensorId Value");
    } else if (!states.contains(request['State'])) {
      return ReturnMessage(400, "Wrong State Parameter");
    }

    var querySnapshot = await FirebaseFirestore.instance
        .collection('sensor_information')
        .where('account_name', isEqualTo: request['AccountName'])
        .where('sensor_id', isEqualTo: request['SensorId'])
        .get();

    if (querySnapshot.docs.length == 0) {
      return ReturnMessage(200, "Sensor doesn't exists");
    } else {
      await FirebaseFirestore.instance.collection('timer').add({
        "account_name": request["AccountName"],
        "duration": request["Duration"],
        "timestamp": request["DateOfWeek"],
        "last_record": Timestamp.now(),
        "state": request["State"],
        "sensor_id": request["SensorId"],
        "timer_id": request["TimerId"],
        "name": request["Name"],
        "time_of_day": request["TimeOfDay"],
      });
    }

    return ReturnMessage(200, "Set Timer Successfully");
  }

  // request: JSON(ID)
  static deleteTimer(request) async {
    if (request["ID"] == null) {
      return ReturnMessage(400, "Missing Timer ID Value");
    }

    var tmp = await FirebaseFirestore.instance
        .collection('timer')
        .where('timer_id', isEqualTo: request['ID'])
        .limit(1)
        .get();

    await FirebaseFirestore.instance
        .collection('timer')
        .doc(tmp.docs[0].id)
        .delete();

    return ReturnMessage(200, "Delete Timer Successfully");
  }

  // request: JSON(AccountName, SensorId)
  static turnOnSensor(request) async {
    if (request["AccountName"] == null) {
      return ReturnMessage(400, "Missing Account Name Value");
    } else if (request["SensorId"] == null) {
      return ReturnMessage(400, "Missing SensorId Value");
    }

    var querySnapshot = await FirebaseFirestore.instance
        .collection('sensor_information')
        .where('account_name', isEqualTo: request['AccountName'])
        .where('sensor_id', isEqualTo: request['SensorId'])
        .get();

    if (querySnapshot.docs[0]['state'] == 'on') {
      return ReturnMessage(200, "Sensor has turned on already");
    }

    await FirebaseFirestore.instance.collection('log_sensor').add({
      'account_name': request['AccountName'],
      'duration': -1,
      'sensor_id': request['SensorId'],
      'time_start': Timestamp.now()
    });

    await FirebaseFirestore.instance
        .collection('sensor_information')
        .doc(querySnapshot.docs[0].id)
        .update({'state': 'on'});

    return ReturnMessage(200, "Turn On Successfully");
  }

  // request: JSON(AccountName, SensorId)
  static turnOffSensor(request) async {
    if (request["AccountName"] == null) {
      return ReturnMessage(400, "Missing Account Name Value");
    } else if (request["SensorId"] == null) {
      return ReturnMessage(400, "Missing SensorId Value");
    }

    var query = await FirebaseFirestore.instance
        .collection('sensor_information')
        .where('account_name', isEqualTo: request['AccountName'])
        .where('sensor_id', isEqualTo: request['SensorId'])
        .get();

    if (query.docs[0]['state'] == 'off') {
      return ReturnMessage(200, "Sensor has turned off already");
    }

    var querySnapshot = await FirebaseFirestore.instance
        .collection('log_sensor')
        .where('account_name', isEqualTo: request['AccountName'])
        .where('sensor_id', isEqualTo: request['SensorId'])
        .orderBy('time_start', descending: true)
        .limit(1)
        .get();

    var id = querySnapshot.docs[0].id;
    var start_time = querySnapshot.docs[0]['time_start'].toDate();
    var current_time = Timestamp.now().toDate();
    var duration = current_time.difference(start_time).inSeconds;

    await FirebaseFirestore.instance
        .collection('log_sensor')
        .doc(id)
        .update({'duration': duration});

    await FirebaseFirestore.instance
        .collection('sensor_information')
        .doc(query.docs[0].id)
        .update({'state': 'off'});

    return ReturnMessage(200, "Turn Off Successfully");
  }

  // request: JSON(AccountName, SensorId, LandHumidity)
  static setTargetEnv(request) async {
    if (request["AccountName"] == null) {
      return ReturnMessage(400, "Missing Account Name Value");
    } else if (request["SensorId"] == null) {
      return ReturnMessage(400, "Missing SensorId Value");
    } else if (request["LandHumidity"] == null) {
      return ReturnMessage(400, "Missing Land Humidity Value");
    }

    var query = await FirebaseFirestore.instance
        .collection("target_env")
        .where("account_name", isEqualTo: request["AccountName"])
        .where("sensor_id", isEqualTo: request["SensorId"])
        .get();

    if (query.docs.isEmpty) {
      await FirebaseFirestore.instance.collection("target_env").add({
        "account_name": request["AccountName"],
        "sensor_id": request["SensorId"],
        "land_humidity": request["LandHumidity"]
      });
    } else {
      await FirebaseFirestore.instance
          .collection("target_env")
          .doc(query.docs[0].id)
          .update({"land_humidity": request["LandHumidity"]});
    }
    return ReturnMessage(200, "Set Target Environment Successfully");
  }

  // request: JSON(AccountName, SensorId)
  static getTargetEnv(request) async {
    if (request["AccountName"] == null) {
      return ReturnMessage(400, "Missing Account Name Value");
    } else if (request["SensorId"] == null) {
      return ReturnMessage(400, "Missing SensorId Value");
    }

    var querySnapshot = await FirebaseFirestore.instance
        .collection("target_env")
        .where("account_name", isEqualTo: request["AccountName"])
        .where("sensor_id", isEqualTo: request["SensorId"])
        .snapshots();

    return ReturnMessage.data(
        200, "Get Target Environment Successfully", querySnapshot);
  }

  // request: JSON(AccountName)
  static getStatisticLogSensor(request) async {
    if (request["AccountName"] == null) {
      return ReturnMessage(400, "Missing Account Name Value");
    }

    var querySnapshot = await FirebaseFirestore.instance
        .collection("log_sensor")
        .where("account_name", isEqualTo: request["AccountName"])
        .orderBy("time_start", descending: true)
        .get();

    List<LogSensorData> sensors_data = [];

    for (var snapshot in querySnapshot.docs) {
      var sensor_id = snapshot["sensor_id"];
      bool check = false;

      for (var sensor_data in sensors_data) {
        if (sensor_data.sensor_id == sensor_id) {
          check = true;
          bool check_date = false;
          var time_start =
              DateFormat('dd/MM/yyyy').format(snapshot["time_start"].toDate());

          for (var time_duration in sensor_data.sensor_data) {
            if (time_duration.date == time_start) {
              check_date = true;
              time_duration.duration += snapshot["duration"];
            }
          }

          if (!check_date) {
            sensor_data.sensor_data
                .add(TimeDuration(time_start, snapshot["duration"]));
          }
        }
      }

      if (!check) {
        sensors_data.add(LogSensorData(sensor_id, [
          TimeDuration(
              DateFormat('dd/MM/yyyy').format(snapshot["time_start"].toDate()),
              snapshot["duration"])
        ]));
      }
    }

    return ReturnMessage.data(
        200, "Get Log Sensor Data Successfully", sensors_data);
  }
}
