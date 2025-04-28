import 'package:flutter/material.dart';
import 'package:forms_validate/pages/bottom_nav_bar.dart';
// import 'package:forms_validate/pages/home.dart';
import 'package:forms_validate/pages/login.dart';
import 'package:forms_validate/pages/profile/edit_profile.dart';
import 'package:forms_validate/pages/profile/security.dart';
import 'package:forms_validate/pages/profile/sign_out.dart';
import 'package:forms_validate/pages/register.dart';
import 'package:forms_validate/pages/router.dart';
import 'package:forms_validate/pages/welcome_page.dart';
import 'package:forms_validate/services/airtime.dart';
import 'package:forms_validate/services/data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        AppRoutes.indexPage: (context) => WelcomePage(),
        //  AppRoutes.homePage: (context) => HomePage(),
        AppRoutes.security: (context) => Security(),
        AppRoutes.data: (context) => Data(),
        AppRoutes.airtime: (context) => Airtime(),
        AppRoutes.logout: (context) => SignOut(),
        AppRoutes.register: (context) => RegisterPage(),
        AppRoutes.login: (context) => LoginPage(),
        AppRoutes.editProfile: (context) => EditProfile(),
        AppRoutes.home: (context) => BottomNavBar(),
      },
    );
  }
}
