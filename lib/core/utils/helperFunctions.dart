import 'dart:math';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../values/strings.dart';

void showSnackBar(
    {required String message,
    String title = "error occurred",
    Color backGroundColor = Colors.red,
    SnackPosition snackPosition = SnackPosition.TOP}) {
  Get.snackbar(
    title,
    message,
    backgroundColor: backGroundColor,
    colorText: Colors.white,
    snackPosition: snackPosition,
    duration: const Duration(seconds: 5),
  );
}

Future<bool> isConnectedToNetwork() async {
  bool isConnected = false;
  final connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.mobile) {
    isConnected = true;
  } else if (connectivityResult == ConnectivityResult.wifi) {
    isConnected = true;
  } else if (connectivityResult == ConnectivityResult.ethernet) {
    isConnected = true;
  } else if (connectivityResult == ConnectivityResult.vpn) {
    isConnected = true;
  } else if (connectivityResult == ConnectivityResult.none) {
    isConnected = false;
  } else {
    isConnected = true;
  }
  return isConnected;
}

double getMediaQueryHeight(
    {required BuildContext context, required num value}) {
  var size = MediaQuery.of(context).size;
  //figma height
  double xdHeight = 1024;
  double percentage = value / xdHeight;
  return size.height * percentage;
}

double getMediaQueryWidth({required BuildContext context, required num value}) {
  var size = MediaQuery.of(context).size;
  //figma width
  double xdWidth = 1440;
  double percentage = value / xdWidth;

  return size.width * percentage;
}

/// for validating password field in login screen
String? validatePasswordLogin(String password) {
  if (password.isEmpty) {
    return passwordIsRequiredMessage;
  } else if (password.length < 8) {
    return lessThan8charMessage;
  } else {
    return null;
  }
}

String? validateId(String id) {
  if (id.isEmpty) {
    return idIsRequiredMessage;
  } else if (!whiteSpaceRegex.hasMatch(id)) {
    return whiteSpacesError;
  } else {
    return null;
  }
}

String? validateNameField(String name) {
  if (name.isEmpty) {
    return nameIsRequiredMessage;
  } else if (name.length < 4 || name.length > 30) {
    return nameMustHave4LettersAtLeastMessage;
  } else if (name.length > 30) {
    return nameMustHave30LettersAtMostMessage;
  } else {
    return null;
  }
}

String? validateCourseNameField(String name) {
  if (name.isEmpty) {
    return courseNameIsRequiredMessage;
  } else if (name.length < 4 || name.length > 30) {
    return "courseNameMustHave4LettersAtLeastMessage";
  } else if (name.length > 30) {
    return nameMustHave30LettersAtMostMessage;
  } else {
    return null;
  }
}

String? validateBannerNameField(String name) {
  if (name.isEmpty) {
    return "banner name is required";
  } else if (name.length < 4 || name.length > 30) {
    return "banner name must have at least 4 characters.";
  } else if (name.length > 30) {
    return nameMustHave30LettersAtMostMessage;
  } else {
    return null;
  }
}

String? validateEmail(String email) {
  if (email.isEmpty) {
    return emailIsRequiredMessage;
  } else if (!email.isEmail) {
    return wrongEmailFormatMessage;
  } else {
    return null;
  }
}

/// for validating password field in register screen
String? validatePasswordRegister(
  String password,
) {
  if (password.isEmpty) {
    return passwordIsRequiredMessage;
  } else if (password.length < 8) {
    return lessThan8charMessage;
  } else if (!uppercaseRegex.hasMatch(password)) {
    return atLeast1UpperCaseLetterMessage;
  } else if (!lowercaseRegex.hasMatch(password)) {
    return atLeast1LowerCaseLetterMessage;
  } else if (!numberRegex.hasMatch(password)) {
    return atLeast1NumberMessage;
  } else if (!specialCharRegex.hasMatch(password)) {
    return atLeast1SpecialCharacterMessage;
  } else {
    return null;
  }
}

///validate dropdown
String? validateDropDown(String? value) {
  if (value == null) {
    return "Required";
  } else {
    return null;
  }
}

String? validateDescription(String description) {
  if (description.length > 3000) {
    return lessThat200CharRequiredMessage;
  } else if (description.isEmpty) {
    return "Description can't be empty";
  } else {
    return null;
  }
}

String? validateCoursePrice(String price) {
  if (!price.isNumericOnly) {
    return "only numbers allowed here";
  } else {
    return null;
  }
}

int generateRandomNumber() {
  final random = Random();
  return random.nextInt(101);
}

double calculatePercentage(int number) {
  return number / 100;
}

Future<void> trackUserActivity(
    {required String activity, required String title}) async {
  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  await analytics.logEvent(
    name: title,
    parameters: {'activity': activity},
  );
}
