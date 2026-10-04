import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

const Color kCanvas = Color(0xFFF4F1FA);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: kCanvas,
    statusBarIconBrightness: Brightness.dark,
    systemNavigationBarColor: kCanvas,
    systemNavigationBarIconBrightness: Brightness.dark,
  ));
  runApp(const WorkoutApp());
}

class WorkoutApp extends StatelessWidget {
  const WorkoutApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'جدول التمرين',
      debugShowCheckedModeBanner: false,
      home: WorkoutPage(),
    );
  }
}

class WorkoutPage extends StatefulWidget {
  const WorkoutPage({super.key});

  @override
  State<WorkoutPage> createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(kCanvas)
      // The page calls Haptic.postMessage() for light taps.
      ..addJavaScriptChannel(
        'Haptic',
        onMessageReceived: (_) => HapticFeedback.lightImpact(),
      );
    _loadPage();
  }

  Future<void> _loadPage() async {
    final html = await rootBundle.loadString('assets/index.html');
    // A real https base URL gives the page a normal origin, so localStorage
    // (the "done" checkmarks and the sound setting) is kept between launches.
    await _controller.loadHtmlString(html, baseUrl: 'https://workout.app/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kCanvas,
      body: SafeArea(child: WebViewWidget(controller: _controller)),
    );
  }
}
