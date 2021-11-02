import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../AppColor.dart';
import 'HomeScreen.dart';
import 'SignupScreen.dart';
class LoginScreen extends StatelessWidget{
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final bool skip;

   LoginScreen({Key? key, this.skip = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return  Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/background.png"), fit: BoxFit.cover)),
        child: Scaffold(
          backgroundColor: Colors.transparent,
        body: SafeArea(
              child: Column(
                children: [
                 SizedBox(height: MediaQuery.of(context).size.height / 2.5,),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: Text(
                                    "Login",
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                               Padding(
                                 padding: const EdgeInsets.all(8.0),
                                 child: SizedBox(
                                   height: 45,
                                   child: TextField(
                                      controller: _emailController,
                                      decoration: InputDecoration(

                                        fillColor: AppColor.PrimaryColor,
                                        border: OutlineInputBorder(),
                                        labelText: "Email",
                                      ),
                                    ),
                                 ),
                               ),

                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  height: 45,
                                  child: TextField(
                                      controller: _passwordController,
                                      obscureText: true,
                                      decoration: InputDecoration(
                                        fillColor: AppColor.PrimaryColor,
                                        border: OutlineInputBorder(),
                                        labelText: 'Password',
                                      ),
                                    ),
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child:
                                    InkWell(onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => SignupScreen())), child: const Text("noEmail",style: TextStyle(color: AppColor.SecondColor,decoration: TextDecoration.underline))),

                              ),
                              Container(
                                width: size.width / 2,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(primary: AppColor.PrimaryColor),
                                  child: Text("Login"),
                                  onPressed: () async {

                                    },
                                ),
                              ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: GestureDetector(),
                  )
                ],
              ),
        )
      ),
    );
  }
}