import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:vendors/AppColor.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body:
      Column(children: [
        Container(
          height: 250,
          child: FittedBox(fit: BoxFit.fill,child: Image.asset("images/group_359.png")),width: MediaQuery.of(context).size.width,),
          Expanded(child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppColor.HorizontalPadding),
            child: SupplierRegisterWidget(),
          )),
        ],
        ),

    );
  }
}

class SupplierRegisterWidget extends StatelessWidget {
  const SupplierRegisterWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Column(
          children: [

            Text(
              "Find your supplier now",
              style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,

            ),
            // Spacer(),
            // SupplierMainInfo(),
            // Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DescriptionSupplier(),
            ),
            Spacer(),
          ],
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
  TextEditingController _descriptionText = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: DropdownButton<String>(
            value: dropdownValue,
            icon: Icon(Icons.arrow_downward),
            isExpanded: true,
            iconSize: 24,
            elevation: 16,

            underline: Container(
              height: 2,
              color: AppColor.PrimaryColor,
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
                child: Text(
                  value,
                  style: TextStyle(fontSize: 24),
                ),
              );
            }).toList(),
          ),
        ),
        Container(
          height: 200,
          child: TextField(
            controller: _descriptionText,
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Description',
                alignLabelWithHint: true,
                contentPadding: EdgeInsets.all(6.0)),
            maxLines: null,
            minLines: null,
            textAlignVertical: TextAlignVertical.top,
            expands: true,
          ),
        ),
      ],
    );
  }
}

class SupplierMainInfo extends StatefulWidget {
  const SupplierMainInfo({
    Key key,
  }) : super(key: key);

  @override
  _SupplierMainInfoState createState() => _SupplierMainInfoState();
}

class _SupplierMainInfoState extends State<SupplierMainInfo> {
  TextEditingController _userText, _passText, _emailText, _confirmPassText;
  bool emailCorrect = false;
  void initState() {
    super.initState();
    _userText = new TextEditingController();
    _emailText = new TextEditingController();
    _passText = new TextEditingController();
    _confirmPassText = new TextEditingController();
  }

  void dispose() {
    _userText.dispose();
    _emailText.dispose();
    _passText.dispose();
    _confirmPassText.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _userText,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Name',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _emailText,
            onChanged: (newValue) {
              if (newValue.contains("@"))
                setState(() {
                  emailCorrect = true;
                });
            },
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email',
                errorText: !emailCorrect ? "Must Contain @" : null),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _passText,
            obscureText: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Password',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _confirmPassText,
            obscureText: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Confirm Password',
            ),
          ),
        ),
      ],
    );
  }
}
