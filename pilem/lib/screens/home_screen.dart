import 'package:flutter/material.dart';
import 'package:pilem/services/api_service.dart';
import 'package:pilem/models/movie.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService _apiServices = ApiService();
  List<Movie> _allMovies = [];
  List<Movie> _trendingMovies = [];
  List<Movie> _popularMovies = [];

  Future<void> _loadMovies() async {
    final List<Map<String, dynamic>> allMoviesData = 
        await _apiServices.getAllMovies();
        
    final List<Map<String, dynamic>> trendingMovieData = 
        await _apiServices.getTrendingMovies();

    final List<Map<String, dynamic>> popularMovieData = 
        await _apiServices.getPopularMovies();

    setState(() {
      _allMovies = allMoviesData.map((e) => Movie.fromJson(e)).toList();
      _trendingMovies = trendingMovieData.map((e) => Movie.fromJson(e)).toList();
      _popularMovies = popularMovieData.map((e) => Movie.fromJson(e)).toList();
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
        title: const Text("Pilem"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildMovieList("All Movies", _allMovies),
            _buildMovieList("Trending Movies", _trendingMovies),
            _buildMovieList("Popular Movies", _popularMovies),
          ],
              )
        ),
    );
  }

@override
widget _buildMovieList(String title, List<Movie>)

}