import 'package:flutter/material.dart';
import 'package:pilem/services/api_services.dart';
import 'package:pilem/models/movie.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiServices _apiServices = ApiServices();
  List<Movie> _allMovie = [];

  Future<void> _loadMovies() async {
    final List<Map<String, dynamic>> allMoviesData = await _apiServices.getAllMovies();

    setState(() {
      _allMovie = allMoviesData.map((e) => Movie.fromJson(e)).toList();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Pilem",
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                "All Movies",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
            SizedBox(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _allMovies.length,
                itemBuilder:
                itemBuilder: ,
              )
              
            )
          ],
        ),
      ),
    );
  }
}