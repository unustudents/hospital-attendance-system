import 'package:flutter/material.dart';
import 'package:forui/theme.dart';

class PresenceHistoryWidget extends StatelessWidget {
  const PresenceHistoryWidget({
    super.key,
    required this.icon,
    required this.color,
    required this.status,
    required this.total,
  });

  final IconData icon;
  final Color color;
  final String status;
  final int total;

  @override
  Widget build(BuildContext context) {
    final FTypography typography = context.theme.typography;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.35),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            blurRadius: 20,
            spreadRadius: -4,
            offset: const Offset(0, 6),
          ),
          BoxShadow(
            color: Colors.white.withValues(alpha: 0.20),
            blurRadius: 6,
            spreadRadius: 0,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      child: Row(
        spacing: 15,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 32),
          Column(
            spacing: 10,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                status,
                style: typography.base.copyWith(fontWeight: FontWeight.bold),
              ),
              Text("$total Hari", style: typography.xs),
            ],
          ),
        ],
      ),
    );
  }
}
