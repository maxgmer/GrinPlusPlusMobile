import 'package:clipboard_manager/clipboard_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grin_plus_plus/colors.dart';
import 'package:grin_plus_plus/screens/receive_screen/file_saved_screen.dart';
import 'package:grin_plus_plus/screens/root_screen/bloc/bloc.dart';
import 'package:grin_plus_plus/screens/screens.dart';
import 'package:grin_plus_plus/screens/wallet_screen/funds_block.dart';
import 'package:grin_plus_plus/strings.dart';
import 'package:grin_plus_plus/widgets/text_field.dart';
import 'package:marquee_widget/marquee_widget.dart';

import 'bloc/bloc.dart';

class ReceiveScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ReceiveScreenState();
}

class _ReceiveScreenState extends State<ReceiveScreen> {
  RootBloc _rootBloc;
  ReceiveScreenBloc _bloc;
  TextEditingController _messageController;

  @override
  void initState() {
    super.initState();
    _rootBloc = BlocProvider.of<RootBloc>(context);
    _bloc = BlocProvider.of<ReceiveScreenBloc>(context);
    _messageController = TextEditingController(text: _bloc.state.message);
    _messageController.addListener(() {
      _bloc.add(MessageUpdated(_messageController.text));
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ReceiveScreenBloc, ReceiveScreenState>(
      listener: (context, state) {
        if (state.message != _messageController.text) {
          setState(() => _messageController.text = state.message);
        }
      },
      builder: (context, state) {
        if (state.transactionFilePath != null) {
          return ReceiveTxFileSavedScreen(state.transactionFilePath);
        }

        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 24,
                  ),
                  child: FundsBlock(),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 24, right: 24, bottom: 80),
                  child: Column(
                    children: <Widget>[
                      AddressesWidgetsBlock(_rootBloc),
                      Builder(
                        builder: (context) {
                          if (state.file != null) {
                            return Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8),
                                  child: BorderedTextField(
                                    labelText: kMessageString,
                                    controller: _messageController,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              '$kSelectedFileString: ',
                                              style: TextStyle(
                                                fontSize: 18,
                                                color: kColorAlmostWhite,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            Marquee(
                                              animationDuration: Duration(milliseconds: state.file.path.length * 100),
                                              backDuration: Duration(milliseconds: state.file.path.length * 100),
                                              child: Text(
                                                state.file.path,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: kColorAlmostWhite,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () => _bloc.add(ClearFileSelection()),
                                        icon: Icon(
                                          Icons.clear,
                                          color: kColorAlmostWhite,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 16),
                                  child: Row(
                                    children: <Widget>[
                                      Spacer(),
                                      RaisedButton(
                                        onPressed: () => _bloc.add(Receive()),
                                        color: kColorAlmostWhite,
                                        child: Row(
                                          children: <Widget>[
                                            Text(
                                              kReceiveString,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                                color: Colors.black,
                                              ),
                                            ),
                                            Icon(
                                              Icons.call_received,
                                              color: Colors.black,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Spacer(),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          } else {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 28),
                              child: RaisedButton(
                                onPressed: () {
                                  _messageController.clear();
                                  _bloc.add(SelectTxFile());
                                },
                                color: kColorAlmostWhite,
                                child: Text(
                                  kSelectFileString,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            );
                          }
                        }
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          floatingActionButton: FloatingActionButton(
            onPressed: () => _rootBloc.add(ChangeScreen(Screen.walletScreen)),
            child: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            tooltip: kReturnToWalletString,
          ),
        );
      },
    );
  }
}

class AddressesWidgetsBlock extends StatelessWidget {
  final RootBloc rootBloc;

  AddressesWidgetsBlock(this.rootBloc);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Text(
            kHttpAndTorAddressesString,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: kColorAlmostWhite,
            ),
          ),
        )
        ,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Marquee(
                child: Text(
                  rootBloc.state.httpAddress ?? kCouldNotRunTorString,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: kColorAlmostWhite,
                  ),
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                if (rootBloc.state.httpAddress == null) {
                  final snackBar = SnackBar(content: Text(kNothingToCopyString));
                  Scaffold.of(context).showSnackBar(snackBar);
                } else {
                  ClipboardManager.copyToClipBoard(rootBloc.state.httpAddress).then((result) {
                    final snackBar = SnackBar(content: Text(kCopiedToClipboardString));
                    Scaffold.of(context).showSnackBar(snackBar);
                  });
                }
              },
              icon: Icon(Icons.content_copy),
              color: kColorAlmostWhite,
              padding: const EdgeInsets.all(0),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Marquee(
                child: Text(
                  rootBloc.state?.torPublicKey ?? kCouldNotRunTorString,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: kColorAlmostWhite,
                  ),
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                if (rootBloc.state.torPublicKey == null) {
                  final snackBar = SnackBar(content: Text(kNothingToCopyString));
                  Scaffold.of(context).showSnackBar(snackBar);
                } else {
                  ClipboardManager.copyToClipBoard(rootBloc.state.torPublicKey).then((result) {
                    final snackBar = SnackBar(content: Text(kCopiedToClipboardString));
                    Scaffold.of(context).showSnackBar(snackBar);
                  });
                }
              },
              icon: Icon(Icons.content_copy),
              color: kColorAlmostWhite,
              padding: const EdgeInsets.all(0),
            ),
          ],
        ),
      ],
    );
  }
}