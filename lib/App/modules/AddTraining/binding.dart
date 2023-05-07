import 'package:get/get.dart';
import 'package:getx_architecture/App/modules/AddTraining/controller.dart';
import 'package:getx_architecture/App/modules/AddTraining/repository.dart';

class AddTrainingScreenBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<AddTrainingScreenController>(() => AddTrainingScreenController(),);
    Get.lazyPut<AddTrainingRepository>(() => AddTrainingRepository(),);
  }

}