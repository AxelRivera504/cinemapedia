import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/config/helpers/human_formats.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';


typedef SearchMovieCallback = Future<List<Movie>> Function( String query);

class SearchMovieDelegate  extends SearchDelegate<Movie?>{

  final SearchMovieCallback searchMovie;
  List<Movie> initialMovies;
  StreamController<List<Movie>> debounceMovies = StreamController.broadcast();
  StreamController<bool> isloadingStream = StreamController.broadcast();
  Timer? _debounceTimer;//hace la funcionalidad de setTimeOut de js


  SearchMovieDelegate({required this.searchMovie,  required this.initialMovies}):super(
    searchFieldLabel: 'Buscar películas',
    //textInputAction: TextInputAction.done cambiar el valor del boton de buscar en el teclado
  );

  void _onQuertyChanged(String query){

    isloadingStream.add(true);
    if(_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();

    _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
    
      final movies = await searchMovie(query);
      initialMovies = movies;
      debounceMovies.add(movies);
      isloadingStream.add(false);

    });
  }

  // @override
  // String get searchFieldLabel => 'Buscar película';
  Widget _buildSuggestionsAndResults(){
 return  StreamBuilder(
        initialData: initialMovies,
        stream: debounceMovies.stream,
        builder: (context, snapshot) {

        final movies = snapshot.data ?? [];

        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (context, index) => _MoviesItens(
            movie: movies[index],
            onMovieSelected: close,
            )
        );
      }
    );

}

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [

        //if(query.isEmpty)
        //Query palabra reservada que nos permite acceder al valor de la searchDelegate

        StreamBuilder(
          stream: isloadingStream.stream, 
          builder: (context, snapshot) {

              if(snapshot.data ?? false){
                  return SpinPerfect(
                      duration: const Duration(seconds: 10),
                      infinite: true,
                      spins: 10,
                      child: 
                      IconButton(
                        onPressed: () => query = '', 
                        icon: const Icon(Icons.refresh_rounded)
                      )
                    );
              }

              
         return FadeIn(
            animate: query.isNotEmpty,
            duration: const Duration(milliseconds: 200),
            child: 
            IconButton(
              onPressed: () => query = '', 
              icon: const Icon(Icons.clear)
            )
          );
        })
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
     return IconButton(
        onPressed: () => close(context, null) , icon: const Icon(Icons.arrow_back_ios_new_rounded)
     );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildSuggestionsAndResults();
  }

  @override
  Widget buildSuggestions(BuildContext context) {

      _onQuertyChanged(query);
      return _buildSuggestionsAndResults();
  }
} 

class _MoviesItens extends StatelessWidget {
  final Movie movie;
  final Function onMovieSelected;
  const _MoviesItens({ required this.movie, required this.onMovieSelected});

  @override
  Widget build(BuildContext context) {

    final textStyles = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        onMovieSelected(context, movie);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
      
          children: [
      
            SizedBox(
              width: size.width * 0.20,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  movie.posterPath,
                  loadingBuilder:(context, child, loadingProgress) => FadeIn(child: child),
                  ),
                
              ),
            ),
      
            const SizedBox(width: 10),
      
            SizedBox(
              width: size.width  * 0.7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(movie.title, style: textStyles.titleMedium),
                  (movie.overview.length > 100)
                  ? Text('${movie.overview.substring(0,100)}...')
                  :Text(movie.overview),
      
                  Row(
                    children: [
                      Icon(Icons.star_half_rounded, color: Colors.yellow.shade800),
                      const SizedBox(width: 5),
                      Text( 
                        HumanFormat.number(movie.voteAverage,1),
                        style: textStyles.bodyMedium!.copyWith(color: Colors.yellow.shade900),
                      )
                    ],
                  )
      
      
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}