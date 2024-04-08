
import 'package:flutter/material.dart';
import '../../utils/size_config.dart';
import 'loading.dart';

// ShowLoading Widget - SHOW LOADING WIDGET WHEN inAsyncCall IS TRUE
//============================================================================================
class ShowLoading extends StatelessWidget {
  final Widget child;
  final bool inAsyncCall;
  final double opacity;
  final Color color;
  final Animation<Color>? valueColor;

  const ShowLoading({
    Key? key,
    required this.child,
    required this.inAsyncCall,
    this.opacity = 0.1,
    this.color = Colors.black,
    this.valueColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetList = <Widget>[];
    widgetList.add(child);
    if (inAsyncCall) {
      final modal = SizedBox(
        height: SizeConfig.heightMultiplier * 100,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Opacity(
              opacity: opacity,
              child: ModalBarrier(dismissible: false, color: color),
            ),
            // ignore: prefer_const_constructors
            Container(
              height: SizeConfig.heightMultiplier*10,
              width: SizeConfig.widthMultiplier*20,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12)
              ),
              child: LoadingWidget(height: SizeConfig.heightMultiplier * 100),
            )
          ],
        ),
      );
      widgetList.add(modal);
    }
    return Stack(
      children: widgetList,
    );
  }
}
