import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:projet_federe/firebase_options.dart';
import 'package:projet_federe/pages/Etudiant/homepage.dart';
import 'package:projet_federe/providers/authprovider.dart';
import 'package:projet_federe/providers/checkbox.dart';
import 'package:projet_federe/pages/login_page.dart';
import 'package:projet_federe/pages/register_page.dart';
import 'package:projet_federe/providers/textfields_state.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => TextFieldsState()),
      ChangeNotifierProvider(create: (context) => AuthProvider()),
      ChangeNotifierProvider(create: (context) => CheckBoxChanger()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: "login",
        routes: {
          "login": (context) => LoginPage(),
          "register": (context) => RegisterPage(),
          "etudiant": (context) => EtudiantHomePage(),
        });
  }
}
