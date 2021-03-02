import 'package:flutter/material.dart';
import 'package:vendors/AppColor.dart';


class CreateTenderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(preferredSize: Size.fromHeight(40),child: AppBar(title: Text("Create Tender",style: TextStyle(color: AppColor.SecondColor,fontSize: 16,fontWeight: FontWeight.bold),),iconTheme: IconThemeData(
        color: AppColor.PrimaryColor, //change your color here
      ),centerTitle: true,backgroundColor: Colors.transparent,elevation: 0)),
      body: Padding(
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
        ],),
      ),
    );
  }

}