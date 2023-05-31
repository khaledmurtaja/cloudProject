import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';

import '../../../core/utils/helperFunctions.dart';
import '../../data/models/user.dart';

class TraineeProfileController extends GetxController {
  dynamic argumentData = Get.rootDelegate;
  final RxBool isLoading = true.obs;
  final balance = ''.obs;
  var uId = ''.obs;
  final systemUser = Rxn<SystemUser>();

  TextEditingController balanceController = TextEditingController();

  @override
  void onInit() async {
    String uid = await argumentData.arguments()['uId'];
    uId.value = uid;
    balance.value = (await fetchUserBalance(uid))!;
    isLoading.value = false;
    super.onInit();
  }

  Future<String?> fetchUserBalance(String userId) async {
    try {
      final DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      if (userSnapshot.exists) {
        systemUser.value =
            SystemUser.fromJson(userSnapshot.data() as Map<String, dynamic>);
        final userData = userSnapshot.data() as Map<String, dynamic>;
        final balance = userData['balance'];
        return balance;
      } else {
        print('User not found');
        return null;
      }
    } catch (e) {
      print('Error fetching user balance: $e');
      return null;
    }
  }

  Future<void> increaseBalance(String userId) async {
    final double amountToAdd = double.parse(balanceController.text);

    try {
      final DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      if (userSnapshot.exists) {
        // final user =
        //     SystemUser.fromJson(userSnapshot.data() as Map<String, dynamic>);
        // print(user.name);
        final userData = userSnapshot.data() as Map<String, dynamic>;
        final double currentBalance = double.parse(userData['balance']);
        final double newBalance = currentBalance + amountToAdd;
/*
        final paymentMethod = await Stripe.instance.createPaymentMethod(
          params: const PaymentMethodParams.card(
            paymentMethodData: PaymentMethodData(),
          ),
        );
*/
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .update({'balance': newBalance.toString()});

        balance.value = newBalance.toString();


        balanceController.clear();
        Get.snackbar(
          'Successfully Done',
          "Balance increased successfully!",
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white,
          backgroundColor: Colors.green,
          icon: const Icon(Icons.add_alert),
        );
      } else {
        Get.snackbar(
          'An error occurred !',
          "User not found",
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white,
          backgroundColor: Colors.green,
          icon: const Icon(Icons.add_alert),
        );
      }
    } catch (e) {
      Get.snackbar(
        'An error occurred !',
        "Error increasing balance: $e",
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.white,
        backgroundColor: Colors.green,
        icon: const Icon(Icons.add_alert),
      );
    }
  }
}
