import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:newankigen/entry.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ankigen',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home Page")),
      body: FutureBuilder<List<Entry>>(
        future: entries(),
        builder: (context, snapshot) {
          Stopwatch stopwatch = Stopwatch()..start();
          if (snapshot.connectionState == ConnectionState.done) {
            stopwatch.stop(); // Stop the stopwatch when rendering is completed
            Duration renderDuration = stopwatch.elapsed; // Get the elapsed time
            Fluttertoast.showToast(
              msg: "Rendering completed in ${renderDuration.inSeconds}s!",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.green,
              textColor: Colors.white,
            );
            final items = snapshot.data ?? [];
            return ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(items[index].reb ?? ''),
                );
              },
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else {
            return Text('Error: ${snapshot.error}\n${snapshot.stackTrace}');
          }
        },
      ),
    );
  }
}
