import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';



class ImagesProvider extends ChangeNotifier {
  final String apiKey = '39f6a371dba5cb235557fc8fdafe0dc7';
  final String baseUrl = 'https://api.themoviedb.org/3';
  Map<String, dynamic> images = {};
  bool imageError = false;
  String imageErrorMessage = "";
  
  

  
  /* List get movie => _movie;
  bool get movieError => _movieError;
  String get movieErrorMessage => _movieErrorMessage; */

  
  Future<void> fetchImages(int movieId) async{
    final response = await get(Uri.parse('$baseUrl/movie/$movieId/images?api_key=$apiKey&language=en-US&include_image_language=en,null'));

    if(response.statusCode == 200){
      try{
        images = jsonDecode(response.body);
        imageError = false;
        /* print(response.body); */
      }catch(e){
        imageError = true;
        imageErrorMessage = e.toString();
        images = {};
      }
    }else{
      imageError = true;
      imageErrorMessage = "Error: it could be your internet connection";
      images = {};
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