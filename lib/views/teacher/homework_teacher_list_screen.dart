import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../globals/commonStyles.dart';
import '../../globals/widgets/loader.dart';
import '../../models/teacher/homework_teacher_list_model.dart';
import '../../services/teachersService.dart';

class HomeworkTeacherListScreen extends StatefulWidget {
  const HomeworkTeacherListScreen({Key? key}) : super(key: key);

  @override
  _HomeworkTeacherListScreenState createState() =>
      _HomeworkTeacherListScreenState();
}

class _HomeworkTeacherListScreenState extends State<HomeworkTeacherListScreen> {
  bool isLoading = true;

  List<HomeworkTeacherListModel>? homeworkList = [];
  String returnDateAndTime(HomeworkTeacherListModel? chat){
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
    var userList = await TeacherService().getTeacherHomeWorksList();
    homeworkList = userList;
    print(homeworkList?.length);

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
                ?"Homework list":"قائمة الواجب المدرسى",
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

              ): homeworkList?.isEmpty??true?
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
                        ?"no Homework available":"لا يوجد واجب المدرسى متوفره لان",
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
                    itemCount: homeworkList?.length,
                    itemBuilder: (context, int index) {
                      return Container(
                        width: double.infinity,
                        child:  Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Expanded(
                            child: Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                  Localizations.localeOf(context).languageCode == "en"
                                  ?"School assignment title:":"عنوان الواجب المدرسى:",
                                    style:
                                    TextStyle(fontSize: 16, fontWeight:FontWeight.normal ),
                                    textAlign: TextAlign.left,
                                    maxLines: null,
                                  ),
                                  SizedBox(height: 8),
                                  Container(
                                    width: double.infinity,
                                    child: Text(
                                      homeworkList?[index].title??"",
                                      style:
                                      TextStyle(fontSize: 16, fontWeight:FontWeight.normal ),
                                      maxLines: null,
                                      textAlign: TextAlign.center,

                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    Localizations.localeOf(context).languageCode == "en"
                                        ?"Time to create the assignment:":"وقت أنشاء الواجب الدراسى:",
                                    style:
                                    TextStyle(fontSize: 16, fontWeight:FontWeight.normal ),
                                    textAlign: TextAlign.left,
                                    maxLines: null,
                                  ),
                                  SizedBox(height: 8),
                                  Container(
                                    width: double.infinity,
                                    child: Text(
                                      returnDateAndTime(homeworkList?[index])??"",
                                      style:
                                      TextStyle(fontSize: 16, fontWeight:FontWeight.normal ),
                                      textAlign: TextAlign.center,

                                      maxLines: null,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    Localizations.localeOf(context).languageCode == "en"
                                        ?"class:":"الفصل:",
                                    style:
                                    TextStyle(fontSize: 16, fontWeight:FontWeight.normal ),
                                    textAlign: TextAlign.left,
                                    maxLines: null,
                                  ),
                                  SizedBox(height: 8),
                                  Container(
                                    width: double.infinity,
                                    child: Text(
                                      homeworkList?[index].homeworkTeacherListModelClass??"",
                                      style:
                                      TextStyle(fontSize: 16, fontWeight:FontWeight.normal ),
                                      textAlign: TextAlign.center,

                                      maxLines: null,
                                    ),
                                  ),

                                ],
                              ),
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
