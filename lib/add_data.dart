import 'package:cloud_firestore/cloud_firestore.dart';

// LivingroomScreen(),
// BedroomScreen(),
// BathroomScreen(),
// KitchenScreen(),
// GardenScreen(),

void add_data() {
  FirebaseFirestore.instance.collection('sensor_information').add({
    'account_name': 'giacat',
    'area': 'living_room',
    'name': 'Máy 1',
    'sensor_id': 1
  });

  FirebaseFirestore.instance.collection('sensor_information').add({
    'account_name': 'giacat',
    'area': 'living_room',
    'name': 'Máy 2',
    'sensor_id': 2
  });

  FirebaseFirestore.instance.collection('sensor_information').add({
    'account_name': 'giacat',
    'area': 'bed_room',
    'name': 'Máy 1',
    'sensor_id': 3
  });

  FirebaseFirestore.instance.collection('sensor_information').add({
    'account_name': 'giacat',
    'area': 'kitchen',
    'name': 'Máy 1',
    'sensor_id': 4
  });

  FirebaseFirestore.instance.collection('sensor_information').add({
    'account_name': 'giacat',
    'area': 'garden',
    'name': 'Máy 1',
    'sensor_id': 5
  });

  FirebaseFirestore.instance.collection('sensor_information').add({
    'account_name': 'hongphucvo',
    'area': 'living_room',
    'name': 'Máy 1',
    'sensor_id': 1
  });

  FirebaseFirestore.instance.collection('sensor_information').add({
    'account_name': 'hongphucvo',
    'area': 'living_room',
    'name': 'Máy 2',
    'sensor_id': 2
  });

  FirebaseFirestore.instance.collection('sensor_information').add({
    'account_name': 'hongphucvo',
    'area': 'bed_room',
    'name': 'Máy 1',
    'sensor_id': 3
  });

  FirebaseFirestore.instance.collection('sensor_information').add({
    'account_name': 'hongphucvo',
    'area': 'kitchen',
    'name': 'Máy 1',
    'sensor_id': 4
  });

  FirebaseFirestore.instance.collection('sensor_information').add({
    'account_name': 'hongphucvo',
    'area': 'garden',
    'name': 'Máy 1',
    'sensor_id': 5
  });

  FirebaseFirestore.instance.collection('timer').add({
    'account_name': 'giacat',
    'delete_state': false,
    'duration': 2,
    'frequency': 4,
    'last_record': Timestamp.now(),
    'sensor_id': 1,
    'state': 'on',
    'timestamp': Timestamp.now()
  });

  FirebaseFirestore.instance.collection('timer').add({
    'account_name': 'giacat',
    'delete_state': false,
    'duration': 2,
    'frequency': 4,
    'last_record': Timestamp.now(),
    'sensor_id': 2,
    'state': 'off',
    'timestamp': Timestamp.now()
  });

  FirebaseFirestore.instance.collection('timer').add({
    'account_name': 'giacat',
    'delete_state': false,
    'duration': 2,
    'frequency': 4,
    'last_record': Timestamp.now(),
    'sensor_id': 4,
    'state': 'off',
    'timestamp': Timestamp.now()
  });

  FirebaseFirestore.instance.collection('timer').add({
    'account_name': 'hongphucvo',
    'delete_state': false,
    'duration': 2,
    'frequency': 4,
    'last_record': Timestamp.now(),
    'sensor_id': 1,
    'state': 'on',
    'timestamp': Timestamp.now()
  });
}
