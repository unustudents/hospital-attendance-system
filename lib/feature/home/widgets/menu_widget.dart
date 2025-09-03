import 'package:flutter/material.dart';
import 'package:forui/theme.dart';

class MenuWidget extends StatelessWidget {
  const MenuWidget({
    super.key,
    required this.icon,
    this.color,
    required this.label,
    this.onTap,
  });
  final IconData icon;
  final Color? color;
  final String label;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
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
