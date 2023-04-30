import 'package:get/get.dart';
import 'package:getx_architecture/App/modules/login/repository.dart';

import 'controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController(),);
    Get.lazyPut<LoginRepository>(() => LoginRepository());
  }
}
