import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:developer';
import 'controller/controller.dart';
import 'package:get/get.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({Key? key}) : super(key: key);

  @override
  _MyLoginState createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  var errorMessage;

  final LoginController controller = Get.put(LoginController());
  // final TextEditingController emailController = new TextEditingController();
  // final TextEditingController passwordController = new TextEditingController();
  void clearText() {
    controller.email.clear();
    controller.password.clear();
  }

  void dispose() {
    controller.dispose();
    super.dispose();
  }

  late String errormsg;
  late bool error, showprogress;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/bg.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.1), BlendMode.darken)),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(),
            Container(
              padding: EdgeInsets.only(left: 90, top: 170),
              child: Text(
                'Welcome to\nFACENOTE',
                style: GoogleFonts.lato(
                    textStyle: TextStyle(
                        color: Color(0xff4c505b),
                        fontSize: 39,
                        fontWeight: FontWeight.w900)),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 35, right: 35),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: controller.email,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter email address!';
                                }
                                return null;
                              },
                              style: TextStyle(color: Color(0xff4c505b)),
                              decoration: InputDecoration(
                                  fillColor: Color.fromARGB(255, 248, 245, 245),
                                  filled: true,
                                  hintText: "Email",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  )),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            TextFormField(
                              controller: controller.password,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter password!';
                                }
                                return null;
                              },
                              style: TextStyle(),
                              obscureText: true,
                              decoration: InputDecoration(
                                  fillColor: Color.fromARGB(255, 248, 245, 245),
                                  filled: true,
                                  hintText: "Password",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  )),
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Sign in',
                                  style: TextStyle(
                                      fontSize: 27,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xff4c505b)),
                                ),
                                CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Color(0xff4c505b),
                                  child: IconButton(
                                      color: Colors.white,
                                      onPressed: () {
                                        setState(() {
                                          _isLoading = true;
                                        });
                                        if (_formKey.currentState!.validate()) {
                                          signIn(context);
                                          clearText();
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                                content: Text(
                                                    'Must fill all text fields!')),
                                          );
                                          clearText();
                                        }
                                      },
                                      icon: Icon(
                                        Icons.arrow_forward,
                                      )),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pushNamed(context, 'register');
                                      clearText();
                                    },
                                    child: Text(
                                      'Sign Up',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          decoration: TextDecoration.underline,
                                          color: Color(0xff4c505b),
                                          fontSize: 18),
                                    ),
                                    style: ButtonStyle(),
                                  ),
                                ])
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  signIn(BuildContext cont) async {
    var response = await http
        .post(Uri.parse('http://192.168.1.15:8080/api/login'), body: {
      'email': controller.email.text,
      'password': controller.password.text
    });

    log(response.body);
    log("reponse $response");
    if (response.statusCode == 200) {
      var jsondata = json.decode(response.body);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login successful!')),
      );
      Navigator.restorablePushReplacementNamed(cont, 'pages/notes_page');

      if (jsondata["error"]) {
        setState(() {
          showprogress = false; //don't show progress indicator
          error = true;
          errormsg = jsondata["message"];
        });
      } else {
        if (jsondata["success"]) {
          setState(() {
            error = false;
            showprogress = false;
          });
          //save the data returned from server
          //and navigate to home page
          // String uid = jsondata["uid"];
          // String fullname = jsondata["fullname"];
          // String address = jsondata["address"];
          // print(fullname);
          //user shared preference to save data
        } else {
          showprogress = false; //don't show progress indicator
          error = true;
          errormsg = "Something went wrong.";
          //message for front-end
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Something went wrong!')),
          );
        }
      }
    } else {
      setState(() {
        showprogress = false; //don't show progress indicator
        error = true;
        errormsg = "Error during connecting to server.";
      });
      //msg for front-end
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Account does not exist!')),
      );
    }
  }
}
