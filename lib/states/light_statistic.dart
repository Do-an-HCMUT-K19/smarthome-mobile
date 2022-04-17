import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:smart_home/constants/room_type.dart';
import 'package:smart_home/models/return_msg.dart';
import 'package:smart_home/models/statistic_logsensor_data.dart';
import 'package:smart_home/utils/firebase_utils.dart';

class LightStatistic with ChangeNotifier {
  int a = 0;
  Map<RoomType, Map<String, int>> data = {
    RoomType.livingRoom: {},
    RoomType.bedRoom: {},
    RoomType.bathRoom: {},
    RoomType.kitChen: {},
    RoomType.garden: {},
  };
  LightStatistic() {
    initData();
  }

  Future<void> initData() async {
    ReturnMessage msg =
        await FirebaseUtils.getStatisticLogSensor({'AccountName': 'giacat'});
    List<LogSensorData> dataList = msg.data;
    dataList.sort((a, b) => a.sensor_id.compareTo(b.sensor_id));
    List<String> dateList = [];
    for (var i = 0; i < 7; i++) {
      String tmpKey = DateFormat('yyyy-MM-dd')
          .format(DateTime.now().subtract(Duration(days: i)));
      data[RoomType.livingRoom]![tmpKey] = 0;
      data[RoomType.bedRoom]![tmpKey] = 0;
      data[RoomType.bathRoom]![tmpKey] = 0;
      data[RoomType.kitChen]![tmpKey] = 0;
      data[RoomType.garden]![tmpKey] = 0;
      dateList.add(tmpKey);
    }

    dataList.forEach((element) {
      element.sensor_data.forEach((subElement) {
        String tmpDate = DateFormat('yyyy-MM-dd').format(subElement.date);
        if (element.sensor_id <= 4 &&
            dateList.contains(tmpDate) &&
            data[RoomType.livingRoom]![tmpDate] != null) {
          data[RoomType.livingRoom]![tmpDate] =
              subElement.duration.toInt() + data[RoomType.livingRoom]![tmpDate];
        } else if (element.sensor_id > 4 &&
            element.sensor_id <= 8 &&
            dateList.contains(tmpDate) &&
            data[RoomType.bedRoom]![tmpDate] != null) {
          data[RoomType.bedRoom]![tmpDate] =
              subElement.duration.toInt() + data[RoomType.bedRoom]![tmpDate];
        } else if (element.sensor_id > 8 &&
            element.sensor_id <= 12 &&
            dateList.contains(tmpDate) &&
            data[RoomType.bathRoom]![tmpDate] != null) {
          data[RoomType.bathRoom]![tmpDate] =
              subElement.duration.toInt() + data[RoomType.bathRoom]![tmpDate];
        } else if (element.sensor_id > 12 &&
            element.sensor_id <= 16 &&
            dateList.contains(tmpDate) &&
            data[RoomType.kitChen]![tmpDate] != null) {
          data[RoomType.kitChen]![tmpDate] =
              subElement.duration.toInt() + data[RoomType.kitChen]![tmpDate];
        } else if (element.sensor_id > 16 &&
            element.sensor_id <= 18 &&
            dateList.contains(tmpDate) &&
            data[RoomType.garden]![tmpDate] != null) {
          data[RoomType.garden]![tmpDate] =
              subElement.duration.toInt() + data[RoomType.garden]![tmpDate];
        }
      });
    });
  }

  List<int> getLightData(RoomType roomType) {
    List<int> rs = [];
    for (int i = 0; i < 7; i++) {
      String tmpKey = DateFormat('yyyy-MM-dd')
          .format(DateTime.now().subtract(Duration(days: i)));
      if (data[roomType]![tmpKey] == null) {
        rs.add(0);
      } else {
        rs.add(data[roomType]![tmpKey]!.toInt());
      }
    }

    return rs.reversed.toList();
  }
}
