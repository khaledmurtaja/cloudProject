import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_architecture/App/modules/login/repository.dart';
import '../../../core/errors/exceptions.dart';
import '../../../core/utils/helperFunctions.dart';
import '../../../core/values/roles.dart';
import '../../../routes/routes.dart';
import '../../data/services/sharedPrefService.dart';

class LoginController extends GetxController {
  bool securePassword = true;
  TextEditingController idController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;
  String role = "";
  onRedEyeClicked() {
    /// for controlling password visibility icon
    securePassword = !securePassword;
    update();
  }

  login({required String id, required String password}) async {
    isLoading = true;
    update();
    final repo = Get.find<LoginRepository>();
    try {
      await repo.loginUser(id: id, password: password);
      final sharedPref = Get.find<AppSharedPref>();
      sharedPref.putStringValue(key: "userrole", value: role);
      _routeTo(role: role);
    } catch (e) {
      isLoading = false;
      update();
      _handleLogInError(exception: e);
    }
  }

  _routeTo({required String role}) async {
    if (role != "") {
      if (role == Roles.maneger) {
        return Get.rootDelegate.offAndToNamed(Routes.MANEGER_HOME);
      } else if (role == Roles.trainee) {
        await trackUserActivity(activity: 'Login', title: 'Login by trainee');
        return Get.rootDelegate.offAndToNamed(Routes.TRAINEE_HOME);
      } else {
        return Get.rootDelegate.offAndToNamed(Routes.ADVISOR_HOME);
      }
    }
  }

  _handleLogInError({required dynamic exception}) {
    if (exception is IdNotFoundException) {
      showSnackBar(
          message: "No account found with this id",
          snackPosition: SnackPosition.TOP);
    } else if (exception is NetWorkException) {
      showSnackBar(
          message: "Check your internet connection",
          snackPosition: SnackPosition.TOP);
    } else if (exception is UserNotFoundException) {
      showSnackBar(message: "No user found", snackPosition: SnackPosition.TOP);
    } else if (exception is WrongPasswordException) {
      showSnackBar(message: "Wrong password", snackPosition: SnackPosition.TOP);
    } else if (exception is UnKnowException) {
      showSnackBar(
          message: "Unknown error occurred ", snackPosition: SnackPosition.TOP);
    }
  }
}
