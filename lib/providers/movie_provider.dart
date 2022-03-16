import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';



class MoviesProvider extends ChangeNotifier {
  final String apiKey = '39f6a371dba5cb235557fc8fdafe0dc7';
  final String baseUrl = 'https://api.themoviedb.org/3';
  Map<String, dynamic> _movies = {};
  List _movie = [];
  bool _movieError = false;
  String _movieErrorMessage = "";
  bool _error = false;
  String _errorMessage = "";
  

  /* final dataService = ApiService(); */
  Map<String, dynamic> get movies => _movies;
  bool get error => _error;
  String get errorMessage => _errorMessage;


  List get movie => _movie;
  bool get movieError => _movieError;
  String get movieErrorMessage => _movieErrorMessage;

  Future<void> get fetchNowPlayingMovie async{
    /* '$baseUrl/movie/now_playing?$apiKey' */
    final response = await get(Uri.parse('$baseUrl/movie/now_playing?api_key=$apiKey'));

    if(response.statusCode == 200){
      try{
        _movies = jsonDecode(response.body);
        _error = false;
        /* print('Movie Data: $_movies'); */
      }catch(e){
        _error = true;
        _errorMessage = e.toString();
        _movies = {};
        print("Movie Error:$e");
      }
    }else{
      _error = true;
      _errorMessage = "Error: It could be your internet connection";
      _movies = {};
    }

    notifyListeners();
  }


  /* Future<void> fetchMovie(int movieId) async{
    final response = await get(Uri.parse('$baseUrl/movie/$movieId?api_key=$apiKey&language=en-US'));

    if(response.statusCode == 200){
      try{
        _movie.add(jsonDecode(response.body));
        _movieError = false;
        print(response.body);
      }catch(e){
        _movieError = true;
        _movieErrorMessage = e.toString();
        _movie = [];
      }
    }else{
      _movieError = true;
      _movieErrorMessage = "Error: it could be your internet connection";
      _movie = [];
    }

    notifyListeners();
  } */

  void initialValues(){
    _movies = {};
    _error = false;
    _errorMessage = '';

    notifyListeners();
  }
  
}