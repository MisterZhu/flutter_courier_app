import 'package:flutter/material.dart';

class DatabaseDebugPage extends StatefulWidget {
  const DatabaseDebugPage({super.key});

  @override
  State<DatabaseDebugPage> createState() => _DatabaseDebugPageState();
}

class _DatabaseDebugPageState extends State<DatabaseDebugPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Database viewer'),
      ),
      body: _renderPageContent(),
    );
  }

  Widget _renderPageContent() {
    return const Text('Database viewer page');
  }
}
