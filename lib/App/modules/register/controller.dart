import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_architecture/App/modules/register/repository.dart';
import 'package:getx_architecture/core/errors/exceptions.dart';

import '../../../core/utils/helperFunctions.dart';

class RegisterController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController chosenFileController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool securePassword = true;
  String supportDocUrl = "";
  FilePickerResult? filePickerResult;
  String selectedProfessionValue = "";
  String selectedRoleValue = "";
  bool isLoading = false;
  String fileName = "choose file";
  UserCredential? userCredential;
  bool isRegisterButtonPressed = false;
  List<String> role = ["Trainee", "Advisor"];
  List<String> professions = [
    "DataBase",
    "Design",
    "FrontEnd",
    "BackEnd",
    "Mobile",
    "DevOps",
    "Security"
  ];
  onRedEyeClicked() {
    /// for controlling password visibility icon
    securePassword = !securePassword;
    update();
  }

  updateRegisterButtonStatues() {
    isRegisterButtonPressed = true;
    update();
  }

  pickFile() async {
    try {
      filePickerResult = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'png'],
      );
      fileName = filePickerResult!.files.first.name;
      update();
      return filePickerResult;
    } catch (error) {
      //handle error;
      print(error);
    }
  }

  changeProfessionFiled({required String value}) {
    selectedProfessionValue = value;
  }

  changeRoleFiled({required String role}) {
    selectedRoleValue = role;
  }

  registerUser({required String email, required String password}) async {
    try {
      isLoading = true;
      update();
      final repo = Get.find<RegisterRepository>();
      await repo.registerUser(email: email, password: password);
      isLoading = false;
      update();
   

      showSnackBar(
          message: "We will send you an email soon",
          title: "Request has been sent");
    } catch (e) {
      if (e is EmailAlreadyInUseException) {
        showSnackBar(
            message: "Email already in use", snackPosition: SnackPosition.TOP);
      } else {
        showSnackBar(
            message: "Unknown error occurred,Check your internet connection ",
            snackPosition: SnackPosition.TOP);
      }
    }
  }
}
