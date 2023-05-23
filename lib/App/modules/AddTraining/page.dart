import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'controller.dart';

class AddTrainingScreen extends GetView<AddTrainingScreenController> {
  const AddTrainingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: <Widget>[
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'add training',
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w500,
                        fontSize: 30),
                  )),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: TextField(
                  controller: controller.trainingName,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'training name',
                  ),
                ),
              ),
              GetBuilder<AddTrainingScreenController>(
                builder: (controller) {
                  return DropdownButton<String>(
                    value: controller.selectedCategory,
                    onChanged: (newValue) {
                      controller.changeSelectedCategory(newValue: newValue!);
                    },
                    items: const [
                      DropdownMenuItem(
                        value: 'Mobile development',
                        child: Text('Mobile development'),
                      ),
                      DropdownMenuItem(
                        value: 'Web development',
                        child: Text('web development'),
                      ),
                      DropdownMenuItem(
                        value: 'Testing',
                        child: Text('Testing'),
                      ),
                      DropdownMenuItem(
                        value: 'Security',
                        child: Text('Security '),
                      ),
                      DropdownMenuItem(
                        value: 'Quality assurance',
                        child: Text('Quality assurance '),
                      ),
                    ],
                  );
                },
              ),
              Container(
                height: 200.h,
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: TextField(
                  expands: true,
                  textAlignVertical: TextAlignVertical.top,
                  controller: controller.trainingDescription,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    // labelText: 'training description',
                    hintText: 'training description',
                  ),
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              GetBuilder<AddTrainingScreenController>(
                builder: (controller) {
                  if (controller.isEditing) {
                    return UnconstrainedBox(
                        child: ElevatedButton(
                            onPressed: () {
                              controller.addDate();
                            },
                            child: const Text("save")));
                  } else {
                    return UnconstrainedBox(
                        child: ElevatedButton(
                            onPressed: () {
                              controller.changeEditMode();
                            },
                            child: const Text("Add course date")));
                  }
                },
              ),
              SizedBox(
                height: 15.h,
              ),
              GetBuilder<AddTrainingScreenController>(
                builder: (controller) {
                  if (controller.isLoading) {
                    return Center(child: const CircularProgressIndicator());
                  } else {
                    return ElevatedButton(
                        onPressed: () async {
                          await controller.addTraining();
                        },
                        child: const Text("submit "));
                  }
                },
              ),
              SizedBox(
                height: 15.h,
              ),
              GetBuilder<AddTrainingScreenController>(
                builder: (controller) {
                  if (controller.isEditing) {
                    return Row(
                      children: [
                        GetBuilder<AddTrainingScreenController>(
                          builder: (controller) {
                            return DropdownButton<String>(
                              value: controller.selectedDay,
                              onChanged: (newValue) {
                                controller.changeSelectedDay(
                                    newValue: newValue!);
                              },
                              items: const [
                                DropdownMenuItem(
                                  value: 'saturday',
                                  child: Text('saturday'),
                                ),
                                DropdownMenuItem(
                                  value: 'sunday',
                                  child: Text('sunday'),
                                ),
                                DropdownMenuItem(
                                  value: 'monday',
                                  child: Text('monday'),
                                ),
                                DropdownMenuItem(
                                  value: 'tuesday',
                                  child: Text('tuesday'),
                                ),
                                DropdownMenuItem(
                                  value: 'wednesday',
                                  child: Text('wednesday'),
                                ),
                              ],
                            );
                          },
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Column(
                          children: [
                            const Text("From"),
                            ElevatedButton(onPressed: () async {
                              TimeOfDay? time = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now());
                              controller.changeFormTime(fromTime: time!);
                            }, child: GetBuilder<AddTrainingScreenController>(
                              builder: (controller) {
                                return Text(
                                    "${controller.hoursFrom}:${controller.minutesFrom} ${controller.periodFrom}");
                              },
                            ))
                          ],
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Column(
                          children: [
                            const Text("To"),
                            ElevatedButton(onPressed: () async {
                              TimeOfDay? time = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now());
                              controller.changeToTime(toTime: time!);
                            }, child: GetBuilder<AddTrainingScreenController>(
                              builder: (controller) {
                                return Text(
                                    "${controller.hoursTo}:${controller.minutesTo} ${controller.periodTo}");
                              },
                            ))
                          ],
                        ),
                      ],
                    );
                  } else {
                    return Container();
                  }
                },
              ),
              GetBuilder<AddTrainingScreenController>(
                builder: (controller) {
                  return DataTable(
                      columns: const [
                        DataColumn(label: Text('Course date')),
                        DataColumn(label: Text('Day')),
                        DataColumn(label: Text('Start Time')),
                        DataColumn(label: Text('End Time')),
                        // DataColumn(label: Text("")),
                      ],
                      rows: controller.attendanceDates.map((e) {
                        return DataRow(cells: [
                          const DataCell(Text('Course date')),
                          DataCell(Text(e.day)),
                          DataCell(Text(e.startHour)),
                          DataCell(Text(e.endHour))
                        ]);
                      }).toList());
                },
              )
            ],
          )),
    );
  }
}
