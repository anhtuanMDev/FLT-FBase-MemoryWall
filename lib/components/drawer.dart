import 'package:flutter/material.dart';

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
          const ListTile(
            title: Text("Home page"),
            leading: Icon(Icons.home),
          ),
          const ListTile(
            title: Text("Profile page"),
            leading: Icon(Icons.person),
          ),
          const ListTile(
            title: Text("Log out"),
            leading: Icon(Icons.logout),
          ),
        ],
      ),
    );
  }
}
