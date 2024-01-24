import 'package:communitybank/utils/utils.dart';
import 'package:communitybank/views/pages/home/home.page.dart';
import 'package:communitybank/views/pages/login/login.page.dart';
import 'package:communitybank/views/widgets/globals/global.widgets.dart';
import 'package:communitybank/widget.test.dart';
import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final windowSizeProvider =
    StateProvider.family<Size, BuildContext>((ref, context) {
  return MediaQuery.of(context).size;
});

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  await Supabase.initialize(
    url: CBConstants.supabaseUrl ?? '',
    anonKey: CBConstants.supabaseKey ?? '',
    authFlowType: AuthFlowType.pkce,
    storageRetryAttempts: 10,
    realtimeClientOptions: const RealtimeClientOptions(
      logLevel: RealtimeLogLevel.info,
    ),
  );

  // debugPrint('simple access: ${dotenv.env['SUPABASE_URL']}');
  // debugPrint('get access: ${dotenv.get('SUPABASE_URL')}');

  await DesktopWindow.setMinWindowSize(
    const Size(1280.0, 700.0),
  );
  runApp(
    const ProviderScope(
      child: CommunityBankApp(),
    ),
  );
}

class CommunityBankApp extends ConsumerWidget {
  const CommunityBankApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(
      windowSizeProvider(context),
      (previous, next) async {
        if (next.width < 1280.0) {
          await DesktopWindow.setWindowSize(
            Size(1280.0, next.height),
          );
        }
      },
    );

    return MaterialApp(
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      supportedLocales: const [
        Locale('fr', 'FR'),
        Locale('en', 'US'),
      ],
      theme: CBThemeData.lightTheme,
      debugShowCheckedModeBanner: false,
      home:
          // const WidgetTest(),
          //  const RegistrationPage(),
          //  const LoginPage(),
          const MainApp(),
      // const LoginPage(),
    );
  }
}

final authStateProvider = StreamProvider<AuthState>((ref) async* {
  final supabase = Supabase.instance.client;
  final auth = supabase.auth.onAuthStateChange;
  yield* auth;
});

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authStateStream = ref.watch(authStateProvider);
    // final supabase = Supabase.instance.client;
    // final currentUser = supabase.auth.currentUser;

    // return currentUser == null
    //     ? const LoginPage()
    //     :
    return authStateStream.when(
      data: (authState) {
        /* final authStateEvent = authState.event;
        if (authStateEvent == AuthChangeEvent.signedIn) {
          return const HomePage();1
        } else if (authStateEvent == AuthChangeEvent.signedOut) {
          return const LoginPage();
        } else {
          return const LoginPage();
        } */

        final authStateSession = authState.session;
        if (authStateSession != null) {
          return const HomePage();
        } else {
          return const LoginPage();
        }
      },
      error: (error, stackTrace) => const LoginPage(),
      loading: () => const LoginPage(),
    );
  }
}

class LoadingPage extends ConsumerWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(
              width: 15.0,
            ),
            CBText(
              text: 'Veuillez patientez ...',
              fontWeight: FontWeight.w500,
            ),
          ],
        ),
      ),
    );
  }
}
