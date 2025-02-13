import '../../domain/repositories/deck_repository.dart';
import '../../assets/image_paths.dart';
class DeckRepositoryImpl implements DeckRepository {
  final List<String> deck = [
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
    return List.from(deck);
  }

  @override
  Future<void> addCard(String cardPath) async {
    deck.add(cardPath);
  }

  @override
  Future<void> removeCard(int index) async {
    deck.removeAt(index);
  }

  @override
  Future<String?> getCardBack() async {
    return ImagePaths.cardBack;
  }

  @override
  Future<void> shuffleDeck() async {
    deck.shuffle();
  }
  
} 