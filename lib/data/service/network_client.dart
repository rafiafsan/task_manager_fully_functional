import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:logger/logger.dart';
import 'package:task_manager_fully_functional/app.dart';
import 'package:task_manager_fully_functional/ui/screens/login_screen.dart';
import '../../ui/controllers/auth_controller.dart';

class NetworkResponse {
  final bool isSuccess;
  final int statusCode;
  final Map<String, dynamic>? data;
  final String errorMessage;

  NetworkResponse({
    required this.isSuccess,
    required this.statusCode,
    this.data,
    this.errorMessage = 'Something went wrong.',
  });
}

class NetworkClient {
  static final Logger _logger = Logger();

  static Future<NetworkResponse> getRequest({required String url}) async {
    try {
      Uri uri = Uri.parse(url);
      Map<String,String> headers =  {
        'token': AuthController.token ?? ''
      };
      preRequestLog(url,headers);
      Response response = await get(uri);
      postRequestLog(url, response.statusCode, headers: response.headers,
          responseBody: response.body);

      if (response.statusCode == 200) {
        final decodedJson = jsonDecode(response.body);
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          data: decodedJson,
        );
      } else if(response.statusCode == 401){
        _movedToLoginScreen();
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMessage: 'Un-Authorize user. Please login again.',
        );
      }else {
        final decodedJson = jsonDecode(response.body);
        final errorMessage = decodedJson['data'] ?? 'Something went wrong.';
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMessage: errorMessage,
        );
      }
    } catch (e) {
      postRequestLog(url, -1);
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMessage: e.toString(),
      );
    }
  }

  static Future<NetworkResponse> postRequest(
      {required String url, Map<String, dynamic>? body}) async {
    try {
      Uri uri = Uri.parse(url);
      Map<String,String> headers =  {
        'Content-type': 'Application/json',
        'token': AuthController.token ?? ''
      };
      preRequestLog(url,headers,body: body);
      Response response = await post(uri,
          headers: headers,
          body: jsonEncode(body));
     postRequestLog(url, response.statusCode,headers: response.headers,responseBody: response.body);
      if (response.statusCode == 200) {
        final decodedJson = jsonDecode(response.body);
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          data: decodedJson,
        );
      } else if(response.statusCode == 401){
        _movedToLoginScreen();
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMessage: 'Un-Authorize user. Please login again.',
        );
      }else {
        final decodedJson = jsonDecode(response.body);
        final errorMessage = decodedJson['data'] ?? 'Something went wrong.';
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMessage: errorMessage,
        );
      }
    } catch (e) {
      postRequestLog(url, -1, errorMessage: e.toString(),);
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMessage: e.toString(),
      );
    }
  }

  static void preRequestLog(String url, Map<String,String> headers, {Map<String, dynamic> ?body}){
    _logger.i('URL => $url\n Headers: $headers'
    'Body: $body');
  }
  static void postRequestLog(String url ,int statusCode,
      {Map<String, dynamic> ?headers, dynamic responseBody,dynamic errorMessage}){

    if(errorMessage != null){
      _logger.e(
          'Url : $url\n'
              'Status code : $statusCode\n'
              'Error Message : $errorMessage');
    }else{
      _logger.i(
          'Url : $url\n'
              'Status code : $statusCode\n'
              'Headers : $headers)'
              'Body : $responseBody');
    }
  }

  static Future<void> _movedToLoginScreen () async {
    await AuthController.clearUserData();
    Navigator.pushAndRemoveUntil(
        TaskManager.navigatorKey.currentContext!,
        MaterialPageRoute(builder: (context) => LoginScreen()),
        (predicate) => false);
  }
}
