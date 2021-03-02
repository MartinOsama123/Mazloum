
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:vendors/AppColor.dart';

class SupplierProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Company Profile",style: TextStyle(color: AppColor.PrimaryColor),),centerTitle: true,backgroundColor: Colors.transparent,elevation: 0,),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppColor.HorizontalPadding,horizontal: AppColor.HorizontalPadding),
        child: Center(
          child: Column(children: [
            Image.asset("images/temp_logo.png",height: 154),
            Text("Company Name"),
            Text("Industry Name"),
            RatingBar.builder(
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
            Row(mainAxisAlignment: MainAxisAlignment.center,children: [
              Icon(Icons.people),
              Text("1-10 Employee")
            ],),
            Text("Description"),
            Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."),
            Text("To Know More"),
            FlatButton.icon(onPressed: (){}, icon: Icon(Icons.file_download), label: Text("Download Portfolio")),
            Row(children: [
              FlatButton.icon(onPressed: (){}, icon: Icon(Icons.phone), label: Text("")),
              FlatButton.icon(onPressed: (){}, icon: Icon(Icons.mail), label: Text("Mail")),

            ],)

          ],),
        ),
      ),
    );
  }

}