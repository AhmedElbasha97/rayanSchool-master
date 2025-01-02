import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

import '../../globals/commonStyles.dart';
import '../../globals/widgets/loader.dart';

import '../../models/recommendation_list_model.dart';
import '../../services/ParentsService.dart';


class RecommendationsListScreen extends StatefulWidget {
  const RecommendationsListScreen({Key? key}) : super(key: key);

  @override
  _RecommendationsListScreenState createState() => _RecommendationsListScreenState();
}

class _RecommendationsListScreenState extends State<RecommendationsListScreen> {
  bool isLoading = true;
  String recommendationTitle = "توصيات الأكاديمية ";
  String recommendationValue = "1";
  var type ;
  List<RecommendationListModel>? recommendationList = [];
  String returnDateAndTime(RecommendationListModel? chat){
    String dateOrTime = "" ;
    print(chat?.date??"");
    final format = DateFormat('HH:mm a');
    DateFormat formatDate = DateFormat("MMM dd");

    final dateTime = DateTime.parse(chat?.date??"2024-02-28 11:55:54");
    if(dateTime.day == DateTime.now().day){
      dateOrTime = format.format(dateTime);
    }else{
      dateOrTime = formatDate.format(dateTime);
    }
    return dateOrTime;
  }
  getAllListOfRecommendation()async{
    isLoading = true;
    setState(() {

    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    type = prefs.getString("type");
    var userList = await ParentService().getRecommendationList(typeId: recommendationValue);
    recommendationList = userList;
    print(recommendationList?.length);

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
              ?"Recommendation Behavioural list":"قائمة التوصيات السلوكيه",
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

            ): recommendationList?.isEmpty??true?
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
            ?"no Recommendation Behavioural available":"لا يوجد توصيات السلوكيه متوفره لان",
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
                          itemCount: recommendationList?.length,
                          itemBuilder: (context, int index) {
                            return Container(
            width: double.infinity,
            child:  Padding(
              padding: const EdgeInsets.all(10.0),
              child: Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      recommendationList?[index].title??"",
                      style:
                      TextStyle(fontSize: 16, fontWeight:FontWeight.normal ),
                      maxLines: null,
                    ),
                    SizedBox(height: 8),
                    Text(
                      recommendationList?[index].student??"",
                      style:
                      TextStyle(fontSize: 16, fontWeight:FontWeight.normal ),
                      maxLines: null,
                    ),
                    SizedBox(height: 8),
                    Text(
                      recommendationList?[index].subject??"",
                      style:
                      TextStyle(fontSize: 16, fontWeight:FontWeight.normal ),
                      maxLines: null,
                    ),
                    SizedBox(height: 8),
                    Text(
                      recommendationList?[index].teacher??"",
                      style:
                      TextStyle(fontSize: 16, fontWeight:FontWeight.normal ),
                      maxLines: null,
                    ),
                    SizedBox(height: 8),
                    Text(
                        recommendationList?[index].notes??"",
                      style:
                      TextStyle(fontSize: 16, fontWeight:FontWeight.normal),
                      maxLines: null,
                    ),
                    SizedBox(height: 8),
                    Opacity(
                      opacity: 0.64,
                      child: Text(
                        returnDateAndTime(recommendationList?[index]),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(color: Colors.grey.shade500,width: 1)
                )
            ),

                            );
                          }),
                        )),
      ));
  }
}