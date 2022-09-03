import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // backgroundColor: Colors.white,
      body: Column(
        //main axis = y axis in column
        mainAxisAlignment: MainAxisAlignment.center,
       
        children:const [
          Center(
            child: Text(
              'data',
            ),
          ),
        ],
      ),
    );
  }
}
