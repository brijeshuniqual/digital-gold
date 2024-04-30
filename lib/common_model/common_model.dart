import 'package:flutter/material.dart';

class CommonModel {
  String? title;
  String? subtitle;
  List<CommonModel>? listData;
  String? image;
  String? unSelectedImage;
  int? id;
  double? height;
  String? desc;
  List<String>? list;
  Function? onPressed;
  bool? isSelected = false;
  TextEditingController? controller;
  TextEditingController? focusNode;

  CommonModel({
    this.title,
    this.id,
    this.onPressed,
    this.image,
    this.unSelectedImage,
    this.desc,
    this.isSelected = false,
    this.subtitle,
    this.controller,
    this.list,
    this.height,
    this.listData,
  });

  CommonModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    return data;
  }
}
