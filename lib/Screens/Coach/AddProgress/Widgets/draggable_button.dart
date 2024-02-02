import 'package:flutter/material.dart';

class DraggableButton extends StatefulWidget {
  @override
  _DraggableButtonState createState() => _DraggableButtonState();
}

class _DraggableButtonState extends State<DraggableButton> {
  Offset position = Offset(0, 0);
  int score = 0;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: position.dx,
      top: position.dy,
      child: Draggable(
        child: ElevatedButton(
          onPressed: () {
            _showDialog();
          },
          child: Text('$score'),
        ),
        feedback: Container(
          width: 300.0,
          height: 50.0,
          color: Colors.yellow, // Set the color to yellow
          child: Center(
            child: Text('$score', style: TextStyle(color: Colors.black)),
          ),
        ),
        onDraggableCanceled: (velocity, offset) {
          setState(() {
            position = offset;
          });
        },
        childWhenDragging: Container(), // Hide the button while dragging
      ),
    );
  }

  Future<void> _showDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Score'),
          content: TextField(
            keyboardType: TextInputType.number,
            onChanged: (value) {
              setState(() {
                score = int.tryParse(value) ?? 0;
              });
            },
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
