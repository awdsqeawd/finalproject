import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:developer';
import 'controller/controller.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddNote extends StatefulWidget {
  const AddNote({Key? key}) : super(key: key);

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Note'),
        backgroundColor: Color(0xff4c505b),
        // actions: [Icon(Icons.search), SizedBox(width: 12)],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/user_pro.png'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.2), BlendMode.darken)),
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(0.8),
            )
          ],
        ),
      ),
    );
  }
}
