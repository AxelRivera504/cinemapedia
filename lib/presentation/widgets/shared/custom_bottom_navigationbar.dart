
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int index;
  const CustomBottomNavigationBar({super.key, required this.index});


  void onItemTapped( BuildContext  context, int index){
      switch( index){
        case 0:
          context. go('/home/0');
          break;
        case 1:
          context. go('/home/1');
          break;
        case 2:
          context. go('/home/2');
          break;
      }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: index, //apartir de la función getCurrentIndex redirijira a la pagina que tenga el index seleccionado
      onTap: (value) => onItemTapped(context, value),
      //Apartir dE onItemTapped se navegara por las diferentes rutas apartir de los botones
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