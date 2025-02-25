import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rayanSchool/services/loggedUser.dart';
import 'package:rayanSchool/views/Student/schadules_detailed_screen.dart';
import 'package:dio/dio.dart';
import 'dart:io';
import '../../I10n/app_localizations.dart';
import '../../globals/commonStyles.dart';
import '../../globals/widgets/loader.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../models/Student/schadules_student_model.dart';

class SchadulesScreen extends StatefulWidget {
  const SchadulesScreen({Key? key}) : super(key: key);

  @override
  _SchadulesScreenState createState() => _SchadulesScreenState();
}

class _SchadulesScreenState extends State<SchadulesScreen> {
  bool isLoading = true;
  SchadulesStudentModel? data;
  @override
  void initState() {
    super.initState();
    getData();
  }
  downloadImage() async {
    String savename = "schedules.png";
    String path ="";
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
      //add more permission to request here.
    ].request();

    if(statuses[Permission.storage]!.isGranted){
      Directory dir = Directory('/storage/emulated/0/Download');
      if(dir != null){
        String savePath = "${dir.path}/$savename";
        path = "${dir.path}/$savename";
        print(savePath);
        //output:  /storage/emulated/0/Download/banner.png

        try {
          await Dio().download(
              data?.img??"",
              savePath,
              onReceiveProgress: (received, total) {
                if (total != -1) {
                  print("${(received / total * 100).toStringAsFixed(0)}%");
                  //you can build progressbar feature too
                }
              });
          print("Image is saved to download folder.");
        } on DioError catch (e) {
          print(e.message);
        }
      }
    }else{
      print("No permission to read and write.");
    }


    final snackBar = SnackBar(

      content:  Container(
        height: 200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:  [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.file_copy,color: Colors.white,),
            ),
            Row(
              children: [
                const Text('اسم الملف:'),
                Text(savename,),
              ],
            ),
            const Text("تم تحميله في ملف مساره هو:",textDirection: TextDirection.rtl,),

            Text(path,),

          ],
        ),
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);

  }
  getData() async {
    data = await LoggedUser().getSchadules();
    isLoading = false;
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:mainColor ,
        title: Text(
          AppLocalizations.of(context)?.translate('schedule')??"",

        ),
      ),
      body: data?.img?.isEmpty??true?
      Container(
        height: MediaQuery.of(context).size.height*0.75,
        width: MediaQuery.of(context).size.width,
        child: Column(

          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Image.asset("assets/images/noData.png"),
            ),
            SizedBox(height: 20,),
            Text(Localizations.localeOf(context).languageCode == "en"
                ?"no schadule available":"لا يوجد جداول متوفرة الآن",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20

              ),),
          ],
        ),
      ):ListView(
        shrinkWrap: true,
        children: [


          isLoading?Container():GestureDetector(
            child: Hero(
                tag: 'imageHero',
                child: CachedNetworkImage(
                  imageUrl:  data?.img??"",
                  imageBuilder: ((context, image){
                    return  Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height*0.3,
                        margin: const EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                            image: DecorationImage(
                              image: image,
                              fit: BoxFit.cover,
                            ),
                            borderRadius:
                            const BorderRadius.all(Radius.circular(15))

                        )
                    );
                  }),
                  placeholder:  (context, image){
                    return  Padding(
                      padding:  const EdgeInsets.all(5),
                      child: Container(
                          decoration: const BoxDecoration(
                              borderRadius:
                              BorderRadius.all(Radius.circular(15))
                          ),
                          child: Loader(width: MediaQuery.of(context).size.width,height: 150.0)),
                    );
                  },
                  errorWidget:(context, url, error){
                    return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/images/no_data_slideShow.png"),
                              fit: BoxFit.fill,
                            ),
                            borderRadius:
                            BorderRadius.all(Radius.circular(15))

                        )
                    );
                  },
                )
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return  SchadulesDetailedImageScreen(link: data?.img??"",);
              }));
            },
          ),
          const SizedBox(
            height: 15,
          ),
          isLoading?Container():Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 30),
              child: InkWell(
                onTap: () {
                  downloadImage();
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  height: 40,
                  decoration: BoxDecoration(
                      color: mainColor,
                      borderRadius:
                      const BorderRadius.all(Radius.circular(10))),
                  alignment: Alignment.center,
                  child: const Text(
                    "حمل الجدول",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
