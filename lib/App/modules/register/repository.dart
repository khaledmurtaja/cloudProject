import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:getx_architecture/App/modules/register/controller.dart';
import '../../data/models/user.dart';

class RegisterRepository {
  final controller = Get.find<RegisterController>();
  registerUser({required String email, required String password}) async {
    try {
      controller.userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await _storeUserData();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  _storeUserData() async {
    print("object");
    print(controller.userCredential!.user!.uid);
    final bytes = controller.filePickerResult!.files.first.bytes;
    String url = await _uploadImage(bytes: bytes);
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    users
        .add(SystemUser(
                fullName: controller.nameController.text,
                role: controller.selectedRoleValue,
                email: controller.emailController.text,
                urlForSupportDocument: url,
                field: controller.selectedProfessionValue,
                id: "",
                uid: controller.userCredential!.user!.uid)
            .toJson())
        .then((value) {
      print("user stored");
    }).catchError((error) {
      print(error.toString());
    });
  }

  _uploadImage({dynamic bytes}) async {
    try {
      final Reference storageRef = FirebaseStorage.instance
          .ref()
          .child('images/${DateTime.now().toString()}');
      final UploadTask uploadTask = storageRef.putData(bytes);
      final TaskSnapshot snapshot = (await uploadTask);
      final String url = await snapshot.ref.getDownloadURL();
      print("URL for the image: $url");
      return url;
    } catch (error) {
      print(error.toString());
    }
  }
}
