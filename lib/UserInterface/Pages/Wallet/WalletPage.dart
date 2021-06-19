import 'package:getparked/UserInterface/Pages/Wallet/Wallet.dart';
import 'package:flutter/cupertino.dart';

class WalletPage extends StatefulWidget {
  @override
  _WalletPageState createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [Wallet()],
      ),
    );
  }
}
