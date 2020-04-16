import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grin_plus_plus/colors.dart';
import 'package:grin_plus_plus/screens/send_screen/bloc/bloc.dart';
import 'package:grin_plus_plus/screens/send_screen/transport_type.dart';
import 'package:grin_plus_plus/strings.dart';
import 'package:grin_plus_plus/widgets/text_field.dart';

class SendTransactionFields extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SendTransactionFieldsState();
}

class _SendTransactionFieldsState extends State<SendTransactionFields> {
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
      _bloc.add(AmountChanged(double.tryParse(_amountController.text.replaceAll(',', '.'))));
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SendScreenBloc, SendScreenState>(
      builder: (context, state) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 24, top: 24, bottom: 4),
            child: Text(
              '$kFeeToPayString: ${state?.estimatedFee?.toStringAsFixed(9) ?? 0.toStringAsFixed(9)}',
              style: TextStyle(
                color: kColorAlmostWhite,
                fontWeight: FontWeight.w300,
                fontSize: 15,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 24, right: 24, bottom: 8),
            child: BorderedTextField(
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: BorderedTextField(
              labelText: kMessageString,
              controller: _messageController,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: Builder(
              builder: (context) {
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
          Builder(
            builder: (context) {
              if (state.transportType == TransportType.http ||
                  state.transportType == TransportType.tor) {
                return Tooltip(
                  showDuration: Duration(seconds: 5),
                  waitDuration: Duration(milliseconds: 1),
                  message: kGrinJoinInfoString,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Checkbox(
                        value: state.grinJoin,
                        onChanged: (grinJoin) => _bloc.add(GrinJoin(grinJoin)),
                        activeColor: kColorAlmostWhite,
                        checkColor: Colors.black,
                        materialTapTargetSize: MaterialTapTargetSize.padded,
                      ),
                      Text(
                        kGrinJoinString,
                        style: TextStyle(
                          color: kColorAlmostWhite,
                          fontWeight: FontWeight.w300,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                );
              }
              return Container();
            },
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 120),
              child: IconButton(
                padding: const EdgeInsets.all(24),
                onPressed: () => _bloc.add(Send(
                  amount: double.tryParse(_amountController.text.replaceAll(',', '.')),
                  address: _addressController.text,
                  message: _messageController.text,
                )),
                tooltip: kSendString,
                icon: Icon(
                  Icons.send,
                  color: kColorAlmostWhite,
                  size: 28,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}