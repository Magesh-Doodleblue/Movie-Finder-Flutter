// ignore_for_file: camel_case_types, non_constant_identifier_names

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:movies/models/movie.dart';
import 'package:movies/movie_details.dart';

class movieApp extends StatefulWidget {
  const movieApp({super.key});

  @override
  State<movieApp> createState() => _movieAppState();
}

class _movieAppState extends State<movieApp> {
  final TextEditingController _searchController = TextEditingController();
  String _searchTerm = '';
  List<Movie> fullMovie = [];

  _searchMovie() async {
    var response = await http.get(
        Uri.parse('http://www.omdbapi.com/?s=$_searchTerm&apikey=c389a144'));
    var data = json.decode(response.body);

    setState(() {
      fullMovie = (data['Search'] as List)
          .map((movie) => Movie.fromJson(movie))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          minimum: const EdgeInsets.fromLTRB(5, 5, 0, 10),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 26, 24, 0),
                child: GestureDetector(
                  onTap: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                  child: TextFormField(
                    controller: _searchController,
                    keyboardType: TextInputType.name,
                    obscureText: false,
                    onChanged: (value) {
                      setState(() {
                        _searchTerm = value;
                      });
                    },
                    decoration: const InputDecoration(
                        hintText: 'Search for movies...',
                        suffixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(12)))),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              // Text(_searchTerm),
              SingleChildScrollView(
                //used to get movie details
                child: SizedBox(
                  height: 570,
                  child: GridView.builder(
                    itemCount: fullMovie.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.52,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      var movie = fullMovie[index];
                      return GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) => movieDetails(
                                      movie: movie,
                                    ))),
                        child: Card(
                          elevation: 30,
                          child: Column(
                            children: <Widget>[
                              Container(
                                height: 260,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(movie.poster),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                movie.title,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 5),
                              Text(
                                movie.year,
                                style: const TextStyle(
                                  fontSize: 12,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 5),
                              Text(
                                movie.type,
                                style: const TextStyle(
                                  fontSize: 12,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _searchMovie();
        },
        child: const Icon(Icons.search),
      ),
    );
  }
}
//imdbID
