import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';



// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key key, this.title}) : super(key: key);
//
//
//
//   final String title;
//
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

class SupplierRegisteration extends StatelessWidget {
  String dropdownValue = "Industry";
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Text("Supplier"),
      ),
      body: Center(

        child: Padding(
          padding: const EdgeInsets.all(8.0),

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("We need some information about your company",style: TextStyle(fontSize: 24),textAlign: TextAlign.center,),
                Spacer(),
                SupplierMainInfo(),
                Spacer(),
             Expanded(child: DescriptionSupplier()),
                Spacer(),
                FlatButton(onPressed: (){}, child: Text("Next",style: TextStyle(fontSize: 18,letterSpacing: 1,color: Colors.white),),color: Theme.of(context).accentColor,minWidth: 200,height: 40,),
              ],
            ),

        ),
      ),

    );
  }
}


class DescriptionSupplier extends StatefulWidget {
  DescriptionSupplier({Key key}) : super(key: key);




  @override
  _MyDescriptionSupplier createState() => _MyDescriptionSupplier();
}
class _MyDescriptionSupplier extends State<DescriptionSupplier> {
  String dropdownValue = "Industry";

  @override
  Widget build(BuildContext context) {
    body:
    return

      DropdownButton<String>(
        value: dropdownValue,
        icon: Icon(Icons.arrow_downward),
        iconSize: 24,
        elevation: 16,
        style: TextStyle(color: Colors.deepPurple),
        underline: Container(
          height: 2,
          color: Colors.deepPurpleAccent,
        ),
        onChanged: (String newValue) {
          setState(() {
            dropdownValue = newValue;
          });
        },
        items: <String>['Industry', 'Two', 'Free', 'Four']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      );
  }
}
class SupplierMainInfo extends StatelessWidget {
  const SupplierMainInfo({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(

      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Name',
            ),),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Email',
            ),),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            obscureText: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Password',
            ),),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            obscureText: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Confirm Password',
            ),),
        ),

          ],
    );
  }
}
