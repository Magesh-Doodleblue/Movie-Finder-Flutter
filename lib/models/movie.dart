part 'movie.g.dart';

class Movie {
  final String title;
  final int id;
  final String year;
  final String poster;
  final String type;
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
