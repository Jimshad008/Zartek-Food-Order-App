import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../feature/auth/presentation/pages/login_page.dart';

void showLogoutDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              SharedPreferences local=await SharedPreferences.getInstance();
              local.clear();
             Navigator.pushAndRemoveUntil(context, CupertinoPageRoute(builder: (context) => const LoginPage(),), (route) => false);
            },
            child: const Text('Logout'),
          ),
        ],
      );
    },
  );
}