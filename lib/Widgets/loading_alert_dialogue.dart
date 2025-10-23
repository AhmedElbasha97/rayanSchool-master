import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

import '../Utils/Colors_File.dart';
import '../Utils/constant.dart';
import '../Utils/localization_services.dart';
import '../Utils/memory.dart';
import 'custom_text_widget.dart';

class LoadingAlertDialogue extends StatelessWidget {
  const LoadingAlertDialogue({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor:Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 0,
      child: Container(
        height:Get.height*0.3,
        width: Get.width * 0.7,
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
                Image.asset("assets/images/3dgifmaker00286.gif",width: Get.width*0.35, fit: BoxFit.fitWidth),

                Center(
                  child:  SizedBox(
                    width:Get.width*0.7,
                    child: CustomText(
                      // alertTitle,
                      "جارى التحميل",
                      textAlign: TextAlign.center,
                      style:  TextStyle(
                        fontWeight: FontWeight.w800,
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
                    )
                  ).animate(onPlay: (controller) => controller.repeat())
                      .shimmer(duration: 1200.ms, color:  kLightBlueColor.withAlpha(10))
                      .animate() // this wraps the previous Animate in another Animate
                      .fadeIn(duration: 700.ms, curve: Curves.easeOutQuad)
                      .slide(),

                ),

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
