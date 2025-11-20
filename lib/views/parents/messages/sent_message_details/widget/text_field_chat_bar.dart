// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rayanSchool/globals/commonStyles.dart';

import '../controller/sent_message_controller.dart';



class TextFieldChatBar extends StatelessWidget {
   const TextFieldChatBar({super.key, required this.sendMassage, required this.myController, required this.id,   });
  final Function sendMassage;
  final TextEditingController myController ;
   final String id;

  @override
  Widget build(BuildContext context) {
    final SentMessagesDetailsController controller = Get.put(
        SentMessagesDetailsController(id), permanent: false
    );
    return Column(
      children: [

        Container(
          width:MediaQuery.of(context).size.width,
          decoration:  const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20), topLeft: Radius.circular(20),),
            boxShadow: [
              BoxShadow(color: Colors.black38, spreadRadius: 1, blurRadius: 1),
            ],
          ),
          child: Padding(
            padding:  const EdgeInsets.symmetric(vertical: 10.0),
            child: Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width*0.9,

                child: Container(
                  constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height*0.25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        width: MediaQuery.of(context).size.width*0.9,

                        decoration: BoxDecoration(
                          color: Colors.grey[200],

                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: const Color(0xffDEEAFD),width: 1),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(child: TextField(

                                controller: myController,
                                cursorColor: mainColor,
                                autocorrect: false,
                                maxLines: null,
                                keyboardType: TextInputType.multiline,
                                decoration:    InputDecoration(

                                    border: InputBorder.none,
                                    hintStyle:  TextStyle(
                                      fontSize: 14,
                                      color: mainColor,
                                    ),


                                    hintText: "type a message")
                            )),
                            const SizedBox(width: 20,),
    Obx(() {
                            return controller.isSendingMessage.value?Container(height:  MediaQuery.of(context).size.height*0.05,child: Center(child: CircularProgressIndicator(color: mainColor,),)):InkWell(
                                onTap: (){sendMassage();myController.clear();FocusScope.of(context).unfocus();},
                                child: Icon(Icons.send,color: mainColor,),
                            );}),


                          ],
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
