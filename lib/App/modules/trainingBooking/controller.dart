import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TrainingBookingController extends GetxController {
  List<String> selectedTrainingIds = [];

  Map<String, List<Map<String, dynamic>>> trainingDates = {};

  Stream<QuerySnapshot<Map<String, dynamic>>> getTrainingsByCategory(
      String category) {
    return FirebaseFirestore.instance
        .collection('trainings')
        .where('category', isEqualTo: category)
        .snapshots();
  }

  void showTrainingDateDialog(String trainingId,
      Map<String, dynamic> trainingData, BuildContext context) {
    final List<Map<String, dynamic>>? dates = trainingDates[trainingId] ?? [];
    print(dates);
    // print('****************');
    // for (final dayTime in trainingData['dates']) {
    //   print(
    //     dates.any((date) =>
    //         date['day'] == dayTime['day'] &&
    //         date['startHour'] == dayTime['startHour'] &&
    //         date['endHour'] == dayTime['endHour']),
    //   );
    // }

    Get.defaultDialog(
      title: trainingData['name'],
      content: Container(
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (final dayTime in trainingData['dates'])
              CheckboxListTile(
                title: Text(
                    '${dayTime['day']}, ${dayTime['startHour']} - ${dayTime['endHour']}'),
                // value: dates.contains(dayTime),
                value: dates!.any((date) =>
                    date['day'] == dayTime['day'] &&
                    date['startHour'] == dayTime['startHour'] &&
                    date['endHour'] == dayTime['endHour']),
                selected: dates.any((date) =>
                    date['day'] == dayTime['day'] &&
                    date['startHour'] == dayTime['startHour'] &&
                    date['endHour'] == dayTime['endHour']),
                onChanged: (bool? value) {
                  if (value!) {
                    dates.add(dayTime);
                  } else {
                    /*
                        dates.remove(dayTime);
                        */

                    dates.removeWhere((date) =>
                        date['day'] == dayTime['day'] &&
                        date['startHour'] == dayTime['startHour'] &&
                        date['endHour'] == dayTime['endHour']);
                  }

                  update();
                },
              ),
          ],
        ),
      ),
      actions: [
        TextButton(
          child: const Text('CANCEL'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text('OK'),
          onPressed: () async {
            trainingDates[trainingId] = dates!;
            if (!selectedTrainingIds.contains(trainingId)) {
              selectedTrainingIds.add(trainingId);
            }

            update();
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
