import 'package:cond_app/firebase/firebase_options.dart';
import 'package:cond_app/utils/exports.dart';
import 'package:flutter/foundation.dart' show kIsWeb;


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: MyFirebaseOptions.options,

  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CondApp',
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('pt', 'BR'),
      ],
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFFf6f5ee),
      ),
      initialRoute: kIsWeb ? '/login/' : '/splash/',
      routes: Routes().getRoutes(),
    );
  }
}