import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grin_plus_plus/screens/restore_wallet_screen/bloc/bloc.dart';
import 'package:grin_plus_plus/widgets/text_field_with_inner_text.dart';

class SeedFields extends StatelessWidget {
  final List<TextEditingController> seedWordControllers;

  SeedFields(this.seedWordControllers);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RestoreWalletBloc, RestoreWalletState>(
      builder: (context, state) {
        return Row(
          children: <Widget>[
            Expanded(
              child: Column(
                children: List.generate((seedWordControllers.length / 2).round(), (index) {
                  bool enabled = index < state.seedWordsNumber;
                  if (!enabled) {
                    seedWordControllers[index].clear();
                  }
                  return BorderedTextFieldWithInnerText(
                    enabled: enabled,
                    text: '${index + 1}.',
                    controller: seedWordControllers[index],
                    margin: EdgeInsets.only(right: 8, top: 8, bottom: 8),
                  );
                }),
              ),
            ),
            Expanded(
              child: Column(
                children: List.generate((seedWordControllers.length / 2).round(), (indexList) {
                  int index = indexList + (seedWordControllers.length / 2).round();
                  bool enabled = index < state.seedWordsNumber;
                  if (!enabled) {
                    seedWordControllers[index].clear();
                  }
                  return BorderedTextFieldWithInnerText(
                    enabled: enabled,
                    text: '${index + 1}.',
                    controller: seedWordControllers[index],
                    margin: const EdgeInsets.only(left: 8, top: 8, bottom: 8),
                  );
                }),
              ),
            ),
          ],
        );
      },
    );
  }
}
