import 'package:cafe3awan/views/splash_view.dart';
import 'package:cafe3awan/views/home_view.dart'; // ⬅️ tambahkan ini
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'viewmodels/menu_viewmodel.dart';
import 'viewmodels/cart_viewmodel.dart';
import 'viewmodels/order_viewmodel.dart';

void main() {
  runApp(const RestoCafeApp());
}

class RestoCafeApp extends StatelessWidget {
  const RestoCafeApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MenuViewModel()),
        ChangeNotifierProvider(create: (_) => CartViewModel()),
        ChangeNotifierProvider(
          create: (_) => OrderViewModel(),
        ), // ✅ tambahkan ini
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Resto & Cafe',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: const Color(0xFFF2F9FF),
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.transparent,
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.black87),
            titleTextStyle: TextStyle(
              color: Colors.black87,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        home: const SplashView(),
        routes: {'/home': (context) => const HomeView()},
      ),
    );
  }
}
