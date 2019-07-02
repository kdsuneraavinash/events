import 'package:events/logic/theme.dart';
import 'package:events/ui/home_page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:theme_provider/theme_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      themes: [
        ThemeRepository.defaultTheme,
        ThemeRepository.darkTheme,
      ],
      child: MaterialApp(
        title: 'Events.',
        home: ThemeConsumer(child: HomePage()),
      ),
    );
  }
}
