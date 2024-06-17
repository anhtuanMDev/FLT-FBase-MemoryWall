import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:memory_wall/pages/HomePage.dart';
import 'package:memory_wall/pages/ProfilePage.dart';

class DrawerCpn extends StatelessWidget {
  const DrawerCpn({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child: Container(
              alignment: Alignment.center,
              height: 150,
              child: Text(
                "M E M O R Y W A L L",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              color: Theme.of(context).colorScheme.primary,
            ),
            padding: EdgeInsets.zero,
          ),
          ListTile(
              title: Text("Home page"),
              leading: Icon(Icons.home),
              onTap: () => {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomePage()))
                  }),
          ListTile(
              title: Text("Profile page"),
              leading: Icon(Icons.person),
              onTap: () => {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ProfilePage()))
                  }),
          ListTile(
            title: Text("Log out"),
            leading: Icon(Icons.logout),
            onTap: () {
              FirebaseAuth.instance.signOut();
            },
          ),
        ],
      ),
    );
  }
}
