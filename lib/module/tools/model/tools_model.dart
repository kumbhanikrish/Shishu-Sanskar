class ToolsModel {
  final String title;
  final String subtitle;
  final String image;

  ToolsModel({
    required this.title,
    required this.subtitle,
    required this.image,
  });
}

class OvulationPrediction {
  final DateTime fertileStart;
  final DateTime fertileEnd;
  final DateTime ovulationDay;
  final DateTime nextPeriod;
  final DateTime pregnancyTestDay;
  final DateTime estimatedDueDate;

  OvulationPrediction({
    required this.fertileStart,
    required this.fertileEnd,
    required this.ovulationDay,
    required this.nextPeriod,
    required this.pregnancyTestDay,
    required this.estimatedDueDate,
  });
}
