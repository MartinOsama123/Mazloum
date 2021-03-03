import 'package:flutter/material.dart';
import 'package:vendors/AppColor.dart';

class VendorLoginScreen extends StatefulWidget {
  @override
  _VendorLoginScreenState createState() => _VendorLoginScreenState();
}

class _VendorLoginScreenState extends State<VendorLoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        children: [
          Container(
              height: 250,
              child: FittedBox(fit: BoxFit.fill,child: Image.asset("images/group_359.png")),width: MediaQuery.of(context).size.width),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppColor.HorizontalPadding),
              child: Column(
                  children: [

                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Text(
                        "Find your supplier now",
                        style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: AppColor.PrimaryColor),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 25),
                      child: Text(
                        "Login",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal,color: AppColor.SecondColor),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    // Spacer(),
                    // SupplierMainInfo(),
                    // Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: TextField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Email',

                      )),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Password',
                          )),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FlatButton(
                        onPressed: () {},
                        child: Text(
                          "Confirm",
                          style: TextStyle(
                              fontSize: 18, letterSpacing: 1, color: Colors.white),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)
                        ),
                        minWidth: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.07,
                        color: AppColor.PrimaryColor,
                      ),
                    ),
                  ],
                ),
            ),
          ),
        ],
      ),

    );
  }
}
