import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

final navigatorKey = GlobalKey<NavigatorState>();

class Session {
  static void _unauthenticatedState(SharedPreferences prefs, String error) {
    for (final i in prefs.getKeys()) {
      prefs.remove(i);
    }
  }

  static const tokenKey = 'token_key';

  static Future<http.Response> get(String url) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var token = prefs.getString(tokenKey).toString();
    log('token in api - $token');
    var response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': token,
      },
    );

    if (response.statusCode == 401) {
      _unauthenticatedState(prefs, jsonDecode(response.body)['message']);
    }
    return response;
  }

  static Future<http.Response> postJson(
    String url,
    Map<String, dynamic>? body, {
    bool withToken = true,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(tokenKey).toString();

    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        if (withToken) 'token': 'JWT $token',
      },
      body: body != null ? jsonEncode(body) : null,
    );
    if (response.statusCode == 401) {
      _unauthenticatedState(prefs, jsonDecode(response.body)['msg']);
    }
    return response;
  }
}
