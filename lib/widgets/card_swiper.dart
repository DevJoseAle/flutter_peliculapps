import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:pelicula_apps/models/models.dart';

class CardSwiper extends StatelessWidget {
    //propiedades peliculas
    final List<Movie> movies;

  const CardSwiper({
    Key? key, 
    required this.movies
    }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {


    final size = MediaQuery.of(context).size;

    if( this.movies.length == 0) {
      return Container(
        width: double.infinity,
        height: size.height * 0.5,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Container(
      
      width: double.infinity,
      height: size.height * 0.50,
      child: Swiper(
        axisDirection: AxisDirection.right,
        layout: SwiperLayout.STACK,
        itemHeight: size.height * 0.45,
        itemWidth: size.width * 0.55,

        itemCount:  movies.length,
        itemBuilder: ( _ , int index){

          final movie = movies[index];


          return  GestureDetector(
            onTap: ()=> Navigator.pushNamed(
              context, 'details',
              arguments: movie
              ),
              
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: AssetImage('assets/loading.gif'), 
                image: NetworkImage(movie.fullPosterImg),
                fit: BoxFit.cover,
                ),
            ),
          );
        },
        ),
    );
  }
}