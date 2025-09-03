import 'dart:ui' show ImageFilter;

import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:hospital_attendance_system/core/widgets/toaster.dart';

import '../../../gen/assets.gen.dart';
import '../../../routes/app_router.dart' show PresenceRoute;
import '../widgets/box_presence_widget.dart' show BoxPresenceWidget;
import '../widgets/menu_widget.dart' show MenuWidget;
import '../widgets/presence_history_widget.dart' show PresenceHistoryWidget;

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FTypography typography = context.theme.typography;
    final FColors colors = context.theme.colors;
    final FScaffoldStyle myStyle =
        FScaffoldStyle.inherit(
          colors: context.theme.colors,
          style: context.theme.style,
        ).copyWith(
          // Make scaffold background transparent so parent gradient shows.
          backgroundColor: Colors.transparent,
        );

    return SafeArea(
      child: Container(
        // Two-tone background: 1/4 green (top), 3/4 grey (bottom)
        decoration: BoxDecoration(
          gradient: () {
            const double topFraction = 0.2; // 1/4 top green
            return LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                colors.primary,
                colors.primary,
                Colors.grey.shade300,
                Colors.grey.shade300,
              ],
              stops: const [
                0.0,
                topFraction,
                topFraction,
                1.0,
              ], // Hard split at 20%
            );
          }(),
        ),
        child: FScaffold(
          scaffoldStyle: (_) => myStyle,
          child: FToaster(
            child: Builder(
              builder: (context) => SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 20,
                  children: [
                    // Logo
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Assets.images.logo.image(
                          width: 72,
                          height: 72,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    // Greeting and Menu (glass + shadow)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(18),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            color: Colors.white.withValues(alpha: 0.10),
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.28),
                              width: 1,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.25),
                                blurRadius: 24,
                                spreadRadius: -4,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      spacing: 8,
                                      children: [
                                        Text(
                                          "Selamat Siang",
                                          style: typography.xs.copyWith(
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Text(
                                          "Mas Akmal",
                                          style: typography.base.copyWith(
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      spacing: 8,
                                      children: [
                                        Text(
                                          "Rabu",
                                          style: typography.xs.copyWith(
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Text(
                                          "08:00 WIB - 14:00 WIB",
                                          style: typography.xs.copyWith(
                                            fontWeight: FontWeight.w600,
                                            color: colors.background,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const Divider(thickness: 2, height: 20),
                              const SizedBox(height: 12),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  MenuWidget(
                                    icon: FIcons.camera,
                                    label: 'Presensi',
                                    color: Colors.pinkAccent,
                                    onTap: () =>
                                        const PresenceRoute().push(context),
                                  ),
                                  MenuWidget(
                                    icon: FIcons.fileBox,
                                    label: 'Izin',
                                    color: Colors.orangeAccent,
                                    onTap: () => showWarningToast(
                                      context: context,
                                      title: "Fitur sedang dalam pengembangan",
                                    ),
                                  ),
                                  MenuWidget(
                                    icon: FIcons.calendar,
                                    label: 'Cuti',
                                    onTap: () => showWarningToast(
                                      context: context,
                                      title: "Fitur sedang dalam pengembangan",
                                    ),
                                    color: Colors.green,
                                  ),
                                  MenuWidget(
                                    icon: FIcons.history,
                                    label: 'Riwayat',
                                    onTap: () => showWarningToast(
                                      context: context,
                                      title: "Fitur sedang dalam pengembangan",
                                    ),
                                    color: Colors.purple,
                                  ),
                                  MenuWidget(
                                    icon: FIcons.contact,
                                    label: 'Profil',
                                    onTap: () => showWarningToast(
                                      context: context,
                                      title: "Fitur sedang dalam pengembangan",
                                    ),
                                    color: Colors.deepOrangeAccent,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // Presence Status
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: BoxPresenceWidget(
                            typography: typography,
                            status: 'Masuk',
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: BoxPresenceWidget(
                            typography: typography,
                            status: 'Pulang',
                            color: const Color(0xFFFF9800),
                          ),
                        ),
                      ],
                    ),

                    // Presence Quick History
                    Text(
                      "Presensi Bulan Agustus 2025",
                      style: typography.base.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    // create this
                    GridView(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 20,
                            crossAxisSpacing: 20,
                            childAspectRatio: 2.2,
                          ),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: const [
                        PresenceHistoryWidget(
                          icon: FIcons.notebookTabs,
                          color: Colors.deepPurpleAccent,
                          status: 'Hadir',
                          total: 0,
                        ),
                        PresenceHistoryWidget(
                          icon: FIcons.users,
                          color: Colors.green,
                          status: 'Izin',
                          total: 0,
                        ),
                        PresenceHistoryWidget(
                          icon: FIcons.frown,
                          color: Colors.blueGrey,
                          status: 'Sakit',
                          total: 0,
                        ),
                        PresenceHistoryWidget(
                          icon: FIcons.alarmClock,
                          color: Colors.pinkAccent,
                          status: 'Cuti',
                          total: 0,
                        ),
                      ],
                    ),

                    // Presence a week ago
                    Text(
                      "1 Minggu Terakhir",
                      style: typography.base.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    // Header row
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 16,
                      ),
                      decoration: BoxDecoration(
                        color: colors.primary,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: colors.primary.withValues(alpha: 0.2),
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(
                              "Tanggal",
                              style: typography.sm.copyWith(
                                fontWeight: FontWeight.bold,
                                color: colors.background,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              "Jam Masuk",
                              style: typography.sm.copyWith(
                                fontWeight: FontWeight.bold,
                                color: colors.background,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              "Jam Pulang",
                              style: typography.sm.copyWith(
                                fontWeight: FontWeight.bold,
                                color: colors.background,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Data rows
                    Column(
                      children: List.generate(7, (index) {
                        final DateTime date = DateTime.now().subtract(
                          Duration(days: index),
                        );
                        final String formattedDate =
                            "${date.day}/${date.month}/${date.year}";

                        return Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          padding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 16,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey.shade300),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.05),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Text(
                                  formattedDate,
                                  style: typography.sm.copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  "08:00 WIB",
                                  style: typography.sm.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: colors.primary,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  "17:00 WIB",
                                  style: typography.sm.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: colors.destructive,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
