import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:app1/Api_logic/modelling.dart';
import 'package:http/http.dart' as http;
const url='http://tournaments-dot-game-tv-prod.uc.r.appspot.com/tournament/api/tournaments_list_v2?limit=10&status=all&cursor=CmMKGQoMcmVnX2VuZF9kYXRlEgkIgLTH_rqS7AISQmoOc35nYW1lLXR2LXByb2RyMAsSClRvdXJuYW1lbnQiIDIxMDQ5NzU3N2UwOTRmMTU4MWExMDUzODEwMDE3NWYyDBgAIAE=';


class List_view extends StatefulWidget {
  @override
  _List_viewState createState() => _List_viewState();
}

class _List_viewState extends State<List_view> {
  List<Tournament> parsetournament(String responsebody){
    final parsed=jsonDecode(responsebody).cast<Map<String, dynamic>>();
    return parsed.map<Tournament>((json) => Tournament.fromJson(json)).toList();
  }
  Future<List<Tournament>> fetchdata(http.Client client) async{
    final response=await client.get(url);
    return compute(parsetournament,response.body);
  }
  @override

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 10,right: 10,left: 10),
        child: FutureBuilder<List<Tournament>>(
          future: fetchdata(http.Client()),
          builder: (context, snapshot){
            if(snapshot.hasError) print(snapshot.error);
            return snapshot.hasData ? TournamentList(tournaments : snapshot.data) :Center(child: CircularProgressIndicator());
          },
        )
      )
    );
  }
}

class TournamentList extends StatelessWidget {
  final List<Tournament> tournaments;
  TournamentList({Key key,this.tournaments}) : super(key:key);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: tournaments.length,
        itemBuilder: (context,index){
      return Text((tournaments[index].startDate).toString());
    });
  }
}

