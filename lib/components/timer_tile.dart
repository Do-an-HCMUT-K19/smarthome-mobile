import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/src/provider.dart';
import 'package:smart_home/models/timer.dart';
import 'package:smart_home/states/timer.dart';

class TimerTile extends StatelessWidget {
  final Timer timer;
  const TimerTile({required this.timer, Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var dateTimeString = DateFormat.MEd().add_jms().format(timer.dateTime);
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      height: size.height * 0.15,
      width: size.width * 0.9,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Text(
                  'Bulb timer no.${timer.idx + 1}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                  ),
                ),
                margin: EdgeInsets.only(left: 30),
              ),
              IconButton(
                onPressed: () {
                  context.read<TimerState>().removeTimer(timer.idx);
                },
                icon: Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                '${dateTimeString}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
              Text(
                '${timer.duration.inHours} hour(s)',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
              Text(
                timer.isAutoOff ? 'Auto off' : 'Auto on',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
            ],
          ),
          // SizedBox(
          //   height: 10,
          // ),
        ],
      ),
      decoration: BoxDecoration(
          color: Color(0xff25214D),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.25),
              spreadRadius: 5,
              blurRadius: 10,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ]),
    );
  }
}
