import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:vuemax_tv/screens/mainScreen.dart';
import 'dart:convert';
import 'dart:io' show Platform;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:vuemax_tv/screens/moviedetailsScreen.dart';
import 'package:vuemax_tv/widgets/shimmerEffect.dart';
import 'package:vuemax_tv/providers/searchProvider.dart';



class SearchScreen extends StatefulWidget {
  const SearchScreen({ Key? key }) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final searchController = TextEditingController();

  String? searchStr;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();    
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    context.read<SearchProvider>().fetchSearchedMovie;
    final outlineInputBorder = OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey.shade800, width: 1),
    );
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: FractionallySizedBox(
            widthFactor: 1,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children:[
                    Row(
                      children:[
                        GestureDetector(
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context){
                                return MainScreen();
                              })
                            );
                          },
                          child: Icon(Icons.arrow_back, color: Colors.grey.shade800,)
                        ),
                        SizedBox(width: 4),
                        Container(       
                          width: MediaQuery.of(context).size.width * 0.85,
                          height: 38,
                          child: TextField(
                            controller: searchController,
                            onSubmitted: (_)async {
                              await context.read<SearchProvider>().fetchSearchedMovie(searchController.text);
                              searchController.text = "";
                            },
                            decoration: InputDecoration(                
                              contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                              labelStyle: TextStyle(color: Colors.grey.shade900),
                              focusedBorder: outlineInputBorder,
                              enabledBorder: outlineInputBorder,
                              hintText: 'search vuemax',                            
                            ),
                            style: TextStyle(
                              color: HexColor("#f5f5f5"),                            
                            )
                          ),
                        )
                      ]
                    ),
                    SizedBox(height: 20),
                    SingleChildScrollView(
                      child: Consumer<SearchProvider>(
                        builder: (context, value, index){
                          return value.search.length == 0 && !value.error
                          ? Center(child: Text("Nothing here for now", style: TextStyle(
                            color: Colors.grey.shade500
                          )))
                          : value.error ? Text('Oops, something went wront $value.errorMessage')
                          : SizedBox(
                            height: MediaQuery.of(context).size.height,
                            child: ListView.builder(
                              itemCount: value.search["results"].length,
                              itemBuilder: (context, index){
                                return Container(
                                    child: Column(
                                      children: [
                                        ListTile(
                                          onTap:(){
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(builder: (context){
                                                  return MovieDetailsScreen(movie: value.search["results"][index],);
                                                })
                                            );
                                          },
                                          leading: CachedNetworkImage(
                                            imageUrl: "https://image.tmdb.org/t/p/original${value.search["results"][index]["backdrop_path"]}",
                                            height: 50,
                                            width: 50,
                                            fit: BoxFit.cover,
                                            placeholder:(context, url)=>
                                              Platform.isAndroid 
                                                ? CircularProgressIndicator()
                                                : CupertinoActivityIndicator(),
                                              errorWidget: (context, url, error) => Container(
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    image: AssetImage('images/vuemax-icon.png')
                                                  ),
                                                )
                                              )
                                          ),
                                          title: Text(value.search["results"][index]["title"], style: TextStyle(
                                            color: Colors.grey.shade500,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600
                                          )),
                                          subtitle: Text(value.search["results"][index]["release_date"], style: TextStyle(
                                            color: Colors.grey.shade800,                                            
                                          ))
                                        )
                                      ]
                                    )                                
                                );
                              }
                            ),
                          );
                        }
                      )
                    )
                  ]
                ),
              )
            ),
          )
        )
      )
    );    
  }
}