import 'package:flutter/material.dart';

class BirdImage extends StatefulWidget {

  final String url;

  const BirdImage({super.key, required this.url});

  @override
  State<BirdImage> createState() => _BirdImageState();
}

class _BirdImageState extends State<BirdImage> {
  late  bool _taken = false;

  void _onImageTaken(){
    setState(() {
      _taken = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Container(
      decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(widget.url),
            fit: BoxFit.cover,
            colorFilter: _taken ? null : const ColorFilter.mode(Colors.grey, BlendMode.color),
          )
      ),
    );
  }


}
