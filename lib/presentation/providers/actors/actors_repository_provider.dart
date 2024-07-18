




//Este repositorio es inmutable
import 'package:cinemapedia/infrastructure/datasources/actor_moviedb_datasource.dart';
import 'package:cinemapedia/infrastructure/repositories/actor_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final actorRepositoryProvider = Provider((ref) {
    //indicarle a la implementacion de nuestro repositorio nuestro origen de datos para hacer las debidas implementaciones
    return ActorRepositoryImpl( datasource:  ActorMovieDbDataSource() );
});