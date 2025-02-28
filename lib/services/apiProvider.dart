import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../constants/api_path_constants.dart';
import 'customException.dart';

class ApiProvider {
  static const int _timeoutDuration = 120;

  Future<dynamic> getCall1(path,context) async {
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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("No Internet connection"),
          duration: const Duration(seconds: 2),
          backgroundColor: Colors.red,
        ),
      );
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> getCall(String path, BuildContext context) async {
    var responseJson;
    try {
      var requestUrl = ApiNames.API_BASE_URL + path;
      print("Requesting: $requestUrl");

      final response = await http.get(Uri.parse(requestUrl), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      }).timeout(Duration(seconds: _timeoutDuration));

      print("Response Body: ${response.body}");
      print("Response Status: ${response.statusCode}");

      responseJson = _response(response);
      print('API RESPONSE: $responseJson');

    } on TimeoutException {
      print("Request timed out");
      throw FetchDataException('Request timed out. Please try again later.');
    } on SocketException catch (e) {
      print("Network Error: $e");  // Logs actual error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("No Internet connection"),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.red,
        ),
      );
      throw FetchDataException('No Internet connection');
    } on HttpException catch (e) {
      print("HTTP Error: $e");
      throw FetchDataException('HTTP error occurred.');
    } on FormatException catch (e) {
      print("Invalid Response Format: $e");
      throw FetchDataException('Invalid response format.');
    } catch (e) {
      print("Unexpected Error: $e");
      throw FetchDataException('Something went wrong: $e');
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
