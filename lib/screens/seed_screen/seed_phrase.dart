import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grin_plus_plus/colors.dart';
import 'package:grin_plus_plus/screens/seed_screen/bloc/bloc.dart';
import 'package:grin_plus_plus/strings.dart';
import 'package:grin_plus_plus/widgets/fade_in.dart';
import 'package:grin_plus_plus/widgets/text_field.dart';

class SeedPhraseScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(35),
            child: Text(
              kSaveThisToASafePlaceString,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w200,
                color: kColorAlmostWhite,
              ),
            ),
          ),
          FadeIn(
            child: Expanded(
              child: BlocBuilder<SeedScreenBloc, SeedScreenState>(
                builder: (context, state) {
                  int index = 1;
                  List<String> firstHalf = state.seed.sublist(0, (state.seed.length / 2).round());
                  List<String> secondHalf = state.seed.sublist((state.seed.length / 2).round());
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 90),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: firstHalf.map((seedWord) {
                                  final controller = TextEditingController(text: '${index++}. $seedWord');
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: BorderOnlyTextField(
                                      enabled: false,
                                      controller: controller,
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: secondHalf.map((seedWord) {
                                  final controller = TextEditingController(text: '${index++}. $seedWord');
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: BorderOnlyTextField(
                                      enabled: false,
                                      controller: controller,
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => BlocProvider.of<SeedScreenBloc>(context)
            .add(VerifyUserSavedSeed()),
        child: Icon(Icons.done),
        tooltip: kISavedMySeedString,
      ),
    );
  }
}