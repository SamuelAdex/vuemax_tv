import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';



class TrailerProvider extends ChangeNotifier {
  final String apiKey = '39f6a371dba5cb235557fc8fdafe0dc7';
  final String baseUrl = 'https://api.themoviedb.org/3';
  Map<String, dynamic> trailer = {};
  bool trailerError = false;
  String trailerErrorMessage = "";
  
  

  
  /* List get movie => _movie;
  bool get movieError => _movieError;
  String get movieErrorMessage => _movieErrorMessage; */

  
  Future<void> fetchTrailer(int movieId) async{
    final response = await get(Uri.parse('$baseUrl/movie/$movieId/videos?api_key=$apiKey&language=en-US'));

    if(response.statusCode == 200){
      try{
        trailer = jsonDecode(response.body);
        trailerError = false;
        /* print(response.body); */
      }catch(e){
        trailerError = true;
        trailerErrorMessage = e.toString();
        trailer = {};
      }
    }else{
      trailerError = true;
      trailerErrorMessage = "Error: it could be your internet connection";
      trailer = {};
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