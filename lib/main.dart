import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import 'package:pelicula_apps/Providers/providers.dart';
import 'Screens/screens.dart';



void main() => runApp( const AppState());


class AppState extends StatelessWidget {
   
  //  Widget para mantener el stado del movie provider
  const AppState({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider( create: ( _ ) => MoviesProvider()..Moviesprovider(), lazy: false, ),
        
      ],
      child: MyApp(),
    );
  }
}


class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Peliculas App',
      initialRoute: 'home',
      routes: {
        'home' : ( _ ) =>HomeScreen(),
        'details' : (_) => DetailsScreen()
      },
      theme: ThemeData.dark().copyWith(
        appBarTheme: AppBarTheme(
          backgroundColor: Color.fromARGB(255, 81, 81, 81),
          elevation: 2,

        ),
        scaffoldBackgroundColor: Color.fromARGB(255, 32, 32, 32)


      ),
    );
  }
}