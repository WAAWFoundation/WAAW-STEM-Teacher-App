import 'package:flutter/material.dart';
import 'package:kurriki/shared/theme_data.dart';

class Faq extends StatelessWidget {
  @override
  Widget build (BuildContext context) => new Scaffold(
    // AppBar
    appBar: new AppBar(
      backgroundColor: WaawColors.blue[900],
      title: new Text(
        'Faq', 
        style: new TextStyle(
          fontSize: Theme.of(context).platform == TargetPlatform.iOS ? 17.0 : 20.0,
        ),
      ),
      elevation: Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 4.0,
    ),
    //Content of tabs
    body: new PageView(
      // children: <Widget>[
      //       new Container(color: Colors.red),
      //       new Container(color: Colors.blue),
      //       new Container(color: Colors.grey)
      //     ],
      children: <Widget>[
        new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text('Faq')
          ],
        )
      ],
    ),
      // bottomNavigationBar: new BottomNavigationBar(
      //   items: [
      //     new BottomNavigationBarItem(
      //         icon: new Icon(Icons.add),
      //         title: new Text("trends")
      //     ),
      //     new BottomNavigationBarItem(
      //         icon: new Icon(Icons.location_on),
      //         title: new Text("feed")
      //     ),
      //     new BottomNavigationBarItem(
      //         icon: new Icon(Icons.people),
      //         title: new Text("community")
      //     )
      //   ]
      // ),
    
    
    
    // drawer: new MenuDrawer()
  );
}