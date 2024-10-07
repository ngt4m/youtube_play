import 'package:flutter/material.dart';
import 'package:flutter_application_2/home_page.dart';
import 'package:flutter_application_2/provider/recently_provider.dart';
import 'package:flutter_application_2/service/video_api.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=>YouTubeService()),
        ChangeNotifierProvider(create: (_)=>RecentlyProvider())
      ],
    
child: MyApp(),

    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Music App',
      home: HomePage(),
    );
  }
}
