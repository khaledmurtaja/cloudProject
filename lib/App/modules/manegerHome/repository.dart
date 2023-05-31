import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:getx_architecture/App/data/models/trainings.dart';
import 'package:getx_architecture/App/modules/manegerHome/controller.dart';
import 'package:http/http.dart' as http;
import '../../../core/errors/exceptions.dart';
import '../../../core/values/email_service_consts.dart';
import '../../../core/values/roles.dart';
import '../../data/models/ad.dart';
import '../../data/models/user.dart';
import 'package:image/image.dart' as img;

class ManagerHomeRepository {
  final collection = Get.find<CollectionReference>(tag: "users");
  int advisorNumber = 0;
  int traineeNumber = 0;
  int coursesNumber = 0;
  int requestsNumber = 0;

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

  Future<int> getCoursesCount() async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance.collection('trainings').get();
      coursesNumber = snapshot.size;
      return coursesNumber;
    } catch (exception) {
      throw UnKnowException();
    }
  }

  Future<int> getRequestsCount() async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection('users')
          .where('id', isEqualTo: "")
          .get();
      for (var doc in snapshot.docs) {
        Map<String, dynamic>? data = doc.data();
        requestsNumber++;
      }

      return requestsNumber;
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

  Future<List<Ad>> getBanners() async {
    try {
      final QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('ads').get();
      final List<Ad> ads = querySnapshot.docs
          .map((doc) =>
              Ad(imageUrl: doc['imageUrl'], name: doc['name'], id: doc['id']))
          .toList();
      return ads;
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
    String id = trainings.doc().id;
    CollectionReference usersCollection =
        FirebaseFirestore.instance.collection('users');
    trainings
        .add(Training(
                trainingName: controller.courseName.text,
                trainingId: id,
                category: controller.courseCategory,
                description: controller.courseDescription.text,
                dates: controller.attendanceDates,
                advisorId: controller.advisorId,
                advisorName: controller.advisorName,
                courseImageUrl: controller.imgUrl,
                price: controller.coursePrice.text,
                isPaidCourse: controller.isPaidCourse)
            .toJson())
        .then((value) {
      FirebaseFirestore.instance
          .collection('users')
          .where("id", isEqualTo: controller.advisorId)
          .get()
          .then((value) {
        DocumentSnapshot userSnapshot = value.docs.first;
        String userId = userSnapshot.id;
        print(userId);
        usersCollection.doc(userId).update({
          'selected_training_ids': FieldValue.arrayUnion([id])
        }).then((value) {
          print('Training ID added successfully');
        }).catchError((error) {
          print('Failed to add training ID: $error');
        });
      });
    });
  }

  storeBannerData() async {
    final controller = Get.find<ManagerHomeController>();
    final bytes = controller.bannerFilePickerResult!.files.first.bytes;
    controller.bannerImageUrl = await _uploadCourseImage(bytes: bytes);
    CollectionReference ads = FirebaseFirestore.instance.collection('ads');
    String id = ads.doc().id;
    ads.add({
      'name': controller.bannerName.text,
      'imageUrl': controller.bannerImageUrl,
      'id': id
    }).then((value) {
      controller.banners.add(Ad(
          id: id,
          imageUrl: controller.bannerImageUrl,
          name: controller.bannerName.text));
    }).catchError((error) {});
  }

  updateBannerData({required int index}) async {
    final controller = Get.find<ManagerHomeController>();
    final bytes = controller.bannerFilePickerResult!.files.first.bytes;
    controller.bannerImageUrl = await _uploadCourseImage(bytes: bytes);
    CollectionReference ads = FirebaseFirestore.instance.collection('ads');

    // Assuming the field to match is "id" and the desired value is 123
    QuerySnapshot querySnapshot =
        await ads.where('id', isEqualTo: controller.banners[index].id).get();

    if (querySnapshot.size > 0) {
      String documentId = querySnapshot.docs.first.id;

      ads.doc(documentId).update({
        'name': controller.bannerUpdatedName.text,
        'imageUrl': controller.bannerImageUrl,
      }).then((_) {
        // Update successful
      }).catchError((error) {
        // Error handling
      });
    }
  }

  Future<void> fetchTrainings() async {
    final controller = Get.find<ManagerHomeController>();

    try {
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('trainings').get();

      controller.trainings = snapshot.docs
          .map((doc) => Training.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('Error fetching trainings: $e');
    }
  }

  Future<void> fetchTrainees() async {
    final controller = Get.find<ManagerHomeController>();

    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('role', isEqualTo: Roles.trainee)
          .get();

      controller.trainees = snapshot.docs
          .map((doc) => SystemUser.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('Error fetching trainings: $e');
    }
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
