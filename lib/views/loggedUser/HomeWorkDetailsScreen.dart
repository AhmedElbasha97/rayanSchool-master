import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rayanSchool/I10n/app_localizations.dart';
import 'package:rayanSchool/globals/widgets/mainButton.dart';
import 'package:rayanSchool/models/homeWorkDetails.dart';
import 'package:rayanSchool/services/loggedUser.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../globals/commonStyles.dart';
import '../../services/teachersService.dart';

class HomeWorkDetailsScreen extends StatefulWidget {
  final String id;
  HomeWorkDetailsScreen({required this.id});
  @override
  _HomeWorkDetailsScreenState createState() => _HomeWorkDetailsScreenState();
}

class _HomeWorkDetailsScreenState extends State<HomeWorkDetailsScreen> {
  bool isLoading = true;
  List<HomeWorkDetails> homework = [];
  bool isDownloading = false;
  bool isFileDownloaded = false;

  String? lastSavedFilePath;
  @override
  void initState() {
    super.initState();
    getData();


  }

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? id = prefs.getString("id");
   if(prefs.getString("type") == "STUDENT"){

    homework =
        await LoggedUser().gethomeWorkDetails(id: id, homeWorkId: widget.id);
    isLoading = false;
    setState(() {});
   }else{
     homework =
     await TeacherService().gethomeWorkTeacherDetails(id: id, homeWorkId: widget.id);
     isLoading = false;
     setState(() {});
   }
  await checkIfFileExists();
  }
  Future<void> checkIfFileExists() async {
    if (lastSavedFilePath == null) {
      isFileDownloaded = false;
      setState(() {});
      return;
    }

    File file = File(lastSavedFilePath!);
    isFileDownloaded = await file.exists();
    setState(() {});
  }
  Future<bool> hasAcceptedPermissions() async {
    if (Platform.isAndroid) {
      final sdkInt = (await DeviceInfoPlugin().androidInfo).version.sdkInt;

      if (sdkInt >= 33) {
        // Android 13+ uses media permissions
        return await requestPermission(Permission.photos);
      } else {
        // Android 12 وأقل
        return await requestPermission(Permission.storage);
      }
    }

    if (Platform.isIOS) {
      return await requestPermission(Permission.photos);
    }

    return false;
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
    isDownloading = true;
    setState(() {});

    try {
      String? fileUrl = homework[0].homeworkFile;
      if (fileUrl == null || fileUrl.isEmpty) {
        isDownloading = false;
        setState(() {});
        print("❌ No file URL provided");
        return false;
      }

      String fileName = getFileName(fileUrl);

      final response = await Dio().get(
        fileUrl,
        options: Options(responseType: ResponseType.bytes),
      );

      Uint8List fileBytes = Uint8List.fromList(response.data);

      final res = await FileSaver.instance.saveFile(
        name: fileName.split('.').first,
        bytes: fileBytes,
        ext: fileName.split('.').last,
        mimeType: MimeType.other,
      );

      isDownloading = false;
      setState(() {});

      if (res != null) {
        lastSavedFilePath = res;
        checkIfFileExists();
        print(res);// هنا بنخزن المسار المؤقت
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.green,
              content: Text(
                Localizations.localeOf(context).languageCode == "en"
                    ? "✅ File saved successfully"
                    : "✅ تم حفظ الملف بنجاح",
              ),
            ),
          );
        }
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print("❌ Error saving file: $e");
      isDownloading = false;
      setState(() {});
      return false;
    }
  }
  Future<void> openDownloadedFile() async {
    if (lastSavedFilePath == null) {
      print("❌ No saved file to open");
      return;
    }

    final result = await OpenFile.open(lastSavedFilePath!);
    print("📂 Open result: ${result.message}");
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
                        (homework[index].homeworkFile?.isNotEmpty)??false
                            ? isDownloading?Container(
                          decoration: BoxDecoration(
                              color: mainColor,
                              shape: BoxShape.circle
                          ),

                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: CircularProgressIndicator(

                              ),
                            ),
                          ),
                        ):Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: AppBtn(
                                  label: AppLocalizations.of(context)
                                      ?.translate('download')??"",
                                  onClick: () async {
                                    if(homework[index].homeworkFile != null) {
                                     if(!await saveFile()){
                                       final snackBar = SnackBar(content:
                                       Row(children: [
                                         Icon(Icons.close,color: Colors.white,),
                                         SizedBox(width: 10,),
                                         Text(Localizations.localeOf(context).languageCode == "en" ?'There is no file available for download':'ليس هناك ملف متاح للتحميل',style: TextStyle(
                                             color: Colors.white,
                                             fontWeight: FontWeight.bold
                                         ),
                                         ),
                                       ],),
                                           backgroundColor:Colors.red
                                       );
                                       ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                     }

                                    }else{

                                    }
                                  },
                                ),
                              )
                            : Center(child: Text(
                            Localizations.localeOf(context).languageCode == "en"?"There is no file attached to this homework.":"ليس  هناك ملف مرفق مع هذا الواجب المدرسى",
                            style:  TextStyle(

                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                              color: Colors.black
                              ,
                            )
                        ),
                        ),
                        isFileDownloaded?Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: AppBtn(
                            label: Localizations.localeOf(context).languageCode == "en"?"Open file":"فتح الملف",
                            onClick: () async {
                             openDownloadedFile();
                            },
                          ),
                        ):Container(),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
