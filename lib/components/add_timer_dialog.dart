import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/src/provider.dart';
import 'package:smart_home/states/timer.dart';

class NewAlarmDialog extends StatefulWidget {
  const NewAlarmDialog({
    Key? key,
  }) : super(key: key);

  @override
  State<NewAlarmDialog> createState() => _NewAlarmDialogState();
}

class _NewAlarmDialogState extends State<NewAlarmDialog> {
  DateTime chosenDate = DateTime.now();
  TimeOfDay chosenTime = TimeOfDay.now();
  int durations = 0;
  bool isTurnOff = true;
  String chosenName = 'Bulb no.1';

  void pickDateAndTime() {
    Future<DateTime?> chosen = showDatePicker(
        context: context,
        initialDate: chosenDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(DateTime.now().year + 3));
    chosen.then(
      (value) {
        if (value != null) {
          Future<TimeOfDay?> chosenTime_ =
              showTimePicker(context: context, initialTime: chosenTime);
          chosenTime_.then(
            (valueTime) {
              if (valueTime != null) {
                chosenDate = value;
                chosenTime = valueTime;
              }
              setState(() {});
            },
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String dateString = DateFormat.MEd().format(chosenDate);
    String timeString = chosenTime.format(context);
    return AlertDialog(
      actionsAlignment: MainAxisAlignment.spaceEvenly,
      actions: [
        TextButton(
          onPressed: () {
            context.read<TimerState>().addTimer(
                  dateTime: DateTime(
                    chosenDate.year,
                    chosenDate.month,
                    chosenDate.day,
                    chosenTime.hour,
                    chosenTime.minute,
                  ),
                  duration: durations,
                  isAutoOff: isTurnOff,
                  name: chosenName,
                );
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
          height: 200,
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
                          .bulbList
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
              Row(
                children: [
                  Text(dateString),
                  const SizedBox(
                    width: 30,
                  ),
                  Text(timeString),
                  Expanded(
                    child: IconButton(
                      splashRadius: 30,
                      onPressed: pickDateAndTime,
                      icon: const Icon(
                        Icons.calendar_today,
                      ),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  const Text('Turn off'),
                  const SizedBox(
                    width: 40,
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
