import 'package:flutter_test/flutter_test.dart'; // Importa o mock
import 'game_page_robot.dart'; // Importa o robot
import 'package:alchemy_tcg/presentation/features/grid/widgets/card_grid.dart';
import 'package:alchemy_tcg/core/di/service_locator.dart';

void main() {
  setUpAll(() {
    setupServiceLocator();
  });

  tearDownAll(() {
    // Limpe as instâncias registradas após os testes, se necessário
    getIt.reset();
  });
  testWidgets('GamePage renders correctly', (WidgetTester tester) async {
    final robot = GamePageRobot(tester);

    // Usa o robot para configurar a GamePage
    await robot.pumpGamePage();

    // Verifica se os widgets esperados estão presentes
    expect(find.byType(CardGrid), findsOneWidget); // Verifica se o CardGrid está presente
    expect(find.text('Alchemy TCG'), findsOneWidget); // Verifica se algum texto esperado está presente
  });

  testWidgets('User can tap on CardGrid', (WidgetTester tester) async {
    final robot = GamePageRobot(tester);

    // Usa o robot para configurar a GamePage
    await robot.pumpGamePage();

    // Usa o robot para interagir com a página
    await robot.tapCardGrid();

    // Adicione verificações adicionais conforme necessário
    // Por exemplo, verificar se um determinado estado foi alterado ou se um widget foi exibido
  });
}