import 'package:flutter/material.dart';
import 'package:kurriki/module/chat/conversation.dart';
import 'package:kurriki/module/curriculum/topics.dart';


class TopMenu extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return new Row(
      children: <Widget>[
                new PopupMenuButton<String>(
                  // tooltip: "User Settings",
                  padding: EdgeInsets.zero,
                  icon: new Icon(Icons.account_circle),
                  onSelected:(value) async {
                    if (value == "logout")  {
                      // await AuthService().logout();
                      // Navigator.push(context, new MaterialPageRoute(builder: (__) => new LoginPage()));
                      
                    }
                  },
                  itemBuilder: (BuildContext context) => <PopupMenuItem<String>>[
                    const PopupMenuItem<String>(
                      value: 'Profile',
                      child: const Text('Profile')
                    ),
                    const PopupMenuItem<String>(
                      value: 'Settings',
                      child: const Text('Settings')
                    ),
                    const PopupMenuItem<String>(
                      value: 'logout',
                      child: const Text('Logout')
                    ),
                  ],
                ),
                new Icon(Icons.sync),
        ],
    );
  }
}
