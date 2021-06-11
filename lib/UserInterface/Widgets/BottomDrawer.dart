import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomDrawer extends StatefulWidget {
  double height;
  Function getController;
  Widget child;

  BottomDrawer(
      {@required this.height,
      @required this.getController,
      @required this.child});

  @override
  _BottomDrawerState createState() => _BottomDrawerState();
}

class BottomDrawerController {
  Function open;
  Function close;

  BottomDrawerController({this.close, this.open});
}

class _BottomDrawerState extends State<BottomDrawer>
    with SingleTickerProviderStateMixin {
  BottomDrawerController qbBottomDrawerController;
  AnimationController qbBottomDrawerAnimController;
  Animation<double> qbBottomDrawerHeightAnim;

  @override
  void initState() {
    super.initState();

    qbBottomDrawerAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );

    qbBottomDrawerHeightAnim = Tween<double>(begin: 0.0, end: widget.height)
        .animate(qbBottomDrawerAnimController)
          ..addListener(() {
            setState(() {});
          });

    qbBottomDrawerController = BottomDrawerController(open: () {
      qbBottomDrawerAnimController.forward();
    }, close: () {
      qbBottomDrawerAnimController.reverse();
    });
  }

  @override
  Widget build(BuildContext context) {
    widget.getController(qbBottomDrawerController);

    return AnimatedBuilder(
      animation: qbBottomDrawerAnimController,
      builder: (context, child) {
        return Positioned(
          top: MediaQuery.of(context).size.height -
              qbBottomDrawerHeightAnim.value,
          height: widget.height,
          width: MediaQuery.of(context).size.width,
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    offset: Offset(0, -4),
                    blurRadius: 1,
                    color: Color.fromRGBO(0, 0, 0, 0.03),
                    spreadRadius: 0.25)
              ],
              color: Colors.transparent,
            ),
            height: widget.height,
            child: widget.child,
          ),
        );
      },
    );
  }
}
