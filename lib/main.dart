import 'package:communitybank/utils/utils.dart';
import 'package:communitybank/views/pages/home/home.page.dart';
import 'package:communitybank/views/pages/login/login.page.dart';
import 'package:communitybank/widget.test.dart';
import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final windowSizeProvider =
    StateProvider.family<Size, BuildContext>((ref, context) {
  return MediaQuery.of(context).size;
});

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // debugPrint('Hello World');
  await dotenv.load(fileName: '.env');
  // debugPrint('simple access: ${dotenv.env['SUPABASE_URL']}');
  // debugPrint('get access: ${dotenv.get('SUPABASE_URL')}');

  await DesktopWindow.setMinWindowSize(
    const Size(1280.0, 700.0),
  );
  runApp(
    const ProviderScope(
      child: MainApp(),
    ),
  );
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

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
      theme: CBThemeData.lightTheme,
      debugShowCheckedModeBanner: false,
      home: const Scaffold(
        body: FormCard(),
        //  HomePage(),
      ),
    );
  }
}
