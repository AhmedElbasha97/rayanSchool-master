// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Utils/Colors_File.dart';
import '../Utils/constant.dart';
import '../Utils/localization_services.dart';
import '../Utils/memory.dart';



class NoDataWidget extends StatelessWidget {
  final Function refreshedFunc;
  final String text;
  final String imgPath;
 final bool hasRefreshButtonOrNot;
  final double height;
  final double width;
  const NoDataWidget({super.key, required this.refreshedFunc, required this.text, required this.imgPath, required this.hasRefreshButtonOrNot,  this.height=0,  this.width=0});

  @override
  Widget build(BuildContext context) {
    return
    SizedBox(
      height: height==0?MediaQuery.of(context).size.height:height ,
      width: width==0?MediaQuery.of(context).size.width:width ,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(imgPath,height: Get.width*0.65,),
            Text(text,style:   TextStyle(color: kDarkBlueColor, fontFamily: Get.find<StorageService>()
                .activeLocale ==
                SupportedLocales.english
                ? fontFamilyEnglishName
                : fontFamilyArabicName,fontWeight: FontWeight.bold,fontSize: 30),textAlign: TextAlign.center,),
            const SizedBox(height: 30,),
            hasRefreshButtonOrNot?
            InkWell(
              onTap: (){refreshedFunc();},
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Container(
                  height: 50,
                  width: 200,
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: kDarkBlueColor,
                        width: 2.0,
                        style: BorderStyle.solid
                    ),
                    borderRadius: BorderRadius.circular(10),

                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:  [Text(
                          "refresh",
                          style:  TextStyle(
                              fontFamily: Get.find<StorageService>()
                                  .activeLocale ==
                                  SupportedLocales.english
                                  ? fontFamilyEnglishName
                                  : fontFamilyArabicName,
                              color:kDarkBlueColor,
                              fontWeight: FontWeight.w800,
                              fontSize: 20)
                      ),
                        const SizedBox(width: 10,),
                         const Icon(Icons.refresh,color: kYellowColor,)
                      ],

                    ),
                  ),
                ),
              ),
            ):
            const SizedBox(),
          ],
        ),
      ),
    );
  }
}
