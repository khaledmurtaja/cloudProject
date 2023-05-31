import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:get/get.dart';

import '../../../core/utils/helperFunctions.dart';
import '../../data/models/training.dart';
import '../../data/services/sharedPrefService.dart';

class TrainingDetaileAfterRecordingController extends GetxController {
  dynamic argumentData = Get.rootDelegate;
  Training? training;
  final RxBool isLoading = true.obs;
  Rx<PlatformFile?> selectedFile = Rx<PlatformFile?>(null);
  var uId = ''.obs;
  final sharedPref = Get.find<AppSharedPref>();

  Future<void> getUid() async {
    String? uidValue;
    uidValue = await sharedPref.getStringValue(key: 'Uid');

    uId.value = uidValue ?? '';

    update();
  }

  void pickFile() async {
    print(training!.id);
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);
    if (result != null && result.files.isNotEmpty) {
      selectedFile.value = result.files.first;
    }
  }

  Future<void> uploadFile() async {
    final storage = FirebaseStorage.instance;
    final firestore = FirebaseFirestore.instance;

    if (selectedFile.value != null) {
      final file = selectedFile.value!;
      final storageRef = storage.ref().child(file.name);
      final uploadTask = storageRef.putData(file.bytes!);
      final snapshot = await uploadTask.whenComplete(() => null);
      final downloadUrl = await snapshot.ref.getDownloadURL();

      final documentSnapshot = await firestore
          .collection('users')
          .doc(uId.value)
          .collection('files')
          .doc(training!.id)
          .get();

      if (documentSnapshot.exists) {
        await firestore
            .collection('users')
            .doc(uId.value)
            .collection('files')
            .doc(training!.id)
            .update({
          'files': FieldValue.arrayUnion([
            {
              'name': file.name,
              'url': downloadUrl,
            }
          ])
        });
      } else {
        await firestore
            .collection('users')
            .doc(uId.value)
            .collection('files')
            .doc(training!.id)
            .set({
          'files': [
            {
              'name': file.name,
              'url': downloadUrl,
            }
          ]
        });
      }

      selectedFile.value = null;
      Get.snackbar('Success', 'File uploaded successfully');
    } else {
      Get.snackbar('Error', 'No file selected');
    }
  }

  @override
  void onInit() async {
    await getUid();
    training = await argumentData.arguments()['trainingObject'] as Training;
    isLoading.value = false;
  }
}
