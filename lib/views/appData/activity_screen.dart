import 'package:flutter/material.dart';

import '../../globals/commonStyles.dart';
import '../../globals/helpers.dart';
import '../../globals/widgets/loader.dart';
import '../../models/activity_list_model.dart';
import '../../services/activity_services.dart';
import 'activity_detailed_screen.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({Key? key}) : super(key: key);

  @override
  _ActivityScreenState createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  bool isLoading = true;

  List<ActivitiesListModel>? activityList = [];
  getAllListOfRecommendation()async{
    isLoading = true;
    setState(() {
    });

    var userList = await ActivityService().getActivitiesList();
    activityList = userList;
    print(activityList?[0].miName??"");
    print("hi lenth");
    isLoading=false;
    setState(() {

    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getAllListOfRecommendation();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:  AppBar(
          backgroundColor: Colors.grey[300],
          title: Text(
            Localizations.localeOf(context).languageCode == "en"
                ?"school activities list":"قائمة الأنشطة المدرسية",
            style: TextStyle(color: mainColor),
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
        body:SafeArea(
          child: Container(
              height: MediaQuery.of(context).size.height ,
              width: MediaQuery.of(context).size.width,
              child: isLoading?Loader(

              ): activityList?.isEmpty??true?
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Image.asset("assets/images/no_recomendation_data.png"),
                    ),
                    SizedBox(height: 20,),
                    Text(Localizations.localeOf(context).languageCode == "en"
                        ?"no school activities available":"لا يوجد أنشطه المدرسيه متوفره لان",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20

                      ),),
                  ],
                ),
              ):
              Container(
                height: MediaQuery.of(context).size.height,

                child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: activityList?.length,
                    itemBuilder: (context, int index) {
                      return InkWell(
                        onTap: (){
                          pushPage(context, ActivityDetailedScreen(activityId: activityList?[index].id??"",));
                        },
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(30.0),
                            child: Center(
                              child:Text(
                                activityList?[index].miName??"",
                                style:
                                TextStyle(fontSize: 16, fontWeight:FontWeight.bold ),
                                maxLines: 3,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              )),
        ));
  }
}
