// import 'dart:math';

String getNameInitials(String? name, {int initialsLength = 2,}) {
  assert (initialsLength > 0);
  if (name.toString().isEmpty) return '';

  final split = name!.split(' ');

  if (split.isNotEmpty) {
    return split.map((e) => e[0]).join();
    // String toReturn = '';
    // for (int i = 0; i < min(split.length, initialsLength); i++) {
    //   toReturn += split[i][0];
    // }
    // return toReturn;
  } else {
    return '';
  }
}
