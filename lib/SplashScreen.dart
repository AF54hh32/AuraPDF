import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'HomePage.dart';

class Splashscreen  extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => SplashState();


}


class SplashState extends State<Splashscreen> {


  @override
  void initState() {
    super.initState();
    _gotoNext();
  }


  Future<void> _gotoNext() async{
    await Future.delayed(const Duration(seconds: 5));

    Navigator.push(context, MaterialPageRoute(builder: (context) =>  Homepage()));


  }



  @override
  Widget build(BuildContext context) {

    var screenSize = MediaQuery.sizeOf(context);

    return Scaffold(
            body: Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFFA8DDB8), // mint green
                  Color(0xFFA9D6D3), // soft aqua
                  Color(0xFFA9C0E8), // periwinkle blue
                ],
                stops: [0.0, 0.5, 1.0],
                ),
              ),
              child: Center(child: Image(width:screenSize.width*0.40,
                height: screenSize.width*0.40,
                image: AssetImage("assets/images/aura_logo.png"),
              ),
             )
            )

    );


  }

}


