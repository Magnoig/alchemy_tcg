abstract class GraveyardEvent {}

class AddCardToGraveyard extends GraveyardEvent {
  final String cardPath;
  AddCardToGraveyard(this.cardPath);
}

class InitializeGraveyard extends GraveyardEvent {} 

class ShowGraveyard extends GraveyardEvent {}

class RemoveTopCardGraveyard extends GraveyardEvent {}