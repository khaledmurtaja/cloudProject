import 'package:get/get.dart';
import 'package:getx_architecture/App/modules/manegerHome/repository.dart';

import 'controller.dart';

class ManegerHomeBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<ManagerHomeController>(() => ManagerHomeController(),);
    Get.lazyPut<ManagerHomeRepository>(() => ManagerHomeRepository());
  }

}