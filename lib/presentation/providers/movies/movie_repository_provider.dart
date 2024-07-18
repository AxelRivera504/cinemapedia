import 'package:cinemapedia/infrastructure/datasources/moviedb_datasource.dart';
import 'package:cinemapedia/infrastructure/repositories/movie_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


//Este repositorio es inmutable
final movieRepositoryProvider = Provider((ref) {
    //indicarle a la implementacion de nuestro repositorio nuestro origen de datos para hacer las debidas implementaciones
    return MovieRepositoryImpl(MoviedbDataSource());
});