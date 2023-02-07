import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final email = TextEditingController();
  final password = TextEditingController();

  String useremail = '';
  String userpassword = '';
}

class RegisterController extends GetxController {
  final email = TextEditingController();
  final password = TextEditingController();
  final name = TextEditingController();

  String useremail = '';
  String userpassword = '';
  String uname = '';
}

class AddNoteController extends GetxController {
  final user_id = TextEditingController();
  final privacy = TextEditingController();
  final description = TextEditingController();
  final title = TextEditingController();
  final category = TextEditingController();

  int userid = 0;
  String noteprivacy = '';
  String notedescription = '';
  String notetitle = '';
  String notecategory = '';
}
