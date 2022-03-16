import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:vuemax_tv/screens/loginScreen.dart';
import 'package:vuemax_tv/screens/mainScreen.dart';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({ Key? key }) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: FractionallySizedBox(
            widthFactor: 1,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children:[
                  SizedBox(height: 10,),
                  Center(child: Image.asset('images/vuemax-icon.png', width: 200, height: 200)),                
                  FractionallySizedBox(
                    widthFactor: 0.9,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:[
                        Text("Welcome To Vuemax Tv", style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold
                        )),
                        SizedBox(height:5),
                        Text("the universe for all movies and tv shows", style: TextStyle(
                          color: Colors.grey.shade400,                      
                        ))
                      ]
                    )
                  ),
                  SizedBox(height: 25),
                  Container(
                    padding: EdgeInsets.zero,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:[
                      FractionallySizedBox(
                        widthFactor: 0.9,
                        child: Text("Create new Account", style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        )),
                      ),
                      SizedBox(height: 20),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.85,
                        height: 40,
                        child: TextField(
                          decoration: InputDecoration(
                            labelStyle: TextStyle(color: Colors.grey.shade900),
                            labelText: 'email',
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey.shade400, width: 1),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey.shade800, width: 1),
                            )
                          ),
                          style: TextStyle(
                              color: HexColor("#f5f5f5"),                            
                          )
                        )
                      ),
                      SizedBox(height: 20),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.85,
                        height: 40,
                        child: TextField(
                          obscureText: true,
                          decoration: InputDecoration(
                            labelStyle: TextStyle(color: Colors.grey.shade900),
                            labelText: 'password',
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey.shade400, width: 1),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey.shade800, width: 1),
                            )
                          ),
                          style: TextStyle(
                              color: HexColor("#f5f5f5"),                            
                          )
                        )
                      ),
                      SizedBox(height: 20),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.85,
                        height: 40,               
                        child: ElevatedButton(
                          onPressed:(){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context){
                                return MainScreen();
                              })
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text("submit", style: TextStyle(
                              color: Colors.white,                          
                            )),
                          )
                        )
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.85,
                        height: 40,
                        child: Row(
                          children:[
                            Text("Already have an account?", style: TextStyle(
                                color: Colors.grey.shade300,                          
                            )),
                            TextButton(
                              onPressed: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context){
                                    return LoginScreen();
                                  })
                                );
                              },
                              child: Text("Login", style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold                          
                              ))
                            )
                          ]
                        ),
                      ),
                      SizedBox(height: 10,),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.85,                        
                        padding: EdgeInsets.all(5.0),
                        child: TextButton(
                          onPressed: (){},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:[
                              Text("Sign Up with Google", style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade600,
                              )),
                              SizedBox(width: 10),
                              Image.asset('images/google.png', width: 30, height: 30),
                            ]
                          ),
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        )
                      )
                    ]
                    )
                  )
                ]
              ),
            ),
          ),
        ),
      )
    );
  }
}