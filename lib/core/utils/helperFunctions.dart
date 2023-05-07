import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
