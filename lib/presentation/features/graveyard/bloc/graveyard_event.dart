abstract class GraveyardEvent {}

class AddCardGraveyard extends GraveyardEvent {
  final String cellId;
  final String cardPath;

  AddCardGraveyard({required this.cellId, required this.cardPath});
  
}

class RemoveCardGraveyard extends GraveyardEvent {
  final String cellId;
  final int index;

  RemoveCardGraveyard({required this.cellId, required this.index});
  
}

class InitializeGraveyard extends GraveyardEvent {} 

class ShowGraveyard extends GraveyardEvent {}
