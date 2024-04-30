import 'app.export.dart';

class Constants {}

extension IntExtension on int? {
  Widget get heightSpacer => SizedBox(height: Utils.getSize((this ?? 0).toDouble()));

  Widget get widthSpacer => SizedBox(width: Utils.getSize((this ?? 0).toDouble()));

  double get getSize => Utils.getSize((this ?? 0).toDouble());
}
