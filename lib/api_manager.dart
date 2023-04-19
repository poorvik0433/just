import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:just/user_module.dart';

import 'logger.dart';

const String postApi = "https://jsonplaceholder.typicode.com/posts";

const String getApi = "https://jsonplaceholder.typicode.com/users";

class APIManager {
  static final APIManager singleton = APIManager._internal();

  factory APIManager() {
    return singleton;
  }

  static APIManager API = APIManager();
  APIManager._internal();

  Future postCall(String userEmail, String userName) async {
    const String url = postApi;
    var response = await http
        .post(Uri.parse(url), body: {"email": userEmail, "name": userName});
    return response.body;
  }

  List<UserModel> userList = [];

  Future<List<UserModel>> getCall() async {
    const String url = getApi;
    final response = await http.get(
      Uri.parse(url),
    );
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map<String, dynamic> i in data) {
        print(i['id']);
        print(i['name']);
        print(i['email']);
        userList.add(UserModel.fromJson(i));
      }
      return userList;
    } else {
      throw Exception('Failed to load data from API');
    }
  }

  void postData(String email, String name) async {
    String result = await postCall(email, name);
    return Logger.log(result);
  }

  getData() async {
    List<UserModel> result = await getCall();
    return result;
  }
}
