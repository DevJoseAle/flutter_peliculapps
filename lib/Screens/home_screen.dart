import 'package:flutter/material.dart';
import 'package:pelicula_apps/Search/search_delegate.dart';
import 'package:provider/provider.dart';
import '../Providers/providers.dart';
import '../widgets/widgets.dart';



class HomeScreen extends StatelessWidget {
   
  
  @override
  Widget build(BuildContext context) {

    final moviesProviders = Provider.of<MoviesProvider>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Peliculapps'),
        actions:  [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () => showSearch(context: context, delegate: MovieSearchDelegate()),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            
            //* Listado principal de pelis
              CardSwiper(movies: moviesProviders.onDisplayMovie),
      
            //* Listado de pelis
              MovieSlider( 
                movies: moviesProviders.popularMovies, 
                title: 'Populares', 
                onNextPage: () => moviesProviders.getPopularMovies() //Aqui
                ),
              MovieSlider( 
                movies: moviesProviders.popularMovies, 
                title: 'Populares', 
                onNextPage: () => moviesProviders.getPopularMovies() //Aqui
                ),
              MovieSlider( 
                movies: moviesProviders.popularMovies, 
                title: 'Populares', 
                onNextPage: () => moviesProviders.getPopularMovies() //Aqui
                ),
      
          ],
        ),
      ),
    );
  }
}