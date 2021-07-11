import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/src/services/text_input.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit() : super(AuthenticationState(data: null));

  Future<void> signInPostRequest(String email, String password) async {
    final url = Uri.parse('http://18.193.7.235:8000/accounts/login/');
    final headers = {"Content-type": "application/json"};
    final json = jsonEncode({"username": email, "password": password});

    final response = await post(url, headers: headers, body: json);
    Map signInData = jsonDecode(response.body);
    print(signInData);

    print('Status code: ${response.statusCode}');
    print('Body: ${response.body}');

    emit(AuthenticationState(data: signInData));
  }

  Future<void> signUpPostRequest(
      String fullName, String email2, String password2) async {
    final url = Uri.parse('http://18.193.7.235:8000/accounts/register/');
    final headers = {"Content-type": "application/json"};
    final body = {
      "first_name": fullName,
      "last_name": "a",
      "email": email2,
      "password": password2,
      "is_teacher": true
    };

    final response = await post(url, headers: headers, body: jsonEncode(body));
    Map signUpData = jsonDecode(response.body);
    print(signUpData);

    print('Status code2: ${response.statusCode}');
    print('Body2: ${response.body}');

    emit(AuthenticationState(data: signUpData));
  }
}
