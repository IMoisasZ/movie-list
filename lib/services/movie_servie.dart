import 'dart:async';
import 'dart:convert';
import '../domain/models/movie.dart';
import 'package:http/http.dart' as http;

class MovieService {
  static const key = 'abd6d3bfe88a555f8adcdb05392f8c3e';

  Future<List<Movie>> getMovies({int page = 1}) async {
    var url = Uri.parse("https://api.themoviedb.org/3/movie/popular?api_key=$key&language=en-US&page=$page");
    final response = await http.post(url);
    final json = jsonDecode(response.body);
    final movieData = MovieData.fromJson(json);
    return MovieData.fromJson(json).movies;
  }
}