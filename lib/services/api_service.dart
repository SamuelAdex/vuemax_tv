import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:vuemax_tv/models/movie.dart';


class ApiService {
  final Dio dio = Dio();
  final String apiKey = '39f6a371dba5cb235557fc8fdafe0dc7';
  final String baseUrl = 'https://api.themoviedb.org/3';


  Future<List<Movie>> getNowPlayingMovie() async{
    List<Movie>? movieList;
    try{
      /* final url = '$baseUrl/movie/now_playing?$apiKey'; */
      //final queryParameters = {"api_key": apiKey};
      //final url = Uri.https(baseUrl, '/movie/now_playing', queryParameters);
      final response = await http.get(Uri.parse('$baseUrl/movie/now_playing?$apiKey'));

      if(response.statusCode == 200){
        /* final movies = jsonDecode(response.body); */
        movieList = jsonDecode(response.body);
        /* movieList = movies.map((m)=> Movie.fromJson(m)).toList(); */
        print(response.body);
      }else{
        print("Something went Wrong");
      }

    }catch(error, stacktrace){
      throw Exception('Exception occured $error with stacktrace: $stacktrace');
    }

    return movieList!;
  }

  originalImage(String imgPath){
    return 'https://image.tmdb.org/t/p/original$imgPath';
  }
}