import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:interspec/random_user.dart';
import 'package:location/location.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ImagePicker imagePicker = ImagePicker();
  File? image;
  String? lat,long;
  LocationPermission? permission;

  void takePhoto()async{
    final file = await imagePicker.pickImage(source: ImageSource.gallery);
    if(file != null){
      File imageFile = File(file.path);
      setState(() {
        image = imageFile;
      });
    }

  }
  void getLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      lat =position.latitude.toString();
      long =position.longitude.toString();
    });
    print("${position.latitude} latitue");
    print(position.longitude);
  }
  @override
  void initState() {
    getLocation();

    // TODO: implement initState
    super.initState();
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        // CircleAvatar(
        //   radius: 90,
        //   backgroundImage: FileImage(image!),
        // )
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            image != null?CircleAvatar(
              radius: 90,
              backgroundImage: FileImage(image!),
            ): CircleAvatar(
              radius: 90,
              child: Icon(Icons.person),
            ),
            SizedBox(height: 40,),

            InkWell(
              onTap: (){
                takePhoto();
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 20,horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.blue
                ),
                child: Text("Take a photo"),
              ),
            ),
            const SizedBox(height: 20,),
            lat ==null? CupertinoActivityIndicator(): Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Lat: ",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                Text(lat!,style: TextStyle(color: Colors.black,fontWeight: FontWeight.w300)),
              ],
            ),
            SizedBox(height: 10,),
            long ==null? CupertinoActivityIndicator(): Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Lng: ",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                Text(long?? "Access denied",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w300)),
              ],
            ),
            SizedBox(height: 20,),
            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> RandomUserUI()));
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.blueGrey,
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Text("Please click task 2"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
