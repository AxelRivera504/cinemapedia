import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../widgets/widgets.dart';


class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});
  
  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<HomeView> {

  @override
  void initState() {
    super.initState();
    ref.read(nowPlayingMoviesProvider.notifier).loadNexPage();
    ref.read(popularMoviesProvider.notifier).loadNexPage();
    ref.read(upcomingMoviesProvider.notifier).loadNexPage();
    ref.read(topRatedMoviesProvider.notifier).loadNexPage();
  }


  @override
  Widget build(BuildContext context) {

    final initialLoading = ref.watch( initialLoadingProvider );

    final nowPlayingMovies = ref.watch( nowPlayingMoviesProvider );
    final moviesSlideshow = ref.watch( moviesSlideshowProvider );
    final popularMovies = ref.watch( popularMoviesProvider );
    final topRatedMovies = ref.watch( topRatedMoviesProvider );
    final upcomingMovies = ref.watch( upcomingMoviesProvider );

    
    return Visibility(
      visible: !initialLoading,
      child: CustomScrollView(//el custom scrollView nos sirve para que nos muestre el buscado o encabeado desde que se empieza a scrollear
        slivers: [
      
          const SliverAppBar(
            floating: true,//colocamos que el encabezado estara flotando
            flexibleSpace: FlexibleSpaceBar(
              title: CustomAppBar(),//le pasamos nuestro appBar que definimos
            ),
          ),// Aqui agregaremos el app
      
          SliverList(delegate: SliverChildBuilderDelegate(
            (context, index) {
              return Column(
                      children: [
                        
                    
                        MoviesSlideshow(movies: moviesSlideshow),
                        MovieHorizontalListView(
                          movies: nowPlayingMovies,
                          label: 'En cines',
                          subLabel: 'Lunes 31',
                          loadNextPage: () {
                            ref.read(nowPlayingMoviesProvider.notifier).loadNexPage();
                          }
                        ),
                    
                        MovieHorizontalListView(
                          movies: upcomingMovies,
                          label: 'Proximas',
                          subLabel: 'Estes mes',
                          loadNextPage: () {
                            ref.read(upcomingMoviesProvider.notifier).loadNexPage();
                          }
                        ),
                    
                    
                        MovieHorizontalListView(
                          movies: popularMovies,
                          label: 'Populares',
                          //ssubLabel: '',  
                          loadNextPage: () {
                            ref.read(popularMoviesProvider.notifier).loadNexPage();
                          }
                        ),
                    
                    
                        MovieHorizontalListView(
                          movies: topRatedMovies,
                          label: 'Mejores calificadas',
                          subLabel: 'Desde siempre',
                          loadNextPage: () {
                            ref.read(topRatedMoviesProvider.notifier).loadNexPage();
                          }
                        ),
                    
                        const SizedBox(height: 10),
                      
                      ],  
                    );
            },
            childCount: 1
          ))
      
      
        ]
      ),
    );
  }
}