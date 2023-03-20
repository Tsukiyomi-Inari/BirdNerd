///*
/// @author:   Katherine Bellman, Russell Waring
/// @version:  1
/// @since:    2023-03-10
import 'dart:io';

import 'package:birdnerd/model/birds.dart';
import 'package:birdnerd/screens/wrapper.dart';
import 'package:birdnerd/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';
import 'model/user_model.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MultiProvider(
        providers:[
          ChangeNotifierProvider.value(
            value: Birds(),
          ),
          StreamProvider<UserModel?>.value(
              initialData: null,
              value: AuthService().onAuthStateChanged,
              builder: (context, snapshot) {
                return  MaterialApp(
                  //debugShowCheckedModeBanner: false,
                  title: 'Bird Nerd',
                  theme: ThemeData(
                    buttonTheme: ButtonTheme.of(context).copyWith(
                      buttonColor: Colors.teal,
                      textTheme: ButtonTextTheme.primary,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    ), colorScheme: ColorScheme.fromSwatch(
                        primarySwatch: Colors.teal).copyWith(
                        background: Colors.white).copyWith(secondary: Colors.tealAccent)
                  ),
                  home: const Wrapper(),
                );
              }
          )
        ]
    )
      ;
  }
}