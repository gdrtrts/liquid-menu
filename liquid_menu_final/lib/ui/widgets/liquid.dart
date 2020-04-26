import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:liquid_menu/core/viewmodels/home_model.dart';
import 'package:liquid_menu/ui/shared/globals.dart';
import 'package:lottie/lottie.dart';
import 'package:neumorphic/neumorphic.dart';
import 'package:provider/provider.dart';

class Liquid extends StatelessWidget {
  final bool isFlipped;
  final AnimationController controller;

  Liquid({
    @required this.isFlipped,
    @required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<HomeModel>(context);

    final double height = 200.0;

    return Center(
      child: AnimatedContainer(
        duration: Duration(milliseconds: 2000),
        curve: Curves.elasticOut,
        transform: Matrix4.identity()
          ..translate(
            0.0,
            isFlipped ? -model.openValue - 100 : model.openValue + 100,
          ),
        decoration: BoxDecoration(
          color: Global.bgColor,
          boxShadow: [
            BoxShadow(
              blurRadius: 30.0,
              color: !isFlipped ? Colors.grey[350] : Colors.white,
              offset: Offset(isFlipped ? -20 : 20, isFlipped ? -30 : 30),
            ),
          ],
          borderRadius: BorderRadius.all(
            Radius.circular(15.0),
          ),
        ),
        height: height,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Transform(
              transform: Matrix4.identity()
                ..scale(1.0, isFlipped ? -1.0 : 1.0)
                ..translate(0.0, isFlipped ? -height * 2 + 50 : -height + 50),
              child: Lottie.asset(
                'data/liquid.json',
                controller: controller,
                animate: false,
                height: height,
                delegates: LottieDelegates(
                  values: [
                    ValueDelegate.color(
                      const ['**', 'Rectangle 1', 'Fill 1'],
                      value: Global.bgColor,
                      // value: Colors.red,
                    ),
                    ValueDelegate.color(const ['**', 'Shape 1', 'Fill 1'],
                        value: Global.bgColor),
                    // value: Colors.red),
                  ],
                ),
              ),
            ),
            isFlipped
                ? SizedBox()
                : GestureDetector(
                    onTap: () {
                      model.openLiquidMenu(controller);
                    },
                    child: NeuCard(
                      curveType: model.isOpening
                          ? CurveType.emboss
                          : CurveType.concave,
                      width: 88,
                      height: 88,
                      bevel: 16,
                      decoration: NeumorphicDecoration(
                        color:
                            model.isOpening ? Global.activeColor : Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        model.isOpening ? Icons.lock_open : Icons.lock,
                        color: Colors.pinkAccent,
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
