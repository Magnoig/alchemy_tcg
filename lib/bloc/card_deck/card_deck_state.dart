class CardDeckState {
  final List<String> cardImages;

  CardDeckState({required this.cardImages});

  factory CardDeckState.initial() {
    return CardDeckState(
      cardImages: [
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
      ],
    );
  }

  CardDeckState copyWith({
    List<String>? cardImages,
  }) {
    return CardDeckState(
      cardImages: cardImages ?? this.cardImages,
    );
  }
} 