import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class User_profile extends StatefulWidget {
  const User_profile({Key? key}) : super(key: key);

  @override
  State<User_profile> createState() => _User_profileState();
}

class _User_profileState extends State<User_profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('FaceNote'),
          backgroundColor: Color(0xff4c505b),
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
        ));
  }
}
