import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_project/controller/database_controller.dart';
import 'package:sample_project/controller/text_form_provider.dart';
import 'package:sample_project/view/task_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseController.initDb();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => DatabaseController()),
        ChangeNotifierProvider(create: (context) => TextFormProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
        home: const TaskScreen(),
      ),
    );
  }
}
