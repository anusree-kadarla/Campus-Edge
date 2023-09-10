import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:minor/rate.dart';

class AboutUsPage extends StatelessWidget{
  const AboutUsPage({Key? key}): super(key:key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          alignment: Alignment.center,
          child:Column(
            children: [
              FlutterLogo(
                size:100,
              ),
              Text(
                'College Management System',
                style: TextStyle(fontWeight: FontWeight.bold,
                  fontSize: 20,),
                //style:Theme.of(context).textTheme.headline3;
              ),
              Spacer(),
              TextButton.icon(
                onPressed: (){
                  openRatingDialog(context);
                },
                style:ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue.withOpacity(0.1),
                  ),
                ),
                icon:Icon(Icons.star),
                label:Text(
                  'Rate us!',
                  //style: Theme.of(context).textTheme.headline6,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  openRatingDialog(BuildContext context){
    showDialog(context: context,
      builder:(context){
        return Dialog(
          child: RatingView(),
        );
      },
    );
  }
}