import 'package:app/screens/components/carousel_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:app/screens/login.dart';
import 'package:app/screens/components/primary_button.dart';
import 'package:app/screens/theme/theme.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> texts = [
      "Registre seus Livros",
      "Faça anotações",
      "visualize seu progresso",
    ];

    return SafeArea(
      child: Container(
        decoration: AppBackgroundProperties.boxDecoration,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  //SvgPicture.asset("assets/images/background.svg"),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      //SvgPicture.asset("assets/images/logo.svg"),
                      CarouselSlider(
                        items: List.generate(
                          3,
                          (int i) => CarouselItem(text: texts[i], index: i),
                        ),
                        options: CarouselOptions(
                          autoPlay: true,
                          height: MediaQuery.of(context).size.height * .5,
                          autoPlayInterval: Duration(seconds: 5),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 104.0),
                        child: PrimaryButton(
                          text: "Entrar",
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Login(),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
