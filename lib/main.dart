// ignore_for_file: prefer_const_constructors
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'screens/welcome_screen.dart';
import 'screens/login_screen.dart';
import 'screens/registration_screen.dart';
import 'screens/chat_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(FastChat());
}

class FastChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        ChatScreen.id: (context) => ChatScreen(),
      },
    );
  }
}

            // StreamBuilder<QuerySnapshot>(
            //     stream: _firestore.collection('messages').snapshots(),
            //     builder: ((context, AsyncSnapshot<QuerySnapshot> snapshot) {
            //       if (snapshot.hasError) {
            //         return Text('Something went wrong!');
            //       }
            //       if (snapshot.connectionState == ConnectionState.waiting) {
            //         return Text('Loading..');
            //       }
            //       final data = snapshot.requireData;

            //       return ListView.builder(
            //           scrollDirection: Axis.vertical,
            //           shrinkWrap: true,
            //           itemCount: data.size,
            //           itemBuilder: (context, index) {
            //             return Text(
            //                 '${data.docs[index]['text']} by ${data.docs[index]['sender']}.');
            //           });
            //     })),