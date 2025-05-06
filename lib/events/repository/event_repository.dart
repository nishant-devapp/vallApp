import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vallassignment/utils/constants/api_key.dart';
import 'package:vallassignment/utils/constants/app_urls.dart';
import 'package:vallassignment/utils/constants/project_id.dart';

import '../models/fetch_events_model.dart';

class EventsRepository{
  final String apiKey = ApiKey.apiKey;
  final String projectId = ProjectId.projectId;


  Future<FetchEventsModel> fetchEvents() async {
    final prefs = await SharedPreferences.getInstance();
    final idToken = prefs.getString('idToken') ?? false;

   // print(idToken);
    final url = AppUrl.getEventsBaseUrl;

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $idToken',
        'Content-Type': 'application/json',
      },
    );

   // print(response.body);
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
     // print(body);
      return FetchEventsModel.fromJson(body);
    } else {
      throw Exception('Failed to fetch events: ${response.body}');
    }
  }


  Future<void> bookSlot({required String eventId}) async {
    final prefs = await SharedPreferences.getInstance();
    final idToken = prefs.getString('idToken');
    final localId = prefs.getString('localId');

    if (idToken == null || localId == null) {
      throw Exception('User not authenticated');
    }

    final documentPath =
        'projects/$projectId/databases/(default)/documents/Events/$eventId';

    final url =
        'https://firestore.googleapis.com/v1/projects/$projectId/databases/(default)/documents:commit';

    final requestBody = {
      "writes": [
        {
          "transform": {
            "document": documentPath,
            "fieldTransforms": [
              {
                "fieldPath": "bookedUsers",
                "appendMissingElements": {
                  "values": [
                    {"stringValue": localId}
                  ]
                }
              },
              {
                "fieldPath": "totalBookedCount",
                "increment": {"integerValue": 1}
              }
            ]
          }
        }
      ]
    };

    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $idToken',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(requestBody),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to book slot: ${response.body}');
    }
  }


  Future<void> cancelSlot({required String eventId}) async {
    final prefs = await SharedPreferences.getInstance();
    final idToken = prefs.getString('idToken');
    final localId = prefs.getString('localId');

    if (idToken == null || localId == null) {
      throw Exception('User not authenticated');
    }

    final documentPath =
        'projects/$projectId/databases/(default)/documents/Events/$eventId';

    final url =
        'https://firestore.googleapis.com/v1/projects/$projectId/databases/(default)/documents:commit';

    final requestBody = {
      "writes": [
        {
          "transform": {
            "document": documentPath,
            "fieldTransforms": [
              {
                "fieldPath": "bookedUsers",
                "removeAllFromArray": {
                  "values": [
                    {"stringValue": localId}
                  ]
                }
              },
              {
                "fieldPath": "totalBookedCount",
                "increment": {"integerValue": -1}
              }
            ]
          }
        }
      ]
    };

    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $idToken',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(requestBody),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to cancel slot: ${response.body}');
    }
  }

}