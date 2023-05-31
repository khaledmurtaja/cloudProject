import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:getx_architecture/core/values/imagePaths.dart';
import '../../../core/utils/helperFunctions.dart';
import '../../../core/values/colors.dart';
import '../../widgets/drawerItem.dart';
import 'controller.dart';

class AdvisorHomesScreen extends StatelessWidget {
  const AdvisorHomesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: null,
      body: Row(
        children: [
          GetBuilder<AdvisorController>(
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
                      'Welcome',
                      style: TextStyle(
                          fontSize: 40.spMin,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    controller.gettingUserDataLoading
                        ? const CircularProgressIndicator()
                        : ListTile(
                            leading: CircleAvatar(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.network(
                                    fit: BoxFit.fill,
                                    controller.advisor!.userImgUrl),
                              ),
                            ),
                      trailing: Column(
                        children: [
                          Expanded(
                            child: Text(
                                controller.advisor!.name,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 28.spMin
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              controller.advisor!.email,
                              style: TextStyle(
                                fontSize: 12.spMin,
                                color: Colors.white
                              ),
                            ),
                          )
                        ],
                      ),
                          ),
                    SizedBox(height: 20.h,),
                    DrawerItem(
                      text: 'My Courses',
                      isPointerShown: controller.isMyCoursesSelected,
                      iconPath: ImagePaths.statisticsIcon,
                      onTap: () async {
                        await controller.getCurrentUserData();
                        controller.onMyCoursesSelected();
                      },
                    ),
                    SizedBox(
                      height: getMediaQueryHeight(context: context, value: 21),
                    ),
                    DrawerItem(
                      text: 'My students',
                      isPointerShown: controller.isMyStudentsSelected,
                      iconPath: ImagePaths.coursesIcon,
                      onTap: () {
                        controller.onMyStudentsSelected();
                      },
                    ),
                    SizedBox(
                      height: getMediaQueryHeight(context: context, value: 100),
                    ),
                    DrawerItem(
                      isPointerShown: false,
                      text: 'Logout',
                      iconPath: ImagePaths.logoutIcon,
                      onTap: () {
                        controller.logout();
                      },
                    )
                  ],
                ),
              );
            },
          ),
          GetBuilder<AdvisorController>(
            builder: (controller) {
              return Expanded(
                child: Padding(
                    padding: EdgeInsets.only(
                        left: getMediaQueryWidth(context: context, value: 40)),
                    child: controller.pages[controller.currentPageIndex]),
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
