import 'package:flutter/material.dart';

class FullScreenLoader extends StatelessWidget {
   FullScreenLoader({super.key});

  final message = <String>[
    'Cargando peliculas',
    'Comprando palomitas',
    'Cargando populares',
    'Llamando a mi perro',
    'Ya merito...',
    'Esta vaina se esta tardando mucho'
  ];

  Stream<String> getLoadingMessages(){
    return Stream.periodic(const Duration(milliseconds: 1200), (step) {
      return message[step];
    }).take(message.length);

  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Espera por fvor"),
            const SizedBox(height: 10),
            const CircularProgressIndicator(strokeWidth:2),
            const SizedBox(height: 10,),
            StreamBuilder(
              stream: getLoadingMessages(), 
              builder: (context, snapshot) {
                if(!snapshot.hasData) return const Text('Cargando...');

                return Text(snapshot.data!);
              },
            )
          ],
        ),
    );
  }
}