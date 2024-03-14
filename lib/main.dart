import 'package:flex_education/services/authentication__service.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'pages/login.dart';
import 'services/authentication_stream.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          //We istantiate the first actual provider of the application. As for convention, providers should be instatiated just one level above the first class where they need to be used
          value: AuthenticationService.instance(),
        ),
      ],
      child: const MaterialApp(
        title: 'FlexEd', // the title displayed below the launcher
        debugShowCheckedModeBanner:
            false, //this is useful just in debug mode, as the banner is not diplayed in release mode
        home:
            AuthenticationStream(), //the actual home widget of the app, i.e. the widget shown initially, is not a screen
      ),
    );
    ;
  }
}
