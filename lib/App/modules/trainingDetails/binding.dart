import 'package:get/get.dart';
import 'controller.dart';

class TrainingDetaileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TrainingDetaileController>(
      () => TrainingDetaileController(),
    );
    // Get.lazyPut<RegisterRepository>(() => RegisterRepository(),);
  }
}
