import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/movie_details.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/movie_moviedb.dart';

class MovieMapper {
  static Movie movieDBToEntity(MovieMovieDB movie) => Movie(
      adult: movie.adult,
      backdropPath: (movie.backdropPath != '') 
      ? 'https://image.tmdb.org/t/p/w500${ movie.backdropPath }'
      : 'https://ih0.redbubble.net/image.5218811881.3250/raf,360x360,075,t,fafafa:ca443f4786.jpg',
      genreIds: movie.genreIds.map((e) => e.toString()).toList(),
      id: movie.id,
      originalLanguage: movie.originalLanguage,
      originalTitle: movie.originalTitle,
      overview: movie.overview,
      popularity: movie.popularity,
      posterPath: (movie.posterPath != '') 
      ? 'https://image.tmdb.org/t/p/w500${ movie.posterPath }'
      : 'https://ih0.redbubble.net/image.5218811881.3250/raf,360x360,075,t,fafafa:ca443f4786.jpg',
      releaseDate: (movie.releaseDate != null) ? movie.releaseDate : null,
      title: movie.title,
      video: movie.video,
      voteAverage: movie.voteAverage,
      voteCount: movie.voteCount);


      static MovieDetailsToEntity( MovieDetails movie) => Movie(
        adult: movie.adult,
        backdropPath: (movie.backdropPath != '') 
        ? 'https://image.tmdb.org/t/p/w500${ movie.backdropPath }'
        : 'https://ih0.redbubble.net/image.5218811881.3250/raf,360x360,075,t,fafafa:ca443f4786.jpg',
        genreIds: movie.genres.map((e) => e.name.toString()).toList(),
        id: movie.id,
        originalLanguage: movie.originalLanguage,
        originalTitle: movie.originalTitle,
        overview: movie.overview,
        popularity: movie.popularity,
        posterPath: (movie.posterPath != '') 
        ? 'https://image.tmdb.org/t/p/w500${ movie.posterPath }'
        : 'https://ih0.redbubble.net/image.5218811881.3250/raf,360x360,075,t,fafafa:ca443f4786.jpg',
        releaseDate: movie.releaseDate,
        title: movie.title,
        video: movie.video,
        voteAverage: movie.voteAverage,
        voteCount: movie.voteCount
      );
}