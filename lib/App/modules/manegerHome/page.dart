import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:getx_architecture/App/modules/manegerHome/controller.dart';
import 'package:getx_architecture/core/values/imagePaths.dart';
import '../../../core/utils/helperFunctions.dart';
import '../../../core/values/colors.dart';
import '../../widgets/drawerItem.dart';

class ManagerHomesScreen extends GetView<ManagerHomeController> {
  const ManagerHomesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: null,
      body: Row(
        children: [
          GetBuilder<ManagerHomeController>(
            builder: (controller) {
              return Container(
                color: buttonColor,
                width: getMediaQueryWidth(context: context, value: 250),
                child: Column(
                  children: [
                    SizedBox(
                      height: getMediaQueryHeight(context: context, value: 197),
                    ),
                    Text(
                      'Main',
                      style: TextStyle(
                          fontSize: 24.spMin,
                          fontWeight: FontWeight.w600,
                          color: mainTextColor),
                    ),
                    SizedBox(
                      height: getMediaQueryHeight(context: context, value: 28),
                    ),
                    DrawerItem(
                      text: 'statistics',
                      isPointerShown: controller.isStatisticsSelected,
                      iconPath: ImagePaths.statisticsIcon,
                      onTap: () {
                        controller.onStatisticsSelected();
                      },
                    ),
                    SizedBox(
                      height: getMediaQueryHeight(context: context, value: 21),
                    ),
                    DrawerItem(
                      text: 'courses',
                      isPointerShown: controller.isCoursesSelected,
                      iconPath: ImagePaths.coursesIcon,
                      onTap: () {
                        controller.onCoursesSelected();
                      },
                    ),
                    SizedBox(
                      height: getMediaQueryHeight(context: context, value: 21),
                    ),
                    DrawerItem(
                      isPointerShown: controller.isRequestsSelected,
                      text: 'Requests',
                      iconPath: ImagePaths.requestsIcon,
                      onTap: () {
                        controller.onRequestsSelected();
                      },
                    ),
                    SizedBox(
                      height: getMediaQueryHeight(context: context, value: 21),
                    ),
                    DrawerItem(
                      isPointerShown: controller.isTraineesSelected,
                      text: 'Trainees',
                      iconPath: ImagePaths.traineesIcon,
                      onTap: () {
                        controller.onTraineesSelected();
                      },
                    ),
                    SizedBox(
                      height: getMediaQueryHeight(context: context, value: 21),
                    ),
                    DrawerItem(
                      isPointerShown: controller.isAdvisorsSelected,
                      text: 'advisors',
                      iconPath: ImagePaths.advisorIcon,
                      onTap: () {
                        controller.onAdvisorSelected();
                      },
                    ),
                    SizedBox(
                      height: getMediaQueryHeight(context: context, value: 21),
                    ),
                    DrawerItem(
                      isPointerShown: controller.isBannerSelected,
                      text: 'Banners',
                      iconPath: ImagePaths.bannerIcon,
                      onTap: () {
                        controller.onBannerSelected();
                      },
                    )
                  ],
                ),
              );
            },
          ),
          GetBuilder<ManagerHomeController>(
            builder: (controller){
              return Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                      left: getMediaQueryWidth(context: context, value: 40)),
                  child: controller.pages[controller.currentPageIndex]
                ),
              );
            },
          )
        ],
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: const Text("maneger"),
  //       centerTitle: false,
  //     ),
  //     floatingActionButton: FloatingActionButton(
  //       onPressed: () {
  //         Get.toNamed(
  //           Routes.ADD_TRAINING,
  //         );
  //       },
  //       child: const Icon(Icons.add),
  //     ),
  //     body: GetBuilder<ManegerHomeController>(builder: (controller) {
  //       if (controller.snapshot == null) {
  //         return const Center(child: CircularProgressIndicator());
  //       } else {
  //         return _buildTable(querySnapshot: controller.snapshot!);
  //       }
  //     }),
  //   );
  // }

  // Widget _buildTable({required QuerySnapshot querySnapshot}) {
  //   if (querySnapshot.docs.isEmpty) {
  //     return const Center(child: Text('No users found'));
  //   } else {
  //     final List<DataRow> rows = querySnapshot.docs.map((document) {
  //       return DataRow(
  //         cells: [
  //           DataCell(Text(document['email'] ?? '')),
  //           DataCell(Text(document['field']?.toString() ?? '')),
  //           DataCell(Text(document['role'] ?? '')),
  //           DataCell(Text(document['name'] ?? '')),
  //           DataCell(ElevatedButton(
  //             onPressed: () async {
  //               final newId = DateTime.now().microsecondsSinceEpoch;
  //               await controller.updateIdField(
  //                 uid: document['uid'],
  //                 newId: newId.toString(),
  //               );
  //               await controller.sendEmail(
  //                   name: EmailService.companyName,
  //                   email: document['email'],
  //                   message: "Use this id to log in $newId");
  //             },
  //             child: const Text("verify"),
  //           ))
  //         ],
  //       );
  //     }).toList();
  //
  //     return DataTable(
  //       columns: const [
  //         DataColumn(label: Text('email')),
  //         DataColumn(label: Text('field')),
  //         DataColumn(label: Text('role')),
  //         DataColumn(label: Text('name')),
  //         DataColumn(label: Text("")),
  //       ],
  //       rows: rows,
  //     );
  //   }
  // }
}
