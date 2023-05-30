import 'package:get/get.dart';

import '../../data/models/training.dart';

class TrainingDetaileAfterRecordingController extends GetxController {
  dynamic argumentData = Get.rootDelegate;
  Training? training;
  final RxBool isLoading = true.obs;

  @override
  void onInit() async {
    training = await argumentData.arguments()['trainingObject'] as Training;
    isLoading.value = false;
  }
}
