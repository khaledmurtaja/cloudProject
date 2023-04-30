import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_architecture/App/modules/register/repository.dart';

class RegisterController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String supportDocUrl = "";
  FilePickerResult? filePickerResult;
  String selectedProfessionValue = "mobile development";
  String selectedRoleValue = "trainee";
  bool isLoading = false;
  UserCredential? userCredential;

  pickFile() async {
    try {
      filePickerResult = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'pdf', 'doc', 'png'],
      );
      return filePickerResult;
    } catch (error) {
      //handle error;
      print(error);
    }
  }

  changeProfessionFiled({required String value}) {
    selectedProfessionValue = value;
    update();
  }

  changeRoleFiled({required String role}) {
    selectedRoleValue = role;
    update();
  }

  registerUser({required String email, required String password}) async {
    isLoading = true;
    update();
    final repo = Get.find<RegisterRepository>();
    await repo.registerUser(email: email, password: password);
    isLoading = false;
    update();
    print("success");
  }
}
