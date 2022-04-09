import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/src/provider.dart';
import 'package:smart_home/constants/color.dart';
import 'package:smart_home/constants/room_type.dart';
import 'package:smart_home/states/timer_state.dart';

class NewAlarmDialog extends StatefulWidget {
  final RoomType roomType;
  const NewAlarmDialog({
    Key? key,
    required this.roomType,
  }) : super(key: key);

  @override
  State<NewAlarmDialog> createState() => _NewAlarmDialogState();
}

class _NewAlarmDialogState extends State<NewAlarmDialog> {
  String chosenDate = '';
  TimeOfDay chosenTime = TimeOfDay.now();
  int durations = 0;
  bool isTurnOff = true;
  String chosenName = 'Bulb #1';
  List<String> dateOfWeek = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

  void _showTimePicker() {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((value) {
      if (value != null) {
        chosenTime = value;
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    chosenDate =
        chosenDate == '' ? dateOfWeek[DateTime.now().weekday - 1] : chosenDate;
    String timeString = chosenTime.format(context);
    return AlertDialog(
      actionsAlignment: MainAxisAlignment.spaceEvenly,
      actions: [
        TextButton(
          onPressed: () {
            context.read<TimerState>().addTimer(
                dayOfWeek: chosenDate,
                duration: durations,
                isAutoOff: isTurnOff,
                name: chosenName,
                roomType: widget.roomType,
                timeOfDay: chosenTime.format(context));
            Navigator.of(context).pop();
          },
          child: const Text(
            'Confirm',
            style: TextStyle(fontSize: 25),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(
            'Cancel',
            style: TextStyle(fontSize: 25),
          ),
        ),
      ],
      content: SizedBox(
          height: 300,
          width: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  Text('Bulb'),
                  SizedBox(
                    width: 50,
                  ),
                  Container(
                    width: size.width * 0.4,
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: chosenName,
                      icon: const Icon(Icons.arrow_drop_down),
                      elevation: 16,
                      style: const TextStyle(
                        color: Colors.deepPurple,
                        fontSize: 16,
                      ),
                      underline: Container(
                        height: 2,
                        color: Colors.deepPurpleAccent,
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          chosenName = newValue!;
                        });
                      },
                      items: context
                          .read<TimerState>()
                          .getBulbList(widget.roomType)
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 15),
                width: size.width * 0.8,
                child: SingleChildScrollView(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: dateOfWeek
                        .map((e) => GestureDetector(
                              onTap: () {
                                chosenDate = e;
                                print(e);
                                setState(() {});
                              },
                              child: Container(
                                child: Text(e),
                                decoration: chosenDate == e
                                    ? BoxDecoration(
                                        color: Colors.blue.withOpacity(0.5))
                                    : null,
                              ),
                            ))
                        .toList(),
                  ),
                ),
              ),
              Row(
                children: [
                  Text('Time'),
                  const SizedBox(
                    width: 70,
                  ),
                  GestureDetector(
                    onTap: () => _showTimePicker(),
                    child: Text(timeString),
                  ),
                ],
              ),
              Row(
                children: [
                  const Text('Turn off'),
                  const SizedBox(
                    width: 30,
                  ),
                  Switch(
                    value: isTurnOff,
                    onChanged: (value) {
                      isTurnOff = value;
                      setState(() {});
                    },
                  )
                ],
              ),
              Row(
                children: [
                  const Text('Duration'),
                  const SizedBox(
                    width: 30,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.blue,
                        width: 1.0,
                        style: BorderStyle.solid,
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            border: Border(
                              right: BorderSide(
                                color: Colors.blue,
                                width: 1.0,
                                style: BorderStyle.solid,
                              ),
                            ),
                          ),
                          child: IconButton(
                            splashRadius: 20,
                            onPressed: () {
                              setState(() {
                                if (durations > 0) {
                                  durations--;
                                }
                              });
                            },
                            icon: const Icon(Icons.remove),
                          ),
                        ),
                        SizedBox(
                          child: Center(child: Text('$durations')),
                          width: 75,
                        ),
                        Container(
                          decoration: const BoxDecoration(
                            border: Border(
                              left: BorderSide(
                                color: Colors.blue,
                                width: 1.0,
                                style: BorderStyle.solid,
                              ),
                            ),
                          ),
                          child: IconButton(
                            splashRadius: 20,
                            onPressed: () {
                              durations++;
                              setState(() {});
                            },
                            icon: const Icon(Icons.add),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              )
            ],
          )),
    );
  }
}
