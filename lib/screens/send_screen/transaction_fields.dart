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
  TextEditingController _feeController;
  TextEditingController _messageController;
  TextEditingController _addressController;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<SendScreenBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 24, right: 24, top: 24, bottom: 12),
          child: Row(
            children: <Widget>[
              Flexible(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: BorderedTextField(
                    labelText: kAmountString,
                    controller: _amountController,
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: BorderedTextField(
                    labelText: kFeeString,
                    controller: _feeController,
                    enabled: false,
                  ),
                ),
              ),
            ],
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