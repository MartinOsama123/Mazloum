import 'package:flutter/material.dart';
import 'package:vendors/AppColor.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class VendorMainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
         Padding(
           padding: const EdgeInsets.all(6.0),
           child: Container(
             height: 60,
             width: 318,
             child: TextField(
               style: TextStyle(color: AppColor.SilverColor,fontSize: 14),
                decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(5),  borderSide: new BorderSide(color: Colors.red,width: 0)),
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
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("AAAA"),
                    ),
                    Container(
                      height: 150,
                      child: ListView.builder(
                        itemCount: 4,
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Card(
                              child: Container(
                                height: 50,
                                width: 320,
                                child: Column(
                                  children: [
                                    ListTile(
                                      leading: Icon(Icons.height),
                                      title: Text("Company Name"),
                                      subtitle: Text("Industry Name"),
                                      trailing: RatingBar.builder(
                                        itemSize: 15,
                                        initialRating: 3,
                                        minRating: 1,
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
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
                                      padding: const EdgeInsets.fromLTRB(6, 20, 6, 6),
                                      child: Center(child:
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.people),
                                          Text("1-10 Employee(s)")
                                        ],),),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
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