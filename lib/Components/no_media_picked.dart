import 'package:flutter/material.dart';

class NoMediaPicked extends StatelessWidget {
  const NoMediaPicked({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
          ),
          borderRadius: BorderRadius.circular(9)),
      child: const Center(child: Text('Click attach button to pick video')),
    );
  }
}
