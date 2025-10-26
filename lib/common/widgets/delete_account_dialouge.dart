import 'package:flutter/material.dart';

class DeleteAccountDialog {
  // Function to show delete account confirmation dialog
  static Future<void> showDeleteConfirmationDialog(BuildContext context,
      {VoidCallback? deleteOnTap}) async {
    showDialog(
      context: context,
      barrierDismissible: false, // User must choose an action
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Account'),
          content: Text(
              'Are you sure you want to delete your account? This action is irreversible.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: deleteOnTap,
              child: Text('Delete',style: TextStyle(color: Colors.red),),
            ),
          ],
        );
      },
    );
  }
}