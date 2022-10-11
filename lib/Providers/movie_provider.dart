
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'dart:convert' as convert;

import 'package:http/http.dart' as http;
import 'package:pelicula_apps/Helpers/debouncer.dart';
import 'package:pelicula_apps/models/models.dart';
import 'package:pelicula_apps/models/search_response.dart';


class MoviesProvider extends ChangeNotifier{
  
  //Propiedades para las peticiones http
 final String _apiKey = 'cc3dab774ad342f9a130cd59cad31f18';
  final String _baseUrl = 'api.themoviedb.org';
  final String _language = 'es-ES';

  List<Movie> onDisplayMovie = [];
  List<Movie> popularMovies = [];

  Map<int, List<Cast>> movieCast = {};

  int _popularPage = 0;

  final debouncer = Debouncer(
    duration: Duration(milliseconds: 550),
    );

  final StreamController<List<Movie>> _suggestionsStreamController = new StreamController.broadcast();
  Stream<List<Movie>> get suggestionStream => this._suggestionsStreamController.stream;

  // Constructor
  Moviesprovider(){ 

    // Cuando el const sea llamado, se realizará el metodo:
    this.getOnDisplayMovies();
    this.getPopularMovies();
  }

  Future<String> _getJsonData(String endPoint, [int page = 1]) async{
    var url = Uri.https(_baseUrl, endPoint, 
        { //Mapa de Querys
        'api_key': _apiKey,
        'language': _language ,
        'page' : '$page' ,
        });
    // Await de la respuesta.
    var response = await http.get(url);
    return response.body;

  }

  // Método Independiente (async)
  getOnDisplayMovies() async{
    
    final jsonData = await this._getJsonData('3/movie/now_playing');

    final nowPlayingResponse = NowPlayingResponse.fromJson(jsonData);
    print('await');

    onDisplayMovie = nowPlayingResponse.results;
    
    notifyListeners();
  }

  getPopularMovies () async{
     _popularPage++;
    final jsonData = await this._getJsonData('3/movie/popular', _popularPage);
    final popularResponse = PopularResponse.fromJson(jsonData);
    popularMovies = [...popularMovies, ...popularResponse.results];
  
    notifyListeners();

  }

  Future<List<Cast>> getMovieCast (int movieId) async{

    if(movieCast.containsKey(movieId) )return movieCast[movieId]! ;

    final jsonData = await _getJsonData('3/movie/$movieId/credits');

    final creditsResponse = CreditsResponse.fromJson(jsonData);

    //Llenar el objeto movieCast
    movieCast[movieId] = creditsResponse.cast;
    return creditsResponse.cast;
  }

  //Función de Búsqueda
  Future <List<Movie>> searchMovie (String query) async{

    final url = Uri.https(_baseUrl, '3/search/movie', 
        { //Mapa de Querys
        'api_key': _apiKey,
        'language': _language ,
        'query' : query ,
        });
    // Await de la respuesta.
    var response = await http.get(url);
    final searchResponse = SearchResponse.fromJson(response.body);
     return searchResponse.results;
  }

void getSuggestionsByQuery (String query){

  debouncer.value = '';
  debouncer.onValue = (value) async{
    final results = await this.searchMovie(value);
    this._suggestionsStreamController.add(results); 
  };
  
  final timer = Timer.periodic(Duration(milliseconds: 300), (_) {
    debouncer.value = query;
  });
  
  Future.delayed(Duration(milliseconds: 301)).then((_) =>timer.cancel());

}
}