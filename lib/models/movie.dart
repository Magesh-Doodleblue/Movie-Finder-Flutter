// ignore_for_file: depend_on_referenced_packages, invalid_annotation_target

import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
// import 'package:json_annotation/json_annotation.dart';

// @JsonSerializable()
part 'movie.g.dart';

@HiveType(typeId: 0)
class Movie {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final int id;
  @HiveField(2)
  final String year;
  @HiveField(3)
  final String poster;
  @HiveField(4)
  final String type;
  @HiveField(5)
  final String imdbID;
  Movie(
      {required this.title,
      required this.id,
      required this.year,
      required this.poster,
      required this.imdbID,
      required this.type});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      title: json['Title'],
      id: json["id"],
      year: json['Year'],
      poster: json['Poster'],
      type: json['Type'],
      imdbID: json['imdbID'],
    );
  }
}
