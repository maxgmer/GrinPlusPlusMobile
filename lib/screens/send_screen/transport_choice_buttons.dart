import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grin_plus_plus/colors.dart';
import 'package:grin_plus_plus/screens/send_screen/bloc/bloc.dart';
import 'package:grin_plus_plus/screens/send_screen/transport_type.dart';
import 'package:grin_plus_plus/strings.dart';

class TransportChoiceButtons extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TransportChoiceButtonsState();
}

class _TransportChoiceButtonsState extends State<TransportChoiceButtons> {
  SendScreenBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<SendScreenBloc>(context);
  }
  
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SendScreenBloc, SendScreenState>(
      builder: (context, state) => Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Column(
            children: <Widget>[
              Radio<TransportType>(
                groupValue: state.transportType,
                value: TransportType.file,
                onChanged: (selectedTransport) {
                  _bloc.add(ChangeTransportType(selectedTransport));
                },
                activeColor: kColorAlmostWhite,
              ),
              Text(
                kFileString,
                style: TextStyle(
                  fontSize: 17,
                  color: kColorAlmostWhite,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          Column(
            children: <Widget>[
              Radio<TransportType>(
                groupValue: state.transportType,
                value: TransportType.http,
                onChanged: (selectedTransport) {
                  _bloc.add(ChangeTransportType(selectedTransport));
                },
                activeColor: kColorAlmostWhite,
              ),
              Text(
                kHttpString,
                style: TextStyle(
                  fontSize: 17,
                  color: kColorAlmostWhite,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          Column(
            children: <Widget>[
              Radio<TransportType>(
                groupValue: state.transportType,
                value: TransportType.tor,
                onChanged: (selectedTransport) {
                  _bloc.add(ChangeTransportType(selectedTransport));
                },
                activeColor: kColorAlmostWhite,
              ),
              Text(
                kTorString,
                style: TextStyle(
                  fontSize: 17,
                  color: kColorAlmostWhite,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}