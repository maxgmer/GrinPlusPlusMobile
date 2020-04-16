import 'package:clipboard_manager/clipboard_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grin_plus_plus/colors.dart';
import 'package:grin_plus_plus/models/input_output.dart';
import 'package:grin_plus_plus/models/transaction.dart';
import 'package:grin_plus_plus/screens/wallet_screen/bloc/bloc.dart';
import 'package:grin_plus_plus/strings.dart';
import 'package:grin_plus_plus/widgets/container_if_null_widget.dart';
import 'package:marquee_widget/marquee_widget.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class TxDetailsPanel extends StatelessWidget {
  final PanelController panelController;

  TxDetailsPanel(this.panelController);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(60),
        topRight: Radius.circular(60),
      ),
      color: kColorBackgroundGrey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: kColorBackgroundGreyLight)),
            ),
            width: double.infinity,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Text(
              kTransactionDetailsString,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: kColorAlmostWhite,
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<WalletScreenBloc, WalletScreenState>(
              builder: (context, state) {
                if (state.selectedTransaction == null) {
                  return Container();
                }
                final Orientation orientation = MediaQuery.of(context).orientation;
                final bool isLandscape = orientation == Orientation.landscape;

                if (isLandscape) {
                  return TxDetailsContentLandscape(
                    state.selectedTransaction,
                    panelController,
                  );
                } else {
                  return TxDetailsContentPortrait(
                    state.selectedTransaction,
                    panelController,
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class TxDetailsContentPortrait extends StatelessWidget {
  final Transaction selectedTx;
  final PanelController panelController;

  TxDetailsContentPortrait(this.selectedTx, this.panelController);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 12),
          child: ShowIfTrue(
            boolean: selectedTx.typeEnum == TransactionType.sendingStarted ||
                selectedTx.typeEnum == TransactionType.receivingInProgress,
            builder: () => Center(
              child: RaisedButton(
                onPressed: () {
                  panelController.close();
                  BlocProvider.of<WalletScreenBloc>(context)
                      .add(CancelTransaction(selectedTx));
                },
                color: kColorErrorRed,
                child: Text(
                  kCancelTransactionString,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: TxDetails(selectedTx, false),
        ),
        Expanded(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: TxOutputs(selectedTx.outputs),
            ),
          ),
        ),
      ],
    );
  }
}

class TxDetailsContentLandscape extends StatelessWidget {
  final Transaction selectedTx;
  final PanelController panelController;

  TxDetailsContentLandscape(this.selectedTx, this.panelController);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 12),
          child: ShowIfTrue(
            boolean: selectedTx.typeEnum == TransactionType.sendingStarted ||
                selectedTx.typeEnum == TransactionType.receivingInProgress,
            builder: () => Center(
              child: RaisedButton(
                onPressed: () {
                  panelController.close();
                  BlocProvider.of<WalletScreenBloc>(context)
                      .add(CancelTransaction(selectedTx));
                },
                color: kColorErrorRed,
                child: Text(
                  kCancelTransactionString,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 16, top: 16, bottom: 16),
                child: TxDetails(selectedTx, true),
              ),
              Expanded(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: TxOutputs(selectedTx.outputs),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class TxOutputs extends StatelessWidget {
  final List<InputOutput> outputs;

  TxOutputs(this.outputs);

  @override
  Widget build(BuildContext context) {
    return ShowIfTrue(
      boolean: (outputs?.length ?? 0) != 0,
      builder: () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Text(
              '$kOutputsString: ',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: kColorAlmostWhite,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: outputs.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                InputOutput txOutput = outputs[index];
                return TxOutputDetails(txOutput);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class TxDetails extends StatelessWidget {
  final Transaction tx;
  final bool isLandscape;

  TxDetails(this.tx, this.isLandscape);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isLandscape
          ? MediaQuery.of(context).size.width * 0.5
          : MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ShowIfTrue(
            boolean: tx.id != null,
            builder: () => Row(
              children: <Widget>[
                Text(
                  '$kIdString: ',
                  style: TextStyle(
                    color: kColorAlmostWhite,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  tx.id.toString(),
                  style: TextStyle(
                    color: kColorAlmostWhite,
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          ShowIfTrue(
            boolean: tx.slateId != null,
            builder: () => Row(
              children: <Widget>[
                Text(
                  '$kSlateIdString: ',
                  style: TextStyle(
                    color: kColorAlmostWhite,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  '${tx.slateId.substring(0, 8)}...'
                      '${tx.slateId.substring(tx.slateId.length - 8, tx.slateId.length)}',
                  style: TextStyle(
                    color: kColorAlmostWhite,
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                ),
                Container(
                  height: 24,
                  alignment: Alignment.center,
                  child: IconButton(
                    onPressed: () {
                      ClipboardManager.copyToClipBoard(tx.slateId).then((result) {
                        final snackBar = SnackBar(content: Text(kCopiedToClipboardString));
                        Scaffold.of(context).showSnackBar(snackBar);
                      });
                    },
                    icon: Icon(Icons.content_copy),
                    color: kColorAlmostWhite,
                    padding: const EdgeInsets.all(0),
                  ),
                ),
              ],
            ),
          ),
          ShowIfTrue(
            boolean: tx.slateMessage != null,
            builder: () => Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  '$kMessageString: ',
                  style: TextStyle(
                    color: kColorAlmostWhite,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: Marquee(
                      animationDuration: Duration(milliseconds: tx.slateMessage.length * 100),
                      backDuration: Duration(milliseconds: tx.slateMessage.length * 100),
                      child: Text(
                        tx.slateMessage,
                        maxLines: 1,
                        style: TextStyle(
                          color: kColorAlmostWhite,
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          ShowIfTrue(
            boolean: tx.amountCredited != null,
            builder: () => Row(
              children: <Widget>[
                Text(
                  '$kCreditedString: ',
                  style: TextStyle(
                    color: kColorAlmostWhite,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  tx.amountCreditedDouble.toStringAsFixed(9),
                  style: TextStyle(
                    color: kColorAlmostWhite,
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                ),
                SvgPicture.asset(
                  'assets/images/grin-logo-eyes.svg',
                  width: 24,
                  height: 24,
                  color: kColorAlmostWhite,
                ),
              ],
            ),
          ),
          ShowIfTrue(
            boolean: tx.amountDebited != null,
            builder: () => Row(
              children: <Widget>[
                Text(
                  '$kDebitedString: ',
                  style: TextStyle(
                    color: kColorAlmostWhite,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  tx.amountDebitedDouble.toStringAsFixed(9),
                  style: TextStyle(
                    color: kColorAlmostWhite,
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                ),
                SvgPicture.asset(
                  'assets/images/grin-logo-eyes.svg',
                  width: 24,
                  height: 24,
                  color: kColorAlmostWhite,
                ),
              ],
            ),
          ),
          ShowIfTrue(
            boolean: tx.confirmedHeight != null,
            builder: () => Row(
              children: <Widget>[
                Text(
                  '$kConfirmedHeightString: ',
                  style: TextStyle(
                    color: kColorAlmostWhite,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  tx.confirmedHeight.toString(),
                  style: TextStyle(
                    color: kColorAlmostWhite,
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          ShowIfTrue(
            boolean: tx.creationTime != null,
            builder: () => Row(
              children: <Widget>[
                Text(
                  '$kConfirmedDateTimeString: ',
                  style: TextStyle(
                    color: kColorAlmostWhite,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  tx.creationTime.toString(),
                  style: TextStyle(
                    color: kColorAlmostWhite,
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TxOutputDetails extends StatelessWidget {
  final InputOutput txOutput;

  TxOutputDetails(this.txOutput);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget> [
          ShowIfTrue(
            boolean: txOutput.commitment != null,
            builder: () => Row(
              children: <Widget>[
                Text(
                  '$kCommitmentString: ',
                  style: TextStyle(
                    color: kColorAlmostWhite,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                Text(
                  '${txOutput.commitment.substring(0, 8)}...'
                      '${txOutput.commitment.substring(txOutput.commitment.length - 8, txOutput.commitment.length)}',
                  style: TextStyle(
                    color: kColorAlmostWhite,
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                ),
                Container(
                  height: 24,
                  alignment: Alignment.center,
                  child: IconButton(
                    onPressed: () {
                      ClipboardManager.copyToClipBoard(txOutput.commitment).then((result) {
                        final snackBar = SnackBar(content: Text(kCopiedToClipboardString));
                        Scaffold.of(context).showSnackBar(snackBar);
                      });
                    },
                    icon: Icon(Icons.content_copy),
                    color: kColorAlmostWhite,
                    padding: const EdgeInsets.all(0),
                  ),
                ),
              ],
            ),
          ),
          ShowIfTrue(
            boolean: txOutput.keychainPath != null,
            builder: () => Row(
              children: <Widget>[
                Text(
                  '$kKeychainPathString: ',
                  style: TextStyle(
                    color: kColorAlmostWhite,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                Text(
                  txOutput.keychainPath,
                  style: TextStyle(
                    color: kColorAlmostWhite,
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          ShowIfTrue(
            boolean: txOutput.amountDouble != null,
            builder: () => Row(
              children: <Widget>[
                Text(
                  '$kAmountString: ',
                  style: TextStyle(
                    color: kColorAlmostWhite,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                Text(
                  txOutput.amountDouble.toStringAsFixed(9),
                  style: TextStyle(
                    color: kColorAlmostWhite,
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                ),
                SvgPicture.asset(
                  'assets/images/grin-logo-eyes.svg',
                  width: 20,
                  height: 20,
                  color: kColorAlmostWhite,
                ),
              ],
            ),
          ),
          ShowIfTrue(
            boolean: txOutput.status != null,
            builder: () => Row(
              children: <Widget>[
                Text(
                  '$kStatusString: ',
                  style: TextStyle(
                    color: kColorAlmostWhite,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                Text(
                  txOutput.status,
                  style: TextStyle(
                    color: kColorAlmostWhite,
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          ShowIfTrue(
            boolean: txOutput.mmrIndex != null,
            builder: () => Row(
              children: <Widget>[
                Text(
                  '$kMmrIndexString: ',
                  style: TextStyle(
                    color: kColorAlmostWhite,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                Text(
                  txOutput.mmrIndex.toString(),
                  style: TextStyle(
                    color: kColorAlmostWhite,
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          ShowIfTrue(
            boolean: txOutput.blockHeight != null,
            builder: () => Row(
              children: <Widget>[
                Text(
                  '$kBlockHeightString: ',
                  style: TextStyle(
                    color: kColorAlmostWhite,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                Text(
                  txOutput.blockHeight.toString(),
                  style: TextStyle(
                    color: kColorAlmostWhite,
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
