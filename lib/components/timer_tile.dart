import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/src/provider.dart';
import 'package:smart_home/constants/room_type.dart';
import 'package:smart_home/models/timer.dart';
import 'package:smart_home/states/timer.dart';

class TimerTile extends StatelessWidget {
  final RoomType roomType;
  final Timer timer;
  const TimerTile({
    required this.timer,
    required this.roomType,
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      height: size.height * 0.15,
      width: size.width * 0.85,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Text(
                  '${timer.name}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                  ),
                ),
                margin: EdgeInsets.only(left: 30),
              ),
              IconButton(
                onPressed: () {
                  context
                      .read<TimerState>()
                      .removeTimer(id: timer.id, roomType: roomType);
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
              Row(
                children: [
                  Text(
                    timer.dayOfWeek,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    timer.timeOfDay,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ],
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
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 0), // changes position of shadow
            ),
          ]),
    );
  }
}
