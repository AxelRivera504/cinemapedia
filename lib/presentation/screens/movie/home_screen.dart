import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:cinemapedia/views/home_views/favorites-view.dart';
import 'package:cinemapedia/views/home_views/home-view.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static const name = 'home-screen';
  final int pageIndex;
  const HomeScreen({super.key, required this.pageIndex});

  final viewRoutes = const <Widget>[
    HomeView(),
    SizedBox(),
    FavoritesView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:IndexedStack(
        index: pageIndex,
        children: viewRoutes,
      ),
      bottomNavigationBar: CustomBottomNavigationBar(index: pageIndex),
    );
  }
}
