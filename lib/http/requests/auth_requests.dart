import "package:http/http.dart" as http;
import "dart:convert";
import "../models/response_models.dart";
import "../models/request_models.dart";

final String baseUrl = "http://127.0.0.1:8000";

Future<LoginResponse?> loginReq(LoginModel loginData) async {
  try {
    final url = Uri.parse('$baseUrl/auth/login');
    final res = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(loginData.toJson()),
    );

    if (res.statusCode == 200) {
      // Deserialize JSON into LoginResponse
      final data = jsonDecode(res.body);
      return LoginResponse.fromJson(data);
    } else {
      return null; // Explicitly return null on failure
    }
  } catch (err) {
    return null; // Explicitly return null on exception
  }
}
