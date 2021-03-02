import 'package:flutter/material.dart';
import 'package:vendors/AppColor.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:vendors/Screens/CreateTender/CreateTenderScreen.dart';
import 'package:vendors/Screens/SupplierProfile/SupplierProfile.dart';

class VendorMainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(child: Icon(Icons.add,color: Colors.white,size: 32,),elevation: 3,onPressed: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CreateTenderScreen()),
        );
      },),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Welcome, Ahmed",style: TextStyle(fontSize: 16,color: AppColor.PrimaryColor,fontWeight: FontWeight.bold)),
              ),
         Padding(
           padding: const EdgeInsets.symmetric(horizontal: AppColor.HorizontalPadding,vertical: 6),
           child: Container(
             height: 60,
             width: 318,
             child: TextField(
               style: TextStyle(color: AppColor.SilverColor,fontSize: 14),
                decoration: InputDecoration(
                  filled: true,
                fillColor: Colors.white,
                border:  InputBorder.none,
                labelText: "Search Supplier",
                 suffixIcon: Icon(Icons.search),
        )),
           ),
         ),
       Expanded(

            child: ListView.builder(
                itemCount: 4,
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                scrollDirection: Axis.vertical,
              itemBuilder: (context,index) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, AppColor.HorizontalPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: AppColor.HorizontalPadding,vertical: 10),
                        child: Text("Industry Type",style: TextStyle(fontSize: 14,color: AppColor.SecondColor,fontWeight: FontWeight.bold))
                      ),
                      Container(
                        height: 115,
                        child: ListView.builder(
                          itemCount: 4,
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return SupplierCardView();
                          },
                        ),
                      )
                    ],
                  ),
                );
              }
            ),
          ),

          ],),
        ),
      ),
    );
  }

}

class SupplierCardView extends StatelessWidget {
  const SupplierCardView({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SupplierProfile()),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: Card(
          elevation: 3,
          shadowColor: Color(0xFF1a0f6388),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          child: Container(
            height: 115,
            width: 320,
            child: Column(
              children: [
                ListTile(
                  leading: Image.asset("images/temp_logo.png"),
                  title: Text("Company Name",style: TextStyle(fontSize: 14,color: AppColor.SecondColor,fontWeight: FontWeight.bold)),
                  subtitle: Text("Industry Name",style: TextStyle(fontSize: 14,color: AppColor.SilverColor)),
                  trailing: RatingBar.builder(
                    itemSize: 15,
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
                  padding: const EdgeInsets.fromLTRB(6, 0, 6, 0),
                  child: Center(child:
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.people,color: AppColor.SecondColor,),
                      Text("1-10 Employee(s)",style: TextStyle(fontSize: 14,color: AppColor.SecondColor))
                    ],),),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}