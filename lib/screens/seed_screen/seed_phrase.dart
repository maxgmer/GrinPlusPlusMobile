import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grin_plus_plus/colors.dart';
import 'package:grin_plus_plus/screens/root_screen/bloc/bloc.dart';
import 'package:grin_plus_plus/screens/screens.dart';
import 'package:grin_plus_plus/screens/seed_screen/bloc/bloc.dart';
import 'package:grin_plus_plus/strings.dart';
import 'package:grin_plus_plus/widgets/fade_animator.dart';
import 'package:grin_plus_plus/widgets/fade_in.dart';

class SeedPhraseScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SeedPhraseScreenState();
}

class _SeedPhraseScreenState extends State<SeedPhraseScreen> {
  SeedScreenBloc _bloc;
  List<TextEditingController> _seedWordControllers = [];

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<SeedScreenBloc>(context);
    for (String seedWord in _bloc.state.seed) {
      _seedWordControllers.add(TextEditingController(text: seedWord));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          FadeIn(
            child: BlocBuilder<SeedScreenBloc, SeedScreenState>(
              builder: (context, state) {
                if (state.verifyingSeedPhrase) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: InkWell(
                      onTap: () => _bloc.add(BackToSeed()),
                      borderRadius: BorderRadius.circular(50),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          kGoBackToSeedPhraseString,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w200,
                            color: kColorAlmostWhite,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                  );
                }
                return Padding(
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
                );
              }
            ),
          ),
          Expanded(
            child: FadeAnimator(
              startOpacity: 0,
              endOpacity: 1,
              duration: 1500,
              delay: 3000,
              child: BlocConsumer<SeedScreenBloc, SeedScreenState>(
                listener: (context, state) {
                  if (state.createdSuccessfully) {
                    BlocProvider.of<RootBloc>(context).add(ChangeScreen(Screen.walletChoiceScreen));
                  }
                  if (state.verifyingSeedPhrase) {
                    for (int i = 0; i < _seedWordControllers.length; i++) {
                      _seedWordControllers[i].text = state.obfuscatedSeed[i];
                    }
                  } else {
                    if (state.seed != null && state.seed.length != 0) {
                      for (int i = 0; i < _seedWordControllers.length; i++) {
                        _seedWordControllers[i].text = state.seed[i];
                      }
                    }
                  }
                },
                builder: (context, state) {
                  int index = 0;
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
                                  bool enabled = _seedWordControllers[index].text.isEmpty &&
                                      state.verifyingSeedPhrase;
                                  return _buildTextFieldWithText(
                                    enabled: enabled,
                                    text: '${index + 1}.',
                                    controller: _seedWordControllers[index++],
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
                                  bool enabled = _seedWordControllers[index].text.isEmpty &&
                                      state.verifyingSeedPhrase;
                                  return _buildTextFieldWithText(
                                    enabled: enabled,
                                    text: '${index + 1}.',
                                    controller: _seedWordControllers[index++],
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
        onPressed: () {
          if (_bloc.state.verifyingSeedPhrase) {
            _bloc.add(FinishWalletCreation(_seedWordControllers.map((controller) => controller.text).toList()));
          } else {
            _bloc.add(VerifyUserSavedSeed());
          }
        },
        child: Icon(Icons.done),
        tooltip: kISavedMySeedString,
      ),
    );
  }

  Widget _buildTextFieldWithText({bool enabled, String text, TextEditingController controller}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
              color: enabled ? kColorAlmostWhite : kColorAlmostWhite.withOpacity(0.2),
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(4)
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 4),
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                  color: kColorAlmostWhite,
                ),
              ),
            ),
            Expanded(
              child: TextField(
                enabled: enabled,
                cursorColor: kColorAlmostWhite,
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                  color: kColorAlmostWhite,
                ),
                controller: controller,
              ),
            ),
          ],
        ),
      ),
    );
  }
}