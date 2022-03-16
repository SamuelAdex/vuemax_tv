import 'dart:convert';
/* import 'dart:html'; */
import 'dart:io' show Platform;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import 'package:vuemax_tv/providers/genre_provider.dart';
import 'package:vuemax_tv/providers/movie_provider.dart';
import 'package:vuemax_tv/providers/top_movie_provider.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:vuemax_tv/screens/moviedetailsScreen.dart';
import 'package:vuemax_tv/screens/navScreen/profileScreen.dart';
import 'package:vuemax_tv/widgets/ratedWidget.dart';
import 'package:vuemax_tv/widgets/shimmerEffect.dart';
import 'package:vuemax_tv/widgets/upcomingWidget.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({ Key? key }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
   int selectedGenre = 28;

  @override
  Widget build(BuildContext context) {    
    context.read<MoviesProvider>().fetchNowPlayingMovie;    
    /* context.watch<GenreProvider>().fetchGenrelist; */
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(                  
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:[
              SizedBox(height: 20),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children:[
                        Image(
                          image: AssetImage('images/vuemax-icon.png',),
                          width: 70, 
                          height: 70
                        ),
                        SizedBox(width: 0),
                        Text("VUEMAX-TV", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight:FontWeight.bold)),
                      ]
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context){
                            return ProfileScreen();
                          })
                        );
                      },
                      child: CircleAvatar(
                        backgroundImage: AssetImage("images/2.jpg"),
                        radius: 12,                      
                      ),
                    )
                  ],
                )
              ),
              SizedBox(height: 2),
              SingleChildScrollView(
                child: RefreshIndicator(
                  onRefresh: () async{
                    context.watch<MoviesProvider>().initialValues;
                    context.watch<TopRated>().initialValues;
                    await context.watch<MoviesProvider>().fetchNowPlayingMovie;
                    await context.watch<TopRated>().fetchTopRatedMovies;
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [                  
                      Container(                
                        child: Consumer<MoviesProvider>(
                          builder:(context, value, child){
                            return value.movies.length == 0 && !value.error ? 
                            Center(child: CircularProgressIndicator())
                            : value.error ? Text('Oops, something went wrong ${value.errorMessage}', textAlign: TextAlign.center) 
                            : SizedBox(
                              height: 250.0,
                              child: ListView(
                                physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                                children:[
                                  CarouselSlider.builder(
                                    itemCount: value.movies['results'].length,                                  
                                    itemBuilder: (context, index, realIndex) {
                                      return Stack(               
                                        alignment: Alignment.bottomLeft,                   
                                        children:<Widget>[
                                          GestureDetector(
                                            onTap: (){
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(builder: (context){
                                                  return MovieDetailsScreen(movie: value.movies["results"][index],);
                                                })
                                              );
                                              /* print(value.movies["results"][index]['title']); */
                                            },
                                            child: ClipRRect(                                    
                                              child: CachedNetworkImage(                                      
                                                imageUrl:'https://image.tmdb.org/t/p/original${value.movies["results"][index]["backdrop_path"]}',
                                                height: MediaQuery.of(context).size.height / 3,
                                                width: MediaQuery.of(context).size.width,
                                                fit: BoxFit.cover,
                                                placeholder:(context, url)=>
                                                  Platform.isAndroid 
                                                    ? ShimmerEffect(
                                                        height: MediaQuery.of(context).size.height / 3,
                                                        width: MediaQuery.of(context).size.width
                                                      ) 
                                                    : CupertinoActivityIndicator(),
                                                  errorWidget: (context, url, error) => Container(
                                                    decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                        image: AssetImage('images/vuemax-icon.png')
                                                      ),
                                                    )
                                                  )
                                              ),
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(10)
                                              )
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Text(value.movies != null ?
                                              value.movies['results'][index]['title'].toUpperCase() : "",
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: HexColor('#f5f5f5')
                                              )
                                            )
                                          )
                                        ]
                                      );
                                    },
                                    options: CarouselOptions(
                                      enableInfiniteScroll: true,
                                      autoPlay: true,
                                      autoPlayInterval: Duration(seconds: 3),
                                      autoPlayAnimationDuration: Duration(microseconds: 500),
                                      pauseAutoPlayOnTouch: true,
                                      viewportFraction: 0.8,
                                      enlargeCenterPage: true,                              
                                    )
                                  ),
                                ]
                              ),
                            );
                            /* return value.movies.length > 0 ? Text("All Movies", style: TextStyle(color: Colors.white)) 
                            : Text(value.errorMessage, style: TextStyle(color: Colors.white)); */
                          }
                        )
                      ),
                      Container(
                        
                      ),
                      TopRatedMovies(),
                      SizedBox(height: 10),
                      Upcoming(),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              )
            ]
          ),
        )
      )
    );
  }
}