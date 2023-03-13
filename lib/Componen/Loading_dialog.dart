import 'package:flutter/material.dart';

class Loading_dialog {
  String title;
  BuildContext context;
  Loading_dialog({
    required this.title,
    required this.context,
  });

  show() {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: ((context) {
          return AlertDialog(
            content: Container(
              child: Row(
                children: [
                  SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 8,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(title),
                ],
              ),
            ),
          );
        }));
  }
}
