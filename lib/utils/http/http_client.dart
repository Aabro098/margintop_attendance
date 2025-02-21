import 'dart:convert';

import 'package:http/http.dart' as http;

class HttpHelper {
  HttpHelper._();
  //* Using http package as helper function

  static const String _baseUrl = 'http://example.com';

  // TODO: Create GET method
  static Future<Map<String, dynamic>> get(String endPoint) async {
    final response = await http.get(Uri.parse('$_baseUrl/$endPoint'));
    return _handleResponse(response);
  }

  // TODO: Create POST method
  static Future<Map<String, dynamic>> post(
      String endPoint, dynamic data) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/$endPoint'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(data),
    );

    return _handleResponse(response);
  }

  // TODO: Create PUT method
  static Future<Map<String, dynamic>> put(String endPoint, dynamic data) async {
    final response = await http.put(
      Uri.parse('$_baseUrl/$endPoint'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(data),
    );

    return _handleResponse(response);
  }

  // TODO: Create DELETE method
  static Future<Map<String, dynamic>> delete(String endPoint) async {
    final response = await http.delete(Uri.parse('$_baseUrl/$endPoint'));
    return _handleResponse(response);
  }

  // TODO: Create method for handling the response
  static Map<String, dynamic> _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      //Success response
      return jsonDecode(response.body);
    } else {
      //Failure response
      throw Exception('Failed to fetch data from the server.');
    }
  }
}
