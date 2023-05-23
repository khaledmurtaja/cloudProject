import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showSnackBar(
    {required String message,
    String title = "error occurred",
    Color backGroundColor = Colors.red,
    SnackPosition snackPosition = SnackPosition.BOTTOM}) {
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
  double xdHeight = 813;
  double percentage = value / xdHeight;
  return size.height * percentage;
}

double getMediaQueryWidth({required BuildContext context, required num value}) {
  var size = MediaQuery.of(context).size;
  //figma height
  double xdWidth = 375;
  double percentage = value / xdWidth;

  return size.width * percentage;
}
