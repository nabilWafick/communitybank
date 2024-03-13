//import 'package:communitybank/functions/auth/auth.function.dart';
import 'package:communitybank/utils/utils.dart';
import 'package:communitybank/views/pages/home/home.page.dart';
import 'package:communitybank/views/pages/login/login.page.dart';
import 'package:communitybank/views/widgets/globals/global.widgets.dart';
import 'package:communitybank/widget.test.dart';
//import 'package:communitybank/widget.test.dart';
//import 'package:communitybank/widget.test.dart';
import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';
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
  // await AuthFunctions.logout();
/*
  // logout after user stopping app
  WidgetsBinding.instance.addPostFrameCallback(
    (timeStamp) {
      ProcessSignal.sigterm.watch().listen(
        (event) async {
          await AuthFunctions.logout();
        },
      );
    },
  );
*/
  await DesktopWindow.setMinWindowSize(
    const Size(
      1280.0,
      700.0,
    ),
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
      /* builder: (context, child) => ResponsiveBreakpoints.builder(
        child: child!,
        breakpoints: [
         /* const Breakpoint(start: 0, end: 450, name: MOBILE),
          const Breakpoint(start: 451, end: 800, name: TABLET),
          const Breakpoint(start: 801, end: 1920, name: DESKTOP),
          const Breakpoint(start: 1921, end: double.infinity, name: '4K'),*/
       ],
      ),*/
      builder: (context, widget) => ResponsiveWrapper.builder(
        ClampingScrollWrapper.builder(context, widget!),
        breakpoints: const [
          ResponsiveBreakpoint.autoScaleDown(350, name: MOBILE),
          ResponsiveBreakpoint.autoScaleDown(600, name: TABLET),
          ResponsiveBreakpoint.autoScaleDown(800, name: DESKTOP),
          ResponsiveBreakpoint.autoScaleDown(1200, name: '1200'),
          ResponsiveBreakpoint.autoScaleDown(1400, name: '1400'),
          ResponsiveBreakpoint.autoScaleDown(1700, name: 'XL'),
          ResponsiveBreakpoint.resize(1870, name: '1870'),
          ResponsiveBreakpoint.resize(1900, name: '2XL'),
          ResponsiveBreakpoint.resize(2000, name: '2000'),
          //  ResponsiveBreakpoint.autoScale(double.infinity, name: '4K'),
        ],
      ),
      theme: CBThemeData.lightTheme,
      debugShowCheckedModeBanner: false,
      home: const WidgetTest(),
      //  const RegistrationPage(),
      //  const LoginPage(),
      // const MainApp(),
      //  const LoginPage(),
    );
  }
}

final authStateProvider = StreamProvider<AuthState>((ref) async* {
  final supabase = Supabase.instance.client;
  final auth = supabase.auth.onAuthStateChange;
  yield* auth;
});

class MainApp extends ConsumerStatefulWidget {
  const MainApp({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainAppState();
}

class _MainAppState extends ConsumerState<MainApp> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.addObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    /*  if (state == AppLifecycleState.paused) {
      await AuthFunctions.logout();
    }
    if (state == AppLifecycleState.detached) {
      await AuthFunctions.logout();
    }*/
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    final authStateStream = ref.watch(authStateProvider);

    return authStateStream.when(
      data: (authState) {
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
