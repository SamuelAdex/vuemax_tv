import 'package:flutter/material.dart';



class TvScreen extends StatefulWidget {
  const TvScreen({ Key? key }) : super(key: key);

  @override
  _TvScreenState createState() => _TvScreenState();
}

class _TvScreenState extends State<TvScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
        child: Center(
          child: Text("Tv Shows Screen")
        )
      )
    )
    );
  }
}