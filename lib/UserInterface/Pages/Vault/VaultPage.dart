import 'package:getparked/UserInterface/Pages/Vault/Vault.dart';
import 'package:flutter/material.dart';
import 'package:getparked/UserInterface/Widgets/Loaders/LoaderPage.dart';

class VaultPage extends StatefulWidget {
  @override
  _VaultPageState createState() => _VaultPageState();
}

class _VaultPageState extends State<VaultPage> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          LoaderPage(),
          (isLoading) ? Container(height: 0, width: 0) : Vault()
        ],
      ),
    );
  }
}
