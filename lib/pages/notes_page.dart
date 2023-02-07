import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer';
import '../addnote.dart';
import 'edit_note_page.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({Key? key}) : super(key: key);

  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  bool isLoading = false;
  late bool error, showprogress;
  late String errormsg;

  List noteList = [];

  @override
  void initState() {
    super.initState();

    refreshNotes();
  }

  Future refreshNotes() async {
    setState(() => isLoading = true);
    showNotes();
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FaceNote'),
        backgroundColor: Color(0xff4c505b),
        actions: [Icon(Icons.search), SizedBox(width: 12)],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: GNav(
            tabBackgroundColor: Color.fromARGB(224, 104, 103, 103),
            gap: 8,
            padding: EdgeInsets.all(16),
            tabs: [
              GButton(
                text: 'Home',
                icon: Icons.home,
              ),
              GButton(
                text: 'Post',
                icon: Icons.post_add_sharp,
              ),
              GButton(
                text: 'Setting',
                icon: Icons.settings,
              )
            ]),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/user_pro.png'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.2), BlendMode.darken)),
        ),
        child: Center(
            child: isLoading
                ? CircularProgressIndicator()
                : noteList.isEmpty
                    ? Text(
                        'No Notes',
                        style: TextStyle(
                            color: Color.fromARGB(255, 10, 7, 7), fontSize: 24),
                      )
                    : ListView.builder(
                        itemCount: noteList.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: Text(noteList[index]['category']),
                            title: Text(noteList[index]['title']),
                            subtitle: Text(noteList[index]['description']),
                          );
                        },
                      )),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        child: Icon(Icons.add),
        onPressed: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => AddEditNotePage()),
          );

          refreshNotes();
        },
      ),
    );
  }

  showNotes() async {
    var response = await http.get(
      Uri.parse('http://192.168.1.15:8080/crud/index'),
    );

    log(response.body);
    log("reponse $response");
    if (response.statusCode == 200) {
      // var jsondata = json.decode(response.body);
      //msg for front-end
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Loading notes!')),
      );

      setState(() {
        noteList = json.decode(response.body);
      });
      return noteList;
    } else {
      setState(() {
        showprogress = false; //don't show progress indicator
        error = true;
        errormsg = "Error during connecting to server.";
      });
      //msg for front-end
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error during connecting to server')),
      );
    }
  }
}
