import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rayanSchool/Widgets/loader.dart';
import '../../../Utils/localization_services.dart';
import '../../../Utils/memory.dart';
import '../../../globals/commonStyles.dart';
import 'controller/attendance_controller.dart';

class AttendanceScreen extends StatelessWidget {
  AttendanceScreen({Key? key}) : super(key: key);

  final AttendanceController controller = Get.put(AttendanceController(), permanent: false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: mainColor),
        backgroundColor: const Color(0xFFdcdbdb),
        title: Image.asset(
          "assets/images/logo.png",
          scale: 4.5,
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Loader();
        }

        if (controller.attendanceList.isEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                Get.find<StorageService>().activeLocale ==
                    SupportedLocales.english
                    ?"No attendance records available":"لا توجد سجلات حضور متاحة",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[700],
                ),
              ),
            ),
          );
        }

        return ListView.separated(
          itemCount: controller.attendanceList.length,
          itemBuilder: (context, index) {
            final attendance = controller.attendanceList[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                title: Text("${attendance.status ?? 'Unknown'}"),
                trailing: Text(controller.formatDateOrTime(attendance)),
              ),
            );
          },
          separatorBuilder: (context, index) =>  Divider(color: mainColor,),
        );
      }),
    );
  }
}
