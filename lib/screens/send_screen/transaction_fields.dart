import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grin_plus_plus/colors.dart';
import 'package:grin_plus_plus/screens/send_screen/bloc/bloc.dart';
import 'package:grin_plus_plus/screens/send_screen/transport_type.dart';
import 'package:grin_plus_plus/strings.dart';
import 'package:grin_plus_plus/widgets/text_field.dart';

class TransactionFields extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TransactionFieldsState();
}

class _TransactionFieldsState extends State<TransactionFields> {
  SendScreenBloc _bloc;
  TextEditingController _amountController;
  TextEditingController _messageController;
  TextEditingController _addressController;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<SendScreenBloc>(context);
    _amountController = TextEditingController();
    _messageController = TextEditingController();
    _addressController = TextEditingController();
    _amountController.addListener(() {
      if (_amountController.text != null && _amountController.text.isNotEmpty)
      _bloc.add(AmountChanged(double.tryParse(_amountController.text)));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 24, right: 24, top: 24, bottom: 12),
          child: BlocBuilder<SendScreenBloc, SendScreenState>(
            builder: (context, state) => BorderedTextField(
              boxColor: state.amountError == null || state.amountError.isEmpty
                  ? kColorAlmostWhite
                  : kColorErrorRed,
              labelColor: state.amountError == null || state.amountError.isEmpty
                  ? kColorAlmostWhite
                  : kColorErrorRed,
              labelText: state.amountError == null || state.amountError.isEmpty
                  ? kAmountString
                  : state.amountError,
              controller: _amountController,
              keyboardType: TextInputType.numberWithOptions(),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          child: BorderedTextField(
            labelText: kMessageString,
            controller: _messageController,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          child: BlocBuilder<SendScreenBloc, SendScreenState>(
            builder: (context, state) {
              String label;
              if (state.transportType == TransportType.file) {
                label = kFilenameString;
              } else {
                label = kAddressString;
              }
              return BorderedTextField(
                labelText: label,
                controller: _addressController,
              );
            }
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: BlocBuilder<SendScreenBloc, SendScreenState>(
            builder: (context, state) => Text(
              'Fee to pay: ${state?.estimatedFee ?? 0.toStringAsFixed(9)}',
              style: TextStyle(
                color: kColorAlmostWhite,
                fontWeight: FontWeight.w300,
                fontSize: 15,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 90),
          child: IconButton(
            padding: const EdgeInsets.all(24),
            onPressed: () {},
            tooltip: kSendString,
            icon: Icon(
              Icons.send,
              color: kColorAlmostWhite,
              size: 28,
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }
}