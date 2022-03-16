import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';


class TopRated with ChangeNotifier {
  final String apiKey = '39f6a371dba5cb235557fc8fdafe0dc7';
  final String baseUrl = 'https://api.themoviedb.org/3';
  Map<String, dynamic> _topMovies = {};
  bool _error = false;
  String _errorMessage = "";
  

  /* final dataService = ApiService(); */
  Map<String, dynamic> get topMovies => _topMovies;
  bool get error => _error;
  String get errorMessage => _errorMessage;


  Future<void> get fetchTopRatedMovies async {
    final response = await get(Uri.parse('$baseUrl/movie/top_rated?api_key=$apiKey'));

    if(response.statusCode == 200){
      try{
        _topMovies = jsonDecode(response.body);
        _error = false;
      }catch(e){
        _error = true;
        _errorMessage = "Something went wrong";
      }
    }

    notifyListeners();
  }


  void initialValues(){
    _topMovies = {};
    _error = false;
    _errorMessage = '';

    notifyListeners();
  }
}