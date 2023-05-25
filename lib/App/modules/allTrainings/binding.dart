import 'package:get/get.dart';

import 'controller.dart';

class AllTrainingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AllTrainingsController>(
      () => AllTrainingsController(),
    );

    // Get.put(AllTrainingsController(), permanent: true);

    // Get.lazyPut<RegisterRepository>(() => RegisterRepository(),);
  }
}
