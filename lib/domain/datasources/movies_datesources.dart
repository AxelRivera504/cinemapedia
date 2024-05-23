import 'package:cinemapedia/domain/entities/movie.dart';

abstract class MovieDataSoruce{

  Future<List<Movie>> getNowPlaying({int page = 1});


}