import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:insta/Provider/user_provider.dart';
import 'package:insta/Util/Color/custom_color.dart';
import 'package:insta/View/Screen/Auth/Login/login_screen.dart';
import 'package:provider/provider.dart';

import 'Util/Widgets/LayOut/mobile_screen_layout.dart';
import 'Util/Widgets/LayOut/responsive_layout_.dart';
import 'Util/Widgets/LayOut/web_screen_lauout.dart';
import 'firebase_options.dart';

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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
          
        ),

      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: CustomColor.mobileBackGroundColor,
        ),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
// Checking if the snapshot has any data or not
              if (snapshot.hasData) {
                // if snapshot has data which means user is logged in then we check the width of screen and accordingly display the screen layout
                const ResponsiveLayOut(
                  mobileScreenLayOut: MobileScreenLayOut(),
                  webScreenLayOut: WebScreenLayout(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('${snapshot.hasError}'),
                );
              }
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: CustomColor.primaryColor,
                ),
              );
            }
            return const LoginScreen();
          },
        ),

//      const LoginScreen(),
      ),
    );
  }
}




// if(kIsWeb){
//   await FirebaseOptions.initializeApp(
//     options:FirebseOptions(
//     apiKey: "AIzaSyD3MOuYanGc2OZlcrRz2S5fXpL1DLXIdC0",
//   authDomain: "insta-fe761.firebaseapp.com",
//   projectId: "insta-fe761",
//   storageBucket: "insta-fe761.appspot.com",
//   messagingSenderId: "485795396235",
//   appId: "1:485795396235:web:242f5177929e1912e7f28e"
//     ));