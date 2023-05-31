import 'package:get/get.dart';
import 'package:getx_architecture/App/modules/advisorHome/repository.dart';

import 'controller.dart';

class AdvisorHomeBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<AdvisorController>(() => AdvisorController(),);
    Get.lazyPut<AdvisorRepository>(() => AdvisorRepository());
  }

}