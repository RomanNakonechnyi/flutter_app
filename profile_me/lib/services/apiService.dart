import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:profile_me/models/SynonymModel.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static ApiService _instance;
  static Future<ApiService> getInstance() async {
    if (_instance == null) {
      _instance = ApiService();
    }
    return _instance;
  }
  Client _client;

  ApiService(){
    _client = http.Client();
  }
  final Map<String,String> _headers = {
    'x-rapidapi-host':'wordsapiv1.p.rapidapi.com',
    'x-rapidapi-key':API_KEY
  };

  final String host = "https://wordsapiv1.p.rapidapi.com/words/";
  static const String API_KEY = "YOUR_API_KEY";
  final String synonymsUrl = "/synonyms";

  Future<SynonymModel> getSynonyms(String word)async{
    try{
      Response response = await _client.get("$host$word$synonymsUrl",
          headers: _headers);
      var result;
      if(response.statusCode == 200){
        result = SynonymModel.fromJson(jsonDecode(response.body));
      }
      return result;
    }finally{
    }
  }
}