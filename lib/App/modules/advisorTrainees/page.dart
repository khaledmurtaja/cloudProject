import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_architecture/App/modules/advisorTrainees/controller.dart';

import '../../data/models/trainee.dart';

class AdvisorTraineesScreen extends GetView<AdvisorTraineesController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Trainee List'),
        ),
        body: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Filter:',
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                    DropdownButton<String>(
                      value: controller.selectedFilter.value,
                      onChanged: (value) => controller.setFilter(value!),
                      items: <String>['All', 'Free', 'Paid']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: FutureBuilder<List<UserModel>>(
                      future: controller.getTrainees('1683039479358000'),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text('Error: ${snapshot.error}'),
                          );
                        } else {
                          final trainees = snapshot.data;
                          if (trainees == null || trainees.isEmpty) {
                            return Center(
                              child: Text('No trainees found.'),
                            );
                          } else {
                            return ListView.builder(
                              itemCount: trainees.length,
                              itemBuilder: (context, index) {
                                final trainee = trainees[index];
                                return Card(
                                  child: ListTile(
                                    title: Text(trainee.name!),
                                    subtitle: Text(trainee.email!),
                                  ),
                                );
                              },
                            );
                          }
                        }
                      },
                    )),
              ),
            ],
          ),
        ));
  }
}
