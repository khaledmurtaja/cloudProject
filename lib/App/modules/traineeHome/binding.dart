import 'package:get/get.dart';

import 'controller.dart';

class TraineeHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TraineeHomeController>(
      () => TraineeHomeController(),
    );
    // Get.lazyPut<RegisterRepository>(() => RegisterRepository(),);
  }
}
