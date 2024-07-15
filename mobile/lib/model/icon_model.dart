import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ItemIconModel {
  String? title;
  IconData? icon;
  IconData? iconSelected;
  Color? color;
  dynamic type;

  ItemIconModel({this.title, this.icon, this.color, this.iconSelected,this.type});
}
