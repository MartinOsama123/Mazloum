import 'package:badges/badges.dart';
import 'package:curved_bottom_navigation/curved_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vendors/AppColor.dart';
import 'package:vendors/Screens/HomeScreen/HomeScreen.dart';

import 'AppColor.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppColor.PrimaryColor,
        accentColor: AppColor.AccentColor,
        backgroundColor: AppColor.OffWhiteColor,
        fontFamily: 'Montserrat',
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);



  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const platform = const MethodChannel("com.flutter.epic/epic");
  int navPos = 0;

  void _incrementCounter() async {
    var value;
    try {
      value = await platform.invokeMethod("printy");
    } catch (e) {
      print(e.toString());
    }
    print(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: ContinuousRectangleBorder(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(50.0),
          ),),
        toolbarHeight: 70,
        leading:    IconButton(
          icon: const Icon(Icons.search),
          tooltip: 'Show Snackbar',
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('This is a snackbar')));
          },
        ),
        title: const Text('MAZLOUM',style: TextStyle(fontSize: 35),),
        centerTitle: true,
        actions: <Widget>[
            Badge(
              position: BadgePosition.topEnd(top: 5, end: 4),
              badgeColor: Colors.blue,
              badgeContent: Text(
                '3',
                style: TextStyle(color: Colors.white),
              ),
              child: IconButton(icon: Icon(Icons.shopping_cart), color: Colors.white,onPressed: (){},),
            ),
        ],
      ),
      body: Stack(
        children: [
          IndexedStack(
            index: navPos,
            children: [
              HomeScreen(),
              Text("Two"),
              Text("Three"),
              Text("Four"),
              Text("Five"),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: CurvedBottomNavigation(
              bgColor: AppColor.PrimaryColor,
              selected: navPos,
              onItemClick: (i) {
                setState(() {
                  navPos = i;
                });
              },
              items: [
                Icon(Icons.home, color: Colors.white),
                Icon(Icons.add_shopping_cart, color: Colors.white),
                Icon(Icons.category, color: Colors.white),
                Icon(Icons.person, color: Colors.white),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

