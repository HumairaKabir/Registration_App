import 'package:dio/dio.dart';
import 'package:untitled3/regScreen.dart';
import 'loginScreen.dart';

class ApiClient {
  final Dio _dio = Dio();

  Future<Response> RegScreen() async {
    //IMPLEMENT USER REGISTRATION
  }

  Future<Response> LoginScreen() async {
    //IMPLEMENT USER LOGIN
  }

  Future<Response> getUserProfileData() async {
    //GET USER PROFILE DATA
  }

  Future<Response> logout() async {
    //IMPLEMENT USER LOGOUT
  }

  Future<Response> registerUser(Map<String, dynamic>? userData) async {
    try {
     Response response = await _dio.post(
      'https://api.loginradius.com/identity/v2/auth/register',
         //ENDPONT URL
       data: userData,
         //REQUEST BODY
       queryParameters: {'apikey': 'YOUR_API_KEY'},
         //QUERY PARAMETERS
       options: Options(headers: {'X-LoginRadius-Sott': 'YOUR_SOTT_KEY',
         //HEADERS
       }));
     //returns the successful json object
    return response.data;
    }
    on DioError catch (e) {
      //returns the error object if there is
      return e.response!.data;
      }
    }
  Future<Response> login(String email, String password) async {
    try {
      Response response = await _dio.post(
        'https://api.loginradius.com/identity/v2/auth/login',
        data: {
          'email': email,
          'password': password
        },
        queryParameters: {'apikey': 'YOUR_API_KEY'},
      );
      //returns the successful user data json object
    return response.data;
    }
    on DioError catch (e) {
      //returns the error object if any
      return e.response!.data;
    }
  }
}