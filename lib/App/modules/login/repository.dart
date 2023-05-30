import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../../../core/errors/exceptions.dart';
import '../../../core/utils/helperFunctions.dart';
import '../../data/services/sharedPrefService.dart';
import 'controller.dart';

class LoginRepository {
  final controller = Get.find<LoginController>();
  loginUser({required String id, required String password}) async {
    if (await isConnectedToNetwork() == false) {
      throw NetWorkException();
    } else {
      try {
        String? email = await _getEmailFromId(id: id);
        if (email != null) {
          UserCredential userCredential=await FirebaseAuth.instance
              .signInWithEmailAndPassword(email: email, password: password);
          final sharedPref = Get.find<AppSharedPref>();
          Future.delayed(const Duration(milliseconds: 800),(){
            sharedPref.putStringValue(key: "Uid", value: userCredential.user!.uid);
          });
        } else {
          throw IdNotFoundException();
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          throw UserNotFoundException();
        } else if (e.code == 'wrong-password') {
          throw WrongPasswordException();
        } else if (e.code == 'network-request-failed') {
          throw NetWorkException();
        } else {
          throw UnKnowException();
        }
      }
    }
  }

  Future<String?> _getEmailFromId({required String id}) async {
    final collectionRef = FirebaseFirestore.instance.collection('users');
    final value = await collectionRef.where('id', isEqualTo: id).limit(1).get();
    if (value.docs.isNotEmpty) {
      final email = value.docs.first.get("email");
      controller.role = value.docs.first.get("role");
      print(controller.role+"يبي");
      if (email != null) {
        return email;
      }
    }
    return null;
  }
}
