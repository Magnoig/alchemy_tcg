abstract class GraveyardEvent {}

class AddCardGraveyard extends GraveyardEvent {
  final String cardPath;
  AddCardGraveyard(this.cardPath);
}

class InitializeGraveyard extends GraveyardEvent {} 

class ShowGraveyard extends GraveyardEvent {}

class RemoveCardGraveyard extends GraveyardEvent {
  final int index;
  RemoveCardGraveyard(this.index);
}