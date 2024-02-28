import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:projet_federe/firebase_options.dart';
import 'package:projet_federe/pages/Etudiant/homepage.dart';
import 'package:projet_federe/pages/reset_password.dart';
import 'package:projet_federe/stateManagement/authprovider.dart';
import 'package:projet_federe/stateManagement/checkbox.dart';
import 'package:projet_federe/pages/login_page.dart';
import 'package:projet_federe/pages/register_page.dart';
import 'package:projet_federe/stateManagement/home_state.dart';
import 'package:projet_federe/stateManagement/search_state.dart';
import 'package:projet_federe/stateManagement/textfields_state.dart';
import 'package:provider/provider.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => TextFieldsState()),
      ChangeNotifierProvider(create: (context) => AuthProvider()),
      ChangeNotifierProvider(create: (context) => CheckBoxChanger()),
      ChangeNotifierProvider(create: (context)=>HomeState()),
      ChangeNotifierProvider(create: (context)=>SearchTextProvider())
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
          "reset":(context)=>const resetPassword(),
        });
  }
}
