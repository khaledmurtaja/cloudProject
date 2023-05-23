import 'package:get/get.dart';

import 'controller.dart';

class TrainingBookingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TrainingBookingController>(
      () => TrainingBookingController(),
    );
    // Get.lazyPut<RegisterRepository>(() => RegisterRepository(),);
  }
}
