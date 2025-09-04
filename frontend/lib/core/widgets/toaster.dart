import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

/// Show warning toast with orange dominant color
FToasterEntry showWarningToast({
  required BuildContext context,
  required String title,
  String? subtitle,
  Duration duration = const Duration(seconds: 4),
}) {
  return showFToast(
    context: context,
    alignment: FToastAlignment.topCenter,
    duration: duration,
    icon: Icon(FIcons.triangleAlert, color: Colors.orange.shade700, size: 20),
    title: Text(
      title,
      style: TextStyle(
        color: Colors.orange.shade800,
        fontWeight: FontWeight.w600,
      ),
    ),
    description: subtitle != null
        ? Text(
            subtitle,
            style: TextStyle(color: Colors.orange.shade700, fontSize: 14),
          )
        : null,
  );
}

/// Show danger toast with red dominant color
FToasterEntry showDangerToast({
  required BuildContext context,
  required String title,
  String? subtitle,
  Duration duration = const Duration(seconds: 3),
}) {
  return showFToast(
    context: context,
    alignment: FToastAlignment.topCenter,
    duration: duration,
    icon: Icon(FIcons.x, color: Colors.red.shade700, size: 20),
    title: Text(
      title,
      style: TextStyle(color: Colors.red.shade800, fontWeight: FontWeight.w600),
    ),
    description: subtitle != null
        ? Text(
            subtitle,
            style: TextStyle(color: Colors.red.shade700, fontSize: 14),
          )
        : null,
  );
}

/// Show custom raw toast with full control
FToasterEntry showCustomRawToast({
  required BuildContext context,
  required Widget Function(BuildContext, FToasterEntry) builder,
  Duration duration = const Duration(seconds: 3),
  FToastAlignment alignment = FToastAlignment.topCenter,
  List<AxisDirection> swipeToDismiss = const [
    AxisDirection.left,
    AxisDirection.right,
  ],
  VoidCallback? onDismiss,
}) {
  return showRawFToast(
    context: context,
    alignment: alignment,
    duration: duration,
    swipeToDismiss: swipeToDismiss,
    onDismiss: onDismiss,
    builder: builder,
  );
}

/// Example of custom raw toast with FCard
FToasterEntry showCustomCardToast({
  required BuildContext context,
  required String title,
  required String subtitle,
  Duration duration = const Duration(seconds: 5),
}) {
  return showRawFToast(
    context: context,
    alignment: FToastAlignment.topRight,
    duration: duration,
    swipeToDismiss: [AxisDirection.left, AxisDirection.down],
    builder: (context, entry) => FCard(
      title: Text(title),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10,
        children: [
          Text(subtitle),
          FButton(onPress: () => entry.dismiss(), child: const Text('Dismiss')),
        ],
      ),
    ),
  );
}
