import 'package:get/get.dart';
import 'controller.dart';

class TrainingDetaileAfterRecordingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TrainingDetaileAfterRecordingController>(
      () => TrainingDetaileAfterRecordingController(),
    );
    // Get.lazyPut<RegisterRepository>(() => RegisterRepository(),);
  }
}
