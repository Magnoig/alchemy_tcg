import '../../domain/repositories/card_repository.dart';
import '../../assets/image_paths.dart';
class AssetCardRepository implements CardRepository {
  final List<String> _cards = [
    ImagePaths.ancestralAnger,
    ImagePaths.circuitMender,
    ImagePaths.crashThrough,
    ImagePaths.crimsonWisps,
    ImagePaths.devilishValet,
    ImagePaths.expedite,
    ImagePaths.firefluxSquad,
    ImagePaths.humbleDefector,
    ImagePaths.infernoTitan,
    ImagePaths.lavaDart,
    ImagePaths.magmaticInsight,
    ImagePaths.overmaster,
    ImagePaths.pilgrimEye,
    ImagePaths.recklessBarbarian,
    ImagePaths.renegadeTactics,
    ImagePaths.rile,
    ImagePaths.skyscanner,
    ImagePaths.strikeItRich,
    ImagePaths.tectonicGiant,
    ImagePaths.thoresOfChaos,
    ImagePaths.warlordFury,
    ImagePaths.wildGuess,
  ];

  @override
  Future<List<String>> getCards() async {
    return List.from(_cards);
  }

  @override
  Future<String?> getCardBack() async {
    return ImagePaths.cardBack;
  }

  @override
  Future<void> shuffleDeck() async {
    _cards.shuffle();
  }
  @override
  Future<void> removeTopCard(List<String> cardImages) async {
    if (cardImages.isNotEmpty) {
      _cards.removeLast();
    }
  }
} 