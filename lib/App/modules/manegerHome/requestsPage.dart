import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../core/utils/helperFunctions.dart';
import '../../../core/values/colors.dart';
import '../../../core/values/email_service_consts.dart';
import '../../../core/values/fontsStyles.dart';
import '../../../core/values/imagePaths.dart';
import '../../widgets/customButton.dart';
import 'controller.dart';

class RequestsPage extends StatelessWidget {
  const RequestsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Padding(
        padding: EdgeInsets.only(
            left: getMediaQueryWidth(context: context, value: 40),
            top: getMediaQueryHeight(context: context, value: 80)),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    ImagePaths.blackRequestsIcon,
                    height: 32.spMin,
                    width: 32.spMin,
                  ),
                  SizedBox(
                    width: getMediaQueryWidth(context: context, value: 8),
                  ),
                  Text(
                    "Requests",
                    style: TextStyle(
                        fontSize: 32.spMin,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                ],
              ),
              const SizedBox(height: 20,),
               GetBuilder<ManagerHomeController>(
                 builder: (controller){
                   if(controller.isVerifying){
                     return const LinearProgressIndicator();
                   }else{
                     return Container();
                   }
                 },
               ),
              SizedBox(
                height: getMediaQueryHeight(context: context, value: 40),
              ),
              GetBuilder<ManagerHomeController>(
                builder: (controller) {
                  if (controller.isFetchingUsersWithEmptyIdLoading) {
                    return const CircularProgressIndicator();
                  } else {
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.spMin),
                            color: textFormFieldColor),
                        child: DataTable(
                            horizontalMargin: 20,
                            border: const TableBorder(
                                top: BorderSide(),
                                verticalInside: BorderSide(),
                                horizontalInside: BorderSide()),
                            columns: [
                              DataColumn(
                                  label: Text(
                                '',
                                style: FontStyles.tableHeadingStyle,
                              )),
                              DataColumn(
                                  label: Text(
                                'Email',
                                style: FontStyles.tableHeadingStyle,
                              )),
                              DataColumn(
                                  label: Text(
                                'Field',
                                style: FontStyles.tableHeadingStyle,
                              )),
                              DataColumn(
                                  label: Text(
                                'Role',
                                style: FontStyles.tableHeadingStyle,
                              )),
                              DataColumn(
                                  label: Text(
                                'Name',
                                style: FontStyles.tableHeadingStyle,
                              )),
                              DataColumn(
                                  label: Text(
                                '',
                                style: FontStyles.tableHeadingStyle,
                              )),
                            ],
                            rows: controller.usersWithEmptyIdList.map((e) {
                              return DataRow(cells: [
                                DataCell(Text('#',
                                    style: FontStyles.tableCellStyle)),
                                DataCell(Text(
                                  e.email,
                                  style: FontStyles.tableCellStyle,
                                )),
                                DataCell(Text(e.field,
                                    style: FontStyles.tableCellStyle)),
                                DataCell(Text(e.role,
                                    style: FontStyles.tableCellStyle)),
                                DataCell(Text(e.name,
                                    style: FontStyles.tableCellStyle)),
                                DataCell(
                                    ElevatedButton(
                                      onPressed: () async {
                                        controller.selectedUId=e.uid;
                                        String userId = DateTime.now()
                                            .microsecondsSinceEpoch
                                            .toString();
                                        await controller.updateIdField(
                                            uid: e.uid, newId: userId);
                                        if (controller.isVerifying) {
                                          await controller.sendEmail(
                                              name: EmailService.companyName,
                                              email: e.email,
                                              message: "Your ID is: $userId");
                                        }
                                      },
                                      child: const Text("Verify"),
                                    )
                                   )
                              ]);
                            }).toList()),
                      ),
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
