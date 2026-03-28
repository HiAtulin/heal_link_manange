import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heal_link_manange/provider/counselor_provider.dart';
import 'package:heal_link_manange/widgets/main_layout.dart';
import 'package:heal_link_manange/pages/authentication/login_page.dart';
import 'package:heal_link_manange/pages/authentication/register_page.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future<void> checkTokenAndSetCounselor(WidgetRef ref) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('auth_token');
      String? counselorJson = prefs.getString('counselor');
      if (token != null && counselorJson != null) {
        ref.read(counselorProvider.notifier).setounselor(counselorJson);
      } else {
        ref.read(counselorProvider.notifier).signOut();
      }
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '心愈智约',
      theme: AppTheme.lightTheme,
      initialRoute: '/',
      routes: {
        '/': (context) => FutureBuilder(
          future: checkTokenAndSetCounselor(ref),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            final counselor = ref.watch(counselorProvider);
            return counselor != null
                ? const MainCounselorLayout()
                : const LoginPage();
          },
        ),
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/main': (context) => MainCounselorLayout(),
      },
    );
  }
}
