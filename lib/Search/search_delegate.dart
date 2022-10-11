

import 'package:flutter/material.dart';
import 'package:pelicula_apps/Providers/movie_provider.dart';
import 'package:pelicula_apps/Screens/home_screen.dart';
import 'package:pelicula_apps/models/models.dart';
import 'package:provider/provider.dart';

class MovieSearchDelegate extends SearchDelegate{
  @override
  List<Widget>? buildActions(BuildContext context) {
 
      return [
        IconButton(
          icon: Icon(Icons.clear ),
          onPressed:( ) =>{
            query = '',
          }, 
          
          )
        ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: ()=>close(context, null),
      // onPressed: ()=> Navigator.pop(context), 
      icon: Icon(Icons.arrow_back_ios_new), 
            
      ) ;
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container(
      color: Colors.yellow,
      width: double.infinity,
      height: 400,
    );
  }

  Widget _emptyContainer(){
    return Container(
        child: Center(
            child:
              Icon(Icons.movie_outlined, color: Colors.black45, size: 150,),
          ),
        );
  }

  @override
  Widget buildSuggestions(BuildContext context) {

    if(query.isEmpty){
      return _emptyContainer();
    }
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);
    moviesProvider.getSuggestionsByQuery(query);
    
    return StreamBuilder(
      stream: moviesProvider.suggestionStream,
      builder: (_ , AsyncSnapshot<List<Movie>> snapshot) {

        if (!snapshot.hasData) return _emptyContainer();
        final movies = snapshot.data!;

        return ListView.builder(
          itemCount:movies.length,
          itemBuilder: (_, int index){
              return _MovieItem(movies[index]);
          } 
          
          );
      },
    );



  }

}

class _MovieItem extends StatelessWidget {

  final Movie movie;
   
  const _MovieItem(this.movie);
  
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: FadeInImage(
        image: NetworkImage(movie.fullPosterImg), 
        placeholder: const AssetImage('assets/no-image.jpg'),
        width: 50,
      ),

      title: Text(movie.title),
      onTap:  ()=> Navigator.pushNamed(
        context, 'details',
        arguments: movie, //Aqui
        ),
    );
  }
}

