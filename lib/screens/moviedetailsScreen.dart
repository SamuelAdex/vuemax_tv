import 'dart:convert';
import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vuemax_tv/providers/images_provider.dart';
import 'package:vuemax_tv/providers/movie_detail_provider.dart';
import 'package:vuemax_tv/providers/trailer_provider.dart';
/* import 'package:vuemax_tv/providers/movie_provider.dart'; */
import 'package:vuemax_tv/widgets/shimmerEffect.dart';



class MovieDetailsScreen extends StatefulWidget {
  MovieDetailsScreen({ Key? key, this.movie }) : super(key: key);
  dynamic movie;

  @override
  _MovieDetailsScreenState createState() => _MovieDetailsScreenState();
}


class _MovieDetailsScreenState extends State<MovieDetailsScreen> {

  fetchData() async{
    return await context.read<MovieDetailProvider>().fetchMovie(widget.movie["id"]);    
  }
    

  @override
  void initState(){
    // TODO: implement initState    
    super.initState();    
    print(widget.movie["id"]);
    fetchData();
  }

  


  @override
  Widget build(BuildContext context) {
    Provider.of<MovieDetailProvider>(context, listen: false).fetchMovie(widget.movie["id"]);
    Provider.of<ImagesProvider>(context, listen: false).fetchImages(widget.movie["id"]);
    Provider.of<TrailerProvider>(context, listen: false).fetchTrailer(widget.movie["id"]);
    return Scaffold(
      backgroundColor: Colors.black,
      body: FractionallySizedBox(
        widthFactor: 1,
        child: SingleChildScrollView(
          child: Consumer<MovieDetailProvider>(
            builder:(BuildContext context, value, child){
              return value.movie["id"] != widget.movie['id'] && /* value.movie == {} && */ !value.movieError
              ? Center(child: Container(padding: EdgeInsets.only(top: 120), child: CircularProgressIndicator()))
              : value.movieError ? Text('${value.movieErrorMessage}')
              : Column(
                children: [
                  Stack(
                    children:[
                      ClipRRect(                    
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(50),
                          bottomRight: Radius.circular(50),
                        ),                    
                        child: CachedNetworkImage(
                          imageUrl:'https://image.tmdb.org/t/p/original${value.movie["backdrop_path"]}',
                          height: 450,
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.cover,
                          placeholder:(context, url)=>
                            Platform.isAndroid 
                              ? ShimmerEffect(
                                  height: 500,
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
                      ),
                      Container(
                        padding: EdgeInsets.all(20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children:[                        
                            GestureDetector(
                              onTap: (){
                                widget.movie = [];
                                Navigator.pop(context);                            
                              },
                              child: Icon(Icons.arrow_back, color: Colors.white)
                            ),
                            GestureDetector(
                              onTap: (){

                              },
                              child: Icon(Icons.favorite_outline_outlined, size: 30, color: Colors.white)
                            )
                          ]
                        )
                      ),
                      Positioned(
                        top: 200,
                        left: 10,
                        right: 10,
                        child: GestureDetector(
                          onTap: ()async{
                            final trailerId = context.read<TrailerProvider>().trailer['results'][0]["key"];
                            final trailer = "https://www.youtube.com/embed/"+trailerId;
                            if(await canLaunch(trailer)){
                              await launch(trailer);
                            }
                          },
                          child: Container(
                            child: Column(
                              children: [
                                Icon(Icons.play_circle_fill_outlined, size: 60, color: Colors.blue),
                                Text(value.movie["title"], style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold
                                ), textAlign: TextAlign.center)
                              ]
                            )
                          ),
                        ),
                      )
                    ]
                  ),
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Overview".toUpperCase(), style: TextStyle(
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ), textAlign: TextAlign.left,),
                        SizedBox(height: 4),
                        Text(value.movie["overview"], style: TextStyle(
                          color: Colors.grey.shade800,                          
                        ))
                      ]
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:[
                            Text("Release".toUpperCase(), style: TextStyle(
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ), textAlign: TextAlign.left,),
                            SizedBox(height: 4),
                            Text(value.movie["release_date"], style: TextStyle(
                              color: Colors.grey.shade800,                          
                            ))
                          ]
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:[
                            Text("Run Time".toUpperCase(), style: TextStyle(
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ), textAlign: TextAlign.left,),
                            SizedBox(height: 4),
                            Text(value.movie["runtime"].toString(), style: TextStyle(
                              color: Colors.grey.shade800,                          
                            ))
                          ]
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:[
                            Text("Budget".toUpperCase(), style: TextStyle(
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ), textAlign: TextAlign.left,),
                            SizedBox(height: 4),
                            Text(value.movie["budget"].toString(), style: TextStyle(
                              color: Colors.grey.shade800,                          
                            ))
                          ]
                        ),
                      ]
                    )
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:[
                        Text("Screenshots".toUpperCase(), style: TextStyle(
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ), textAlign: TextAlign.left,),
                        SizedBox(height: 4),
                        Consumer<ImagesProvider>(
                          builder:(context, value, index){
                            return value.images["id"] != widget.movie["id"] && !value.imageError
                              ? Center(child: Container(padding: EdgeInsets.only(top: 120), child: CircularProgressIndicator()))
                              : value.imageError ? Text(value.imageErrorMessage)
                              : SizedBox(
                                height: 150.0,                                
                                child: ListView.builder(
                                  itemCount: value.images["backdrops"].length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index){
                                    return Stack(
                                      children:[
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: ClipRRect(
                                            child: CachedNetworkImage(
                                            imageUrl: 'https://image.tmdb.org/t/p/w500${value.images["backdrops"][index]["file_path"]}',
                                            height: MediaQuery.of(context).size.height * 0.5,
                                            width: 160,
                                            fit: BoxFit.cover,
                                            placeholder: (context, url)=>
                                              Platform.isAndroid 
                                                  ? ShimmerEffect(
                                                    height: MediaQuery.of(context).size.height * 0.5,
                                                    width: 160,
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
                                        )
                                      ]
                                    );
                                  }
                                )

                              );
                          }
                        ),
                        
                      ]
                    )
                  )
                ],
              );
            }
          )
        )
      ) 
    );
  }
}