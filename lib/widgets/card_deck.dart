import 'package:flutter/material.dart';

class CardDeck extends StatelessWidget {
  final List<String> cardImages = [
    "assets/images/Ancestral Anger.PNG",
    "assets/images/Circuit Mender.PNG",
    "assets/images/Crash Through.PNG",
    "assets/images/Crimson Wisps.PNG",
    "assets/images/Devilish Valet.PNG",
    "assets/images/Expedite.PNG",
    "assets/images/Fireflux Squad.PNG",
    "assets/images/Humble Defector.PNG",
    "assets/images/Inferno Titan.PNG",
    "assets/images/Lava Dart.PNG",
    "assets/images/Magmatic Insight.PNG",
    "assets/images/Overmaster.PNG",
    "assets/images/Pilgrim's Eye.PNG",
    "assets/images/Reckless Barbarian.PNG",
    "assets/images/Renegade Tactics.PNG",
    "assets/images/Rile.PNG",
    "assets/images/Skyscanner.PNG",
    "assets/images/Strike It Rich.PNG",
    "assets/images/Tectonic Giant.PNG",
    "assets/images/Thores of Chaos.PNG",
    "assets/images/Warlord's Fury.PNG",
    "assets/images/Wild Guess.PNG",
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: cardImages.asMap().entries.map((entry) {
        int index = entry.key;
        String imagePath = entry.value;
        return Positioned(
          top: 0.0, // All cards at the same vertical position
          left: 0.0, // All cards at the same horizontal position
          child: Image.asset(
            imagePath,
            width: 100, // Adjust width as needed
            height: 150, // Adjust height as needed
          ),
        );
      }).toList(),
    );
  }
} 