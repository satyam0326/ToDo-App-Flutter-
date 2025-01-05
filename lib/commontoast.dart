import 'package:flutter/material.dart';

commonToast(BuildContext context, String message, {Color? bgColor}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(message),
    backgroundColor: bgColor ?? Colors.red,
  ));
}
