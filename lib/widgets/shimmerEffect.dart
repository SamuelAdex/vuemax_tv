import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';


class ShimmerEffect extends StatelessWidget {
  ShimmerEffect({ Key? key, required this.height, required this.width, this.boxHeight = 200.0 }) : super(key: key);

  double height;
  double width;
  double boxHeight;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        child: SizedBox(
          height: boxHeight,
          child: ListView.builder(
            itemCount: 7,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index){
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: height,
                  width: width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)
                  ) 
                ),
              );
            }
          ),
        ), 
        baseColor: Colors.white10,
        highlightColor: Colors.white12,
        enabled: true                                   
    );
  }
}