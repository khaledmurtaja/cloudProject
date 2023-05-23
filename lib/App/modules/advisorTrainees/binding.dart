import 'package:get/get.dart';
import 'package:getx_architecture/App/modules/login/repository.dart';

import 'controller.dart';

class AdvisorTraineesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdvisorTraineesController>(
      () => AdvisorTraineesController(),
    );
  }
}
