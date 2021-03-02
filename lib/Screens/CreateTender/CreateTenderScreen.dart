import 'package:flutter/material.dart';
import 'package:vendors/AppColor.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class CreateTenderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(preferredSize: Size.fromHeight(40),child: AppBar(title: Text("Create Tender",style: TextStyle(color: AppColor.SecondColor,fontSize: 16,fontWeight: FontWeight.bold),),iconTheme: IconThemeData(
        color: AppColor.PrimaryColor, //change your color here
      ),centerTitle: true,backgroundColor: Colors.transparent,elevation: 0)),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppColor.HorizontalPadding),
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
              child: Container(
                height: 60,
                child: TextField(
                    style: TextStyle(color: AppColor.SilverColor,fontSize: 14),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border:  InputBorder.none,
                      labelText: "Title",
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: AppColor.HorizontalPadding),
              child: Container(
                height: 200,
                child: TextField(
                  style: TextStyle(color: AppColor.SilverColor,fontSize: 14),
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border:  InputBorder.none,
                      labelText: "Description",
                      alignLabelWithHint: true),
                  maxLines: null,
                  minLines: null,
                  textAlignVertical: TextAlignVertical.top,
                  expands: true,
                ),
              ),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: [
              FlatButton(
                  onPressed: () {
                    DatePicker.showDatePicker(context,

                        minTime: DateTime.now(),
                        maxTime: DateTime(DateTime.now().year,DateTime.now().month, DateTime.now().day),
                        theme: DatePickerTheme(

                            backgroundColor: Colors.white,
                            itemStyle: TextStyle(
                                color:  AppColor.SecondColor, fontWeight: FontWeight.bold, fontSize: 18),
                            doneStyle: TextStyle(color: AppColor.PrimaryColor, fontSize: 16)),
                        onChanged: (date) {
                          print('change $date in time zone ' + date.timeZoneOffset.inHours.toString());
                        }, onConfirm: (date) {
                          print('confirm $date');
                        }, currentTime: DateTime.now(), locale: LocaleType.en);
                  },
                  child: Text(
                    'Start Date',
                    style: TextStyle(color: Colors.blue),
                  )),
              FlatButton(
                  onPressed: () {
                    DatePicker.showDatePicker(context,

                        minTime: DateTime.now(),
                        maxTime: DateTime(DateTime.now().year,DateTime.now().month, DateTime.now().day),
                        theme: DatePickerTheme(

                            backgroundColor: Colors.white,
                            itemStyle: TextStyle(
                                color:  AppColor.SecondColor, fontWeight: FontWeight.bold, fontSize: 18),
                            doneStyle: TextStyle(color: AppColor.PrimaryColor, fontSize: 16)),
                        onChanged: (date) {
                          print('change $date in time zone ' + date.timeZoneOffset.inHours.toString());
                        }, onConfirm: (date) {
                          print('confirm $date');
                        }, currentTime: DateTime.now(), locale: LocaleType.en);
                  },
                  child: Text(
                    'Start Time',
                    style: TextStyle(color: Colors.blue),
                  )),
            ],),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: [
              FlatButton(
                  onPressed: () {
                    DatePicker.showDatePicker(context,

                        minTime: DateTime.now(),
                        maxTime: DateTime(DateTime.now().year,DateTime.now().month, DateTime.now().day),
                        theme: DatePickerTheme(

                            backgroundColor: Colors.white,
                            itemStyle: TextStyle(
                                color:  AppColor.SecondColor, fontWeight: FontWeight.bold, fontSize: 18),
                            doneStyle: TextStyle(color: AppColor.PrimaryColor, fontSize: 16)),
                        onChanged: (date) {
                          print('change $date in time zone ' + date.timeZoneOffset.inHours.toString());
                        }, onConfirm: (date) {
                          print('confirm $date');
                        }, currentTime: DateTime.now(), locale: LocaleType.en);
                  },
                  child: Text(
                    'End Date',
                    style: TextStyle(color: Colors.blue),
                  )),
              FlatButton(
                  onPressed: () {
                    DatePicker.showDatePicker(context,

                        minTime: DateTime.now(),
                        maxTime: DateTime(DateTime.now().year,DateTime.now().month, DateTime.now().day),
                        theme: DatePickerTheme(

                            backgroundColor: Colors.white,
                            itemStyle: TextStyle(
                                color:  AppColor.SecondColor, fontWeight: FontWeight.bold, fontSize: 18),
                            doneStyle: TextStyle(color: AppColor.PrimaryColor, fontSize: 16)),
                        onChanged: (date) {
                          print('change $date in time zone ' + date.timeZoneOffset.inHours.toString());
                        }, onConfirm: (date) {
                          print('confirm $date');
                        }, currentTime: DateTime.now(), locale: LocaleType.en);
                  },
                  child: Text(
                    'End Time',
                    style: TextStyle(color: Colors.blue),
                  )),
            ],),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
              child: FlatButton(onPressed: (){},child: Column(children: [
                Icon(Icons.file_upload,size:45),
                Text("UPLOAD DETAILED DOCUMENT",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14))
              ],),textColor: Colors.white,color: AppColor.PrimaryColor,minWidth: MediaQuery.of(context).size.width ,height: MediaQuery.of(context).size.height * 0.15,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
            ),
            FlatButton(onPressed: (){}, child: Text("CREATE TENDER",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14)),textColor: Colors.white,color: AppColor.PrimaryColor,minWidth: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height * 0.07,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
          ],),
        ),
      ),
    );
  }

}