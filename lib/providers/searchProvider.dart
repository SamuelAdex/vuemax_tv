import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';



class SearchProvider with ChangeNotifier {
  final String apiKey = '39f6a371dba5cb235557fc8fdafe0dc7';
  final String baseUrl = 'https://api.themoviedb.org/3';
  Map<String, dynamic> _search = {};
  bool _error = false;
  String _errorMessage = "";
  String username = "SamuelAdex";

  /* final dataService = ApiService(); */
  Map<String, dynamic> get search => _search;
  bool get error => _error;
  String get errorMessage => _errorMessage;

  //String query = "avengers";

  Future<void> fetchSearchedMovie(String query) async{
    /* '$baseUrl/movie/now_playing?$apiKey' */
    final response = await get(Uri.parse('$baseUrl/search/movie?api_key=$apiKey&query=$query'));

    if(response.statusCode == 200){
      try{
        _search = jsonDecode(response.body);
        _error = false;
        print('Movie Data: $_search');
      }catch(e){
        _error = true;
        _errorMessage = e.toString();
        _search = {};
        print("Movie Error:$e");
      }
      
    }else{
      _error = true;
      _errorMessage = "Error: It couuld be your internet connection";
      _search = {};
    }

    notifyListeners();
  }

  void initialValues(){
    _search = {};
    _error = false;
    _errorMessage = '';

    notifyListeners();
  }
  
}