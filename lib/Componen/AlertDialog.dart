import 'package:flutter/material.dart';

Future<void> Alert(
  BuildContext context,
  String judul,
  String pesan,
) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(judul),
          content: Text(pesan),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Ok")),
          ],
        );
      });
}
