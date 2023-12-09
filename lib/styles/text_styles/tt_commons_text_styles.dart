import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class TTCommonsTextStyles {
  /* text */
  static final textXxs = _TextXxs();
  static final textXs = _TextXs();
  static final textSm = _TextSm();
  static final textMd = _TextMd();
  static final textLg = _TextLg();
  static final textXl = _TextXl();

  /* display */
  static final displayXs = _DisplayXs();
  static final displaySm = _DisplaySm();
  static final displayMd = _DisplayMd();
  static final displayLg = _DisplayLg();
  static final displayXl = _DisplayXl();
  static final display2Xl = _Display2Xl();
}

abstract class _TTCommonsStyles {
  TextStyle modify(TextStyle style);

  TextStyle _style() {
    return modify(const TextStyle(
      fontFamily: 'TTCommons',
    ));
  }

  TextStyle textRegular() {
    return _style().copyWith(
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    );
  }

  TextStyle textMedium() {
    return _style().copyWith(
      fontWeight: FontWeight.w500,
      fontStyle: FontStyle.normal,
    );
  }

  TextStyle textSemiBold() {
    return _style().copyWith(
      fontWeight: FontWeight.w600,
      fontStyle: FontStyle.normal,
    );
  }

  TextStyle textBold() {
    return _style().copyWith(
      fontWeight: FontWeight.w700,
      fontStyle: FontStyle.normal,
    );
  }

  TextStyle textRegularItalic() {
    return _style().copyWith(
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.italic,
    );
  }

  TextStyle textMediumItalic() {
    return _style().copyWith(
      fontWeight: FontWeight.w500,
      fontStyle: FontStyle.italic,
    );
  }

  TextStyle textSemiBoldItalic() {
    return _style().copyWith(
      fontWeight: FontWeight.w600,
      fontStyle: FontStyle.italic,
    );
  }

  TextStyle textTextBoldItalic() {
    return _style().copyWith(
      fontWeight: FontWeight.w700,
      fontStyle: FontStyle.italic,
    );
  }

  TextStyle textRegularUnderlined() {
    return _style().copyWith(
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
        decoration: TextDecoration.underline);
  }

  TextStyle textMediumUnderlined() {
    return _style().copyWith(
        fontWeight: FontWeight.w500,
        fontStyle: FontStyle.normal,
        decoration: TextDecoration.underline);
  }

  TextStyle textSemiBoldUnderlined() {
    return _style().copyWith(
        fontWeight: FontWeight.w600,
        fontStyle: FontStyle.normal,
        decoration: TextDecoration.underline);
  }

  TextStyle textTextBoldUnderlined() {
    return _style().copyWith(
        fontWeight: FontWeight.w700,
        fontStyle: FontStyle.normal,
        decoration: TextDecoration.underline);
  }
}

/* text class styles */
class _TextXxs extends _TTCommonsStyles {
  @override
  TextStyle modify(TextStyle style) {
    return style.copyWith(
      fontSize: 10.sp,
    );
  }
}

class _TextXs extends _TTCommonsStyles {
  @override
  TextStyle modify(TextStyle style) {
    return style.copyWith(
      fontSize: 12.sp,
    );
  }
}

class _TextSm extends _TTCommonsStyles {
  @override
  TextStyle modify(TextStyle style) {
    return style.copyWith(
      fontSize: 14.sp,
    );
  }
}

class _TextMd extends _TTCommonsStyles {
  @override
  TextStyle modify(TextStyle style) {
    return style.copyWith(
      fontSize: 16.sp,
    );
  }
}

class _TextLg extends _TTCommonsStyles {
  @override
  TextStyle modify(TextStyle style) {
    return style.copyWith(
      fontSize: 18.sp,
    );
  }
}

class _TextXl extends _TTCommonsStyles {
  @override
  TextStyle modify(TextStyle style) {
    return style.copyWith(
      fontSize: 20.sp,
    );
  }
}

/* display class styles */
class _DisplayXs extends _TTCommonsStyles {
  @override
  TextStyle modify(TextStyle style) {
    return style.copyWith(
      fontSize: 24.sp,
    );
  }
}

class _DisplaySm extends _TTCommonsStyles {
  @override
  TextStyle modify(TextStyle style) {
    return style.copyWith(
      fontSize: 30.sp,
    );
  }
}

class _DisplayMd extends _TTCommonsStyles {
  @override
  TextStyle modify(TextStyle style) {
    return style.copyWith(
      fontSize: 36.sp,
    );
  }
}

class _DisplayLg extends _TTCommonsStyles {
  @override
  TextStyle modify(TextStyle style) {
    return style.copyWith(
      fontSize: 48.sp,
    );
  }
}

class _DisplayXl extends _TTCommonsStyles {
  @override
  TextStyle modify(TextStyle style) {
    return style.copyWith(
      fontSize: 60.sp,
    );
  }
}

class _Display2Xl extends _TTCommonsStyles {
  @override
  TextStyle modify(TextStyle style) {
    return style.copyWith(
      fontSize: 72.sp,
    );
  }
}
