import 'package:cinemapedia/domain/datasources/movies_datesources.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/infrastructure/mappers/movie_mapper.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/movie_details.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/moviedb_response.dart';
import 'package:dio/dio.dart';

class MoviedbDataSource extends MovieDataSource{
  final dio = Dio();



  List<Movie> _jsonToMovie (Map<String, dynamic> json){
      final movieDB = MovieDbResponse.fromJson(json);
    final List<Movie> movies = movieDB.results
    .where((moviedb) => moviedb.posterPath != 'no-poster')
    .map(
      (moviedb) => MovieMapper.movieDBToEntity(moviedb)
    ).toList();
    return movies;
  }



  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    final response = await dio.get('https://api.themoviedb.org/3/movie/now_playing',
    queryParameters: { 'api_key':'c718f90c4ef3af533c43911028e474f9','language':'es-MX', 'page':page});
    return _jsonToMovie(response.data);
  }

  @override
  Future<List<Movie>> getPopular({int page = 1}) async {
    final response = await dio.get('https://api.themoviedb.org/3/movie/popular',
    queryParameters: { 'api_key':'c718f90c4ef3af533c43911028e474f9','language':'es-MX', 'page':page});
    return _jsonToMovie(response.data);
  }
  
  @override
  Future<List<Movie>> getTopRated({int page = 1}) async {
   final response = await dio.get('https://api.themoviedb.org/3/movie/top_rated',
    queryParameters: { 'api_key':'c718f90c4ef3af533c43911028e474f9','language':'es-MX', 'page':page});
    return _jsonToMovie(response.data);
  }
  
  @override
  Future<List<Movie>> getUpcoming({int page = 1}) async {
    final response = await dio.get('https://api.themoviedb.org/3/movie/upcoming', 
    queryParameters: { 'api_key':'c718f90c4ef3af533c43911028e474f9','language':'es-MX', 'page':page});
    return _jsonToMovie(response.data);
  }
  
  @override
  Future<Movie> getMovieById(String id) async{
    final response = await dio.get('https://api.themoviedb.org/3/movie/$id',
    queryParameters: { 'api_key':'c718f90c4ef3af533c43911028e474f9','language':'es-MX'});
    if( response.statusCode != 200) throw Exception('Movie with id: $id no found');

    final movieDB = MovieDetails.fromJson( response.data );
    final movie = MovieMapper.MovieDetailsToEntity(movieDB);
    return movie; 
  }
  
  @override
  Future<List<Movie>> searchMovies(String query) async{

    if(query.isEmpty) return [];

    final response = await dio.get('https://api.themoviedb.org/3/search/movie',
    queryParameters: { 'api_key':'c718f90c4ef3af533c43911028e474f9','language':'es-MX', 'query':query});
    return _jsonToMovie(response.data);
  }
}