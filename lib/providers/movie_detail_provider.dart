import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';



class MovieDetailProvider extends ChangeNotifier {
  final String apiKey = '39f6a371dba5cb235557fc8fdafe0dc7';
  final String baseUrl = 'https://api.themoviedb.org/3';
  Map<String, dynamic> movie = {};
  bool movieError = false;
  String movieErrorMessage = "";
  
  

  
  /* List get movie => _movie;
  bool get movieError => _movieError;
  String get movieErrorMessage => _movieErrorMessage; */

  
  Future<void> fetchMovie(int movieId) async{
    final response = await get(Uri.parse('$baseUrl/movie/$movieId?api_key=$apiKey&language=en-US'));

    if(response.statusCode == 200){
      try{
        movie = jsonDecode(response.body);
        movieError = false;
        /* print(response.body[0]); */
      }catch(e){
        movieError = true;
        movieErrorMessage = e.toString();
        movie = {};
      }
    }else{
      movieError = true;
      movieErrorMessage = "Error: it could be your internet connection";
      movie = {};
    }

    notifyListeners();
  }

  /* void initialValues(){
    _movies = {};
    _error = false;
    _errorMessage = '';

    notifyListeners();
  } */
  
}