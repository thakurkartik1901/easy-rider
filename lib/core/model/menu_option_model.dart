import 'package:flutter/material.dart';

// Model class to hold menu option data (language and theme)
class MenuOptionsModel {
  String? key;
  String? value;
  String? description;
  IconData? icon;

  MenuOptionsModel({this.key, this.value, this.description, this.icon});
}
