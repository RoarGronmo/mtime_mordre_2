import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Snackbar {
  Snackbar._();
  static buildSuccessSnackbar(BuildContext context, String message, {int durationInSeconds = 7}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(message),
        duration : Duration(seconds : durationInSeconds),
        backgroundColor: Colors.green,

    ));
  }

  static buildErrorSnackbar(BuildContext context, String message, {int durationInSeconds = 7} ) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(message),
        duration : Duration(seconds : durationInSeconds),
        backgroundColor: Colors.red,

    ));
  }
}