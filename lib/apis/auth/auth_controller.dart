import 'package:blood_transfusion_register/apis/auth/auth_repository.dart';
import 'package:blood_transfusion_register/constants/constants.dart';
import 'package:blood_transfusion_register/reusable_content/show_common_snackbar.dart';
import 'package:blood_transfusion_register/utils/session.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../home_page.dart';
import '../../model/login_response_model.dart';

class AuthController extends StateNotifier<AsyncValue<void>> {
  AuthController(this.ref) : super(const AsyncData(null));
  final Ref ref;

  void _succssCallback({
    required String token,
    required String userEmail,
    required String sId,
  }) async {
    final sharePrefs = await SharedPreferences.getInstance();
    await sharePrefs.setString(Session.tokenKey, token);
    await sharePrefs.setString(sidKey, sId);
    await sharePrefs.setString(emailKey, userEmail);

    ref.read(sIdProvider.notifier).state = sId;
    ref.read(emailProvider.notifier).state = userEmail;

    Navigator.pushAndRemoveUntil(
      navigatorKey.currentContext!,
      MaterialPageRoute(
        builder: (_) => const MyHomePage(),
      ),
      (_) => false,
    );
  }

  void _failedCallback() {
    showCommonSnackBar(
      message: 'Invalid Credentials',
      bgColor: Colors.red,
    );
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    state = const AsyncLoading();
    await ref.read(authRepositoryProvider).login(
          email: email,
          password: password,
          successCallback: (data) {
            state = const AsyncData(null);
            _succssCallback(
              token: data.data!.token!,
              userEmail: email,
              sId: data.data!.sId ?? '-',
            );
          },
          failedCallback: () {
            state = const AsyncError('error', StackTrace.empty);
            _failedCallback();
          },
        );
  }

  Future<void> signUp({
    required String email,
    required String password,
  }) async {
    state = const AsyncLoading();
    await ref.read(authRepositoryProvider).login(
          email: email,
          password: password,
          successCallback: (data) {
            state = const AsyncData(null);
            _succssCallback(
              token: data.data!.token!,
              userEmail: email,
              sId: data.data!.sId ?? '-',
            );
          },
          failedCallback: () {
            state = const AsyncError('error', StackTrace.empty);
            _failedCallback();
          },
          login: false,
        );
  }
}

final authControllerProvider = StateNotifierProvider<AuthController, AsyncValue<void>>(
  (ref) {
    return AuthController(ref);
  },
);

final userNameProvider = StateProvider<String?>((ref) {
  return null;
});
