import 'package:communitybank/models/data/agents_total/agents_total.model.dart';
import 'package:communitybank/services/agents_total/agents_total.service.dart';

class AgentsTotalController {
  static Future<List<AgentsTotal>> getTotalNumber() async {
    final totalNumbers = await AgentsTotalService.getTotalNumber();

    return totalNumbers.map(
      (totalNumber) {
        return AgentsTotal.fromMap(
          totalNumber,
        );
      },
    ).toList();
  }
}
