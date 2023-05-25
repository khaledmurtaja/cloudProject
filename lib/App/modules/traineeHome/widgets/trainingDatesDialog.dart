import 'package:flutter/material.dart';

import '../../../data/models/training.dart';
import '../controller.dart';

class TrainingDatesDialog extends StatefulWidget {
  final Training training;
  final TraineeHomeController traineeHomeController;

  TrainingDatesDialog({
    required this.training,
    required this.traineeHomeController,
  });

  @override
  _TrainingDatesDialogState createState() => _TrainingDatesDialogState();
}

class _TrainingDatesDialogState extends State<TrainingDatesDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Select a date'),
      actions: <Widget>[
        TextButton(
            child: Text('Cancel'),
            onPressed: () {
              widget.traineeHomeController.indicatorUpdate();
              Navigator.of(context).pop();
            }),
        TextButton(
            child: Text('Ok'),
            onPressed: () {
              Map<String, dynamic> selectedDate = widget
                  .training.dates[widget.traineeHomeController.selectedIndex];

              widget.traineeHomeController.recordTraining(
                  context,
                  widget.training,
                  selectedDate,
                  widget.traineeHomeController.uId);
              widget.traineeHomeController.indicatorUpdate();

              Navigator.of(context).pop();
            })
      ],
      content: Container(
        height: 200,
        width: 600,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: widget.training.dates.length,
          itemBuilder: (BuildContext context, int position) {
            return InkWell(
              onTap: () {
                setState(() {
                  widget.traineeHomeController.selectedIndex = position;
                });
              },
              child: Container(
                width: 150,
                child: Card(
                  // shape: (selectedIndex == position)
                  //     ? const RoundedRectangleBorder(
                  //         side: BorderSide(color: Colors.green, width: 2))
                  //     : null,
                  color:
                      (widget.traineeHomeController.selectedIndex == position)
                          ? Colors.grey.shade400
                          : Colors.white,
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text('Appointment No #${position + 1}'),
                        Divider(
                          height: 2,
                          color: Colors.black,
                        ),
                        Row(
                          children: [
                            Text('Day:'),
                            Text(widget.training.dates[position]['day']
                                .toString()),
                          ],
                        ),
                        Divider(
                          height: 1,
                          color: Colors.black.withOpacity(.8),
                        ),
                        Row(
                          children: [
                            Text('Start Hour:'),
                            Text(widget.training.dates[position]['startHour']
                                .toString()),
                          ],
                        ),
                        Divider(
                          height: 1,
                          color: Colors.black.withOpacity(.8),
                        ),
                        Row(
                          children: [
                            Text('End Hour:'),
                            Text(widget.training.dates[position]['endHour']
                                .toString()),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
