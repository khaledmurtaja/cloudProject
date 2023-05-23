import 'package:get/get.dart';

import 'controller.dart';

class TraineeLearninBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TraineeLearninController>(
      () =>TraineeLearninController(),
    );
    // Get.lazyPut<RegisterRepository>(() => RegisterRepository(),);
  }
}
