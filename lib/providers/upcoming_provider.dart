import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';



class UpcomingProvider with ChangeNotifier {
  final String apiKey = '39f6a371dba5cb235557fc8fdafe0dc7';
  final String baseUrl = 'https://api.themoviedb.org/3';
  Map<String, dynamic> _upcoming = {};
  bool _error = false;
  String _errorMessage = "";
  String username = "SamuelAdex";

  /* final dataService = ApiService(); */
  Map<String, dynamic> get upcoming => _upcoming;
  bool get error => _error;
  String get errorMessage => _errorMessage;

  Future<void> get fetchUpcomingMovie async{
    /* '$baseUrl/movie/now_playing?$apiKey' */
    final response = await get(Uri.parse('$baseUrl/movie/upcoming?api_key=$apiKey&language=en-US&page=1'));

    if(response.statusCode == 200){
      try{
        _upcoming = jsonDecode(response.body);
        _error = false;
        /* print('Upcoming Data: $_upcoming'); */
      }catch(e){
        _error = true;
        _errorMessage = "Error: It couuld be your internet connection";
        _upcoming = {};
        print("Movie Error:$e");
      }
    }   

    notifyListeners();
  }

  void initialValues(){
    _upcoming = {};
    _error = false;
    _errorMessage = '';

    notifyListeners();
  }
  /* fetchNowPlayingMovie(context) async{
    try{
      movies = await dataService.getNowPlayingMovie();
      error = false;
    }catch(e){
      error = true;
      errorMessage = "Error: it could be your internet connection";      
    }

    notifyListeners();
  }
 */
}