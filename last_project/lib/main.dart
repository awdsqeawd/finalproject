import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loginuicolors/login.dart';
import 'package:loginuicolors/pages/notes_page.dart';
import 'package:loginuicolors/register.dart';
import 'user_profile.dart';
import 'forgotpassword.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    //theme: ThemeData(brightness: Brightness.dark),
    home: MyLogin(),
    routes: {
      'register': (context) => MyRegister(),
      'login': (context) => MyLogin(),
      'user_profile': (context) => User_profile(),
      'pages/notes_page': (context) => NotesPage(),
      'forgotpassword': (context) => ForgotPassword(),
    },
  ));
}
