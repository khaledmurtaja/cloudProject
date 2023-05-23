import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:getx_architecture/App/modules/register/controller.dart';
import '../../../core/errors/exceptions.dart';
import '../../../core/utils/helperFunctions.dart';
import '../../data/models/user.dart';
import 'package:image/image.dart' as img;

class RegisterRepository {
  final controller = Get.find<RegisterController>();
  registerUser({required String email, required String password}) async {
    if (await isConnectedToNetwork() == false) {
      throw NetWorkException();
    } else {
      try {
        controller.userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        await _storeUserData();
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          ///already handled by local validation
          if (kDebugMode) {
            print('The password provided is too weak.');
          }
        } else if (e.code == 'email-already-in-use') {
          throw EmailAlreadyInUseException();
        }
      }
    }
  }

  _storeUserData() async {
    final bytes = controller.filePickerResult!.files.first.bytes;
    String url = await _uploadImage(bytes: bytes);
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    users
        .add(SystemUser(
            name: controller.nameController.text,
            role: controller.selectedRoleValue,
            email: controller.emailController.text,
            field: controller.selectedProfessionValue,
            id: "",
            uid: controller.userCredential!.user!.uid,
            userImgUrl: url,
            balance: '0',
            selectedTrainingIds: []).toJson())
        .then((value) {})
        .catchError((error) {});
  }

  _uploadImage({dynamic bytes}) async {
    try {
      final Reference storageRef = FirebaseStorage.instance
          .ref()
          .child('images/${DateTime.now().toString()}');
      late final String contentType;

      if (img.PngDecoder().isValidFile(bytes)) {
        contentType = 'image/png';
      } else if (img.JpegDecoder().isValidFile(bytes)) {
        contentType = 'image/jpeg';
      } else {
        throw Exception('Unsupported image format.');
      }

      final metadata = SettableMetadata(
        contentType: contentType,
      );
      final UploadTask uploadTask = storageRef.putData(bytes, metadata);
      final TaskSnapshot snapshot = (await uploadTask);
      final String url = await snapshot.ref.getDownloadURL();
      print("URL for the image: $url");
      return url;
    } catch (error) {
      throw UnKnowException();
    }
  }
}
