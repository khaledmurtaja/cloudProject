import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:getx_architecture/App/modules/AddTraining/controller.dart';

import '../../../core/errors/exceptions.dart';
import '../../data/models/trainings.dart';

class AddTrainingRepository {
  final collection = Get.find<CollectionReference>(tag: "trainings");
  addNewTraining() async {
    final controller = Get.find<AddTrainingScreenController>();
    try {
      // await collection.add(Training(
      //     trainingName: controller.trainingName.text,
      //     category: controller.selectedCategory,
      //     description: controller.trainingDescription.text,
      //     dates: controller.attendanceDates).toJson());
    }catch(e){
      throw FailedToAddTrainingException();
    }
  }
}
