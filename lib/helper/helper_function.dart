import 'package:flutter/material.dart';

void displayMessageToUser(String title, BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
    ),
  );
}

void showProgress(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible:
        false, // Prevent user from dismissing dialog by tapping outside
    builder: (context) => const Dialog(
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            SizedBox(width: 20),
            Text("Loading..."),
          ],
        ),
      ),
    ),
  );
}
