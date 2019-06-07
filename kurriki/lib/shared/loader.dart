

import 'package:meta/meta.dart';

import 'package:flutter/material.dart';
import 'package:kurriki/shared/theme_data.dart';
// build result


class Loader extends StatelessWidget {
  // Builder methods rely on a set of data, such as a list.

  final loading;
  Loader(this.loading);

  // First, make your build method like normal.
  // instead of returning Widgets, return a method which
  // returns widgets.
  // Don't forget to pass in the context!
  @override
  Widget build(BuildContext context) {
    if(this.loading == true){
      return new Container(
        height:30.0,
        padding: new EdgeInsets.all(0.0),
          child: new Image(
            image: new AssetImage("assets/loading.gif"),
          )
          // new Text(
          //   " ...",
          //   style: new TextStyle(
          //     color: Colors.white,
          //   ),
          // ),
        );
    }else{
       return new Container(
         width: 0.0,
          child: new Text(""),
        );
    }

  }  
}


class wevoteSnackBar{

  final context;
  final message;

  wevoteSnackBar(this.context, this.message){
    show(this.context, this.message);
  }

  show(context, message) {
    final snackBar = new SnackBar(
            content: new Text(message),
            action: new SnackBarAction(
              label: 'Undo',
              onPressed: () {
                // Some code to undo the change!
              },
            ),
          );

          // Find the Scaffold in the Widget tree and use it to show a SnackBar!
          Scaffold.of(context).showSnackBar(snackBar);
  }
}
 




