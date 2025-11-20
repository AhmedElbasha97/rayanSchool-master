import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../Widgets/custom_text_widget.dart';
import '../../../../../globals/commonStyles.dart';
import '../../../../../models/sent_message_detials_model.dart';
import '../controller/sent_message_controller.dart';

class MessageDetailsWidget extends StatelessWidget {
  const MessageDetailsWidget({super.key, required this.id, required this.item});
  final String id;
  final SentMessageDetailsModel? item;
  @override
  Widget build(BuildContext context) {
    final SentMessagesDetailsController controller = Get.put(
        SentMessagesDetailsController(id), permanent: false
    );
    return  Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 4,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent, // removes the line
        ),
        child: ExpansionTile(
          controller: controller.standardTileController,
          title: CustomText(
            item?.from ?? "",
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 17,
            ),
          ),
          subtitle: CustomText(
            controller.formatDate(item),
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 17,
            ),
          ),
          leading:Container(
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
          iconColor: mainColor,
          dense: true,
          initiallyExpanded: false,
          children:  [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  controller.isHtml(item?.msg ?? "")? Html(data:item?.msg ?? ""):Linkify(
                text:
                item?.msg ?? "",
                onOpen: (link) async {
                  if (!await launchUrl(Uri.parse(link.url))) {
                    throw Exception('Could not launch ${link.url}');
                  }
                },
                linkStyle: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  color: Colors.grey,
                ),

                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
