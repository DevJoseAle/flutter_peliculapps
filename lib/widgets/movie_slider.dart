import 'package:flutter/material.dart';
import 'package:pelicula_apps/models/models.dart';

class MovieSlider extends StatefulWidget {
  //Función que activará la siguiente página del slider
  final Function onNextPage;
  
  final List<Movie> movies;
  final String? title;

   
  const MovieSlider({Key? key, 
  this.title, 
  required this.movies, 
  required this.onNextPage
  }) : super(key: key);

  @override
  State<MovieSlider> createState() => _MovieSliderState();
}

class _MovieSliderState extends State<MovieSlider> {

  final ScrollController scrollControler = new ScrollController();
  
   @override
  void initState() {
    // TODO: implement initState
    super.initState();

    scrollControler.addListener(() {
      if(scrollControler.position.pixels >= scrollControler.position.maxScrollExtent -50){
        print('Scroll');
        widget.onNextPage();
      }
      
    });
  }
  @override
  void dispose() {
    // TODO: implement dispose

    //En el dispose, primero ejecutamos el código y luevo el dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 260,
      color: Colors.blue.withOpacity(0.02),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [ 

          if(this.widget.title != null)         
           Padding(
            padding: const  EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
            child: Text('${widget.title}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
          ),

          Expanded(
            child: ListView.builder(
              controller: scrollControler,
              scrollDirection: Axis.horizontal,
              itemCount: widget.movies.length,
              itemBuilder: ( _ , int index) => _MoviePoster( widget.movies[index] ),
            ),
          )
          
        
        ],
    ));
    
  }
}

class _MoviePoster extends StatelessWidget {

    final Movie movie;

  const _MoviePoster(this.movie);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left:5),
      width: 130,
      margin: EdgeInsets.all(5),
      height: 160,
      child: Column(
        children:  [
          
          GestureDetector(
            onTap:  ()=> Navigator.pushNamed(
              context, 'details',
              arguments: movie, //Aqui
              ),

            child: ClipRRect(

              borderRadius: BorderRadius.circular(15),
              child: FadeInImage(
                width: 130,
                height: 170,
                fit: BoxFit.cover,
                placeholder: AssetImage('assets/no-image.jpg'), 
                image: NetworkImage(movie.fullPosterImg),
                ),
            ),
          ),

            const SizedBox( height: 5),

            Padding(
              padding: EdgeInsets.only(left: 3, top: 2),
              child: Text(movie.originalTitle,
              maxLines: 2,
              style: const TextStyle(fontSize: 11, 
              overflow: TextOverflow.ellipsis, fontWeight: FontWeight.bold ),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis),
            )
        ],),
    );
  }
}