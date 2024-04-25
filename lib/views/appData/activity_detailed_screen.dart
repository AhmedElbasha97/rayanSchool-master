import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:rayanSchool/globals/widgets/loader.dart';
import '../../globals/commonStyles.dart';
import '../../models/activity_detailed_model.dart';
import '../../services/activity_services.dart';

class ActivityDetailedScreen extends StatefulWidget {
  final String activityId;
  const ActivityDetailedScreen({Key? key, required this.activityId}) : super(key: key);

  @override
  _ActivityDetailedScreenState createState() => _ActivityDetailedScreenState();
}

class _ActivityDetailedScreenState extends State<ActivityDetailedScreen> {
  ActivitiesDetailedModel? activityDetails;
  bool loading = true;
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    activityDetails = await ActivityService().getActivitiesDetails(widget.activityId);
    print(activityDetails?.description??"");
    loading = false;
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return  loading
        ? Scaffold(
      appBar: AppBar(),
        backgroundColor: Colors.white,
        body: Loader())
        :Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        title: Text(activityDetails?.title??"",
          style: TextStyle(color: mainColor,fontSize:15),
          maxLines: 3,
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: mainColor,
          ),
          onPressed: () { Navigator.of(context).pop();

          },
        ),
      ),
      body: SingleChildScrollView(
            child: Column(
                    children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.3,
              margin: EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage("${activityDetails?.image}"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Html(data: activityDetails?.description),
            )
                    ],
                  ),
          ),
    );
  }
}
