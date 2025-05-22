import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'providers/auth_provider.dart';
import 'providers/ticket_provider.dart';
import 'providers/comment_provider.dart';
import 'screens/login_screen.dart';
import 'screens/client/client_home_screen.dart';
import 'screens/admin/admin_dashboard_screen.dart';
import 'screens/ticket_list_screen.dart';
import 'screens/create_ticket_screen.dart';
import 'services/role_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    print("Firebase initialized successfully");
  } catch (e) {
    print('Firebase initialization error: $e');
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AuthProvider(),
      child: Consumer<AuthProvider>(
        builder: (context, authProvider, _) {
          print(
            "Auth state changed: isAuthenticated=${authProvider.isAuthenticated}, role=${authProvider.role}",
          );
          return authProvider.isAuthenticated
              ? MultiProvider(
                providers: [
                  ChangeNotifierProvider<TicketProvider>(
                    create: (_) => TicketProvider(authProvider.user?.uid),
                  ),
                  ChangeNotifierProvider<CommentProvider>(
                    create: (_) => CommentProvider(),
                  ),
                ],
                child: MaterialApp(
                  title: 'DEVMOB SUPPORTCLIENT',
                  debugShowCheckedModeBanner: false,
                  theme: ThemeData(
                    useMaterial3: true,
                    colorScheme: ColorScheme.fromSeed(
                      seedColor: const Color(0xFF4CAF50), // Changed to green
                      brightness: Brightness.light,
                      primary: const Color(0xFF4CAF50), // Changed to green
                      onPrimary: Colors.white,
                      secondary: const Color(0xFFFF9800), // Changed to orange
                      onSecondary: Colors.black,
                      tertiary: const Color(0xFF2196F3), // Changed to blue
                      surface: const Color(0xFFFAFAFA),
                      background: Colors.white,
                      error: const Color(0xFFF44336),
                    ),
                    fontFamily: 'Quicksand',
                    textTheme: const TextTheme(
                      displayLarge: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.w300,
                        letterSpacing: -1.0,
                      ),
                      displayMedium: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w300,
                        letterSpacing: -0.5,
                      ),
                      titleLarge: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0,
                      ),
                      titleMedium: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0,
                      ),
                      bodyLarge: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        height: 1.6,
                      ),
                      bodyMedium: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        height: 1.6,
                      ),
                      labelLarge: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                      ),
                    ),
                    appBarTheme: AppBarTheme(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFF6200EA),
                      elevation: 0,
                      centerTitle: false,
                      titleTextStyle: const TextStyle(
                        fontFamily: 'Quicksand',
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF6200EA),
                      ),
                      iconTheme: const IconThemeData(color: Color(0xFF6200EA)),
                      actionsIconTheme: const IconThemeData(
                        color: Color(0xFF6200EA),
                      ),
                      toolbarHeight: 70,
                      shadowColor: Colors.black.withOpacity(0.05),
                    ),
                    elevatedButtonTheme: ElevatedButtonThemeData(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: const Color(0xFF6200EA),
                        padding: const EdgeInsets.symmetric(
                          vertical: 20,
                          horizontal: 32,
                        ),
                        shape: const StadiumBorder(),
                        elevation: 0,
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                    textButtonTheme: TextButtonThemeData(
                      style: TextButton.styleFrom(
                        foregroundColor: const Color(0xFF6200EA),
                        padding: const EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 24,
                        ),
                        shape: const StadiumBorder(),
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                    outlinedButtonTheme: OutlinedButtonThemeData(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFF6200EA),
                        side: const BorderSide(
                          color: Color(0xFF6200EA),
                          width: 2,
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 20,
                          horizontal: 32,
                        ),
                        shape: const StadiumBorder(),
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                    cardTheme: CardThemeData(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                        side: BorderSide(
                          color: const Color(0xFF6200EA).withOpacity(0.1),
                          width: 1,
                        ),
                      ),
                      clipBehavior: Clip.antiAlias,
                      color: Colors.white,
                      margin: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 16,
                      ),
                    ),
                    inputDecorationTheme: InputDecorationTheme(
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 24,
                        horizontal: 24,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(
                          color: Color(0xFF6200EA),
                          width: 2,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(
                          color: Color(0xFFFF3D00),
                          width: 2,
                        ),
                      ),
                      labelStyle: TextStyle(
                        color: Colors.grey.shade700,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      floatingLabelStyle: const TextStyle(
                        color: Color(0xFF6200EA),
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                      prefixIconColor: const Color(0xFF6200EA),
                      suffixIconColor: const Color(0xFF6200EA),
                    ),
                    dividerTheme: DividerThemeData(
                      color: Colors.grey.shade200,
                      thickness: 2,
                      space: 40,
                      indent: 32,
                      endIndent: 32,
                    ),
                    chipTheme: ChipThemeData(
                      backgroundColor: Colors.grey.shade100,
                      disabledColor: Colors.grey.shade200,
                      selectedColor: const Color(0xFFFFD600),
                      secondarySelectedColor: const Color(0xFF6200EA),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                      labelStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                      secondaryLabelStyle: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                      shape: const StadiumBorder(),
                      side: BorderSide.none,
                    ),
                    snackBarTheme: const SnackBarThemeData(
                      backgroundColor: Color(0xFF6200EA),
                      contentTextStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                      behavior: SnackBarBehavior.floating,
                      actionTextColor: Color(0xFFFFD600),
                    ),
                    dialogTheme: const DialogThemeData(
                      backgroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(32)),
                      ),
                      alignment: Alignment.center,
                      titleTextStyle: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF6200EA),
                      ),
                      contentTextStyle: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF424242),
                      ),
                    ),
                    bottomSheetTheme: const BottomSheetThemeData(
                      backgroundColor: Colors.white,
                      modalBackgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(32),
                        ),
                      ),
                      clipBehavior: Clip.antiAlias,
                    ),
                    navigationBarTheme: NavigationBarThemeData(
                      backgroundColor: Colors.white,
                      indicatorColor: const Color(0xFFFFD600),
                      labelTextStyle: MaterialStateProperty.all(
                        const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      iconTheme: MaterialStateProperty.all(
                        const IconThemeData(size: 28, color: Color(0xFF6200EA)),
                      ),
                      labelBehavior:
                          NavigationDestinationLabelBehavior.onlyShowSelected,
                      height: 80,
                    ),
                    floatingActionButtonTheme:
                        const FloatingActionButtonThemeData(
                          backgroundColor: Color(0xFFFFD600),
                          foregroundColor: Colors.black,
                          shape: CircleBorder(),
                          elevation: 0,
                          extendedPadding: EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 16,
                          ),
                          extendedTextStyle: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            letterSpacing: 1,
                          ),
                        ),
                    tabBarTheme: const TabBarThemeData(
                      labelColor: Color(0xFF6200EA),
                      unselectedLabelColor: Color(0xFF9E9E9E),
                      indicatorColor: Color(0xFFFFD600),
                      indicatorSize: TabBarIndicatorSize.label,
                      labelStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                      unselectedLabelStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    checkboxTheme: CheckboxThemeData(
                      fillColor: MaterialStateProperty.resolveWith<Color>((
                        states,
                      ) {
                        if (states.contains(MaterialState.selected)) {
                          return const Color(0xFF6200EA);
                        }
                        return Colors.transparent;
                      }),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      side: const BorderSide(
                        width: 2,
                        color: Color(0xFF9E9E9E),
                      ),
                    ),
                    radioTheme: RadioThemeData(
                      fillColor: MaterialStateProperty.resolveWith<Color>((
                        states,
                      ) {
                        if (states.contains(MaterialState.selected)) {
                          return const Color(0xFF6200EA);
                        }
                        return const Color(0xFF9E9E9E);
                      }),
                    ),
                    switchTheme: SwitchThemeData(
                      thumbColor: MaterialStateProperty.resolveWith<Color>((
                        states,
                      ) {
                        if (states.contains(MaterialState.selected)) {
                          return const Color(0xFF6200EA);
                        }
                        return Colors.white;
                      }),
                      trackColor: MaterialStateProperty.resolveWith<Color>((
                        states,
                      ) {
                        if (states.contains(MaterialState.selected)) {
                          return const Color(0xFF6200EA).withOpacity(0.5);
                        }
                        return Colors.grey.shade300;
                      }),
                    ),
                    progressIndicatorTheme: const ProgressIndicatorThemeData(
                      color: Color(0xFF6200EA),
                      circularTrackColor: Color(0xFFE0E0E0),
                      linearTrackColor: Color(0xFFE0E0E0),
                    ),
                  ),
                  home: _buildHomeScreen(authProvider),
                  routes: {
                    '/login': (context) => const LoginScreen(),
                    '/client_home': (context) => const ClientHomeScreen(),
                    // '/admin_home': (context) => const AdminHomeScreen(),
                    '/admin_dashboard':
                        (context) => const AdminDashboardScreen(),
                    '/tickets': (context) => const TicketListScreen(),
                    '/create-ticket': (context) => const CreateTicketScreen(),
                  },
                ),
              )
              : MaterialApp(
                title: 'DEVMOB SUPPORTCLIENT',
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                  useMaterial3: true,
                  colorScheme: ColorScheme.fromSeed(
                    seedColor: const Color(0xFF4CAF50), // Changed to green
                    brightness: Brightness.light,
                    primary: const Color(0xFF4CAF50), // Changed to green
                    onPrimary: Colors.white,
                    secondary: const Color(0xFFFF9800), // Changed to orange
                    onSecondary: Colors.black,
                    tertiary: const Color(0xFF2196F3), // Changed to blue
                    surface: const Color(0xFFFAFAFA),
                    background: Colors.white,
                    error: const Color(0xFFF44336),
                  ),
                  fontFamily: 'Quicksand',
                  textTheme: const TextTheme(
                    displayLarge: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.w300,
                      letterSpacing: -1.0,
                    ),
                    displayMedium: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w300,
                      letterSpacing: -0.5,
                    ),
                    titleLarge: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0,
                    ),
                    titleMedium: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0,
                    ),
                    bodyLarge: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      height: 1.6,
                    ),
                    bodyMedium: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      height: 1.6,
                    ),
                    labelLarge: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                  appBarTheme: AppBarTheme(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFF6200EA),
                    elevation: 0,
                    centerTitle: false,
                    titleTextStyle: const TextStyle(
                      fontFamily: 'Quicksand',
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF6200EA),
                    ),
                    iconTheme: const IconThemeData(color: Color(0xFF6200EA)),
                    actionsIconTheme: const IconThemeData(
                      color: Color(0xFF6200EA),
                    ),
                    toolbarHeight: 70,
                    shadowColor: Colors.black.withOpacity(0.05),
                  ),
                  elevatedButtonTheme: ElevatedButtonThemeData(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: const Color(0xFF6200EA),
                      padding: const EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 32,
                      ),
                      shape: const StadiumBorder(),
                      elevation: 0,
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                  textButtonTheme: TextButtonThemeData(
                    style: TextButton.styleFrom(
                      foregroundColor: const Color(0xFF6200EA),
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 24,
                      ),
                      shape: const StadiumBorder(),
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                  outlinedButtonTheme: OutlinedButtonThemeData(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF6200EA),
                      side: const BorderSide(
                        color: Color(0xFF6200EA),
                        width: 2,
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 32,
                      ),
                      shape: const StadiumBorder(),
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                  cardTheme: CardThemeData(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                      side: BorderSide(
                        color: const Color(0xFF6200EA).withOpacity(0.1),
                        width: 1,
                      ),
                    ),
                    clipBehavior: Clip.antiAlias,
                    color: Colors.white,
                    margin: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 16,
                    ),
                  ),
                  inputDecorationTheme: InputDecorationTheme(
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 24,
                      horizontal: 24,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(
                        color: Color(0xFF6200EA),
                        width: 2,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(
                        color: Color(0xFFFF3D00),
                        width: 2,
                      ),
                    ),
                    labelStyle: TextStyle(
                      color: Colors.grey.shade700,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    floatingLabelStyle: const TextStyle(
                      color: Color(0xFF6200EA),
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                    prefixIconColor: const Color(0xFF6200EA),
                    suffixIconColor: const Color(0xFF6200EA),
                  ),
                  dividerTheme: DividerThemeData(
                    color: Colors.grey.shade200,
                    thickness: 2,
                    space: 40,
                    indent: 32,
                    endIndent: 32,
                  ),
                  chipTheme: ChipThemeData(
                    backgroundColor: Colors.grey.shade100,
                    disabledColor: Colors.grey.shade200,
                    selectedColor: const Color(0xFFFFD600),
                    secondarySelectedColor: const Color(0xFF6200EA),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                    labelStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                    secondaryLabelStyle: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                    shape: const StadiumBorder(),
                    side: BorderSide.none,
                  ),
                  snackBarTheme: const SnackBarThemeData(
                    backgroundColor: Color(0xFF6200EA),
                    contentTextStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                    behavior: SnackBarBehavior.floating,
                    actionTextColor: Color(0xFFFFD600),
                  ),
                  dialogTheme: const DialogThemeData(
                    backgroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(32)),
                    ),
                    alignment: Alignment.center,
                    titleTextStyle: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF6200EA),
                    ),
                    contentTextStyle: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF424242),
                    ),
                  ),
                  bottomSheetTheme: const BottomSheetThemeData(
                    backgroundColor: Colors.white,
                    modalBackgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(32),
                      ),
                    ),
                    clipBehavior: Clip.antiAlias,
                  ),
                  navigationBarTheme: NavigationBarThemeData(
                    backgroundColor: Colors.white,
                    indicatorColor: const Color(0xFFFFD600),
                    labelTextStyle: MaterialStateProperty.all(
                      const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    iconTheme: MaterialStateProperty.all(
                      const IconThemeData(size: 28, color: Color(0xFF6200EA)),
                    ),
                    labelBehavior:
                        NavigationDestinationLabelBehavior.onlyShowSelected,
                    height: 80,
                  ),
                  floatingActionButtonTheme:
                      const FloatingActionButtonThemeData(
                        backgroundColor: Color(0xFFFFD600),
                        foregroundColor: Colors.black,
                        shape: CircleBorder(),
                        elevation: 0,
                        extendedPadding: EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 16,
                        ),
                        extendedTextStyle: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          letterSpacing: 1,
                        ),
                      ),
                  tabBarTheme: const TabBarThemeData(
                    labelColor: Color(0xFF6200EA),
                    unselectedLabelColor: Color(0xFF9E9E9E),
                    indicatorColor: Color(0xFFFFD600),
                    indicatorSize: TabBarIndicatorSize.label,
                    labelStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                    unselectedLabelStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  checkboxTheme: CheckboxThemeData(
                    fillColor: MaterialStateProperty.resolveWith<Color>((
                      states,
                    ) {
                      if (states.contains(MaterialState.selected)) {
                        return const Color(0xFF6200EA);
                      }
                      return Colors.transparent;
                    }),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    side: const BorderSide(width: 2, color: Color(0xFF9E9E9E)),
                  ),
                  radioTheme: RadioThemeData(
                    fillColor: MaterialStateProperty.resolveWith<Color>((
                      states,
                    ) {
                      if (states.contains(MaterialState.selected)) {
                        return const Color(0xFF6200EA);
                      }
                      return const Color(0xFF9E9E9E);
                    }),
                  ),
                  switchTheme: SwitchThemeData(
                    thumbColor: MaterialStateProperty.resolveWith<Color>((
                      states,
                    ) {
                      if (states.contains(MaterialState.selected)) {
                        return const Color(0xFF6200EA);
                      }
                      return Colors.white;
                    }),
                    trackColor: MaterialStateProperty.resolveWith<Color>((
                      states,
                    ) {
                      if (states.contains(MaterialState.selected)) {
                        return const Color(0xFF6200EA).withOpacity(0.5);
                      }
                      return Colors.grey.shade300;
                    }),
                  ),
                  progressIndicatorTheme: const ProgressIndicatorThemeData(
                    color: Color(0xFF6200EA),
                    circularTrackColor: Color(0xFFE0E0E0),
                    linearTrackColor: Color(0xFFE0E0E0),
                  ),
                ),
                home: const LoginScreen(),
                routes: {
                  '/login': (context) => const LoginScreen(),
                  '/client_home': (context) => const ClientHomeScreen(),
                  // '/admin_home': (context) => const AdminHomeScreen(),
                  '/admin_dashboard': (context) => const AdminDashboardScreen(),
                  '/tickets': (context) => const TicketListScreen(),
                  '/create-ticket': (context) => const CreateTicketScreen(),
                },
              );
        },
      ),
    );
  }

  Widget _buildHomeScreen(AuthProvider authProvider) {
    if (!authProvider.isAuthenticated) {
      return const LoginScreen();
    }

    // Use a FutureBuilder to determine the user's role
    return FutureBuilder<String>(
      future: RoleService().getUserRole(authProvider.user!.uid),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (snapshot.hasData) {
          final userRole = snapshot.data!;
          if (userRole == 'admin') {
            return const AdminDashboardScreen();
          } else {
            return const ClientHomeScreen();
          }
        }

        // If role can't be determined, log out and return to login
        authProvider.signOut();
        return const LoginScreen();
      },
    );
  }
}

