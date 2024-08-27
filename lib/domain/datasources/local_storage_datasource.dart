


import 'package:cinemapedia/domain/entities/movie.dart';

abstract class LocalStorageDataSource{

    Future<void> toggleMovie(Movie movie);

    Future<bool> isMovieFavorite( int movieId );

    Future<List<Movie>> loadMovies({ int limit = 10, int offset = 0});

}