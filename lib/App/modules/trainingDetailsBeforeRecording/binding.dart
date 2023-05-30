import 'package:get/get.dart';
import 'controller.dart';

class TrainingDetaileBeforeRecordingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TrainingDetaileBeforeRecordingController>(
      () => TrainingDetaileBeforeRecordingController(),
    );
    // Get.lazyPut<RegisterRepository>(() => RegisterRepository(),);
  }
}
