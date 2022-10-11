import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pelicula_apps/Providers/providers.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';

class CastingCards extends StatelessWidget {
   
    final int movie;

  const CastingCards(this.movie);
  
  @override
  Widget build(BuildContext context) {

    final moviesProvider = Provider.of<MoviesProvider>(context);

    return FutureBuilder(
      future: moviesProvider.getMovieCast(movie),
      builder: ( _ , AsyncSnapshot snapshot){
        
        if(!snapshot.hasData){

          return Container(
            constraints: BoxConstraints(maxWidth:150),
            height: 180,
            child: CupertinoActivityIndicator(),

          );


        }
          final List<Cast> cast = snapshot.data!;
         return Container(
          width: double.infinity,
          height:170,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: cast.length,
            itemBuilder: ( _ , int index) {
                return _CastCard(cast[index]);
              }
          ),
          
        );    

      }
    );

  }
}

class _CastCard extends StatelessWidget {
   
  final Cast actor;

  const _CastCard(this.actor);
  
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric( horizontal: 5 , vertical:5 ),
        width: 110,
        height: 100,
        child: Column(
        children: [

          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child:  FadeInImage(
              height: 120,
              width: 100,
              fit: BoxFit.cover,
              placeholder:AssetImage('assets/no-image.jpg'),
              image: NetworkImage(actor.fullCastImg)
              ),
          ),
            Text(actor.name, overflow: TextOverflow.ellipsis, textAlign: TextAlign.center,)
            ]),
       );
  }
}