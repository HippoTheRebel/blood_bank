import 'dart:convert';

import 'package:blood_transfusion_register/model/login_response_model.dart';
import 'package:blood_transfusion_register/utils/session.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constants/constants.dart';

class AuthRepository {
  Future<void> login({
    required String email,
    required String password,
    required void Function(LoginResponseModel) successCallback,
    required void Function() failedCallback,
    bool login = true, // sign in -> false
  }) async {
    final response = await Session.postJson(
      '$kBaseUrl/${login ? 'login' : 'signup'}',
      {
        'Name': '',
        'Password': password,
        'Email': email,
      },
      withToken: false,
    );
    if (response.statusCode == 200) {
      final data = LoginResponseModel.fromJson(jsonDecode(response.body));
      successCallback(data);
    } else {
      failedCallback();
    }
  }
}

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository();
});

final sIdProvider = StateProvider<String>((ref) {
  return '';
});

final emailProvider = StateProvider<String>((ref) {
  return '';
});
