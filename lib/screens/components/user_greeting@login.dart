import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../theme_data.dart' as theme;

class UserGreetingAnim extends StatelessWidget {
  UserGreetingAnim(
      {required this.screenSize,
      required this.attributes,
      required this.fileMap,
      required this.layer5Speed,
      required this.scrollOffset,
      required this.maxScrollOffset});

  final Size screenSize;
  final Map<String, String>? attributes;
  final Map<String, String>? fileMap;
  final double layer5Speed;
  final double scrollOffset;
  final double maxScrollOffset;

  Map<String, String>? _nullCheckAttributes() {
    if (attributes == null) {
      return {};
    }
    return attributes;
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 50,
      right: (layer5Speed * (maxScrollOffset - scrollOffset)),
      left: -180,
      child: Container(
        padding: EdgeInsets.only(
          left: _nullCheckAttributes()!.isEmpty
              ? fileMap!.isNotEmpty
                  ? screenSize.width / 2 -
                      (3 + fileMap!['email']!.split('@')[0].length * 12)
                  : screenSize.width / 2
              : screenSize.width / 2 -
                  (3 + attributes!['email']!.split('@')[0].length * 12),
        ),
        child: Text(
          _nullCheckAttributes()!.isNotEmpty
              ? attributes!['email']!.split('@')[0].length >= 15
                  ? "Hi ${attributes!['email']!.split('@')[0].substring(0, 14)}!"
                  : "Hi ${attributes!['email']!.split('@')[0]}!"
              // ? "Hi Vaibhav!"
              : fileMap!.isNotEmpty
                  ? fileMap!['email']!.split('@')[0].length >= 15
                      ? "Hi ${fileMap!['email']!.split('@')[0].substring(0, 14)}!"
                      : "Hi ${fileMap!['email']!.split('@')[0]}!"
                  // ? "Hi Vaibhav!"
                  : "Hi!",
          overflow: TextOverflow.fade,
          softWrap: false,
          textAlign: TextAlign.center,
          style: GoogleFonts.balooTamma(
            textStyle: const TextStyle(
              fontSize: 35,
              color: theme.textColor,
            ),
          ),
        ),
      ),
    );
  }
}
