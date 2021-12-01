import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../Helpers/ResponsiveFramework/IResponsiveFramework.dart';

class ScreenUtilFramework implements IResponsiveFramework {
  @override
  double setHeight(num height) => ScreenUtil().setHeight(height);

  @override
  double setWidth(num width) => ScreenUtil().setWidth(width);

  @override
  double setRadius(num radius) => ScreenUtil().radius(radius);

  @override
  double setSp(num sp) => ScreenUtil().setSp(sp);
}
