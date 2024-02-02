import 'dart:io';
import 'dart:typed_data';

import 'package:basketball_coaching/Components/back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';

List<int> scores = [0];

class LeaderboardScreen extends StatefulWidget {
  final void Function(Uint8List?, List<int>?)? onScreenshotTaken;
  LeaderboardScreen({
    super.key,
    required this.onScreenshotTaken,
  });
  @override
  _DraggableButtonScreenState createState() => _DraggableButtonScreenState();
}

class _DraggableButtonScreenState extends State<LeaderboardScreen> {
  List<DraggableButton> draggableButtons = [];
  ScreenshotController screenshotController = ScreenshotController();

  void _takeScreenshot() {
    screenshotController
        .capture(delay: Duration(milliseconds: 10))
        .then((capturedImage) {
      scores.removeWhere((score) => score == 0);
      final nonZeroScores =
          scores.where((score) => score != 0 && score <= 10).toList();
      widget.onScreenshotTaken?.call(
        nonZeroScores.isEmpty ? null : capturedImage!,
        nonZeroScores.isEmpty ? [] : nonZeroScores,
      );
      Navigator.pop(context);
    }).catchError((onError) {
      print(onError);
    });
  }

  Future<File> saveImageToFile(Uint8List capturedImage) async {
    final tempDir = await getTemporaryDirectory();
    final file = File('${tempDir.path}/captured_image.png');
    await file.writeAsBytes(capturedImage);
    return file;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Screenshot(
            controller: screenshotController,
            child: Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/leaderboard.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                ...draggableButtons,
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10.w),
            child: Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                onPressed: _addNewButton,
                backgroundColor: Colors.black.withOpacity(0.5),
                shape: const CircleBorder(),
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 20),
            width: MediaQuery.of(context).size.width,
            height: 70,
            color: const Color.fromRGBO(0, 0, 0, 0.5),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  backButton(),
                  const Center(
                    child: Text(
                      'Assign Score',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 30),
                    child: GestureDetector(
                      onTap: _takeScreenshot,
                      child: const Text(
                        "Done",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ]),
          ),
        ],
      ),
    );
  }

  void _addNewButton() {
    setState(() {
      draggableButtons.add(DraggableButton(
        onScoreChanged: (newScore) {
          scores.add(newScore);
        },
      ));
    });
  }

  Widget backButton() {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Row(
          children: [
            const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
              size: 14,
            ),
            SizedBox(
              width: 16.w,
            ),
            Text(
              'Back',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12.sp,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
                height: 0,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class DraggableButton extends StatefulWidget {
  final void Function(int) onScoreChanged;

  DraggableButton({required this.onScoreChanged});
  @override
  _DraggableButtonState createState() => _DraggableButtonState();
}

class _DraggableButtonState extends State<DraggableButton> {
  Offset position = Offset(100.w, 100.h);
  int score = 0;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: position.dx,
      top: position.dy,
      child: Draggable(
        feedback: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Color.fromRGBO(171, 124, 230, 1),
          ),
          onPressed: () {
            _showDialog();
          },
          child: Text(
            '$score',
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        onDraggableCanceled: (velocity, offset) {
          setState(() {
            position = offset;
          });
        },
        childWhenDragging: Container(),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Color.fromRGBO(171, 124, 230, 1),
          ),
          onPressed: () {
            _showDialog();
          },
          child: Text(
            '$score',
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
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
                if (score != 0 && score <= 10) {
                  widget.onScoreChanged(score);
                }
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

//for example
class CapturedImageScreen extends StatelessWidget {
  final Uint8List capturedImage;

  CapturedImageScreen({required this.capturedImage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Captured Image'),
      ),
      body: Center(
        child: Image.memory(capturedImage),
      ),
    );
  }
}
