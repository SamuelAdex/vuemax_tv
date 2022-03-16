import 'package:flutter/material.dart';


class AboutScreen extends StatelessWidget {
  const AboutScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: FractionallySizedBox(
          widthFactor: 1,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(                      
                      child: Row( 
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,                       
                        children:[
                          GestureDetector(
                            onTap: (){
                              Navigator.of(context).pop();                          
                            },
                            child: Icon(Icons.close, color: Colors.grey.shade500)
                          ),                          
                          Text("About Vuemax Tv", style: TextStyle(
                            color: Colors.grey.shade500,
                            fontSize: 15,
                            fontWeight: FontWeight.bold
                          ))
                        ]
                      )
                    ),
                    SizedBox(height: 20),
                    Container(
                      child: Image.asset('images/vuemax-icon.png')
                    ),
                    Container(
                      height: MediaQuery.of(context).size.width * 0.8,                      
                      width: MediaQuery.of(context).size.width,
                      child: Text("Lorem ipsum dolor sit amet consectetur adipisicing elit. Distinctio molestiae dolorum temporibus, natus numquam et rerum, deserunt ut a rem fuga repellendus, voluptas praesentium repudiandae harum ipsam doloremque blanditiis? Et, minus. Accusamus hic error nulla, at, aut itaque consequuntur eum ab accusantium nemo natus aspernatur fugit laboriosam laudantium veritatis quas quibusdam! Dicta incidunt veritatis deleniti", style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 16,                      
                      ),),
                    ),
                    /* SizedBox(height: 70), */
                    Container(
                      child: GestureDetector(
                        onTap: (){},
                        child: Text("check for Update", style: TextStyle(
                        color: Colors.grey.shade800,))
                      )
                    )
                  ],
                ),
              ),
            )
          ),
        )
      )
    );
  }
}