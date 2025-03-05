import 'package:flutter/material.dart';
import 'package:pilem/models/movie.dart';
import 'package:pilem/services/api_service.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final ApiService _apiService = ApiService();
  final TextEditingController _searchController = TextEditingController();
  List<Movie> _searchResults = [];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_searchMovies);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _searchMovies() async {
    if (_searchController.text.isEmpty) {
      setState(() {
        _searchResults.clear();
      });
      return;
    }

    final List<Map<String, dynamic>> _searchData =
        await _apiService.searchMovies(_searchController.text);

    setState(() {
      _searchResults = _searchData.map((e) => Movie.fromJson(e)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(5.0)),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: const InputDecoration(
                          hintText: 'Search Movie...',
                          border: InputBorder.none),
                    ),
                  ),
                  Visibility(
                    visible: _searchController.text.isNotEmpty,
                    child: IconButton(
                        onPressed: () {
                          _searchController.clear();
                          setState(() {
                            _searchResults.clear();
                          });
                        },
                        icon: const Icon(Icons.clear)),
                  )
                ],
              ),
            ),
            const SizedBox(height: 16),
            ListView.builder(
              itemBuilder: (context, index) {},
            ),
          ],
        ),
      ),
    );
  }
}
