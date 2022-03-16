import 'dart:convert';
/* import 'dart:html'; */
import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';
import 'package:vuemax_tv/screens/moviedetailsScreen.dart';
import 'package:vuemax_tv/widgets/shimmerEffect.dart';
import 'package:vuemax_tv/providers/upcoming_provider.dart';


class Upcoming extends StatefulWidget {
  const Upcoming({ Key? key }) : super(key: key);

  @override
  _UpcomingState createState() => _UpcomingState();
}

class _UpcomingState extends State<Upcoming> {
  @override
  Widget build(BuildContext context) {
    context.read<UpcomingProvider>().fetchUpcomingMovie;
    return Container(                      
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
          children:[
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text("Upcoming Movies".toUpperCase(), style: TextStyle(color: Colors.grey.shade500, fontWeight: FontWeight.w600, fontSize: 15), textAlign: TextAlign.start),
            ),            
            Consumer<UpcomingProvider>(
              builder: (context, value, index){
                return value.upcoming.length == 0 && !value.error 
                ? ShimmerEffect(
                  height: MediaQuery.of(context).size.height * 0.8,
                  width: 150,
                )
                : value.error ? Text("Oops, something went wrong ${value.errorMessage}") 
                : SizedBox(
                  height: 200.0,
                  child: ListView.builder(
                  itemCount: value.upcoming['results'].length,
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
                                  return MovieDetailsScreen(movie: value.upcoming["results"][index],);
                                })
                              );
                            },
                            child: ClipRRect(                                    
                              child: CachedNetworkImage(                                      
                                imageUrl:'https://image.tmdb.org/t/p/original${value.upcoming["results"][index]["poster_path"]}',
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