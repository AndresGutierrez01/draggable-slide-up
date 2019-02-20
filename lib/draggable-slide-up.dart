import 'package:flutter/material.dart';

//edit speed here :/ wacky
const int milliseconds = 400;


class DraggableSlideUpState extends State<DraggableSlideUp>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation;
  CurveTween curveTween;

  double posYBottom = 0;
  double posYTop = 0;
  double offsetBottom = 0;
  double offsetTop = 0;
  double startDragDY = 0;
  double endVelocity = 0;
  Widget dragTab;
  BoxDecoration decoration;
  double height;
  bool extended;

  @override
  void initState() {
    super.initState();

    if(widget.curve == null){
      curveTween = CurveTween(curve: Curves.elasticOut);
    }
    else{
      curveTween = CurveTween(curve: widget.curve);
    }
    controller = AnimationController(
        duration: const Duration(milliseconds: milliseconds), vsync: this);
    animation = Tween<double>(
            begin: widget.startBottom - widget.height + widget.dragTabHeight,
            end: widget.startBottom - widget.height + widget.dragTabHeight)
        .chain(curveTween)
        .animate(controller);
    animation.addListener(() {
      setState(() {
        posYBottom = animation.value;
        posYTop = null;
      });
    });
    posYBottom = widget.startBottom - widget.height + widget.dragTabHeight;
    posYTop = null;
    extended = widget.extended;
  }

  void extend() {
    animation = Tween<double>(begin: posYBottom, end: offsetBottom)
        .chain(curveTween)
        .animate(controller);

    controller.reset();
    controller.forward();
  }

  void retract() {
    animation = Tween<double>(
            begin: posYBottom,
            end: widget.startBottom - height + widget.dragTabHeight)
        .chain(curveTween)
        .animate(controller);

    controller.reset();
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.dragTab == null) {
      dragTab = Container(child: Icon(Icons.drag_handle));
    } else {
      dragTab = widget.dragTab;
    }
    if (widget.decoration == null) {
      decoration = BoxDecoration();
    } else {
      decoration = widget.decoration;
    }

    height = widget.height;
    offsetBottom = widget.offsetBottom;



    if(extended){
      extend();
      extended = false;
    }

    return Positioned(
        bottom: posYBottom,
        // top: posYTop,
        height: height,
        left: widget.left,
        right: widget.right,
        child: GestureDetector(
          onVerticalDragUpdate: (details) {
            setState(() {
              Offset offset = details.globalPosition;
              posYBottom = startDragDY - offset.dy;
            });
          },
          onVerticalDragStart: (details) {
            setState(() {
              Offset offset = details.globalPosition;
              startDragDY = offset.dy + posYBottom;
            });
          },
          onVerticalDragEnd: (details) {
            setState(() {
              Velocity velocityEndVelocity = details.velocity;
              Offset offsetEndVelocity = velocityEndVelocity.pixelsPerSecond;
              endVelocity = offsetEndVelocity.dy;

              if (endVelocity <= 0) {
                extend();
              } else if (endVelocity > 100) {
                retract();
              }
            });
          },
          child: Container(
            decoration: decoration,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                dragTab,
                Expanded(child: widget.child),
              ],
            ),
          ),
        ));
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class DraggableSlideUp extends StatefulWidget {
  /// Creates a `Positioned` widget that detects swipe gestures in the vertical direction
  ///
  /// Must be a direct descendent of a `Stack` widget in order to work properly
  ///
  ///
  ///
  DraggableSlideUp(
      {this.key,
      this.child,
      this.dragTab,
      this.dragTabHeight,
      this.left: 5,
      this.right: 5,
      this.height: 300,
      this.startBottom: 0,
      this.slideTop,//not yet implemented
      this.offsetBottom:0,
      this.offsetTop,//not yet implemented
      this.decoration,
      this.curve,
      this.extended:false});

  final Key key;
  final Widget child;
  final Widget dragTab;
  final double dragTabHeight;
  final double left;
  final double right;
  final double offsetBottom;
  final double offsetTop;//not yet implemented
  final double startBottom;
  final double slideTop; //not yet implemented
  final double height;
  final BoxDecoration decoration;
  final bool extended;
  final Curve curve;
  DraggableSlideUpState createState() {
    return DraggableSlideUpState();
  }

}
