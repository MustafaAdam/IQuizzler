import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final TextStyle style = GoogleFonts.vollkorn(
  color: Colors.black,
  fontSize: 30,
  fontWeight: FontWeight.w500,
);

List<Map> categories = [
  {"id": 9, "name": "General Knowledge"},
  {"id": 10, "name": "Entertainment: Books"},
  {"id": 11, "name": "Entertainment: Film"},
  {"id": 12, "name": "Entertainment: Music"},
  {"id": 13, "name": "Entertainment: Musicals & Theatres"},
  {"id": 14, "name": "Entertainment: Television"},
  {"id": 15, "name": "Entertainment: Video Games"},
  {"id": 16, "name": "Entertainment: Board Games"},
  {"id": 17, "name": "Science & Nature"},
  {"id": 18, "name": "Science: Computers"},
  {"id": 19, "name": "Science: Mathematics"},
  {"id": 20, "name": "Mythology"},
  {"id": 21, "name": "Sports"},
  {"id": 22, "name": "Geography"},
  {"id": 23, "name": "History"},
  {"id": 24, "name": "Politics"},
  {"id": 25, "name": "Art"},
  {"id": 26, "name": "Celebrities"},
  {"id": 27, "name": "Animals"},
  {"id": 28, "name": "Vehicles"},
  {"id": 29, "name": "Entertainment: Comics"},
  {"id": 30, "name": "Science: Gadgets"},
  {"id": 31, "name": "Entertainment: Japanese Anime & Manga"},
  {"id": 32, "name": "Entertainment: Cartoon & Animations"}
];

List<String> categoryNames() {
  String toRemove = 'Entertainment: ';
  List<String> names = [];
  categories.forEach((element) {
    if(element['name'].contains(toRemove))
      names.add(element['name'].substring(toRemove.length));
    else
      names.add(element['name']);
  });
  return names;
}

List<int> categoryIds() {
  List<int> ids = [];
  categories.forEach((element) {
    ids.add(element['id']);
  });
  return ids;
}
