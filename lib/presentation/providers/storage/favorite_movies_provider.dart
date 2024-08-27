

import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/domain/repositories/local_storage_repository.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final favoriteMoviesProvider = StateNotifierProvider<StorageMovieNotifier, Map<int,Movie>>((ref) {
  final localStorageRepository = ref.watch(localStorageRepositoryProvider);
  return StorageMovieNotifier(localStorageRepository: localStorageRepository);
});


class StorageMovieNotifier extends StateNotifier<Map<int, Movie>> {
  
  int page = 0;
  final LocalStorageRepository localStorageRepository;
  StorageMovieNotifier({required this.localStorageRepository}): super({});

  Future<List<Movie>> loadNextPage() async {
      final movies = await localStorageRepository.loadMovies(offset: page * 10, limit: 20);
      page++;

      final tempMoviesMap = <int, Movie>{};
      for(final movie in movies){
        tempMoviesMap[movie.id] = movie;
      }
      state = {...state, ...tempMoviesMap};

      return movies;
  }

  Future<void> toggleFavorite( Movie movie ) async {
    await localStorageRepository.toggleMovie(movie);
    final bool isMovieInFavorites = state[movie.id] != null;

    if(isMovieInFavorites){
      state.remove(movie.id);
      state = {...state};
    }else{
      state = {...state, movie.id:movie};
    }
  }
} 