
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vendors/AppColor.dart';
import 'package:vendors/Screens/HomeScreen.dart';
import 'Data.dart';
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
      create: (_) => Cart(cartModel: []),
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
          '/': (context) => ProductsScreen(),
          // When navigating to the "/second" route, build the SecondScreen widget.
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({required this.title});

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int navPos = 0;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(

        items: <Widget>[
          Icon(Icons.add_shopping_cart,
              color: navPos == 0 ? AppColor.PrimaryColor : Colors.grey),
          Icon(Icons.home,
              color: navPos == 1 ? AppColor.PrimaryColor : Colors.grey),
          //  Icon(Icons.category, color: navPos == 2 ? AppColor.PrimaryColor : Colors.white),
          Icon(Icons.person,
              color: navPos == 2 ? AppColor.PrimaryColor : Colors.grey),
        ],
        onTap: (index) {
          setState(() {
            navPos = index;
          });
        },
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
