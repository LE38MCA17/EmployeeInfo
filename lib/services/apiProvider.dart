import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/api_path_constants.dart';
import 'customException.dart';

class ApiProvider {
  static const int _timeoutDuration = 120; // Timeout duration in seconds

  Future<dynamic> getCall(path) async {
    var responseJson;
    try {

      var requestUrl = ApiNames.API_BASE_URL + path;
      final response = await http.get(Uri.parse(requestUrl), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      }).timeout(Duration(seconds: _timeoutDuration));
      print("response Body ${response.body}  ");
      print("response ${response}  ");
      responseJson = _response(response);
      print('API RESPONSE: $responseJson');
    } on TimeoutException {
      throw FetchDataException('Request timed out. Please try again later.');
    } on Exception {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }


  dynamic _response(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body);
        return responseJson;
      default:
        print('response.body URL: ${response.body}');
        var responseJson = json.decode(response.body);
        return responseJson;
    }
  }
}
