import 'package:flutter/material.dart';

/// Any message already up is dismissed first, so a burst of failures leaves
/// one message rather than a queue the user has to sit through.
void showToast(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(message)));
}
