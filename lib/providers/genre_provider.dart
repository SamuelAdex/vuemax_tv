import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';


class GenreProvider with ChangeNotifier {
  final String apiKey = '39f6a371dba5cb235557fc8fdafe0dc7';
  final String baseUrl = 'https://api.themoviedb.org/3';
  Map<String, dynamic> _genreList = {};
  bool _error = false;
  String _errorMessage = "";
  

  Map<String, dynamic> get genreList => _genreList;
  bool get error => _error;
  String get errorMessage => _errorMessage;


  Future<void> get fetchGenrelist async {
    final response = await get(Uri.parse('$baseUrl/genre/movie/list?api_key=$apiKey>&language=en-US'));

    if(response.statusCode == 200){
      try{
        _genreList = jsonDecode(response.body);
        _error = false;
        print("Genre Data: $_genreList");
        print("Genres fetched successfully :)");
      }catch(e){
        _error = true;
        _errorMessage = "Something went wrong";
        print("Something went wrong $e");
      }
    }

    notifyListeners();
  }


  void initialValues(){
    _genreList = {};
    _error = false;
    _errorMessage = '';

    notifyListeners();
  }
}