
import 'dart:convert';

import 'package:covid_19_tracker_app/Utilities/app_urls.dart';
import 'package:covid_19_tracker_app/model/WordlStatesModel.dart';
import 'package:http/http.dart' as http;

class StateServices {
  Future<WordlStatesModel> fetchWorldStatesRecord() async{
    var data;
    final response = await http.get(Uri.parse(AppUrls.worldStatesApi));
     if(response.statusCode == 200){
       data = jsonDecode(response.body.toString());
       return  WordlStatesModel.fromJson(data);
     }else{
       throw Exception('Error');
     }
  }
  Future<List<dynamic>> fetchCountryRecord() async{
    var data;
    final response = await http.get(Uri.parse(AppUrls.countriesList));
     if(response.statusCode == 200){
       data = jsonDecode(response.body.toString());
       return  data;
     }else{
       throw Exception('Error');
     }
  }
}