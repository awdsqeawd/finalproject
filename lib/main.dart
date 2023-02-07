import 'package:flutter/material.dart';
import 'package:loginuicolors/addnote.dart';
// import 'package:get/get.dart';
import 'package:loginuicolors/login.dart';
import 'package:loginuicolors/pages/notes_page.dart';
import 'package:loginuicolors/register.dart';
import 'forgotpassword.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    //theme: ThemeData(brightness: Brightness.dark),
    home: MyLogin(),
    routes: {
      'register': (context) => MyRegister(),
      'login': (context) => MyLogin(),
      'pages/notes_page': (context) => NotesPage(),
      'forgotpassword': (context) => ForgotPassword(),
      'addnote': (context) => AddNote(),
    },
  ));
}
