import 'package:flutter/material.dart';
import 'draggable-slide-up.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Animated Slide Up Demo',
      theme: ThemeData(),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Animated Slide Up Demo'),
        ),
        body: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Expanded(
                child: Center(
                  child: Text('This is an example of an Animated Slide Up'),
                ),
                flex: 15),
            Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Text('Pull up on the dragTab to see the Slide Up'),
                ),
                flex: 1),
            Expanded(
                child: Align(
                    alignment: Alignment.topCenter,
                    child: Icon(
                      Icons.arrow_downward,
                      size: 40,
                    )),
                flex: 5),
          ]),
        ),

        /// `DraggableSlideUp` Returns a Positioned widget that can be dragged upwards to display itself. Since it is a Positioned widget it MUST be a direct descendent of a Stack widget.
        DraggableSlideUp(
          /// `dragTab` The tab part that the user drags to open the slide up
          dragTab: Container(
            height: 30,
            decoration: BoxDecoration(color: Colors.blue[600]),
            child: Center(
                child: Icon(
              Icons.drag_handle,
              color: Colors.white,
            )),
          ),

          /// `dragTabHeight` Should be the same height as the dragtab widget (this is the part that's wacky)
          dragTabHeight: 30,

          /// `decoration` Optional decoration attribute to apply to the slide up
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment(0.0, 1.0),
                  end: Alignment(0.0, -1.0),
                  colors: [Color(0xFF44BBFF), Color(0xAA44BBFF)])),

          /// `child` The main content of the the slide up. As you can see, in this example the container is sized via margins on all sides. This means that this containers size is based on the `height` attribute defined in the next section.
          child: Container(
            margin: EdgeInsets.all(50),
            decoration: BoxDecoration(color: Colors.blue[100]),
            child: Center(child: Text('Slide Up Content')),
          ),

          /// `height` The main height of the entire slide up (including the `dragTab`).
          height: 400,

          /// `startBottom` Where the Slide Up should start (it's retracted position). This should be at 0 in order to be fully hidden.
          startBottom: 0,

          /// `offsetBottom` When expanded, the distance from the bottom of the screen
          offsetBottom: 0,

          /// These next two attributes define the width of the Slide Up
          /// `left` The amount of space from the left of the screen to the Slide Up
          left: 5,

          /// `right` The amount of space from the right of the screen to the Slide Up
          right: 5,

          /// `curve` The `Curve` widget that will define the Tween. This attribute cannot be hot reloaded :/ sorri. Default is Curves.elasticOut.
          curve: Curves.elasticOut,

          /// `extended` If set to true then the slide up will be extended
          extended: false,
        ),
      ],
    );
  }
}
