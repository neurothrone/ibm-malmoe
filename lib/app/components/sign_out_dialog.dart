import 'package:flutter/material.dart';

class SignOutDialog extends StatelessWidget {
  const SignOutDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Sign out"),
      content: const Text("Are you sure you want to sign out?"),
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text(
            "Cancel",
            style: TextStyle(
              color: Colors.blue,
              fontSize: 16.0,
            ),
          ),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: const Text(
            "Sign out",
            style: TextStyle(
              color: Colors.blue,
              fontSize: 16.0,
            ),
          ),
        ),
      ],
    );
  }
}
