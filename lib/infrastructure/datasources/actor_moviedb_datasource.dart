import 'package:cinemapedia/domain/datasources/actors_datasources.dart';
import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/infrastructure/mappers/actor_mapper.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/credits_moviedb.dart';
import 'package:dio/dio.dart';

class ActorMovieDbDataSource extends ActorsDataSource{
 final dio = Dio();

  @override
  Future<List<Actor>> getActorsByMovie(String movieId) async {
    final response = await dio.get('https://api.themoviedb.org/3/movie/$movieId/credits',
    queryParameters: { 'api_key':'c718f90c4ef3af533c43911028e474f9','language':'es-MX'});
    if( response.statusCode != 200) throw Exception('Actor in the movie with id: $movieId no found');

    final actorDb = CredistResponse.fromJson( response.data );
    List<Actor> actors = actorDb.cast.map((cast) => ActorMapper.CastToEntity(cast)).toList();
    return actors;
  }

}