
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:vendors/AppColor.dart';

class SupplierProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(preferredSize: Size.fromHeight(40),child: AppBar(title: Text("Company Profile",style: TextStyle(color: AppColor.SecondColor,fontSize: 16,fontWeight: FontWeight.bold),),iconTheme: IconThemeData(
        color: AppColor.PrimaryColor, //change your color here
      ),centerTitle: true,backgroundColor: Colors.transparent,elevation: 0)),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 0,horizontal: AppColor.HorizontalPadding),
              child: Column(children: [
                Image.asset("images/temp_logo.png",height: 154),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text("Company Name",style: TextStyle(color: AppColor.PrimaryColor,fontSize: 14,fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                  child: Text("Industry Name",style: TextStyle(color: AppColor.SilverColor,fontSize: 14)),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 8),
                  child: RatingBar.builder(
                    itemSize: 20,
                    initialRating: 3,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    ignoreGestures: true,
                    itemCount: 5,
                    itemBuilder: (context, _) =>
                        Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                    onRatingUpdate: (rating) {
                      print(rating);
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, AppColor.HorizontalPadding),
                  child: Row(mainAxisAlignment: MainAxisAlignment.center,children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Icon(Icons.people,color: AppColor.SecondColor),
                    ),
                    Text("1-10 Employee",style: TextStyle(fontSize: 14,color: AppColor.SecondColor),)
                  ],),
                ),
                Align(child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                  child: Text("Description",style: TextStyle(color: AppColor.PrimaryColor,fontSize: 14,fontWeight: FontWeight.bold)),
                ),alignment: Alignment.centerLeft,),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, AppColor.HorizontalPadding),
                  child: Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",style: TextStyle(color: AppColor.SecondColor,fontSize: 14,fontWeight: FontWeight.w500)),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 12),
                    child: Text("To Know More",style: TextStyle(color: AppColor.SecondColor,fontSize: 14,fontWeight: FontWeight.bold)),
                  ),
                ),
                FlatButton.icon(onPressed: (){}, label: const Text("DOWNLOAD PORTFOLIO",style: TextStyle(fontWeight: FontWeight.bold),), icon: Icon(Icons.file_download),shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5), side: BorderSide(color: AppColor.PrimaryColor,width: 1)
                ),
                  minWidth: MediaQuery.of(context).size.width * 0.81,
                  height: MediaQuery.of(context).size.height * 0.076,
                  textColor: AppColor.PrimaryColor,
                ),
                Align(child: Padding(
                  padding: const EdgeInsets.fromLTRB(0,12,0,8),
                  child: Text("Contact Info",style: TextStyle(color: AppColor.SecondColor,fontSize: 14,fontWeight: FontWeight.bold)),
                ),alignment: Alignment.centerLeft),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0,0,0,12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Ink(
                        width: 72,
                      height: MediaQuery.of(context).size.height * 0.076,
                        decoration: ShapeDecoration(
                          color: Color(0xFF0f8817),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
                        ),
                        child: IconButton(
                          icon: Icon(Icons.phone),
                          color: Colors.white,
                          onPressed: () {},
                        ),
                      ),
                    FlatButton.icon(onPressed: (){}, icon: Icon(Icons.mail), label: Text("Mail"),textColor: Colors.white,color: AppColor.PrimaryColor,minWidth: MediaQuery.of(context).size.width * 0.6,height: MediaQuery.of(context).size.height * 0.076,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),

                  ],),
                )

              ],),

          ),
        ),
      ),
    );
  }

}