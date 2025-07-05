import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:washywashy_laundry/sign_in.dart';
import 'package:washywashy_laundry/sign_up.dart';
import 'package:washywashy_laundry/home_page.dart';
import 'package:washywashy_laundry/userprofile.dart';
import 'package:washywashy_laundry/dry_page.dart';
import 'package:washywashy_laundry/wash_page.dart';
import 'package:washywashy_laundry/washdry_page.dart';
import 'package:washywashy_laundry/washdryfold_page.dart';
import 'package:washywashy_laundry/payment_page.dart';
import 'package:washywashy_laundry/paymentdetail_page.dart';
import 'package:washywashy_laundry/userhistory_page.dart';
import 'package:washywashy_laundry/userhistorydetail_page.dart';
import 'package:washywashy_laundry/cart_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Required
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: 'AIzaSyC-V1uIBSVK2OEHd6WKilc5GItuK4vehRM',
      appId: '1:220039523089:android:82d6f1598f1858c2897ab0',
      messagingSenderId: '220039523089',
      projectId: 'washywashy-laundry',

      databaseURL: 'https://washywashy-laundry-default-rtdb.asia-southeast1.firebasedatabase.app/',
    ),
  );
  runApp(const MyApp());
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
        '/home': (context) => const HomePage(),
        '/profile': (context) => const UserProfilePage(),
        '/dry': (context) => const DryPage(),
        '/wash': (context) => const WashPage(),
        '/washdry': (context) => const WashDryPage(),
        '/washdryfold': (context) => const WashDryFoldPage(),
        '/payment': (context) => PaymentPage(
          washer: '',
          dryer: '',
          fold: '',
          total: '',
          paymentMethod: '',
          otp: '',
        ),
        '/paymentdetail': (context) => PaymentDetailsPage(
          washer: '',
          dryer: '',
          fold: '',
          total: '',
          paymentMethod: '',
          timestamp: '',
          otp: '',
        ),
        '/cart': (context) => const UserCartPage(),
        '/history': (context) => const UserHistoryPage(),
        //'/historydetail': (context) => const UserHistoryDetailsPage(),
      },
    );
  }
}
