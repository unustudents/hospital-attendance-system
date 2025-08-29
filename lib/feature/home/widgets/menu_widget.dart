import 'package:flutter/material.dart';
import 'package:forui/theme.dart';

import '../../../routes/app_router.dart' show PresenceRoute;

class MenuWidget extends StatelessWidget {
  const MenuWidget({
    super.key,
    required this.icon,
    this.color,
    required this.label,
  });
  final IconData icon;
  final Color? color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => const PresenceRoute().push(context),
      child: Column(
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
                    : Colors
                          .grey
                          .shade700, // Gunakan warna default jika tidak ada background color
              ),
            ),
          ),
          Text(
            label,
            style: context.theme.typography.xs.copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
