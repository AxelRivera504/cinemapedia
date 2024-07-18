import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/movies/movie_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final nowPlayingMoviesProvider = StateNotifierProvider<MovieNotifier, List<Movie>>((ref) {
  final fetchMoreMovies = ref.watch( movieRepositoryProvider).getNowPlaying;
  return MovieNotifier(
    fetchMoreMovies: fetchMoreMovies
  );
});


final popularMoviesProvider = StateNotifierProvider<MovieNotifier, List<Movie>>((ref) {
  final fetchMoreMovies = ref.watch( movieRepositoryProvider).getPopular;
  return MovieNotifier(
    fetchMoreMovies: fetchMoreMovies
  );
});

final topRatedMoviesProvider = StateNotifierProvider<MovieNotifier, List<Movie>>((ref) {
  final fetchMoreMovies = ref.watch( movieRepositoryProvider).getTopRated;
  return MovieNotifier(
    fetchMoreMovies: fetchMoreMovies
  );
});

final upcomingMoviesProvider = StateNotifierProvider<MovieNotifier, List<Movie>>((ref) {
  final fetchMoreMovies = ref.watch( movieRepositoryProvider).getUpcoming;
  return MovieNotifier(
    fetchMoreMovies: fetchMoreMovies
  );
});


typedef MovieCallback = Future<List<Movie>> Function({int page});

class MovieNotifier extends StateNotifier<List<Movie>>{
  
  int currentPage = 0;
  MovieCallback fetchMoreMovies;
  bool isLoadNextPage = false;
  //la palabra clave super se utiliza para invocar el constructor de la clase base en este caso
  //StateNotifier y es importan ya que StateNotifier necesita ser inicializado con un estdo
  //inicial que es gestionado por la clase base de StateNotifier


  // MovieNotifier(super.state);
  //En este constructor super.state se utiliza para pasar un estado incial al  constructor de la clase  
  //base StateNotifier. Aquí, super.state hace referencia a un estado que proviene de algún 
  //contexto externo que proporciona el estado inicial.


  //¿Cuándo usar super.state en el constructor?
  //Este constructor es útil cuando el estado inicial no es conocido de antemano y debe ser pasado 
  //dinámicamente desde fuera de la clase MovieNotifier.
  
  MovieNotifier({required this.fetchMoreMovies}):super([]);
  //En este constructor, super([]) se utiliza para inicializar el estado de la clase base StateNotifier 
  //con una lista vacía []. Este es un valor inicial por defecto que dice que inicialmente no hay películas en la lista.

  //¿Cuándo usar :super(valorInicial) 
  //Este constructor es útil cuando quieres que el estado inicial de MovieNotifier siempre comience con una lista vacía.
  //Es más sencillo y directo si sabes que el estado inicial siempre será el mismo.

  Future<void> loadNexPage() async{
    if(isLoadNextPage) return;
    
    isLoadNextPage = true;
    currentPage++;
    final List<Movie> movies = await fetchMoreMovies(page: currentPage);
    state = [...state, ...movies];
    await Future.delayed(const Duration(milliseconds: 300));
    isLoadNextPage = false;
  }

}