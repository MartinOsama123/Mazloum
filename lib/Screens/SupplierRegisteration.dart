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
  String dropdownValue = "Industry";
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 250,
                  child: Image.asset("images/group_359.png")),
              Text(
                "We need some information about your company",
                style: TextStyle(fontSize: 24),
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
              FlatButton(
                onPressed: () {},
                child: Text(
                  "Next",
                  style: TextStyle(
                      fontSize: 18, letterSpacing: 1, color: Colors.white),
                ),
                color: Theme.of(context).accentColor,
                minWidth: 200,
                height: 40,
              ),
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
