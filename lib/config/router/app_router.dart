  import 'package:cinemapedia/presentation/screens/movie/home_screen.dart';
import 'package:cinemapedia/presentation/screens/movie/movies_screen.dart';
import 'package:cinemapedia/presentation/views/home_views/favorites-view.dart';
import 'package:cinemapedia/presentation/views/home_views/home-view.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [

    ShellRoute(
      builder:  (context, state, child) {
        return HomeScreen(childView: child);
      },
      routes: [

          GoRoute(
            path: '/',
            builder: (context, state) {
              return const HomeView();
            },
            routes: [
              GoRoute(
                path: 'movie/:id',
                name: MoviesScreen.name,
                builder: (context, state) {
                  final movieId = state.pathParameters['id'] ?? 'no-id';

                  return MoviesScreen( movieId:movieId);
                },
              ),
            ]
          ),

            GoRoute(
            path: '/favorites',
            builder: (context, state) {
              return const FavoritesView();
            },
          )

      ]
    )

    //Rutas padre/hijo
    // GoRoute(
    //   path: '/',
    //   name: HomeScreen.name,
    //   builder: (context, state) => const HomeScreen(childView: HomeView()),
    //   routes: [
    //     GoRoute(
    //       path: 'movie/:id',
    //       name: MoviesScreen.name,
    //       builder: (context, state) {
    //         final movieId = state.pathParameters['id'] ?? 'no-id';

    //         return MoviesScreen( movieId:movieId);
    //       },
    //     ),
    //   ]
    // ),

    //Esto se comento porque pasa a ser una ruta hija o route child y se le quita la pleca del inicio
    //del path ya que esa ya la da el padre, esto se hace para que no se nos quite el boton de regresar
    //si lo compilamos en google chrome
    //  GoRoute(
    //     path: '/movie/:id',
    //     name: MoviesScreen.name,
    //     builder: (context, state) {
    //       final movieId = state.pathParameters['id'] ?? 'no-id';

    //       return MoviesScreen( movieId:movieId);
    //     },
    //   ),
  ]
);