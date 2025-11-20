import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../Widgets/custom_text_widget.dart';
import '../../../../../globals/commonStyles.dart';
import '../../../../../models/MessageSentStudent.dart';
import '../controller/sented_messages_controller.dart';

class UserChatWidget extends StatelessWidget {
  const UserChatWidget({    super.key,
    required this.userChat,
    required this.press,
  });




  final MessageSentStudent? userChat;
  final VoidCallback press;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SentedMessagesController(), permanent: false);
    return Center(
      child: InkWell(
        onTap: press,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 10, vertical:10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      InkWell(
                        onTap:(){

                        },
                        child: Container(
                          margin: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10),
                          height: 64,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50.0),
                            child: Image.network(
                              'https://img.freepik.com/premium-vector/vector-flat-illustration-grayscale-avatar-user-profile-person-icon-profile-picture-business-profile-woman-suitable-social-media-profiles-icons-screensavers-as-templatex9_719432-1310.jpg?w=740',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:   [
                          const SizedBox(height: 10,),
                          CustomText(userChat?.to??"",style:  TextStyle(

                              fontWeight: FontWeight.w700,
                              fontSize: 17),
                          ),
                          const SizedBox(height: 10,),
                          CustomText(userChat?.title??"",style:  TextStyle(

                              fontWeight: FontWeight.w700,
                              fontSize: 17),
                          ),
                          const SizedBox(height: 10,),
                          CustomText(controller.formatDate(userChat),style:  TextStyle(

                              fontWeight: FontWeight.w700,
                              fontSize: 17),
                          ),
                          const SizedBox(height: 10,),
                        ],
                      ),

                    ],
                  ),
Padding(
  padding: const EdgeInsets.symmetric(horizontal: 20.0),
  child: Icon(Icons.arrow_forward_ios_rounded,color: mainColor,size: 20,),
),
                ],
              ),
            ),
             Divider(
              color: mainColor,
              height: 1,
              thickness: 2,

            ),
          ],
        ),
      ),
    );
  }
}

