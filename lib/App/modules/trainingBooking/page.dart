import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:getx_architecture/App/modules/trainingBooking/controller.dart';

import '../../data/models/training.dart';

class TrainingBookingScreen extends GetView<TrainingBookingController> {
  final CollectionReference trainingsCollection =
      FirebaseFirestore.instance.collection('trainings');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trainings'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: trainingsCollection.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          final trainings = snapshot.data!.docs
              .map((DocumentSnapshot document) => Training(
                    name: document['trainingName'],
                    description: document['description'],
                    isPaidCourse: document['isPaidCourse'],
                    price: document['price'],
                    dates: List<Map<String, dynamic>>.from(document['dates']),
                    category: '',
                    id: '',
                    imageUrl: document['courseImageUrl'],
                    advisorName: document['advisorName'],
                              advisorId: document['advisorId']

                  ))
              .toList();

          return ListView.builder(
            itemCount: trainings.length,
            itemBuilder: (BuildContext context, int index) {
              final training = trainings[index];
              return Card(
                child: ListTile(
                  title: Text(training.name),
                  subtitle: Text(training.description),
                  trailing: IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      _showTrainingDatesDialog(context, training);
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Future<void> _showTrainingDatesDialog(
      BuildContext context, Training training) async {
    final selectedDate = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select a date'),
          content: SingleChildScrollView(
            child: Column(
              children: training.dates
                  .map(
                    (date) => ListTile(
                      title: Text(date['startHour'].toString()),
                      subtitle: Text(date['endHour'].toString()),
                      onTap: () {
                        Navigator.of(context).pop(date);
                      },
                    ),
                  )
                  .toList(),
            ),
          ),
        );
      },
    );

    if (selectedDate != null) {
      _recordTraining(context, training, selectedDate);
    }
  }

  void _recordTraining(BuildContext context, Training training,
      Map<String, dynamic> selectedDate) {
    // Implement your logic to record the training here
    // You can use Firebase Firestore to store the data
    // For example, you can create a new document in a "bookings" collection
    // with the details of the training and the selected date
    // You can use the trainee's ID or any other identifier to associate the booking with the trainee
    // Example code for creating a new document:
    // FirebaseFirestore.instance.collection('bookings').add({
    //   'traineeId': traineeId,
    //   'trainingName': training.name,
    //   'date': selectedDate,
    // });
  }
}

// 1682876656937000