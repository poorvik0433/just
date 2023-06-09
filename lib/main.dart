import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:just/logger.dart';
import 'package:just/user_module.dart';
import 'api_manager.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PostAPI(),
    );
  }
}

class PostAPI extends StatefulWidget {
  const PostAPI({super.key});

  @override
  State<PostAPI> createState() => _PostAPIState();
}

class _PostAPIState extends State<PostAPI> {
  @override
  void initState() {
    userResponse();
    super.initState();
  }

  TextEditingController myEmailController = TextEditingController();
  TextEditingController myNameController = TextEditingController();
  List<UserModel> apiResponse = [];

  Future<void> userResponse() async {
    APIManager.API.getProductData().then((response) {
      if (true) {
        var data = response;
        for (Map<String, dynamic> i in data) {
          apiResponse.add(UserModel.fromJson(i));
        }
      }
    }).catchError((er) {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('API calls')),
        body: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Container(
              height: 50,
              width: 400,
              child: TextField(
                controller: myEmailController,
                decoration: const InputDecoration(
                  hintText: 'Enter your email',
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              height: 50,
              width: 400,
              child: TextField(
                controller: myNameController,
                decoration: InputDecoration(
                  hintText: 'Enter your name',
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  APIManager.API
                      .postData(myEmailController.text, myNameController.text);
                },
                child: Text("Display"),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      userResponse();
                      setState(() {});
                    },
                    child: Text("GET API")),
                SizedBox(
                  height: 50,
                ),
                ElevatedButton(
                  onPressed: () {
                    apiResponse = [];
                    setState(() {});
                  },
                  child: Text("Clear"),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Container(
                width: 400,
                height: 400,
                decoration: BoxDecoration(
                  border: Border.all(width: 1),
                ),
                child: Expanded(
                  child: apiResponse.isEmpty
                      ? Center(child: Text("Click Get API Button"))
                      : ListView.builder(
                          itemCount: apiResponse.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Text(apiResponse[index].name.toString()),
                                Text(apiResponse[index].email.toString()),
                                Text(apiResponse[index]
                                    .address!
                                    .city
                                    .toString()),
                                Text(
                                    "------------------------------------------------------------------"),
                              ],
                            );
                          }),
                ),
              ),
            ),
          ],
        ));
  }
}
