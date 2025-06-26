import 'package:flutter/material.dart';

class CustomHeader extends StatefulWidget {
  final String title;
  const CustomHeader({super.key, this.title = ""});

  @override
  State<CustomHeader> createState() => _CustomHeaderState();
}

class _CustomHeaderState extends State<CustomHeader> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: 200,
          child: Image.asset(
            'assets/images/header.png',
            width: double.infinity,
            height: 200,
            fit: BoxFit.cover,
            alignment: Alignment.bottomCenter,
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: widget.title == "" ? 25 : 15),
          height: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                      color: Colors.yellow,
                      borderRadius: BorderRadius.circular(100)),
                  child: ClipOval(
                    child: Image.asset(
                      'assets/images/logo_hanaang.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              widget.title == ""
                  ? Container()
                  : Text(widget.title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            offset: Offset(1, 1),
                            blurRadius: 2.0,
                            color: Colors.white,
                          ),
                          Shadow(
                            offset: Offset(-1, -1),
                            blurRadius: 2.0,
                            color: Colors.white,
                          ),
                          Shadow(
                            offset: Offset(1, -1),
                            blurRadius: 2.0,
                            color: Colors.white,
                          ),
                          Shadow(
                            offset: Offset(-1, 1),
                            blurRadius: 2.0,
                            color: Colors.white,
                          ),
                        ],
                      )),
            ],
          ),
        )
      ],
    );
  }
}
