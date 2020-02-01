import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grin_plus_plus/screens/wallet_choice/bloc/bloc.dart';

/// Screen where you open your existing wallet,
/// or create new/import existing one.
class WalletChoiceScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _WalletChoiceScreenState();
}

class _WalletChoiceScreenState extends State<WalletChoiceScreen> {
  WalletChoiceBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<WalletChoiceBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocBuilder<WalletChoiceBloc, WalletChoiceState>(
          condition: (prevState, currentState) => prevState.counter != currentState.counter,
          builder: (context, state) => RaisedButton(
            child: Text('Increment me: ${state.counter}'),
            onPressed: () => _bloc.add(LoadIncrementedCounter()),
          ),
        ),
      ),
    );
  }
}