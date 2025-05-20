import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rayanSchool/I10n/app_localizations.dart';
import 'package:rayanSchool/globals/widgets/mainButton.dart';
import 'package:rayanSchool/models/teacher/HomeWorkDetails.dart';
import 'package:rayanSchool/services/teachersService.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeWorkDetailsScreen extends StatefulWidget {
  final String id;
  HomeWorkDetailsScreen({this.id = ""});
  @override
  _HomeWorkDetailsScreenState createState() => _HomeWorkDetailsScreenState();
}

class _HomeWorkDetailsScreenState extends State<HomeWorkDetailsScreen> {
  bool isLoading = true;
  List<HomeWorkDetailsTeacherModel> homework = [];
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? id = prefs.getString("id");
    if(prefs.getString("type") == "TEACHER"){
      homework = await TeacherService()
          .getHomeworkDetails(id: id ?? "", homeworkId: widget.id);
      isLoading = false;
      setState(() {});
    }else{
      homework = await TeacherService()
          .getHomeworkDetails(id: widget.id, homeworkId: id ?? "");
      isLoading = false;
      setState(() {});
    }
  }
  Future<bool> hasAcceptedPermissions() async {
    if (Platform.isAndroid) {
      if (await requestPermission(Permission.storage) &&
          // access media location needed for android 10/Q
          await requestPermission(Permission.accessMediaLocation) &&
          // manage external storage needed for android 11/R
          await requestPermission(Permission.manageExternalStorage)) {
        return true;
      } else {
        return false;
      }
    }
    if (Platform.isIOS) {
      if (await requestPermission(Permission.photos)) {
        return true;
      } else {
        return false;
      }
    } else {
      // not android or ios
      return false;
    }
  }
  Future<bool> requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      var result = await permission.request();
      if (result == PermissionStatus.granted) {
        return true;
      }
    }
    return false;
  }
  getFileName(String filePath){
    return filePath.split('/').last;
  }
  Future<bool> saveFile() async {
    if (!await hasAcceptedPermissions()) return false;

    try {
      Directory? baseDir = await getExternalStorageDirectory();
      String newPath = baseDir!.path.split("Android")[0] + "AlRayan_App";
      Directory targetDir = Directory(newPath);

      await targetDir.create(recursive: true);

      String fileUrl = homework[0].homeworkFile ?? "";
      String fileName = getFileName(fileUrl);
      File saveFile = File("${targetDir.path}/$fileName");

      await Dio().download(fileUrl, saveFile.path);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.green,
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.file_copy, color: Colors.white),
              SizedBox(height: 8),
              Text("${Localizations.localeOf(context).languageCode == "en" ? 'File name:' : 'اسم الملف:'} $fileName"),
              Text(Localizations.localeOf(context).languageCode == "en"
                  ? "Saved to: $newPath"
                  : "تم حفظه في: $newPath"),
            ],
          ),
          duration: Duration(seconds: 4),
        ),
      );

      return true;
    } catch (e) {
      print("❌ Error saving file: $e");
      return false;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              padding: EdgeInsets.all(10),
              itemCount: homework.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${homework[index].title}"),
                        Text("${homework[index].date}"),
                        Text("${homework[index].teacherName ?? ""}"),
                        Html(data: "${homework[index].homeworkDet}"),
                        homework[index].homeworkFile != null
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: AppBtn(
                                  label: AppLocalizations.of(context)
                                      ?.translate('download')??"",
                                  onClick: () async {
                                    saveFile();
                                  },
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
