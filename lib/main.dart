// ignore_for_file: library_private_types_in_public_api, depend_on_referenced_packages, unused_import, camel_case_types

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'models/movie.dart';
import 'models/user_adding_model.dart';
import 'movie_screen.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hive/hive.dart';

import 'package:path_provider/path_provider.dart' as path_provider;

import "package:hive_flutter/hive_flutter.dart";

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   // final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
//   await Hive.initFlutter();
//   var boxDatabase = Hive.openBox("moviesBox");
// }
late Box box;
void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter<Movie>(MovieAdapter()); // Register MovieAdapter here
  box = await Hive.openBox<Movie>('movies');
  runApp(const SearchPage());
}

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: GoogleFonts.latoTextTheme(
          Theme.of(context).textTheme,
        ),
        useMaterial3: true,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Movies Finder'),
        ),
        body: const movieApp(),
      ),
    );
  }
}

// class hive extends StatefulWidget {
//   const hive({super.key});

//   @override
//   State<hive> createState() => _hiveState();
// }

// class _hiveState extends State<hive> {
//   Future<void> starting() async {
//     WidgetsFlutterBinding.ensureInitialized();
//     final appDocumentDir =
//         await path_provider.getApplicationDocumentsDirectory();
//     Hive.init(appDocumentDir.path);
//   }

// // Create
//   createData() async {
//     final personBox = await Hive.openBox<Person>('persons');

//     final person = Person('John', 30);
//     await personBox.add(person);

//     if (kDebugMode) {
//       print(personBox);
//     }
//   }

// // Read
//   readData() async {
//     final personBox = await Hive.openBox<Person>('persons');

//     final retrievedPerson = personBox.get(0);
//     print(retrievedPerson);
//   }
// // Update

//   updateData() async {
//     final personBox = await Hive.openBox<Person>('persons');

//     final retrievedPerson = personBox.get(0);

//     retrievedPerson?.name = 'Jane';
//     await retrievedPerson?.save();
//     print(retrievedPerson);
//   }

// // Delete
//   deleteData() async {
//     final personBox = await Hive.openBox<Person>('persons');

//     final retrievedPerson = personBox.get(0);
//     await retrievedPerson?.delete();
//     print(retrievedPerson);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Column(
//       children: [
//         ElevatedButton(
//             onPressed: () {
//               Navigator.push(context,
//                   MaterialPageRoute(builder: (context) => const movieApp()));
//             },
//             child: const Text("NEW PAGE ")),
//         ElevatedButton(
//             onPressed: () {
//               starting();
//             },
//             child: const Text("INITIAL HIVE BOX")),
//         ElevatedButton(
//             onPressed: () {
//               createData();
//             },
//             child: const Text("CREATE HIVE BOX")),
//         ElevatedButton(
//             onPressed: () {
//               readData();
//             },
//             child: const Text("read data in HIVE BOX")),
//         ElevatedButton(
//             onPressed: () {
//               updateData();
//             },
//             child: const Text("Update HIVE BOX")),
//         ElevatedButton(
//             onPressed: () {
//               deleteData();
//             },
//             child: const Text("Delete HIVE BOX")),
//       ],
//     ));
//   }
// }
