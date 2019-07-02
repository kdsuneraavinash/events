import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

@immutable
class Category {
  final String name;
  final IconData icon;

  Category({this.name, this.icon});

  static List<Category> get categoryList => [
        Category(icon: FontAwesomeIcons.baseballBall, name: "Sports"),
        Category(icon: FontAwesomeIcons.graduationCap, name: "Education"),
        Category(icon: FontAwesomeIcons.car, name: "Travelling"),
        Category(icon: FontAwesomeIcons.film, name: "Movies & TV Shows"),
        Category(icon: FontAwesomeIcons.book, name: "Books"),
        Category(icon: FontAwesomeIcons.microphone, name: "Public Speeches"),
        Category(icon: FontAwesomeIcons.music, name: "Music"),
        Category(icon: FontAwesomeIcons.theaterMasks, name: "Drama"),
        Category(icon: FontAwesomeIcons.star, name: "Misc"),
      ];
}
