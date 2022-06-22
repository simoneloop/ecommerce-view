import 'package:ecommerce_view/Uti/Consts.dart';
import 'package:ecommerce_view/entities/Product.dart';
import 'package:ecommerce_view/pages/LoginPage.dart';
import 'package:ecommerce_view/pages/HomePage.dart';
import 'package:ecommerce_view/pages/RegistrationPage.dart';
import 'package:ecommerce_view/pages/UserCartPage.dart';
import 'package:ecommerce_view/pages/UserDetailsPage.dart';
import 'package:flutter/material.dart';

import 'entities/User.dart';
import 'managers/Proxy.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-commerce',
      theme: ThemeData(
        fontFamily: 'Poppins',
        primaryColor: Colors.white,
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          elevation: 0,
          foregroundColor: Colors.white,
        ),
        textTheme: TextTheme(
          headline1: TextStyle(fontSize: 40,  fontWeight: FontWeight.w700,
            color: Colors.black,),
          headline2: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
          headline3: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
          headline4: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.normal,
            color: Colors.black,
          ),
          headline5: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.normal,
            color: Colors.black,
          ),
          bodyText1: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w400,
            color: Colors.blueAccent,
          ),
        ), colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Consts.proviamoColor),
      ),
      debugShowCheckedModeBanner: false,

      initialRoute: 'UserCartPage',
      routes: {
        '/':(context)=>HomePage(),

        'HomePage':(context)=>HomePage(),
        'LoginPage':(context)=>LoginPage(),
        'RegistrationPage':(context)=>RegistrationPage(),
        'UserDetailsPage':(context)=>UserDetailsPage(),
        'UserCartPage':(context)=>UserCartPage(),
      },
    );
  }
}
