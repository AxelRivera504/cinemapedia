import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../providers/providers.dart';

class FavoritesView extends ConsumerStatefulWidget {
  const FavoritesView({super.key});

  @override
  FavoritesViewState createState() => FavoritesViewState();
}

class FavoritesViewState extends ConsumerState<FavoritesView> {
  final scrollController = ScrollController();
  bool isLastPage = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    loadNextPage();
  }

  void loadNextPage() async {
    if(isLastPage || isLastPage) return;
    isLoading = true;

    final movies = await ref.read(favoriteMoviesProvider.notifier).loadNextPage();
    isLoading = false;
    if(movies.isEmpty){
      isLastPage = true;
    }
  }

  @override
  Widget build(BuildContext context) {

    final intialMovies = ref.watch( favoriteMoviesProvider ).values.toList();

    if(intialMovies.isEmpty){
      final colors = Theme.of(context).colorScheme;
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.favorite_outline_sharp, size: 60,color: colors.primary),
            Text("Ohh noo!!", style: TextStyle(fontSize: 30, color: colors.primary)),
            const Text("No tienes peliculas favoritas", style: TextStyle(fontSize: 20, color: Colors.black45)),
            const SizedBox(height: 20),
            FilledButton.tonal(
              onPressed: () => context.go("/home/0"), 
              child: const Text("Empieza a buscar")
            )
          ],
        ),
      );
    }

    return Scaffold(
      body:MovieMasonry(
        loadNextPage: loadNextPage,
        movies: intialMovies
        )
    );
  }
}