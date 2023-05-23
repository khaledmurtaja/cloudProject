import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:getx_architecture/App/modules/manegerHome/controller.dart';
import 'package:http/http.dart' as http;
import '../../../core/errors/exceptions.dart';
import '../../../core/values/email_service_consts.dart';
import '../../../core/values/roles.dart';
import '../../data/models/trainings.dart';
import '../../data/models/user.dart';
import 'package:image/image.dart' as img;

class ManagerHomeRepository {
  final collection = Get.find<CollectionReference>(tag: "users");
  int advisorNumber = 0;
  int traineeNumber = 0;

  Future<void> updateIdField(
      {required String uid, required String newId}) async {
    try {
      final snapshot =
          await collection.where('uid', isEqualTo: uid).limit(1).get();
      for (var element in snapshot.docs) {
        element.reference.update({'id': newId});
      }
    } catch (e) {
      print(e.toString());
      throw FailedToUpdatedIdException();
    }
  }

  sendEmail(
      {required String name,
      required String email,
      required String message}) async {
    try {
      final url = Uri.parse(EmailService.apiUrl);
      await http.post(url,
          headers: {'Content-Type': 'application/json'},
          body: json.encode({
            'service_id': EmailService.serviceId,
            'template_id': EmailService.templateId,
            'user_id': EmailService.userId,
            'template_params': {
              'from_name': name,
              'from_email': EmailService.formEmail,
              "to_email": email,
              'message': message
            }
          }));
    } catch (e) {
      throw FailedToSendEmailException();
    }
  }

  Future<int> getAdvisorsNumber() async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance.collection('users').get();
      for (var doc in snapshot.docs) {
        Map<String, dynamic>? data = doc.data();
        String role = data['role'];
        if (role == Roles.advisor) {
          advisorNumber++;
        }
      }

      return advisorNumber;
    } catch (exception) {
      throw UnKnowException();
    }
  }

  Future<int> getTraineesCount() async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance.collection('users').get();
      for (var doc in snapshot.docs) {
        Map<String, dynamic>? data = doc.data();
        String role = data['role'];
        if (role == Roles.trainee) {
          traineeNumber++;
        }
      }

      return traineeNumber;
    } catch (exception) {
      throw UnKnowException();
    }
  }

  Future<List<SystemUser>> getUsers(
      {required String category, required String role}) async {
    try {
      final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('field', isEqualTo: category)
          .where('role', isEqualTo: role)
          .get();
      final List<SystemUser> advisors = querySnapshot.docs
          .map((doc) => SystemUser.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
      return advisors;
    } catch (e) {
      print('Error getting advisors: $e');
      return [];
    }
  }

  storeTrainingData() async {
    final controller = Get.find<ManagerHomeController>();
    final bytes = controller.filePickerResult!.files.first.bytes;
    controller.imgUrl = await _uploadCourseImage(bytes: bytes);
    CollectionReference trainings =
        FirebaseFirestore.instance.collection('trainings');
    trainings
        .add(Training(
                trainingName: controller.courseName.text,
                trainingId:trainings.doc().id ,
                category: controller.courseCategory,
                description: controller.courseDescription.text,
                dates: controller.attendanceDates,
                advisorId: controller.advisorId,
                advisorName: controller.advisorName,
                courseImageUrl: controller.imgUrl,
                price: controller.coursePrice.text,
                isPaidCourse: controller.isPaidCourse)
            .toJson())
        .then((value) {})
        .catchError((error) {});
  }

  _uploadCourseImage({dynamic bytes}) async {
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
