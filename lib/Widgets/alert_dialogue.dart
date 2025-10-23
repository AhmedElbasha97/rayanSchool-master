// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

import '../Utils/Colors_File.dart';
import '../Utils/constant.dart';
import '../Utils/localization_services.dart';
import '../Utils/memory.dart';
import 'custom_text_widget.dart';


class AlertDialogue extends StatelessWidget {
  const AlertDialogue({super.key, required this.alertTitle, required this.alertText, this.containerHeight=0, required this.alertIcon});
  final String alertTitle;
  final String alertText;
  final String alertIcon;
  final double? containerHeight;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor:Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 0,
      child: Container(
        height:containerHeight==0?Get.height*0.36:containerHeight??0+Get.height*0.14,
        width: Get.width * 0.9,
        decoration:  BoxDecoration(
          boxShadow: const [
            BoxShadow(
              color: kGrayColor,
              blurRadius: 2,
              offset:
              Offset(1, 1), // Shadow position
            ),
          ],
          borderRadius: BorderRadius.circular(25),

          image: const DecorationImage(
              image: AssetImage("assets/images/backgroundImage.png"),
              fit: BoxFit.cover),
        ),

        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: kLightBlueColor,
              boxShadow: const [
                BoxShadow(
                  color: kGrayColor,
                  blurRadius: 2,
                  offset: Offset(1, 1), // Shadow position
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
            Container(
              width: 70,
              height:  70,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            color: kDarkBlueColor,
            boxShadow: [
              BoxShadow(
                color: kGrayColor,
                blurRadius: 2,
                offset: Offset(1, 1), // Shadow position
              ),
            ],
          ),
              child: const Center(
                child: Icon(Icons.clear,color: Colors.white,size: 30,),
              ),
            ),
                Center(
                  child:  Container(
                    width:Get.width*0.7,
                    child: CustomText(
                      // alertTitle,
                      alertTitle,
                      textAlign: TextAlign.center,
                      style:  TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        letterSpacing: 0,
                        fontFamily:
                        Get.find<StorageService>()
                            .activeLocale ==
                            SupportedLocales.english
                            ? fontFamilyEnglishName
                            : fontFamilyArabicName,
                        color: kDarkBlueColor,
                      ),
                    ),
                  ),

                ),
                Center(
                  child:  Container(
                    width:Get.width*0.7,
                    child: CustomText(
                      // alertText,
                      alertText,
                      textAlign: TextAlign.center,
                      style:  TextStyle(

                        fontSize: 18,
                        letterSpacing: 0,
                        fontFamily:
                        Get.find<StorageService>()
                            .activeLocale ==
                            SupportedLocales.english
                            ? fontFamilyEnglishName
                            : fontFamilyArabicName,
                        color: kDarkBlueColor,
                      ),
                    ),
                  ),

                ),
                InkWell(
                    onTap:(){
                      Get.back();
                    },
                    child: Container(
                      height: Get.height * 0.07,
                      width: Get.width * 0.5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: kDarkBlueColor,
                        boxShadow: const [
                          BoxShadow(
                            color: kGrayColor,
                            blurRadius: 2,
                            offset:
                            Offset(1, 1), // Shadow position
                          ),
                        ],
                      ),
                      child: Center(
                        child: CustomText(
                          "حسنآ",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily:
                              Get.find<StorageService>()
                                  .activeLocale ==
                                  SupportedLocales.english
                                  ? fontFamilyEnglishName
                                  : fontFamilyArabicName,
                              color: kLightBlueColor,
                              fontWeight: FontWeight.w700,
                              fontSize: 18),
                        ),
                      ),
                    ),
                )
              ],
            ),
          ),
        ),
      ).animate(onPlay: (controller) => controller.repeat())

          .animate() // this wraps the previous Animate in another Animate
          .fadeIn(duration: 700.ms, curve: Curves.easeOutQuad)
          .slide(),
    );
  }
}
