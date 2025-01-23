import '../../domain/repositories/card_repository.dart';

class AssetCardRepository implements CardRepository {
  final List<String> _cards = [
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
  Future<List<String>> getCards() async {
    return List.from(_cards);
  }

  @override
  Future<String?> getCardBack() async {
    return 'assets/images/card_verso.png';
  }

  @override
  Future<void> shuffleDeck() async {
    _cards.shuffle();
  }
} 