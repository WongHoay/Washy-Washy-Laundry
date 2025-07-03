import 'package:flutter/material.dart';
import 'package:washywashy_laundry/cart_page.dart';
import 'package:washywashy_laundry/dry_page.dart';
import 'package:washywashy_laundry/payment_page.dart';
import 'package:washywashy_laundry/paymentdetail_page.dart';
import 'package:washywashy_laundry/userhistory_page.dart';
import 'package:washywashy_laundry/userhistorydetail_page.dart';
import 'package:washywashy_laundry/washdry_page.dart';
import 'package:washywashy_laundry/washdryfold_page.dart';
import 'sign_in.dart';
import 'sign_up.dart';
import 'userprofile.dart';
import 'home_page.dart';
import 'dry_page.dart';
import 'wash_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';



Future<void> main() async {
  runApp(const MyApp());

  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: 'AIzaSyC-V1uIBSVK2OEHd6WKilc5GItuK4vehRM',
      appId: '1:220039523089:android:82d6f1598f1858c2897ab0',
      messagingSenderId: '220039523089',
      projectId: 'washywashy-laundry',
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Washy Washy Laundry',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      routes: {
        '/': (context) => const SignInPage(),
        '/signup': (context) => const SignUpPage(),
        '/':(context) => const UserProfilePage(),
        '/':(context) => const HomePage(),
        '/':(context) => const DryPage(),
        '/':(context) => const PaymentPage(),
        '/':(context)=> const WashPage(),
        '/':(constext)=> const WashDryPage(),
        '/':(constext)=> const WashDryFoldPage(),
        '/':(constext)=> const PaymentDetailsPage(),
        //'/':(constext)=> const UserCartPage()
        '/':(constext)=> const UserHistoryPage(),
        //'/':(constext)=> const UserHistoryDetailsPage(),



      },
    );
  }
}

