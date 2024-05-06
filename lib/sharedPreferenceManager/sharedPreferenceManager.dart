import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceManager {
  final String authToken = "AccessToken";

  Future<void> getToken(String accessToken) async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(authToken, accessToken);
  }

  Future<String> setToken() async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final savedToken = sharedPreferences.getString(authToken);
    print("savedToken $savedToken");

    return savedToken!;
  }
}
