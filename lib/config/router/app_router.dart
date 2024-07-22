  import 'package:cinemapedia/presentation/screens/movie/home_screen.dart';
import 'package:cinemapedia/presentation/screens/movie/movies_screen.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: '/home/0',
  routes: [



    //Rutas padre/hijo
    GoRoute(
      path: '/home/:page',
      name: HomeScreen.name,
      builder: (context, state) {
        final pageIndex = state.pathParameters['page'] ?? '0';
        return HomeScreen(pageIndex: int.parse(pageIndex));
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
        path: '/',
        redirect: (_, __) => '/home/0',//SE COLOCAN LOS GUIONBAJOS PARA INDICAR QUE NO SE NECESITAN ESOS PARAMETROS
      )
  ]
);