import 'package:flutter/material.dart';
import 'package:window_close_guard/window_close_guard.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'WindowCloseGuard Example',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // 1. Full example - custom dialog + cleanup tasks (recommended)
    WindowCloseGuard.initialize(
      context: context,
      onClose: () async {
        // Your cleanup tasks here
      },
      dialogConfig: const CloseDialogConfig(
        title: 'Exit',
        content: 'Are you sure you want to exit?',
      ),
    );

    // 2. Default behavior - shows a generic confirmation dialog
    // WindowCloseGuard.initialize(context: context);

    // 3. Custom dialog only, no cleanup tasks
    // WindowCloseGuard.initialize(
    //   context: context,
    //   dialogConfig: const CloseDialogConfig(
    //     title: 'Exit',
    //     content: 'Are you sure you want to exit?',
    //   ),
    // );

    // 4. Cleanup tasks only, no confirmation dialog
    // WindowCloseGuard.initialize(
    //   context: context,
    //   showDialog: false,
    //   onClose: () async {
    //     // Your cleanup tasks here
    //   },
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WindowCloseGuard Example'),
      ),
      body: const Center(
        child: Text('Try closing the window!'),
      ),
    );
  }
}
