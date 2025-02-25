import 'package:flutter/material.dart';
import 'package:rayanSchool/I10n/app_localizations.dart';
import 'package:rayanSchool/globals/helpers.dart';
import 'package:rayanSchool/globals/widgets/mainButton.dart';
import 'package:rayanSchool/globals/widgets/textFiled.dart';
import 'package:rayanSchool/services/JoinApplicationService.dart';
import 'package:rayanSchool/views/homeScreen.dart';

import '../../globals/commonStyles.dart';

class JoinRequest extends StatefulWidget {
  @override
  _JoinRequestState createState() => _JoinRequestState();
}

class _JoinRequestState extends State<JoinRequest> {
  bool isLoading = false;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController _nameController = new TextEditingController();
  TextEditingController _oldSchoolController = new TextEditingController();
  TextEditingController _mobileController = new TextEditingController();
  TextEditingController _joinSchoolYearController = new TextEditingController();
  TextEditingController _idNumberController = new TextEditingController();
  TextEditingController _birthdateController = new TextEditingController();
  TextEditingController _genderController = new TextEditingController();
  TextEditingController _religionController = new TextEditingController();
  TextEditingController _birthPlaceController = new TextEditingController();
  TextEditingController _nationaltyController = new TextEditingController();
  TextEditingController _cityController = new TextEditingController();
  TextEditingController _provinceController = new TextEditingController();
  TextEditingController _regNumberController = new TextEditingController();
  TextEditingController _addressController = new TextEditingController();
  TextEditingController _zipCodeController = new TextEditingController();
  TextEditingController _phoneController = new TextEditingController();
  TextEditingController _yearController = new TextEditingController();
  TextEditingController _regStatusController = new TextEditingController();
  TextEditingController _parentNameController = new TextEditingController();
  TextEditingController _relationController = new TextEditingController();
  TextEditingController _parentJobController = new TextEditingController();
  TextEditingController _notesController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();

  sendRequest() async {
    if (!isLoading) {
      if (!mounted) return; // ✅ Ensure widget is still in the tree
      setState(() {
        isLoading = true;
      });
    }

    try {
      String result = await JoinApplication().sendApplication(
        email: _emailController.text,
        name: _nameController.text,
        oldSchool: _oldSchoolController.text,
        mobile: _mobileController.text,
        joinSchoolDate: _joinSchoolYearController.text,
        idNumber: _idNumberController.text,
        birthdate: _birthdateController.text,
        gender: _genderController.text,
        religion: _religionController.text,
        birthPlace: _birthPlaceController.text,
        nationalty: _nationaltyController.text,
        city: _cityController.text,
        province: _provinceController.text,
        regNumber: _regNumberController.text,
        address: _addressController.text,
        zipCode: _zipCodeController.text,
        phone: _phoneController.text,
        year: _yearController.text,
        regStatus: _regStatusController.text,
        parentName: _parentNameController.text,
        relation: _relationController.text,
        parentJob: _parentJobController.text,
        notes: _notesController.text,
      );

      if (!mounted) return; // ✅ Ensure widget is still in the tree before calling setState

      if (result == "true") {
        showSnackBar("تم إرسال  طلب التحاق", Colors.green, Icons.check);

        setState(() {
          isLoading = false;
        });

        // ✅ Safe navigation after ensuring widget is mounted
        if (mounted) {
          pushPageReplacement(context, HomeScreen());
        }
      } else {
        showSnackBar("حدث خطأ أثناء إرسال طلب التحاق", Colors.red, Icons.close);
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        showSnackBar("خطأ: ${e.toString()}", Colors.red, Icons.error);
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  /// Helper function to show SnackBar safely
  void showSnackBar(String message, Color color, IconData icon) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(icon, color: Colors.white),
            SizedBox(width: 10),
            Text(
              message,
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        backgroundColor: color,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "${AppLocalizations.of(context)?.translate('joinRequest')}",
        ),
        automaticallyImplyLeading: true,
      ),
      body:ListView(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              children: [
                SizedBox(
                  height: 15,
                ),
                InputFiled(
                  controller: _nameController,
                  hintText: "${AppLocalizations.of(context)?.translate('name')}",

                ),
                SizedBox(
                  height: 15,
                ),
                InputFiled(
                  controller: _genderController,
                  hintText:
                      "${AppLocalizations.of(context)?.translate('gender')}",
                ),
                SizedBox(
                  height: 15,
                ),
                InputFiled(
                  controller: _birthdateController,
                  hintText:
                      "${AppLocalizations.of(context)?.translate('birthday')}",
                ),
                SizedBox(
                  height: 15,
                ),
                InputFiled(
                  controller: _addressController,
                  hintText:
                      "${AppLocalizations.of(context)?.translate('address')}",
                ),
                SizedBox(
                  height: 15,
                ),
                InputFiled(
                  controller: _notesController,
                  hintText:
                      "${AppLocalizations.of(context)?.translate('notes')}",
                ),
                SizedBox(
                  height: 15,
                ),
                InputFiled(
                  controller: _emailController,
                  hintText:
                      "${AppLocalizations.of(context)?.translate('email')}",
                ),
                SizedBox(
                  height: 15,
                ),
                InputFiled(
                  controller: _mobileController,
                  hintText:
                      "${AppLocalizations.of(context)?.translate('mobile')}",
                ),
                SizedBox(
                  height: 15,
                ),
                InputFiled(
                  controller: _phoneController,
                  hintText:
                      "${AppLocalizations.of(context)?.translate('phone')}",
                ),
                SizedBox(
                  height: 15,
                ),
                InputFiled(
                  controller: _oldSchoolController,
                  hintText:
                      "${AppLocalizations.of(context)?.translate('oldSchool')}",
                ),
                SizedBox(
                  height: 15,
                ),
                InputFiled(
                  controller: _joinSchoolYearController,
                  hintText:
                      "${AppLocalizations.of(context)?.translate('joinDate')}",
                ),
                SizedBox(
                  height: 15,
                ),
                InputFiled(
                  controller: _provinceController,
                  hintText:
                      "${AppLocalizations.of(context)?.translate('province')}",
                ),
                SizedBox(
                  height: 15,
                ),
                InputFiled(
                  controller: _regNumberController,
                  hintText:
                      "${AppLocalizations.of(context)?.translate('regNum')}",
                ),
                SizedBox(
                  height: 30,
                ),
                SizedBox(
                  height: 15,
                ),
                InputFiled(
                  controller: _regStatusController,
                  hintText:
                      "${AppLocalizations.of(context)?.translate('regStatus')}",
                ),
                                SizedBox(
                  height: 15,
                ),
                InputFiled(
                  controller: _cityController,
                  hintText: "${AppLocalizations.of(context)?.translate('city')}",
                ),
                SizedBox(
                  height: 30,
                ),
                InputFiled(
                  controller: _religionController,
                  hintText:
                      "${AppLocalizations.of(context)?.translate('religion')}",
                ),
                SizedBox(
                  height: 30,
                ),
                InputFiled(
                  controller: _idNumberController,
                  hintText:
                      "${AppLocalizations.of(context)?.translate('DocNo')}",
                ),
                SizedBox(
                  height: 30,
                ),
                InputFiled(
                  controller: _yearController,
                  hintText:
                      "${AppLocalizations.of(context)?.translate('studyYear')}",
                ),
                SizedBox(
                  height: 30,
                ),
                InputFiled(
                  controller: _parentNameController,
                  hintText:
                      "${AppLocalizations.of(context)?.translate('parentName')}",
                ),
                SizedBox(
                  height: 30,
                ),
                InputFiled(
                  controller: _parentJobController,
                  hintText:
                      "${AppLocalizations.of(context)?.translate('parentJob')}",
                ),
                SizedBox(
                  height: 30,
                ),
                InputFiled(
                  controller: _nationaltyController,
                  hintText:
                      "${AppLocalizations.of(context)?.translate('Nationality')}",
                ),
                SizedBox(
                  height: 30,
                ),
                InputFiled(
                  controller: _relationController,
                  hintText:
                      "${AppLocalizations.of(context)?.translate('relation')}",
                ),
                SizedBox(
                  height: 30,
                ),
                InputFiled(
                  controller: _birthPlaceController,
                  hintText:
                      "${AppLocalizations.of(context)?.translate('bornPlace')}",
                ),
                SizedBox(
                  height: 30,
                ),
                InputFiled(
                  controller: _zipCodeController,
                  hintText:
                      "${AppLocalizations.of(context)?.translate('PostalBox')}",
                ),
                SizedBox(
                  height: 30,
                ),
                !isLoading?  InkWell(
                    splashColor: mainColor,
                    borderRadius: new BorderRadius.circular(10.0),
                    child: Container(
                        height: MediaQuery.of(context).size.height * 0.08,
                        width: MediaQuery.of(context).size.width * 0.8,
                        decoration: BoxDecoration(
                            color: mainColor,
                            borderRadius: BorderRadius.all(Radius.circular(15))),
                        alignment: Alignment.center,
                        child: Center(
                          child: Text(
                            "${AppLocalizations.of(context)?.translate('send')}",
                            style: buttonStyleMain,
                          ),
                        ),),
                    onTap: (){
                      sendRequest();
                    }):Container(
                  decoration: BoxDecoration(
                      color: mainColor,
                      shape: BoxShape.circle
                  ),

                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: CircularProgressIndicator(

                      ),
                    ),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).padding.top + 20))
              ],
            ),
    );
  }
}
