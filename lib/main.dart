import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vuemax_tv/providers/genre_provider.dart';
import 'package:vuemax_tv/providers/images_provider.dart';
import 'package:vuemax_tv/providers/movie_detail_provider.dart';
import 'package:vuemax_tv/providers/movie_provider.dart';
import 'package:vuemax_tv/providers/top_movie_provider.dart';
import 'package:vuemax_tv/providers/trailer_provider.dart';
import 'package:vuemax_tv/providers/upcoming_provider.dart';
import 'package:vuemax_tv/providers/searchProvider.dart';
import 'package:vuemax_tv/screens/mainScreen.dart';
import 'package:vuemax_tv/screens/signupScreen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MoviesProvider()),
        ChangeNotifierProvider(create: (_) => MovieDetailProvider()),
        ChangeNotifierProvider(create: (_) => ImagesProvider()),
        ChangeNotifierProvider(create: (_) => TrailerProvider()),
        ChangeNotifierProvider(create: (_) => TopRated()),
        ChangeNotifierProvider(create: (_) => UpcomingProvider()),
        ChangeNotifierProvider(create: (_) => SearchProvider()),
        ChangeNotifierProvider(create: (_) => GenreProvider()),
      ],
      child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SignUpScreen(),
    );
  }
}

