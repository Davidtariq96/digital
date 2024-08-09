import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:interspec/random_user_model.dart';
import 'package:interspec/service.dart';

class RandomUserUI extends StatefulWidget {
  const RandomUserUI({Key? key}) : super(key: key);

  @override
  State<RandomUserUI> createState() => _RandomUserUIState();
}

class _RandomUserUIState extends State<RandomUserUI> {
  late Timer _timer;

  @override
  void initState() {
    fetchUser();
    _startPeriodicFetch();
    // TODO: implement initState
    super.initState();
  }
  void _startPeriodicFetch() {
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      fetchUser();
    });
  }
  RandomUser? data;
  Future fetchUser()async{

    final response = await network.get("https://randomuser.me/api/");
    response.data;
    RandomUser randomUser = RandomUser.fromJson(response.data);
    setState(() {
      data = randomUser;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(data?.results?[0].picture?.medium??""),
              ),
              Text("User data",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                margin: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.3)
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildRow(title: "Full name",value: "${data?.results?[0].name?.first ??""} ${data?.results?[0].name?.last ??""}"),
                    const SizedBox(height: 20,),
                    buildRow(title: 'Email', value: data?.results?[0].email??""),
                    const SizedBox(height: 20,),
                    buildRow(title: 'DOB', value: "${data?.results?[0].dob?.date ??""}"),
                    const SizedBox(height: 20,),
                    buildRow(title: 'Phone Number', value: "${data?.results?[0].phone ??""}"),
                  ],
                ),
              )

            ],
          ),
        ),
      ),
    );
  }

  Row buildRow({required String title, required String value}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [Text(title), Text(value)],
    );
  }
}
