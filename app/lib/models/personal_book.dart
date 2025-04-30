import 'dart:convert';
import './google_book.dart';

class PersonalBookNotFindException implements Exception {}

// These below are just examples. Need to create new models
class PersonalBook {
  late int? id;
  late String dayStarted;
  late String dayFinished;
  late String comments;
  late GoogleBook googleBook;

  PersonalBook({
    this.id,
    required this.dayStarted,
    required this.dayFinished,
    required this.comments,
    required this.googleBook,
  });

  PersonalBook.fromMap(Map<String, dynamic> map) {
    id = map["id"];
    dayStarted = map["dayStarted"];
    dayFinished = map["dayFinished"];
    comments = map["comments"];
    googleBook = GoogleBook.fromJson(json.decode(map["googleBook"]));
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "googleBook": json.encode(googleBook.toMap()),
      "dayStarted": dayStarted,
      "dayFinished": dayFinished,
      "comments": comments,
    };
  }
}
