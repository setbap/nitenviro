export 'package:enviro_shared/utils/utils.dart';

String weightToText(
    {double? metal,
    double? glass,
    double? mix,
    double? plastic,
    double? paper}) {
  var text = "";
  if (metal != null) text += "فلز:$metal   ";
  if (glass != null) text += "شیشه:$glass   ";
  if (plastic != null) text += "پلاستیک:$plastic   ";
  if (paper != null) text += "کاغذ:$paper   ";
  if (mix != null) text += "مخلوط:$mix   ";

  return text;
}
