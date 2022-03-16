import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io' show Platform;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:vuemax_tv/providers/top_movie_provider.dart';
import 'package:vuemax_tv/screens/moviedetailsScreen.dart';
import 'package:vuemax_tv/widgets/shimmerEffect.dart';


class TopRatedMovies extends StatefulWidget {
  const TopRatedMovies({ Key? key }) : super(key: key);

  @override
  _TopRatedMoviesState createState() => _TopRatedMoviesState();
}

class _TopRatedMoviesState extends State<TopRatedMovies> {
  @override
  Widget build(BuildContext context) {
    context.read<TopRated>().fetchTopRatedMovies;
    return Container(                      
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
          children:[
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text("Top Rated Movies".toUpperCase(), style: TextStyle(color: Colors.grey.shade500, fontWeight: FontWeight.w600, fontSize: 15), textAlign: TextAlign.start),
            ),  
            Consumer<TopRated>(
              builder: (context, value, index){
                return value.topMovies.length == 0 && !value.error 
                ? ShimmerEffect(
                  height: MediaQuery.of(context).size.height * 0.8,
                  width: 150,
                )
                : value.error ? Text("Oops, something went wrong ${value.errorMessage}") 
                : SizedBox(
                  height: 200.0,
                  child: ListView.builder(
                  itemCount: value.topMovies['results'].length,
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.all(2),
                  shrinkWrap: true,
                  itemBuilder: (context, index){
                    return Stack(
                      alignment: Alignment.bottomLeft,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context){
                                  return MovieDetailsScreen(movie: value.topMovies["results"][index],);
                                })
                              );
                            },
                            child: ClipRRect(                                    
                              child: CachedNetworkImage(                                      
                                imageUrl:'https://image.tmdb.org/t/p/original${value.topMovies["results"][index]["poster_path"]}',
                                height: MediaQuery.of(context).size.height * 0.8,
                                width: 150,                                            
                                fit: BoxFit.cover,
                                placeholder:(context, url)=>
                                  Platform.isAndroid 
                                    ? ShimmerEffect(
                                      height: MediaQuery.of(context).size.height * 0.8,
                                      width: 150,
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
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(                                            
                            children:[
                              Icon(Icons.star, color: Colors.yellow),
                              SizedBox(width: 6),
                              Text(value.topMovies['results'][index]['vote_average'].toString(), style: TextStyle(
                                color: HexColor("#f5f5f5"),
                                fontWeight: FontWeight.bold,
                              ))
                            ]
                          ),
                        )
                      ]
                    );
                  }
                  ),
                );
              }
            )
          ]
      )
    );
  }
}