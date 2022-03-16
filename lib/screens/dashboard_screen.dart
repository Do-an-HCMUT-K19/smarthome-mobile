import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DashBoardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 75,
        bottomOpacity: 0,
        title: Text('Dashboard'),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Container(
        child: Center(
            child: Text(
          'dashboard',
          style: TextStyle(fontSize: 40),
        )),
      ),
    );
  }
}
