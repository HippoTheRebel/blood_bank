import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//RouteNames
const String kLogInRoutes = "/logIn";
const String kHomeRoutes = "/home";
const String kSettingRoutes = "/setting";
const String kDRFRoutes = "/drf";
const String kFormRoutes = "/form";
const kBaseUrl = 'https://btt.humanitarianlabfamily.org/apis/v1';

const kPrimaryColor = Color(0xFF74A9FF);

const kThemeColor = Color(0xFF74A9FF);

//LogInHeadersColors
List<Color> logInColors = [
  const Color(0xFF74A9FF),
  const Color(0xFF74A9FF),
  const Color(0xFF74A9FF),
];
//LogInHeaderTextStyle
TextStyle kLogInHeaderTextStyle = GoogleFonts.poppins(
  textStyle: const TextStyle(
    color: Colors.white,
    fontSize: 42,
  ),
);
//LogInSecondTextStyle
TextStyle kLogInSecondTextStyle = GoogleFonts.poppins(
  textStyle: const TextStyle(
    color: Colors.white,
    fontSize: 16,
  ),
);
//LogInTextFieldCursorColor
const kLoginTextFieldCursorColor = Color(0xFF74A9FF);
//LogInButtonTextStyle
TextStyle kLogInButtonTextStyle = GoogleFonts.poppins(
  textStyle: const TextStyle(
    color: Colors.white,
    fontSize: 15,
    fontWeight: FontWeight.bold,
  ),
);

//LogInButtonStyle
ButtonStyle kLogInButtonStyle = ElevatedButton.styleFrom(
  backgroundColor: const Color(0xFF74A9FF),
);

//AppBarTextStyle
TextStyle kAppBarTextStyle = GoogleFonts.poppins(
  textStyle: const TextStyle(
    fontSize: 18,
  ),
);

//ReusableListCardTextStyle
TextStyle kReusableListCardTextStyle = GoogleFonts.poppins(
  textStyle: const TextStyle(
    fontSize: 16,
  ),
);

//PaddingForReusableTextField
const double kDefaultPadding = 16.0;

//DonationRegisterFormHomePage
String? selectedValueForSex;
int kCurrentValueForSBP = 100;
int kCurrentValueForDBP = 60;
int kCurrentValueForMaleHemoglobin = 10;
int kCurrentValueForFemaleHemoglobin = 10;
int kCurrentTimesOfBloodDonation = 0;
bool kIsVisible = false;

//TTRFormHomePage
String? selectedValueForTTRFSex;

//ReusableHomeCardTextStyle
TextStyle kReusableHomeCardTextStyle = GoogleFonts.poppins(
  textStyle: const TextStyle(
    fontSize: 20,
    color: Colors.white,
  ),
);

//FormPages
const kFormFloatingButtonColor = Color(0xFF74A9FF);
const emailKey = 'email_key';
const sidKey = 'sid';
