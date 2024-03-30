import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:projet_federe/firebase_options.dart';
import 'package:projet_federe/pages/Etudiant/homepage.dart';
import 'package:projet_federe/pages/landlord/home_page.dart';
import 'package:projet_federe/pages/landlord/post.dart';
import 'package:projet_federe/pages/landlord/profile_ui.dart';
import 'package:projet_federe/pages/reset_password.dart';
import 'package:projet_federe/services/auth/auth_gate.dart';
import 'package:projet_federe/services/auth/login_or_signup.dart';
import 'package:projet_federe/stateManagement/checkbox.dart';
import 'package:projet_federe/stateManagement/home_state.dart';
import 'package:projet_federe/stateManagement/search_state.dart';
import 'package:provider/provider.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MultiProvider(
    providers: [
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
        initialRoute: "auth_gate",
        routes: {
          "auth_gate":(context) => const AuthGate(),
          "login_or_signup": (context) => const LoginOrRegister(),
          "etudiant": (context) => EtudiantHomePage(),
          "reset":(context)=> ResetPassword(),
          "landlord":(context) =>LandLordHomePage(), 
          "profile":(context)=>const Profile(),
          "post":(context)=> Post(),
        });
  }
}
