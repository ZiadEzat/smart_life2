import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:smart_life/model/ip_model.dart';
import 'package:smart_life/model/user_model.dart';
import 'package:smart_life/services/face_provider.dart';
import 'package:smart_life/views/login_screen.dart';
// import 'package:smart_life/views/faceid.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://dljrtruzmwajipctksnq.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImRsanJ0cnV6bXdhamlwY3Rrc25xIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDQ1NDQ4NTksImV4cCI6MjA2MDEyMDg1OX0.f6T3rLUKLCzOOYyXxSIkw0U2jL1wIVTlwecnnawfKSM',
  );

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => UserModel()),
    ChangeNotifierProvider(create: (context) => IpModel()),
  ], child: const MainApp()));

  final supabase = Supabase.instance.client;

  supabase.auth.onAuthStateChange.listen((data){

    print(data);

  });


}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.transparent,
        primaryColor: Colors.white,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Colors.white,
          secondary: const Color(0XFF6750A4),
        ),
      ),
      home: const LoginScreen(),
    );
  }
}
