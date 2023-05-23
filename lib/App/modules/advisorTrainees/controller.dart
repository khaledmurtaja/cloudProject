import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../data/models/trainee.dart';

class AdvisorTraineesController extends GetxController {
  final CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference _trainingsCollection =
      FirebaseFirestore.instance.collection('trainings');

  RxString selectedFilter = "All".obs;

  Future<List<UserModel>> getTrainees(String advisorId) async {
    try {
      QuerySnapshot snapshot = await _usersCollection
          .where("selected_training_ids",
              arrayContainsAny: await getTrainingIds(advisorId))
          .get();
      List<UserModel> trainees = snapshot.docs
          .map((doc) => UserModel.fromMap(doc.data()! as Map<String, dynamic>))
          .toList();

      if (selectedFilter.value == "Free") {
        print("Free");

        trainees = (await Future.wait(trainees.map((trainee) async {
          List<String>? trainingIds = trainee.selectedTrainingIds;
          if (trainingIds != null) {
            return (await Future.wait(
                    trainingIds.map((id) => isTrainingFree(id))))
                .any((isFree) => isFree);
          }
          return false;
        })))
            .asMap()
            .entries
            .where((element) => element.value)
            .map((element) => trainees[element.key])
            .toList();
      } else if (selectedFilter.value == "Paid") {
        trainees = (await Future.wait(trainees.map((trainee) async {
          List<String>? trainingIds = trainee.selectedTrainingIds;
          if (trainingIds != null) {
            return (await Future.wait(
                    trainingIds.map((id) => isTrainingPaid(id))))
                .any((isFree) => isFree);
          }
          return false;
        })))
            .asMap()
            .entries
            .where((element) => element.value)
            .map((element) => trainees[element.key])
            .toList();
      }
      return trainees;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  Future<List<String>> getTrainingIds(String advisorId) async {
    try {
      QuerySnapshot snapshot = await _trainingsCollection
          .where("advisor_id", isEqualTo: advisorId)
          .get();
      List<String> trainingIds = snapshot.docs.map((doc) => doc.id).toList();
      if (selectedFilter.value == "Free") {
        List<bool> isFreeList =
            await Future.wait(trainingIds.map((id) => isTrainingFree(id)));
        trainingIds = trainingIds
            .where((id) => isFreeList[trainingIds.indexOf(id)])
            .toList();
      } else if (selectedFilter.value == "Paid") {
        List<bool> isFreeList =
            await Future.wait(trainingIds.map((id) => isTrainingPaid(id)));
        trainingIds = trainingIds
            .where((id) => isFreeList[trainingIds.indexOf(id)])
            .toList();
      }
      return trainingIds;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  Future<bool> isTrainingFree(String trainingId) async {
    DocumentSnapshot training =
        await _trainingsCollection.doc(trainingId).get();

    return training.exists &&
        (training.data() as Map<String, dynamic>)['isPaidCourse'] == false;
  }

  Future<bool> isTrainingPaid(String trainingId) async {
    DocumentSnapshot training =
        await _trainingsCollection.doc(trainingId).get();
    return training.exists &&
        (training.data() as Map<String, dynamic>)['isPaidCourse'] == true;
  }

  void setFilter(String filter) {
    selectedFilter.value = filter;

    update();
  }
}
