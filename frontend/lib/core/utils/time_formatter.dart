/// Utility class untuk memformat waktu
/// Mengikuti single responsibility principle
class TimeFormatter {
  TimeFormatter._(); // Private constructor untuk utility class

  /// Format string datetime menjadi HH:mm
  ///
  /// Input: "2025-09-06 20:08:49"
  /// Output: "20:08"
  static String formatToHourMinute(String? dateTimeString) {
    if (dateTimeString == null ||
        dateTimeString.isEmpty ||
        dateTimeString == 'null') {
      return '-';
    }

    try {
      // Method 1: String splitting (lebih efisien untuk format yang konsisten)
      if (dateTimeString.contains(' ')) {
        final timePart = dateTimeString.split(' ')[1]; // "20:08:49"
        final timeComponents = timePart.split(':');
        if (timeComponents.length >= 2) {
          return '${timeComponents[0]}:${timeComponents[1]}'; // "20:08"
        }
      }

      // Method 2: DateTime parsing (fallback untuk format yang bervariasi)
      final dateTime = DateTime.parse(dateTimeString);
      return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
    } catch (e) {
      // Jika parsing gagal, coba extract manual
      if (dateTimeString.length >= 16) {
        // "2025-09-06 20:08:49" -> ambil posisi 11-15 = "20:08"
        try {
          return dateTimeString.substring(11, 16);
        } catch (_) {
          return dateTimeString;
        }
      }
      return dateTimeString;
    }
  }

  /// Format string datetime menjadi format yang dapat dibaca
  ///
  /// Input: "2025-09-06 20:08:49"
  /// Output: "20:08 WIB"
  static String formatToDisplayTime(
    String? dateTimeString, {
    String suffix = 'WIB',
  }) {
    final timeOnly = formatToHourMinute(dateTimeString);
    return timeOnly == '-' ? timeOnly : '$timeOnly $suffix';
  }

  /// Format untuk tampilan lengkap
  ///
  /// Input: "2025-09-06 20:08:49"
  /// Output: "06 Sep 2025, 20:08"
  static String formatToFullDisplay(String? dateTimeString) {
    if (dateTimeString == null ||
        dateTimeString.isEmpty ||
        dateTimeString == 'null') {
      return '-';
    }

    try {
      final dateTime = DateTime.parse(dateTimeString);
      final months = [
        '',
        'Jan',
        'Feb',
        'Mar',
        'Apr',
        'Mei',
        'Jun',
        'Jul',
        'Agu',
        'Sep',
        'Okt',
        'Nov',
        'Des',
      ];

      return '${dateTime.day.toString().padLeft(2, '0')} ${months[dateTime.month]} ${dateTime.year}, '
          '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
    } catch (e) {
      return dateTimeString;
    }
  }
}
