import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:memory_book/Pages/dashboard_memorys_page.dart';
import 'package:memory_book/Pages/login_page.dart';
import 'package:memory_book/Pages/recovery_page.dart';
import 'package:memory_book/Provider/auth_provider.dart';
import 'package:memory_book/Service/memory_service.dart';
import 'package:memory_book/routes.dart';
import 'package:provider/provider.dart';
import 'Pages/form_memory_page.dart';
import 'Pages/only_memory_page.dart';
import 'Pages/register_page.dart';
import 'Provider/memory_provider.dart';
import 'firebase_options.dart';
import 'package:google_maps_flutter_android/google_maps_flutter_android.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';

void main() async{
  //garante que o binding do flutter esteja inicializado
  WidgetsFlutterBinding.ensureInitialized();
  //garante a inicialização do firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const App());
}
class App extends StatelessWidget {
  const App({super.key});


  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(create: (context)=>AuthProvider()),
        ChangeNotifierProvider<MemoryProvider>(create: (context)=>MemoryProvider(MemoryService())),
      ],
      child:MaterialApp(
      title: 'Memory book',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent),
      ),
      //home: const MyHomePage(title: 'Flutter Demo Home Page'),
      routes: {
        Routes.LOGIN: (context) => LoginPage(),
        Routes.REGISTER: (context) => RegisterPage(),
        Routes.DASHBOARD: (context) => DashboardMemorysPage(),
        Routes.FORGOT_PASSWORD: (context) => RecoveryPage(),
        Routes.FORM_MEMORY: (context)=> FormMemoryPage(),
        Routes.ONLY_MEMORY: (context)=> OnlyMemoryPage(),
      },
     ),
    );
  }
}


