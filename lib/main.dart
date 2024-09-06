import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zartek_task/feature/home/presentation/pages/home_page.dart';
import 'feature/auth/presentation/bloc/auth_bloc.dart';
import 'feature/auth/presentation/pages/login_page.dart';
import 'feature/home/presentation/bloc/home_bloc.dart';
import 'firebase_options.dart';
import 'init_dependencies.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initDependencies();
  runApp(MultiBlocProvider(providers: [
    BlocProvider(
      create: (_) => serviceLocator<AuthBloc>(),
    ),
    BlocProvider(
      create: (_) => serviceLocator<HomeBloc>(),
    ),
  ],
  child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Zartek Food Order App',
      theme: ThemeData(


      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key,});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  keepLogin() async {
    final SharedPreferences local=await SharedPreferences.getInstance();
    String? userId=local.getString("uid");
    String? userData=local.getString("data");



    if(userId==null){
      Navigator.pushAndRemoveUntil(context, CupertinoPageRoute(builder: (context) => const LoginPage(),), (route) => false);
    }
    else{
      Navigator.pushAndRemoveUntil(context, CupertinoPageRoute(builder: (context) =>  HomePage(data: userData??"",id: userId),), (route) => false);
    }
  }
  getUser(){
    Future.delayed(const Duration(seconds: 2)).then((value) =>
        keepLogin());
  }
  @override
  void initState() {
     getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset("assets/zartek_logo.png"),
      ),

    );
  }
}
