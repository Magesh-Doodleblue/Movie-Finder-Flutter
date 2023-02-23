// ignore_for_file: camel_case_types, depend_on_referenced_packages, unnecessary_import

import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';

class movieDatabase {
  int? id;
  String? movieTitle;
  String? movieType;
  String? movieYear;

  movieDatabase(
      {required this.movieTitle,
      required this.movieType,
      required this.movieYear,
      required id});

  factory movieDatabase.fromMap(Map<String, dynamic> json) => movieDatabase(
        id: json['id'],
        movieTitle: json['movieTitle'],
        movieType: json['movieType'],
        movieYear: json['movieYear'],
      );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'movieTitle': movieTitle,
      'movieType': movieType,
      'movieYear': movieYear,
    };
  }
}

class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _movieDatabase;
  Future<Database> get database async =>
      _movieDatabase ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'movies.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE saveMovieDetails (id INTEGER PRIMARY KEY, movieTitle TEXT, movieType TEXT, movieYear TEXT)");
  }

  Future<List<movieDatabase>> getMovieDetails() async {
    Database db = await instance.database;
    var movieDetails =
        await db.query('saveMovieDetails', orderBy: 'movieTitle');
    List<movieDatabase> movieList = movieDetails.isNotEmpty
        ? movieDetails.map((c) => movieDatabase.fromMap(c)).toList()
        : [];
    return movieList;
  }

  Future<int> add(movieDatabase addMovie) async {
    Database db = await instance.database;
    return await db.insert('saveMovieDetails', addMovie.toMap());
  }

  Future<int> remove(int id) async {
    Database db = await instance.database;
    return await db
        .delete('saveMovieDetails', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> update(movieDatabase updateMovies) async {
    Database db = await instance.database;
    return await db.update('saveMovieDetails', updateMovies.toMap(),
        where: "id = ?", whereArgs: [updateMovies.id]);
  }
}
