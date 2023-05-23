import 'package:get/get.dart';

import 'controller.dart';

class TraineeProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TraineeProfileController>(
      () => TraineeProfileController(),
    );
    // Get.lazyPut<RegisterRepository>(() => RegisterRepository(),);
  }
}
