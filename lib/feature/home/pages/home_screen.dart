import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FScaffold(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              spacing: 10,
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: context.theme.colors.primary),
                    padding: const EdgeInsets.all(10),
                    child: const Column(children: [Text("Absen Masuk"), Text("Belum absen")]),
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.pinkAccent),
                    padding: const EdgeInsets.all(10),
                    child: const Column(children: [Text("Absen Pulang"), Text("Belum absen")]),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
