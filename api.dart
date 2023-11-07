import 'package:http/http.dart' as http;

final ApiService apiService = ApiService('https://techtest.youapp.ai');
const String baseUrl = 'https://techtest.youapp.ai';
//Get profile
class ApiService {
  ApiService(baseUrl);
  Future<http.Response> getUsers() async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/getProfile'),
      headers: {
        'x-access-token' : 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY1MmRlYWEyOTBmNGNmNDAxNzk3MTkyOCIsInVzZXJuYW1lIjoicGVwZSIsImVtYWlsIjoicm9uYWxkbyIsImlhdCI6MTY5NzUwOTQ5MiwiZXhwIjoxNjk3NTEzMDkyfQ.dyQBF49MM8RnAlPArQv76Gnvs3_jy1yh86TBHZZFDmY',
      },
    );
    return response;
  }
}

//Login
Future<http.Response> login(String email, String username, String password) async {
  final Uri loginUri = Uri.parse('$baseUrl/api/login');
  final response = await http.post(
    loginUri, body: {
      "email": email,
      "username": username,
      "password": password
    }, // Send user credentials in the request body
  );
  return response;
}

Future<http.Response> register(String email, String username, String password) async {
  final Uri registerUri = Uri.parse('$baseUrl/api/register');
  final response = await http.post(
    registerUri, body: {
    "email": email,
    "username": username,
    "password": password
  }
  );
  return response;
}
