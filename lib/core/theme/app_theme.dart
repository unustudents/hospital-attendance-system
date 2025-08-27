import 'package:forui/forui.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static FThemeData createFTheme({required FColors colors, required FTypography typography}) {
    return FThemeData(colors: colors, typography: typography);
  }

  static FTypography get poppinsTypography {
    return FTypography(
      defaultFontFamily: GoogleFonts.poppins().fontFamily!,
      xs: GoogleFonts.poppins(fontSize: 12, height: 1.33),
      sm: GoogleFonts.poppins(fontSize: 14, height: 1.43),
      base: GoogleFonts.poppins(fontSize: 16, height: 1.5),
      lg: GoogleFonts.poppins(fontSize: 18, height: 1.56),
      xl: GoogleFonts.poppins(fontSize: 20, height: 1.4),
      xl2: GoogleFonts.poppins(fontSize: 24, height: 1.33),
      xl3: GoogleFonts.poppins(fontSize: 30, height: 1.2),
      xl4: GoogleFonts.poppins(fontSize: 36, height: 1.11),
      xl5: GoogleFonts.poppins(fontSize: 48, height: 1),
      xl6: GoogleFonts.poppins(fontSize: 60, height: 1),
      xl7: GoogleFonts.poppins(fontSize: 72, height: 1),
      xl8: GoogleFonts.poppins(fontSize: 96, height: 1),
    );
  }

  static FTypography get lexendTypography {
    return FTypography(
      defaultFontFamily: GoogleFonts.lexend().fontFamily!,
      xs: GoogleFonts.lexend(fontSize: 12, height: 1.33),
      sm: GoogleFonts.lexend(fontSize: 14, height: 1.43),
      base: GoogleFonts.lexend(fontSize: 16, height: 1.5),
      lg: GoogleFonts.lexend(fontSize: 18, height: 1.56),
      xl: GoogleFonts.lexend(fontSize: 20, height: 1.4),
      xl2: GoogleFonts.lexend(fontSize: 24, height: 1.33),
      xl3: GoogleFonts.lexend(fontSize: 30, height: 1.2),
      xl4: GoogleFonts.lexend(fontSize: 36, height: 1.11),
      xl5: GoogleFonts.lexend(fontSize: 48, height: 1),
      xl6: GoogleFonts.lexend(fontSize: 60, height: 1),
      xl7: GoogleFonts.lexend(fontSize: 72, height: 1),
      xl8: GoogleFonts.lexend(fontSize: 96, height: 1),
    );
  }

  static FThemeData get lightTheme {
    return createFTheme(colors: FThemes.green.light.colors, typography: poppinsTypography);
  }

  static FThemeData get darkTheme {
    return createFTheme(colors: FThemes.green.dark.colors, typography: poppinsTypography);
  }

  // Alternative dengan Lexend
  static FThemeData get lightThemeWithLexend {
    return createFTheme(colors: FThemes.green.light.colors, typography: lexendTypography);
  }

  static FThemeData get darkThemeWithLexend {
    return createFTheme(colors: FThemes.green.dark.colors, typography: lexendTypography);
  }
}
