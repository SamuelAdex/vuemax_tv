import 'package:flutter/material.dart';
import 'package:vuemax_tv/screens/aboutScreen.dart';
import 'package:vuemax_tv/screens/loginScreen.dart';
import 'package:vuemax_tv/screens/mainScreen.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({ Key? key }) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: FractionallySizedBox(
            widthFactor: 1,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Center(
                child: Column(
                  children:[
                    Container(  
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:[
                          GestureDetector(
                            child: Icon(Icons.arrow_back, color: Colors.grey.shade800),
                            onTap: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context){
                                  return MainScreen();
                                })
                              );
                            }
                          ),
                          Text('v0.0.1', style: TextStyle(
                            color: Colors.grey.shade500,
                            fontSize: 14,
                            fontWeight: FontWeight.bold
                          ))
                        ]
                      )
                    ),
                    SizedBox(height: 40),
                    Container(
                      child: Column(
                        children:[
                          Image(
                            image: AssetImage('images/vuemax-icon.png'),
                            width: 100,
                            height: 100
                          ),
                          SizedBox(height: 10),
                          Container(
                            padding: EdgeInsets.all(20),
                            height: MediaQuery.of(context).size.height * 0.8,
                            child: ListView(
                              children:[
                                Row(
                                  children:[
                                    Icon(Icons.person, color: Colors.grey.shade500),
                                    Expanded(
                                      child: ListTile(
                                        title: Text('adexsamuel6@gmail.com', style: TextStyle(
                                          color: Colors.grey.shade500,
                                          fontSize: 14,                                          
                                        )),
                                        subtitle: Text('SamuelAdex', style: TextStyle(
                                          color: Colors.grey.shade800,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold
                                        )),
                                      ),
                                    ),
                                  ]
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.logout, color: Colors.grey.shade500),
                                    Expanded(
                                      child: ListTile(
                                        onTap: (){
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context){
                                              return LoginScreen();
                                            })
                                          );
                                        },
                                        title: Text("Sign Out", style: TextStyle(
                                            color: Colors.grey.shade500,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold
                                        ))
                                      ),
                                    )
                                  ]
                                ),
                                Row(
                                  children:[
                                    Icon(Icons.rate_review_outlined, color: Colors.grey.shade500),
                                    Expanded(
                                      child: ListTile(
                                        onTap:(){
                                          showModalBottomSheet(
                                            backgroundColor: Colors.grey.shade900,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(30),
                                                topRight: Radius.circular(30),
                                              )
                                            ),
                                            context: context, 
                                            builder: (BuildContext context){
                                              return Container(
                                                padding: EdgeInsets.all(20),
                                                height: 200,                                                
                                                /* decoration: BoxDecoration(
                                                  color: Colors.grey.shade900,
                                                  borderRadius: BorderRadius.only(
                                                    topLeft: Radius.circular(30),
                                                    topRight: Radius.circular(30)
                                                  )
                                                ), */
                                                child: Center(
                                                  child: Column(
                                                    mainAxisAlignment:MainAxisAlignment.center,
                                                    children:[
                                                      Text("Rate Us", style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight: FontWeight.bold
                                                      )),
                                                      SizedBox(height: 40),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                        children:[
                                                          Icon(Icons.star_outline, color: Colors.yellow),
                                                          Icon(Icons.star_outline, color: Colors.yellow),
                                                          Icon(Icons.star_outline, color: Colors.yellow),
                                                          Icon(Icons.star_outline, color: Colors.yellow),
                                                        ]
                                                      )
                                                    ]
                                                  ),
                                                )
                                              );
                                            }
                                          );
                                        },
                                        title: Text("Rate Us", style: TextStyle(
                                            color: Colors.grey.shade500,
                                            fontSize: 14,                                            
                                        ))
                                      )
                                    )
                                  ]
                                ),
                                Row(
                                  children:[
                                    Icon(Icons.info_outline_rounded, color: Colors.grey.shade500),
                                    Expanded(
                                      child: ListTile(
                                        onTap:(){
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context){
                                              return AboutScreen();
                                            })
                                          );
                                        },
                                        title: Text("About us", style: TextStyle(
                                            color: Colors.grey.shade500,
                                            fontSize: 14,                                            
                                        ))
                                      )
                                    )
                                  ]
                                ),
                                SizedBox(height: 20,),
                                GestureDetector(  
                                  onTap: (){

                                  },                                                 
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.yellow,
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children:[
                                        Icon(Icons.coffee,),
                                        SizedBox(width: 10),
                                        Text("Buy me a Coffee", style: TextStyle(
                                            color: Colors.black
                                        ))
                                      ]
                                    ),
                                  )
                                ),
                                SizedBox(height: 20,),
                                Row(
                                  children:[
                                      /* Image.network("https://www.themoviedb.org/assets/2/v4/logos/v2/blue_square_2-d537fb228cf3ded904ef09b136fe3fec72548ebc1fea3fbbd1ad9e36364db38b.svg",
                                      width: 50,
                                      height: 50
                                    ), */
                                    Expanded(
                                      child: ListTile(
                                        title: Text("Disclaimer:", style: TextStyle(
                                            color: Colors.grey.shade500,
                                            fontSize: 14,                                            
                                        )),
                                        subtitle: Text("Lorem ipsum dolor sit amet consectetur adipisicing elit. Distinctio molestiae dolorum temporibus, natus numquam et rerum, deserunt ut a rem fuga repellendus, voluptas praesentium repudiandae harum ipsam doloremque blanditiis? Et, minus. Accusamus hic error nulla, at, aut itaque consequuntur eum ab accusantium nemo natus aspernatur fugit laboriosam laudantium veritatis quas quibusdam! Dicta incidunt veritatis deleniti", style: TextStyle(
                                          color: Colors.grey.shade800,
                                          fontSize: 14,
                                        )),
                                      ),
                                    )
                                  ]
                                )
                                
                              ]
                            ),
                          ),
                        ]
                      )
                    )
                  ]
                )
              )
            )
          )
        )
      )
    );
  }
}