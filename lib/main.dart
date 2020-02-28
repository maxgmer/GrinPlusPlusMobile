import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:grin_plus_plus/colors.dart';
import 'package:grin_plus_plus/screens/root_screen/bloc/bloc.dart';
import 'package:grin_plus_plus/screens/root_screen/root_screen.dart';

void main() async {
  loadConfig();
  runApp(GrinPlusPlus());
}

class GrinPlusPlus extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Grin++',
      theme: ThemeData(
        fontFamily: 'Nunito',
        primaryColor: Colors.black,
        accentColor: kColorAccentGrey,
        scaffoldBackgroundColor: Colors.transparent,
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          elevation: 0,
          focusElevation: 0,
          highlightElevation: 0,
          disabledElevation: 0,
          hoverElevation: 0,
          shape: CircleBorder(),
          backgroundColor: kColorAlmostWhite,
        ),
        unselectedWidgetColor: kColorAlmostWhite,
      ),
      home: BlocProvider<RootBloc>(
        create: (context) => RootBloc(),
        child: RootScreen(),
      ),
    );
  }
}

void loadConfig() async {
  const requiredEnvVariables = const ['OWNER_URL'];

  await DotEnv().load('.env');
  if (!DotEnv().isEveryDefined(requiredEnvVariables)) {
    await DotEnv().load('default.env');
  }
}