import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:developer';
import 'package:http/http.dart' as http;
import '../controller/controller.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'dart:convert';

class AddEditNotePage extends StatefulWidget {
  const AddEditNotePage({Key? key}) : super(key: key);

  @override
  _AddEditNotePageState createState() => _AddEditNotePageState();
}

class _AddEditNotePageState extends State<AddEditNotePage> {
  final _formKey = GlobalKey<FormState>();
  late bool error, showprogress;
  bool isChecked = false;
  late String errormsg;

  final AddNoteController controller = Get.put(AddNoteController());

  //category Dropdown
  final List<String> items = [
    'Technology',
    'Programming',
    'Science',
    'Sports',
    'Random',
  ];
  String? selectedValue;

  List<DropdownMenuItem<String>> _addDividersAfterItems(List<String> items) {
    List<DropdownMenuItem<String>> _menuItems = [];
    for (var item in items) {
      _menuItems.addAll(
        [
          DropdownMenuItem<String>(
            value: item,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                item,
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
          ),
          //If it's last item, we will not add Divider after it.
          if (item != items.last)
            const DropdownMenuItem<String>(
              enabled: false,
              child: Divider(),
            ),
        ],
      );
    }
    return _menuItems;
  }

  List<double> _getCustomItemsHeights() {
    List<double> _itemsHeights = [];
    for (var i = 0; i < (items.length * 2) - 1; i++) {
      if (i.isEven) {
        _itemsHeights.add(40);
      }
      //Dividers indexes will be the odd indexes
      if (i.isOdd) {
        _itemsHeights.add(4);
      }
    }
    return _itemsHeights;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Create Note'),
          backgroundColor: Color(0xff4c505b),
        ),
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/user_pro.png'),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.2), BlendMode.darken))),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Row(
                        children: [
                          Text(
                            'Private',
                            style: TextStyle(fontSize: 14.0),
                          ),
                          Checkbox(
                            checkColor: Colors.white,
                            value: isChecked,
                            onChanged: (bool? value) {
                              setState(() {
                                isChecked = !isChecked;
                              });
                            },
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 135),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton2(
                          isExpanded: true,
                          icon: Icon(Icons.list),
                          hint: Text(
                            'Category',
                            style: TextStyle(
                              fontSize: 14,
                              color: Theme.of(context).hintColor,
                            ),
                          ),
                          items: _addDividersAfterItems(items),
                          customItemsHeights: _getCustomItemsHeights(),
                          value: selectedValue,
                          searchController: controller.category,
                          onChanged: (value) {
                            setState(() {
                              selectedValue = value as String;
                            });
                          },
                          buttonHeight: 40,
                          dropdownMaxHeight: 200,
                          buttonWidth: 140,
                          itemPadding:
                              const EdgeInsets.symmetric(horizontal: 8.0),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 30, left: 15),
                  child: TextFormField(
                      controller: controller.title,
                      style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                      decoration: InputDecoration(
                          fillColor: Color.fromARGB(255, 248, 245, 245),
                          filled: false,
                          hintText: "Title",
                          border: InputBorder.none)),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 25, right: 15),
                  child: TextFormField(
                      controller: controller.description,
                      keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.newline,
                      minLines: 1,
                      maxLines: 10,
                      style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                      decoration: InputDecoration(
                        fillColor: Color.fromARGB(255, 248, 245, 245),
                        filled: false,
                        hintText: "Type here...",
                        border: InputBorder.none,
                      )),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 80),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.grey.shade700,
                    ),
                    onPressed: () {
                      createNotes();
                      // print('hellooooooooooooooooooooo');
                    },
                    child: Text('Save'),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  createNotes() async {
    var privacy;
    isChecked ? privacy = 1 : privacy = 0;
    var response = await http
        .post(Uri.parse('http://192.168.1.15:8080/crud/create'), body: {
      'privacy': privacy.toString(),
      'description': controller.description.text,
      'title': controller.title.text,
      'category': selectedValue.toString(),
    });

    log(response.body);
    log("reponse $response");
    if (response.statusCode == 200) {
      //msg for front-end
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Notes created successfully!')),
      );
      print('Dre ma success');
    } else {
      setState(() {
        showprogress = false; //don't show progress indicator
        error = true;
        errormsg = "Error during connecting to server.";
      });
      log('mo niy response ${response.body}');
      //msg for front-end
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error during connecting to server')),
      );
    }
  }
}
