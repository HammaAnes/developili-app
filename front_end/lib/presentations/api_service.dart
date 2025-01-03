import 'dart:convert';
import 'package:http/http.dart' as http;

class APIService {
  static const String baseUrl = "http://127.0.0.1:8000";

  static Future<Map<String, dynamic>> submitAnswer(
      int userId, int questionId, String response, String djangoApp, String other) async {
    final url = Uri.parse("$baseUrl/$djangoApp/");
    final headers = {"Content-Type": "application/json"};
    final body = jsonEncode({
      "user_id": userId,
      "question_id": questionId,
      "response": response,
      "other_response": other,
    });

    try {
      final http.Response res =
          await http.post(url, headers: headers, body: body);

      if (res.statusCode == 201) {
        return {"success": true, "data": jsonDecode(res.body)};
      } else {
        return {"success": false, "error": jsonDecode(res.body)};
      }
    } catch (e) {
      return {"success": false, "error": e.toString()};
    }
  }

  static Future<Map<String, dynamic>> deleteAnswer(
      int userId, int questionId, String djangoApp) async {
    final url = Uri.parse("$baseUrl/$djangoApp/BackButtonPressed/");
    final headers = {"Content-Type": "application/json"};
    final body = jsonEncode({
      "user": userId,
      "question": questionId,
    });

    try {
      final http.Response res =
          await http.post(url, headers: headers, body: body);

      if (res.statusCode == 200) {
        return {"success": true, "data": jsonDecode(res.body)};
      } else {
        return {"success": false, "error": jsonDecode(res.body)};
      }
    } catch (e) {
      return {"success": false, "error": e.toString()};
    }
  }

  static Future<Map<String, dynamic>> devPrevProjct(
      int userId, String project_name, String dev_spec) async {
    final url = Uri.parse("$baseUrl/handle_questions/DevPreviousProject/");
    final headers = {"Content-Type": "application/json"};
    final body = jsonEncode({
      "user_id": userId,
      "project_name": project_name,
      "dev_speciality": dev_spec,
    });

    try {
      final http.Response res =
          await http.post(url, headers: headers, body: body);

      if (res.statusCode == 201) {
        return {"success": true, "data": jsonDecode(res.body)};
      } else {
        return {"success": false, "error": jsonDecode(res.body)};
      }
    } catch (e) {
      return {"success": false, "error": e.toString()};
    }
  }

}
