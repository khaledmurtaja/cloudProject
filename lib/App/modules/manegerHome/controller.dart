import 'package:getx_architecture/App/modules/manegerHome/repository.dart';
import 'package:getx_architecture/core/utils/helperFunctions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ManegerHomeController extends GetxController {
  QuerySnapshot? snapshot;
  bool isLoading = false;
  final repo = Get.find<ManegerHomeRepository>();

  @override
  Future<void> onInit() async {
    await fetchUsersWithEmptyId();
    update();
  }

  Future<void> fetchUsersWithEmptyId() async {
    snapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('id', isEqualTo: '')
        .get();
    final List<QueryDocumentSnapshot<Object?>>? documents = snapshot?.docs;
    documents?.forEach((document) {
      // Do something with the document data
      print(document.data());
    });
  }

  updateIdField({required String uid, required String newId}) async {
    try {
      await repo.updateIdField(uid: uid, newId: newId);
      //back
    } catch (e) {
      print(e.toString());
      showSnackBar(
          message: "failed to update user ID",
          snackPosition: SnackPosition.TOP);
    }
  }

  sendEmail(
      {required String name,
      required String email,
      required String message}) async {
    try {
      print("ernter");
      await repo.sendEmail(name: name, email: email, message: message);
      showSnackBar(message: "sucess");
    } catch (e) {
      print("faillld;");
      showSnackBar(
          message: "failed to send email", snackPosition: SnackPosition.TOP);
    }
  }
}
