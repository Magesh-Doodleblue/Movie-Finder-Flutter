// ignore_for_file: camel_case_types, non_constant_identifier_names, depend_on_referenced_packages

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:movies/models/movie.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_generator/hive_generator.dart';
import 'package:hive/hive.dart';

class movieDetails extends StatefulWidget {
  const movieDetails({super.key, required this.movie});
  final Movie movie;
  @override
  State<movieDetails> createState() => _movieDetailsState();
}

class _movieDetailsState extends State<movieDetails> {
  late List<dynamic> _castDetails = [];
  late List<dynamic> _Director = [];
  late List<dynamic> _imdbRating = [];
  late List<dynamic> _Language = [];
  late List<dynamic> _Runtime = [];
  late List<dynamic> _Rated = [];
  late List<dynamic> _Plot = [];
  late List<dynamic> _Genre = [];
  late List<dynamic> _Writer = [];

  @override
  void initState() {
    super.initState();
    _fetchCastDetails();
  }

  void _fetchCastDetails() async {
    var response = await http.get(Uri.parse(
        "https://www.omdbapi.com/?t=${widget.movie.title}&apikey=c389a144"));
    //var response = await http.get(url.request as Uri);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      setState(() {
        _castDetails = data['Actors'].split(',');
        _Director = data['Director'].split(',');
        _imdbRating = data['imdbRating'].split(',');
        _Language = data['Language'].split(',');
        _Runtime = data['Runtime'].split(',');
        _Rated = data['Rated'].split(',');
        _Plot = data['Plot'].split(',');
        _Genre = data['Genre'].split(',');
        _Writer = data['Writer'].split(',');
      });
    } else {
      if (kDebugMode) {
        print('Failed to fetch cast details');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 200,
              width: 900,
              child: Stack(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Image.network(widget.movie.poster,
                        fit: BoxFit.fitWidth),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: SizedBox(
                      height: 70,
                      width: 60,
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          if (kDebugMode) {
                            print(' Back button clickedd...');
                          }
                          Navigator.pop(context);
                          // do something
                        },
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 70,
                          width: 60,
                          child: IconButton(
                            icon: const Icon(
                              Icons.play_circle,
                              size: 60,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              // do somethingif (kDebugMode) {
                              if (kDebugMode) {
                                print(' Play button clickedd...');
                              }
                            },
                          ),
                        ),
                        const Text(
                          ' Play Trailer',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        )
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: SizedBox(
                      height: 70,
                      width: 60,
                      child: IconButton(
                        icon: const Icon(
                          Icons.more_horiz,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          if (kDebugMode) {
                            print('More options button clickedd...');
                          }
                          // do something
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              children: [
                SizedBox(
                  // width: MediaQuery.of(context).size.width,
                  width: 290,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24, 0, 0, 0),
                    child: Text(
                      widget.movie
                          .title, //movie title movie in details page... ;)
                      style: GoogleFonts.lato(
                          fontSize: 26, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const Spacer(
                  flex: 30,
                ),
                IconButton(
                  icon: const Icon(
                    Icons.bookmark_border,
                    size: 30,
                    color: Colors.black,
                  ),
                  onPressed: () async {
                    // Create a new instance of the Movie object with the movie details
                    // final Movie movieToSave = Movie(
                    //   title: widget.movie.title,
                    //   id: 1,
                    //   type: widget.movie.type,
                    //   year: widget.movie.year,
                    //   imdbID: widget.movie.imdbID,
                    //   poster: widget.movie.poster,
                    // );

                    // final box = await Hive.openBox<Movie>('MoviesInHive');

                    // box.add(movieToSave);
                    // print(box);
                    debugPrint('bookmark ${widget.movie.title}...');
                  },
                ),
                const Spacer(
                  flex: 8,
                ),
              ],
            ),
            // Padding(
            //   padding: const EdgeInsets.fromLTRB(24, 0, 0, 0),
            //   child: Align(
            //     alignment: Alignment.centerLeft,
            //     child: Text(widget.movie.type,
            //         style: const TextStyle(
            //             fontSize: 20, fontWeight: FontWeight.w400)),
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 1, 18, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.network(
                    'https://spng.pngfind.com/pngs/s/173-1731218_large-yellow-star-clipart-gold-star-icon-png.png',
                    width: 18,
                    height: 18,
                  ),
                  const Spacer(),
                  SizedBox(
                    height: 26,
                    width: 140,
                    child: Align(
                        alignment: Alignment.topLeft,
                        child: Opacity(
                          opacity: 0.5,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 4, 0, 0),
                            child: Text(
                              '$_imdbRating /10  IMDb',
                              style: const TextStyle(
                                  fontSize: 16, color: Colors.black),
                            ),
                          ),
                        )),
                  ),
                  const Spacer(
                    flex: 16,
                  ),
                ],
              ),
            ),
            Opacity(
              opacity: 0.8,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 0, 0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: SizedBox(
                    height: 45,
                    width: double.infinity,
                    child: SizedBox(
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 5.1,
                        ),
                        itemCount: _Genre.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            color: const Color.fromARGB(255, 191, 215, 255),
                            child: Center(
                              child: Text(
                                _Genre[index],
                                style: const TextStyle(color: Colors.blue),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 7,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(3, 0, 0, 0),
              child: Row(
                children: [
                  const Spacer(
                    flex: 1,
                  ),
                  SizedBox(
                    height: 50,
                    width: 100,
                    child: Column(
                      children: [
                        const Opacity(opacity: 0.4, child: Text('Length')),
                        Text('$_Runtime',
                            style:
                                const TextStyle(fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ),
                  const Spacer(
                    flex: 3,
                  ),
                  SizedBox(
                    height: 70,
                    width: 100,
                    child: Column(
                      children: [
                        const Opacity(opacity: 0.4, child: Text('Language')),
                        Text('$_Language',
                            style:
                                const TextStyle(fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ),
                  const Spacer(
                    flex: 3,
                  ),
                  SizedBox(
                    height: 50,
                    width: 100,
                    child: Column(
                      children: [
                        const Opacity(opacity: 0.4, child: Text('Rating')),
                        Text('$_Rated',
                            style:
                                const TextStyle(fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ),
                  const Spacer(
                    flex: 39,
                  ), /*
                  ElevatedButton(
                      onPressed: () {
                        _fetchCastDetails();
                      },
                      style:
                          ElevatedButton.styleFrom(backgroundColor: Colors.amber),
                      child: null),*/
                ],
              ),
            ),
            const SizedBox(
              height: 1,
            ),
            // ignore: prefer_const_constructors
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 0, 0),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Description',
                      style: GoogleFonts.merriweather(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[400]),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Opacity(
                      opacity: 0.5,
                      child:
                          Text('$_Plot', style: GoogleFonts.lato(height: 1.6))),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(25, 0, 0, 0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text('Genre: $_Genre',
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w500)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 0, 0, 0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text('Writers: $_Writer',
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w500)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 0, 0, 0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text('Year: ${widget.movie.year}',
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w500)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 0, 0, 0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Director: $_Director',
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w500),
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(31, 0, 0, 0),
              child: Row(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Cast',
                      style: GoogleFonts.lato(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[1000]),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  const Spacer(
                    flex: 3,
                  ),
                  Opacity(
                    opacity: 0.77,
                    child: SizedBox(
                      height: 30,
                      width: 100,
                      child: ElevatedButton(
                          onPressed: () {},
                          child: const Opacity(
                              opacity: 0.4, child: Text('see more'))),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 3, 24, 0),
              child: SizedBox(
                height: 90,
                width: 400,
                child: GridView.builder(
                  scrollDirection: Axis.horizontal,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    childAspectRatio: 0.81,
                  ),
                  itemCount: _castDetails.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                      child: Card(
                          elevation: 11,
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              _castDetails[index].toString(),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w400),
                            ),
                          )),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
