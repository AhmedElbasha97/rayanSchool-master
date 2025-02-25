import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../globals/commonStyles.dart';
import '../../globals/widgets/loader.dart';
import '../../models/penalties_list_model.dart';
import '../../services/ParentsService.dart';


class PenaltiesListScreen extends StatefulWidget {
  const PenaltiesListScreen({Key? key}) : super(key: key);

  @override
  _PenaltiesListScreenState createState() => _PenaltiesListScreenState();
}

class _PenaltiesListScreenState extends State<PenaltiesListScreen> {
  bool isLoading = true;

  var type ;
  List<PenaltiesListModel>? penaltiesList = [];
  String returnDateAndTime(PenaltiesListModel? chat){
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

    var userList = await ParentService().getPenaltiesList();
    penaltiesList = userList;
    print(penaltiesList?.length);

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
                  ?"Conduct and penalties":"السلوك والجزاءات",
            
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
        body:Container(
            height: MediaQuery.of(context).size.height ,
            width: MediaQuery.of(context).size.width,
            child: isLoading?Loader(
              height: MediaQuery.of(context).size.height*0.75,
            ): penaltiesList?.isEmpty??true?
            Container(
              height: MediaQuery.of(context).size.height*0.75,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Image.asset("assets/images/no_recomendation_data.png"),
                  ),
                  SizedBox(height: 20,),
                  Text(Localizations.localeOf(context).languageCode == "en"
                      ?"no penalties available":"لا يوجد جزاءات متوفرة الآن",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20

                    ),),
                ],
              ),
            ):
            Container(
              height: MediaQuery.of(context).size.height*0.75,

              child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: penaltiesList?.length,
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
                                penaltiesList?[index].student??"",
                                style:
                                TextStyle(fontSize: 16, fontWeight:FontWeight.normal ),
                                maxLines: null,
                              ),
                              SizedBox(height: 8),
                              Text(
                                penaltiesList?[index].penaltiesListModelClass??"",
                                style:
                                TextStyle(fontSize: 16, fontWeight:FontWeight.normal ),
                                maxLines: null,
                              ),
                              SizedBox(height: 8),
                              Text(
                                penaltiesList?[index].level??"",
                                style:
                                TextStyle(fontSize: 16, fontWeight:FontWeight.normal ),
                                maxLines: null,
                              ),
                              SizedBox(height: 8),
                              Text(
                                penaltiesList?[index].action??""??"",
                                style:
                                TextStyle(fontSize: 16, fontWeight:FontWeight.normal ),
                                maxLines: null,
                              ),
                              SizedBox(height: 8),
                              Text(
                                penaltiesList?[index].notes??""??"",
                                style:
                                TextStyle(fontSize: 16, fontWeight:FontWeight.normal),
                                maxLines: null,
                              ),
                              SizedBox(height: 8),
                              Opacity(
                                opacity: 0.64,
                                child: Text(
                                  returnDateAndTime(penaltiesList?[index]),
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
            )));
  }
}