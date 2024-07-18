import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/credits_moviedb.dart';

class ActorMapper{

  static Actor CastToEntity( Cast cast) => 
  Actor(
    id: cast.id, 
    name: cast.name, 
    profilePath: cast.profilePath != null 
    ? 'https://image.tmdb.org/t/p/w500${ cast.profilePath }'
    : 'https://ih0.redbubble.net/image.5218811881.3250/raf,360x360,075,t,fafafa:ca443f4786.jpg' , 
    caracter: cast.character == null ? 'No caracter' : cast.character!
  );

}