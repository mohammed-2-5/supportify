import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class NotfiScreen extends StatefulWidget {
   NotfiScreen({Key? key}) : super(key: key);

  @override
  State<NotfiScreen> createState() => _NotfiScreenState();
}

class _NotfiScreenState extends State<NotfiScreen> {


    getToken()async{

      String? mytoken = await FirebaseMessaging.instance.getToken();
      print("=====================================");
      print(mytoken);

    }

    myrequestpermission()async{
      FirebaseMessaging messaging = FirebaseMessaging.instance;

      NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );

      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        print('User granted permission');
      } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
        print('User granted provisional permission');
      } else {
        print('User declined or has not accepted permission');
      }
    }

    @override
  void initState() {
      myrequestpermission();
      getToken();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text('Notfication',style: TextStyle(color: Colors.black),),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        backgroundColor: Colors.white,
       );
  }
}
