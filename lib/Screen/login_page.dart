import 'package:app1/Screen/home_page.dart';
import 'package:app1/users.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app1/Designing/button.dart';
import 'package:shared_preferences/shared_preferences.dart';
String finaluser;

class Login_page extends StatefulWidget {
  @override
  _Login_pageState createState() => _Login_pageState();
}

// ignore: camel_case_types
class _Login_pageState extends State<Login_page> {
  String username;
  String password;
  bool _isdisablebutton1;
  bool _isdisablebutton2;
  @override
  void initState(){
    _isdisablebutton1=false;
    _isdisablebutton2=false;
    super.initState();
    belogin();
  }
  void belogin() async{
    final SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    var obtainusername=(sharedPreferences.getBool('login') ?? true);
    print(finaluser);
    if(obtainusername==false){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home_page()),);
    }
  }
  void _check() async{
    if (!mockUsers.containsKey(username)) {
      print("has username error");
    }
    else if (mockUsers[username] != password) {
      print("has password error");
    }
    else{
      final SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
      sharedPreferences.setString('user', username);
      sharedPreferences.setBool('login', false);
      Navigator.push(context, MaterialPageRoute(builder: (context) => Home_page()),);
    }
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Hero(
                tag: 'logo',
                child: Container(

                  child: Image.asset('images/tv.logo.jpg'),
                  height: 100,
                ),
              ),
              SizedBox(
                height: 48,
              ),
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "username"
                ),
                autovalidate: true,
                validator: (String value){
                  if(value.length<3){
                    return "Require more character";
                  }else if(value.length<10){
                    return "Sufficient Length";
                  }else{
                    return "Have exxceed the range";
                  }
                },
                onChanged: (value){
                  setState(() {
                    if(value.length>3 && value.length<11){
                      _isdisablebutton2=true;
                    }
                  });
                  username=value;
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Password",
                  ),
                  autovalidate: true,
                  validator: (String value){
                    if(value.length>3 && value.length<11){
                      return "sufficient length";
                    }else{
                      return "Have exceed the range";
                    }
                  },
                  onChanged: (value){
                    setState(() {
                      if(value.length>3 && value.length<11){
                        _isdisablebutton1=true;
                      }
                    });
                    password=value;
                  },
                ),
              ),
              roundbutton(
                colour: Colors.blueAccent,
                title: "Submit",
                onpressed:_isdisablebutton1 && _isdisablebutton2 ? _check : null,
              )
            ],
          ),
        ),
      ),

    );
  }
}
