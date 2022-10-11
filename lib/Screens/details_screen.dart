
import 'package:flutter/material.dart';
import 'package:pelicula_apps/models/models.dart';
import 'package:pelicula_apps/widgets/widgets.dart';


class DetailsScreen extends StatelessWidget {
   
  
  @override
  Widget build(BuildContext context) {

    //TODO Cambiar luego por argumentos

    final Movie movie = ModalRoute.of(context)!.settings.arguments as Movie;
   

    print(movie.title);


    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _CustomAppBar(movie : movie),  
          SliverList(
            delegate: SliverChildListDelegate([ 
              _PosterAndTitle(movie : movie),
               _MovieDescription( movie : movie),
               _MovieDescription( movie : movie ),

             const SizedBox(height: 10),
            CastingCards( movie.id )

            ])
            )
               
        ],
      ),
      
    );
  }
}

class _CustomAppBar extends StatelessWidget {
  
  final Movie movie;

  const _CustomAppBar({Key? key, 
  required this.movie
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating:false,
      pinned: true,
      expandedHeight: 200,
      backgroundColor: Color.fromARGB(255, 29, 33, 54),
      
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        background: FadeInImage(
          placeholder: const AssetImage('assets/loading.gif') , 
          image:NetworkImage(movie.fullBackdropPath), 
          fit: BoxFit.cover
          ),
        title: Container(
          alignment: Alignment.bottomCenter,
          width: double.infinity,
          child: Text(
            movie.title,
            style: const TextStyle(
               fontSize: 20,            
          ),),
        )
      )

    );
  }
} 


class _PosterAndTitle extends StatelessWidget {

  final Movie movie;
   
  _PosterAndTitle({Key? key, 
  required this.movie
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    final TextTheme textTheme =  Theme.of(context).textTheme;
     final size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.only(top:20),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: FadeInImage(
            placeholder: AssetImage('assets/no-image.jpg'),
            image: NetworkImage(movie.fullPosterImg),
            height: 150,
            width: 110,

            )),

            SizedBox( width: 20),

            //*Titulo, titulo original y average

            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: size.width - 190 ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(movie.title, style:textTheme.headline5, overflow: TextOverflow.ellipsis, maxLines: 2),
                  Text(movie.originalTitle, style: textTheme.subtitle2, overflow: TextOverflow.ellipsis, maxLines: 2,),
                  Row(
                    children:  [
                     const  Icon(Icons.star, size: 15,),
                     SizedBox(height: 10,),
                      Text('${movie.voteAverage}', style: textTheme.caption,)
                  ])
                ],
              ),
            )

        ],)
    );
  }
}


class _MovieDescription extends StatelessWidget {   
   
 final Movie movie;
   
  const _MovieDescription({Key? key, 
  required this.movie
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 3, left: 10, right: 10),
      margin: EdgeInsets.only( top: 20, left: 12, right: 12),
      child: Text(movie.overview, textAlign: TextAlign.justify,),
    );

  }
}