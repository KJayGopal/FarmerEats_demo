import 'package:flutter/material.dart';

class OnboardModel {
  final String image;
  final String title;
  final String description;
  final Color backgroundColor;

  OnboardModel({
    required this.image,
    required this.title,
    required this.description,
    this.backgroundColor = Colors.white,
  });
}
