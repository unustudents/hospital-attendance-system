import 'package:flutter/material.dart';
import 'dart:ui' show ImageFilter;
import 'package:forui/forui.dart';
import 'package:hospital_attendance_system/gen/assets.gen.dart';

import '../../../routes/app_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FTypography typography = context.theme.typography;
    final FColors colors = context.theme.colors;
    final FScaffoldStyle myStyle = FScaffoldStyle.inherit(colors: context.theme.colors, style: context.theme.style).copyWith(
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
              colors: [colors.primary, colors.primary, Colors.grey.shade300, Colors.grey.shade300],
              stops: const [0.0, topFraction, topFraction, 1.0], // Hard split at 20%
            );
          }(),
        ),
        child: FScaffold(
          scaffoldStyle: (_) => myStyle,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 20,
              children: [
                // Logo
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Assets.images.logo.image(width: 72, height: 72, fit: BoxFit.cover),
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
                        border: Border.all(color: Colors.white.withValues(alpha: 0.28), width: 1),
                        boxShadow: [
                          BoxShadow(color: Colors.black.withValues(alpha: 0.25), blurRadius: 24, spreadRadius: -4, offset: const Offset(0, 8)),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  spacing: 8,
                                  children: [
                                    Text(
                                      "Selamat Siang",
                                      style: typography.xs.copyWith(fontWeight: FontWeight.w600, color: Colors.white),
                                    ),
                                    Text(
                                      "Mas Akmal",
                                      style: typography.base.copyWith(fontWeight: FontWeight.w600, color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  spacing: 8,
                                  children: [
                                    Text(
                                      "Rabu",
                                      style: typography.xs.copyWith(fontWeight: FontWeight.w600, color: Colors.white),
                                    ),
                                    Text(
                                      "08:00 WIB - 14:00 WIB",
                                      style: typography.xs.copyWith(fontWeight: FontWeight.w600, color: colors.background),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const Divider(thickness: 2, height: 20),
                          const SizedBox(height: 12),
                          const Row(
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
                  ),
                ),

                // Presence Status
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: BoxPresenceWidget(typography: typography, status: 'Masuk', color: colors.primary),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: BoxPresenceWidget(typography: typography, status: 'Pulang', color: colors.secondary),
                    ),
                  ],
                ),

                // Presence Quick History
                Text("Presensi Bulan Agustus 2025", style: typography.base.copyWith(fontWeight: FontWeight.w600)),
                // create this
                GridView(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20,
                    childAspectRatio: 2.0,
                  ),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: const [
                    PresenceHistoryWidget(icon: FIcons.notebookTabs, color: Colors.deepPurpleAccent, status: 'Hadir', total: 0),
                    PresenceHistoryWidget(icon: FIcons.users, color: Colors.green, status: 'Izin', total: 0),
                    PresenceHistoryWidget(icon: FIcons.frown, color: Colors.blueGrey, status: 'Sakit', total: 0),
                    PresenceHistoryWidget(icon: FIcons.alarmClock, color: Colors.pinkAccent, status: 'Cuti', total: 0),
                  ],
                ),

                // Presence a week ago
                Text("1 Minggu Terakhir", style: typography.base.copyWith(fontWeight: FontWeight.w600)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PresenceHistoryWidget extends StatelessWidget {
  const PresenceHistoryWidget({super.key, required this.icon, required this.color, required this.status, required this.total});

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
        border: Border.all(color: Colors.white.withValues(alpha: 0.35), width: 1.5),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.25), blurRadius: 20, spreadRadius: -4, offset: const Offset(0, 6)),
          BoxShadow(color: Colors.white.withValues(alpha: 0.20), blurRadius: 6, spreadRadius: 0, offset: const Offset(0, 0)),
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
              Text(status, style: typography.base.copyWith(fontWeight: FontWeight.bold)),
              Text("$total Hari", style: typography.xs),
            ],
          ),
        ],
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
                    : Colors.grey.shade700, // Gunakan warna default jika tidak ada background color
              ),
            ),
          ),
          Text(label, style: context.theme.typography.xs.copyWith(color: Colors.white)),
        ],
      ),
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
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: color,
        border: Border.all(color: Colors.white.withValues(alpha: 0.35), width: 1.5),
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
          Text("Belum absen", style: typography.base.copyWith(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
