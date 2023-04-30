import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_architecture/App/modules/login/repository.dart';
import '../../../core/errors/exceptions.dart';
import '../../../core/utils/helperFunctions.dart';
import '../../../core/values/roles.dart';
import '../../../routes/routes.dart';

class LoginController extends GetxController {
  TextEditingController idController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  String role = "";
  login({required String id, required String password}) async {
    isLoading = true;
    update();
    final repo = Get.find<LoginRepository>();
    try {
      await repo.loginUser(id: id, password: password);
      if (role != "") {
        if (role == Roles.maneger) {
          Get.offNamed(Routes.MANEGER_HOME);
        }else if(role==Roles.trainee){
          Get.offNamed(Routes.TRAINEE_HOME);
        } else  {
          Get.offNamed(Routes.ADVISOR_HOME);
        }
      }
    } catch (e) {
      isLoading = false;
      update();
      if (e is IdNotFoundException) {
        showSnackBar(
            message: "No account found with this id",
            snackPosition: SnackPosition.TOP);
      } else if (e is NetWorkException) {
        showSnackBar(
            message: "Check your internet connection",
            snackPosition: SnackPosition.TOP);
      } else if (e is UserNotFoundException) {
        showSnackBar(
            message: "No user found", snackPosition: SnackPosition.TOP);
      } else if (e is WrongPasswordException) {
        showSnackBar(
            message: "Wrong password", snackPosition: SnackPosition.TOP);
      } else if (e is UnKnowException) {
        showSnackBar(
            message: "Unknown error occurred ",
            snackPosition: SnackPosition.TOP);
      }
    }
  }
}
