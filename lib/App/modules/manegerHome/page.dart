import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_architecture/App/modules/manegerHome/controller.dart';
import 'package:getx_architecture/core/values/email_service_consts.dart';

import '../../../routes/routes.dart';

class ManegerHomesScreen extends GetView<ManegerHomeController> {
  const ManegerHomesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("maneger"),
        centerTitle: false,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(
            Routes.ADD_TRAINING,
          );
        },
        child: const Icon(Icons.add),
      ),
      body: GetBuilder<ManegerHomeController>(builder: (controller) {
        if (controller.snapshot == null) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return _buildTable(querySnapshot: controller.snapshot!);
        }
      }),
    );
  }

  Widget _buildTable({required QuerySnapshot querySnapshot}) {
    if (querySnapshot.docs.isEmpty) {
      return const Center(child: Text('No users found'));
    } else {
      final List<DataRow> rows = querySnapshot.docs.map((document) {
        return DataRow(
          cells: [
            DataCell(Text(document['email'] ?? '')),
            DataCell(Text(document['field']?.toString() ?? '')),
            DataCell(Text(document['role'] ?? '')),
            DataCell(Text(document['name'] ?? '')),
            DataCell(ElevatedButton(
              onPressed: () async {
                final newId = DateTime.now().microsecondsSinceEpoch;
                await controller.updateIdField(
                  uid: document['uid'],
                  newId: newId.toString(),
                );
                await controller.sendEmail(
                    name: EmailService.companyName,
                    email: document['email'],
                    message: "Use this id to log in $newId");
              },
              child: const Text("verify"),
            ))
          ],
        );
      }).toList();

      return DataTable(
        columns: const [
          DataColumn(label: Text('email')),
          DataColumn(label: Text('field')),
          DataColumn(label: Text('role')),
          DataColumn(label: Text('name')),
          DataColumn(label: Text("")),
        ],
        rows: rows,
      );
    }
  }
}
