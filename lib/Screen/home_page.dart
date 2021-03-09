import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app1/Screen/list_view.dart';


Size displaySize(BuildContext context) {
  debugPrint('Size = ' + MediaQuery.of(context).size.toString());
  return MediaQuery.of(context).size;
}

double displayHeight(BuildContext context) {
  debugPrint('Height = ' + displaySize(context).height.toString());
  return displaySize(context).height;
}

double displayWidth(BuildContext context) {
  debugPrint('Width = ' + displaySize(context).width.toString());
  return displaySize(context).width;
}

class Home_page extends StatefulWidget {
  @override
  _Home_pageState createState() => _Home_pageState();
}

class _Home_pageState extends State<Home_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.filter_list,
              color: Colors.white,
            ),
            onPressed: (){
              //to do if u want
            },
          )
        ],
        title: Center(child: Text("simon baker")),
      ),
      body: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 20,top: 20),
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.lime,
                ),
              ),
              Text("NAME")
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 10,top: 20),
                width: displayWidth(context)*0.33-10,
                height: 100,
                color: Colors.orange,
              ),
              Container(
                margin: EdgeInsets.only(left: 10,top: 20),
                width: displayWidth(context)*0.33-10,
                height: 100,
                color: Colors.purple,
              ),
              Container(
                margin: EdgeInsets.only(left: 10,top: 20),
                width: displayWidth(context)*0.33-10,
                height: 100,
                color: Colors.deepOrange,
              ),
            ],
          ),
          Expanded(
            child:List_view(),
          )
        ],
      ),
    );
  }
}
