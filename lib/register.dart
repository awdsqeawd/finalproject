import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'dart:developer';
import 'dart:convert';

import 'package:loginuicolors/controller/controller.dart';

class MyRegister extends StatefulWidget {
  const MyRegister({Key? key}) : super(key: key);

  @override
  _MyRegisterState createState() => _MyRegisterState();
}

class _MyRegisterState extends State<MyRegister> {
  // bool _isLoading = false;
  var errorMessage;

  final RegisterController controller = Get.put(RegisterController());

  // final TextEditingController nameController = new TextEditingController();
  // final TextEditingController email1Controller = new TextEditingController();
  // final TextEditingController password1Controller = new TextEditingController();

  late String errormsg;
  late bool error, showprogress;
  final formKey = GlobalKey<FormState>();

  void clearText() {
    controller.name.clear();
    controller.email.clear();
    controller.password.clear();
  }

  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/regbg1.png'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.2), BlendMode.darken)),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(left: 35, top: 30),
              child: Text(
                'Create\nAccount',
                style: TextStyle(color: Color(0xff4c505b), fontSize: 33),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 35, right: 35),
                      child: Form(
                          key: formKey,
                          child: Column(
                            children: [
                              TextFormField(
                                controller: controller.name,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter Name!';
                                  }
                                  return null;
                                },
                                style: TextStyle(
                                    color: Color.fromARGB(255, 0, 0, 0)),
                                decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: Color(0xff4c505b),
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: Colors.black,
                                      ),
                                    ),
                                    hintText: "Name",
                                    hintStyle:
                                        TextStyle(color: Color(0xff4c505b)),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    )),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              TextFormField(
                                controller: controller.email,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter email!';
                                  }
                                  return null;
                                },
                                style: TextStyle(
                                    color: Color.fromARGB(255, 0, 0, 0)),
                                decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: Color(0xff4c505b),
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: Colors.black,
                                      ),
                                    ),
                                    hintText: "Email",
                                    hintStyle:
                                        TextStyle(color: Color(0xff4c505b)),
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
                                    return 'Please enter Password!';
                                  }
                                  return null;
                                },
                                style: TextStyle(
                                    color: Color.fromARGB(255, 0, 0, 0)),
                                obscureText: true,
                                decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide:
                                          BorderSide(color: Color(0xff4c505b)),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: Colors.black,
                                      ),
                                    ),
                                    hintText: "Password",
                                    hintStyle:
                                        TextStyle(color: Color(0xff4c505b)),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    )),
                              ),
                              SizedBox(
                                height: 40,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Sign Up',
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 105, 104, 104),
                                        fontSize: 27,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Color(0xff4c505b),
                                    child: IconButton(
                                        color:
                                            Color.fromARGB(255, 255, 254, 254),
                                        onPressed: () {
                                          register(context);
                                          clearText();
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
                                      Navigator.pop(context, 'login');
                                      clearText();
                                    },
                                    child: Text(
                                      'Log In',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          decoration: TextDecoration.underline,
                                          color: Color(0xff4c505b),
                                          fontSize: 18),
                                    ),
                                    style: ButtonStyle(),
                                  ),
                                ],
                              )
                            ],
                          )),
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

  register(BuildContext cont) async {
    var response = await http
        .post(Uri.parse('http://192.168.1.15:8080/api/register'), body: {
      'name': controller.name.text,
      'email': controller.email.text,
      'password': controller.password.text
    });

    log(response.body);
    log("reponse $response");
    if (response.statusCode == 200) {
      var jsondata = json.decode(response.body);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Account has been created!')),
      );
      Navigator.restorablePushReplacementNamed(cont, 'login');

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
        }
      }
    } else {
      setState(() {
        showprogress = false; //don't show progress indicator
        error = true;
        errormsg = "Error during connecting to server.";
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Creating account failed!')),
      );
    }
  }
}
