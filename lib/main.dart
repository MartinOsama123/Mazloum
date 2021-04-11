import 'dart:convert';

import 'package:badges/badges.dart';
import 'package:curved_bottom_navigation/curved_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vendors/AppColor.dart';
import 'package:vendors/Screens/CartScreen.dart';
import 'package:vendors/Screens/HomeScreen/HomeScreen.dart';
import 'package:vendors/Screens/ProductsScreen.dart';

import 'AppColor.dart';
import 'Models/CartModel.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // Future<void> getPrefs() async {
  //   prefs = await SharedPreferences.getInstance();
  //
  //   user = Cart.fromJson(jsonDecode(prefs.getString("cart")));
  // }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => Cart(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: AppColor.PrimaryColor,
          accentColor: AppColor.AccentColor,
          backgroundColor: AppColor.OffWhiteColor,
          fontFamily: 'Montserrat',
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: '/',
        routes: {
          // When navigating to the "/" route, build the FirstScreen widget.
          '/': (context) => MyHomePage(),
          // When navigating to the "/second" route, build the SecondScreen widget.
        },
      ),
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
          ),
        ),
        toolbarHeight: 70,
        leading: IconButton(
          icon: const Icon(Icons.search),
          tooltip: 'Show Snackbar',
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('This is a snackbar')));
          },
        ),
        title: const Text(
          'MAZLOUM',
          style: TextStyle(fontSize: 35),
        ),
        centerTitle: true,
        actions: <Widget>[
          Consumer<Cart>(builder: (context, value, child) {
            child:
            return Badge(
              position: BadgePosition.topEnd(end: 0, top: 0),
              badgeColor: Colors.blue,
              badgeContent: Text(
                '${value.getCartModel?.length ?? 0}',
                style: TextStyle(color: Colors.white),
              ),
              child: IconButton(
                icon: Icon(Icons.shopping_cart),
                color: Colors.white,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CartScreen()));
                },
              ),
            );
          }),
        ],
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppColor.HorizontalPadding),
            child: IndexedStack(
              index: navPos,
              children: [
                HomeScreen(),
                ProductsScreen(),
                CartScreen(),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: CurvedBottomNavigation(
              navHeight: 50,
              bgColor: Colors.white,
              fabBgColor: Colors.white,
              fabSize: 50,
              selected: navPos,
              onItemClick: (i) {
                setState(() {
                  navPos = i;
                });
              },
              items: [
                Icon(Icons.add_shopping_cart,
                    color: navPos == 0 ? AppColor.PrimaryColor : Colors.grey),
                Icon(Icons.home,
                    color: navPos == 1 ? AppColor.PrimaryColor : Colors.grey),
                //  Icon(Icons.category, color: navPos == 2 ? AppColor.PrimaryColor : Colors.white),
                Icon(Icons.person,
                    color: navPos == 2 ? AppColor.PrimaryColor : Colors.grey),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
