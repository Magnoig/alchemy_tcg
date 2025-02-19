import 'deck_state.dart';

extension DeckStateExtension on DeckState {
  List<String> getCardsForCell(String cellId) {
    return cellDecks[cellId] ?? [];
  }
}