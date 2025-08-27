import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FTypography typography = context.theme.typography;
    final FColors colors = context.theme.colors;
    final FScaffoldStyle myStyle = FScaffoldStyle.inherit(
      colors: context.theme.colors,
      style: context.theme.style,
    ).copyWith(backgroundColor: Colors.grey.shade300);

    return SafeArea(
      child: FScaffold(
        scaffoldStyle: (_) => myStyle,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: colors.background),
              padding: const EdgeInsets.all(13),
              child: const Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text("Selamat Siang"), Text("Mas Akmal")]),
                      ),
                      Expanded(
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text("Rabu"), Text("08:00 - 14:00")]),
                      ),
                    ],
                  ),
                  FDivider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      MenuWidget(icon: FIcons.camera, label: 'Presensi', color: Colors.pinkAccent),
                      MenuWidget(icon: FIcons.fileBox, label: 'Izin', color: Colors.orangeAccent),
                      MenuWidget(icon: FIcons.calendar, label: 'Cuti', color: Colors.green),
                      MenuWidget(icon: FIcons.history, label: 'Riwayat', color: Colors.purple),
                      MenuWidget(icon: FIcons.contact, label: 'Profil', color: Colors.deepOrangeAccent),
                    ],
                  ),
                ],
              ),
            ),
            // Presence Status
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              spacing: 10,
              children: [
                Expanded(
                  child: BoxPresenceWidget(typography: typography, status: 'Masuk', color: colors.primary),
                ),
                Expanded(
                  child: BoxPresenceWidget(typography: typography, status: 'Pulang', color: colors.secondary),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MenuWidget extends StatelessWidget {
  const MenuWidget({super.key, required this.icon, this.color, required this.label});
  final IconData icon;
  final Color? color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      children: [
        Card.filled(
          color: color ?? Colors.grey.shade200,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Icon(
              icon,
              color: color != null
                  ? Colors
                        .white // Gunakan warna kontras jika ada background color
                  : Colors.grey.shade700, // Gunakan warna default jika tidak ada background color
            ),
          ),
        ),
        Text(label, style: context.theme.typography.xs),
      ],
    );
  }
}

class BoxPresenceWidget extends StatelessWidget {
  const BoxPresenceWidget({super.key, required this.typography, required this.status, required this.color});

  final FTypography typography;
  final String status;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: color),
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 8,
        children: [
          Text("Presensi $status", style: typography.sm.copyWith(fontWeight: FontWeight.w500)),
          Text("Belum absen", style: typography.base.copyWith(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
