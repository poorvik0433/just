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

  void postData(String email, String name) async {
    String result = await postCall(email, name);
    Logger.log(result);
  }

  Future getCall(String url) async {
    http.Response response = await http.Client()
        .get(Uri.parse(url))
        .timeout(const Duration(seconds: 10));
    return response.body;
  }

  Future getProductData() async {
    var res = await getCall(getApi);
    return jsonDecode(res);
  }
}
