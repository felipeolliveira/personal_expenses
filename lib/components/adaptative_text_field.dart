import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AdaptativeTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final Function(String) onSubmit;
  final TextInputType type;

  AdaptativeTextField({
    this.controller,
    this.label,
    this.onSubmit,
    this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? Padding(
            padding: EdgeInsets.only(bottom: 10.0),
            child: CupertinoTextField(
              controller: controller,
              keyboardType: type,
              prefix: Text(label),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              padding: EdgeInsets.symmetric(horizontal: 6, vertical: 12),
            ),
          )
        : TextField(
            controller: controller,
            keyboardType: type,
            onSubmitted: onSubmit,
            decoration: InputDecoration(
              labelText: label,
              fillColor: Theme.of(context).primaryColor,
            ),
          );
  }
}
