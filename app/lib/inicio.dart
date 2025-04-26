import "package:flutter/material.dart";
import "package:flutter_svg/svg.dart";

class Start extends StatelessWidget {
  const Start({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SvgPicture.asset("assets/images/logo.svg"),
        ElevatedButton(onPressed: () {}, child: Text("Entrar")),
      ],
    );
  }
}
