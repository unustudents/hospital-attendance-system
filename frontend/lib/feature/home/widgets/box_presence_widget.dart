import 'package:flutter/material.dart';
import 'package:forui/theme.dart';

class BoxPresenceWidget extends StatelessWidget {
  const BoxPresenceWidget({super.key, required this.typography, required this.status, required this.color, this.presenceTime});

  final FTypography typography;
  final String status;
  final Color color;
  final String? presenceTime;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: color,
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.25), blurRadius: 20, spreadRadius: -4, offset: const Offset(0, 6)),
          BoxShadow(color: Colors.white.withValues(alpha: 0.20), blurRadius: 6, spreadRadius: 0, offset: const Offset(0, 0)),
        ],
      ),
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 8,
        children: [
          Text("Presensi $status", style: typography.sm.copyWith(fontWeight: FontWeight.w500)),
          Text(presenceTime ?? "Belum absen", style: typography.base.copyWith(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
