import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DashBoardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        backgroundColor: Colors.white.withOpacity(0),
        elevation: 5,
      ),
      body: Container(
        child: Text('dashboard'),
      ),
    );
  }
}
