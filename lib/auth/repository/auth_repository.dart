import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:vallassignment/auth/models/login_response_model.dart';
import 'package:vallassignment/auth/models/signup_response_model.dart';
import 'package:vallassignment/utils/constants/api_key.dart';
import 'package:vallassignment/utils/constants/app_urls.dart';
import 'package:vallassignment/utils/constants/project_id.dart';

class AuthRepository {
  final String apiKey = ApiKey.apiKey;
  final String projectId = ProjectId.projectId;

  Future<String> signUpUser(String name, String email, String password) async {
    final baseUrl = '${AppUrl.authBaseUrl}signUp';

    final queryParameters = {'key': apiKey};

    final url = Uri.parse(baseUrl).replace(queryParameters: queryParameters);

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "email": email,
        "password": password,
        "returnSecureToken": false,
      }),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      print('Sign Up User Response below');

      print(data);

      final localId = SignUpResponseModel.fromJson(data).localId;
      print(localId);

      await addUserData(name, email, localId!);

      return localId;

    } else {
      print('Failed to sign up: ${response.body}');
      throw Exception('Failed to sign up');
    }
  }

  Future<void> addUserData(String name, String email, String localId) async {
    final baseUrl = AppUrl.saveUserDataUrl + localId;

    final url = Uri.parse(baseUrl);

    final body = {
      "fields": {
        "name": {"stringValue": name},
        "email": {"stringValue": email},
        "uid": {"stringValue": localId},
      }
    };

    final response = await http.patch(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );

    print('Add User Response below');
    print(response.body);

    if (response.statusCode != 200) {
      throw Exception("Failed to save user data: ${response.body}");
    }

  }

  Future<LoginResponseModel> loginUser(String email, String password) async {
    final baseUrl = '${AppUrl.authBaseUrl}signInWithPassword';

    final queryParameters = {'key': apiKey};

    final url = Uri.parse(baseUrl).replace(queryParameters: queryParameters);

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "email": email,
        "password": password,
        "returnSecureToken": true,
      }),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      //print(data);
      return LoginResponseModel.fromJson(data);
    } else {
     // print('Failed to fetch event: ${response.body}');
      throw Exception('Failed to fetch event');
    }
  }

}
