import 'package:flutter/material.dart';

class SafeBottom extends StatelessWidget {
  const SafeBottom({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: MediaQuery.of(context).padding.bottom);
  }
}
