import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grin_plus_plus/screens/seed_screen/bloc/bloc.dart';
import 'package:grin_plus_plus/screens/seed_screen/seed_phrase.dart';
import 'package:grin_plus_plus/screens/seed_screen/warning_message.dart';

class SeedScreen extends StatefulWidget {
  final String seed;

  SeedScreen(this.seed);

  @override
  State<StatefulWidget> createState() => _SeedScreenState();
}

class _SeedScreenState extends State<SeedScreen> {
  SeedScreenBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<SeedScreenBloc>(context);
    _bloc.add(Init(widget.seed));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SeedScreenBloc, SeedScreenState>(
      builder: (context, state) {
        if (!state.warningAcknowledged) {
          return WarningMessageScreen(_bloc);
        }
        return SeedPhraseScreen();
      },
    );
  }
}