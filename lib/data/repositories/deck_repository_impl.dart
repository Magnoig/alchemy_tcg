import '../../domain/repositories/deck_repository.dart';
import '../../assets/image_paths.dart';
class DeckRepositoryImpl implements DeckRepository {
  final List<String> _deckTemplate = [
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

  final Map<String, List<String>> cellDecks = {};

  @override
  Future<Map<String, List<String>>> getCards(String cellId) async {
    cellDecks.putIfAbsent(cellId, () => List.from(_deckTemplate));
    return {cellId: List.from(cellDecks[cellId]!)};
  }

  @override
  Future<void> addCard(String cellId, String cardPath) async {
    cellDecks.putIfAbsent(cellId, () => []);
    cellDecks[cellId]!.add(cardPath);
  }

  @override
  Future<void> removeCard(String cellId, int index) async {
    if (cellDecks.containsKey(cellId)) {
      List<String> cards = cellDecks[cellId]!;

      if (index >= 0 && index < cards.length) {
        cards.removeAt(index);
      }

      if (cards.isEmpty) {
        return;
      }
    }
  }

  @override
  Future<String?> getCardBack() async {
    return ImagePaths.cardBack;
  }

  @override
  Future<void> shuffleDeck(String cellId) async {
    if (cellDecks.containsKey(cellId)) {
      cellDecks[cellId]!.shuffle();
    }
  }
}