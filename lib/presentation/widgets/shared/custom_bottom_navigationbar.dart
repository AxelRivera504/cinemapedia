
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key});


  void onItemTapped( BuildContext  context, int index){
      switch( index){
        case 0:
          context. go('/');
          break;
        case 1:
          context. go('/');
          break;
        case 2:
          context. go('/favorites');
          break;
      }
  }



  int getCurrentIndex (BuildContext context) {
    final String location = GoRouterState.of(context).uri.toString();

    switch(location){
      case '/':
        return 0;
      case '/categories':
        return 1;
      case '/favorites':
        return 2;

      default:
        return 0;
    }
  }

  @override
  Widget build(BuildContext context) {


    return BottomNavigationBar(
      elevation: 0,
      currentIndex: getCurrentIndex(context), //apartir de la función getCurrentIndex redirijira a la pagina que tenga el index seleccionado
      onTap: (value) => onItemTapped(context, value),//Apartir dE onItemTapped se navegara por las diferentes rutas apartir de los botones
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_max),
          label: 'Inicio'
        ),
         BottomNavigationBarItem(
          icon: Icon(Icons.label_outline),
          label: 'Categorías'
        ),
         BottomNavigationBarItem(
          icon: Icon(Icons.favorite_outline),
          label: 'Favorito'
        )
      ]
    );

    
  }
}