import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../core/errors/exceptions.dart';
import '../../../core/values/email_service_consts.dart';

class ManegerHomeRepository {
  final collection = Get.find<CollectionReference>(tag: "users");
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
}
