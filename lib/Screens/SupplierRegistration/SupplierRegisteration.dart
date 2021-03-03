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

class SupplierRegisteration extends StatefulWidget {

  @override
  _SupplierRegisterationState createState() => _SupplierRegisterationState();
}

class _SupplierRegisterationState extends State<SupplierRegisteration> {
  int index = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        child: Column(children: [
          Container(
            child: FittedBox(fit: BoxFit.cover,child: Image.asset("images/supplier_"+index.toString()+".png"))),
            Expanded(child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppColor.HorizontalPadding,vertical: 12),
              child: index == 1 ? SupplierMainInfo() : SupplierRegisterWidget()
            )),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppColor.HorizontalPadding,vertical: 12),
            child: FlatButton(
              onPressed: () {setState(() {
                index++;
              });},
              child: Text(
                "Next",
                style: TextStyle(
                    fontSize: 18, letterSpacing: 1, color: Colors.white),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)
              ),
              minWidth: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.07,
              color: AppColor.SupplierPrimaryColor,
            ),
          ),
          ],
          ),
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
      children: <Widget>[
        const Text("Get Your Tender Now",style: TextStyle(color: AppColor.SupplierPrimaryColor,fontSize: 20,fontWeight: FontWeight.bold)),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 4, 0, 41),
          child: const Text("Register",style: TextStyle(color: AppColor.SupplierLabelColor,fontSize: 14)),
        ),
        SupplierTextField(userText: _userText,placeholder: "Name"),
        SupplierTextField(userText: _emailText,placeholder: "Email"),
        SupplierTextField(userText: _passText,placeholder: "Password"),
        SupplierTextField(userText: _confirmPassText,placeholder: "Confirm Password"),
      ],
    );
  }
}

class SupplierTextField extends StatelessWidget {
  const SupplierTextField({
    Key key,
    @required TextEditingController userText,
    @required String placeholder
  }) : _userText = userText, _placeholder = placeholder, super(key: key);

  final TextEditingController _userText;
  final String _placeholder;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0,0,0,6),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.07,
        child: TextField(
          controller: _userText,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderSide: BorderSide(color: AppColor.SupplierBorderColor)),
            labelText: _placeholder,
          ),
        ),
      ),
    );
  }
}
