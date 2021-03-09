import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:app1/Api_logic/modelling.dart';
const url='http://tournaments-dot-game-tv-prod.uc.r.appspot.com/tournament/api/tournaments_list_v2?limit=10&status=all&cursor=CmMKGQoMcmVnX2VuZF9kYXRlEgkIgLTH_rqS7AISQmoOc35nYW1lLXR2LXByb2RyMAsSClRvdXJuYW1lbnQiIDIxMDQ5NzU3N2UwOTRmMTU4MWExMDUzODEwMDE3NWYyDBgAIAE=';
class Restapi{
  List<Tournament> parsetournament(String responsebody){
    final parsed=jsonDecode(responsebody).cast<Map<String, dynamic>>();
    return parsed.map<Tournament>((json) => Tournament.fromJson(json)).toList();
  }
  Future<List<Tournament>> fetchdata(http.Client client) async{
    final response=await client.get(url);
    return compute(parsetournament,response.body);
  }

}





