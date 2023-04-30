import 'package:get/get.dart';
import 'package:getx_architecture/App/modules/register/repository.dart';

import 'controller.dart';

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterController>(() => RegisterController(),);
    Get.lazyPut<RegisterRepository>(() => RegisterRepository(),);

  }
}
