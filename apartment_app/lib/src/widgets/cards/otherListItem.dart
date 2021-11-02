import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class OtherListItem extends StatelessWidget {
  
  final IconData icon;
  final String text;
  final function;
  const OtherListItem({
    Key? key,
    required this.icon,
    required this.text,
    required this.function
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return GestureDetector(
      onTap: function,
      child: Container(
        height: 55,
        margin: EdgeInsets.symmetric(
          horizontal: 10,
        ).copyWith(top: 10),
        padding: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
        ),
        child: Row(
          children: <Widget>[
            Icon(
              this.icon,
              size: 25,
            ),
            SizedBox(width: 15),
            Text(
              this.text,
              style: TextStyle(
                fontSize: ScreenUtil().setSp(17),
                fontWeight: FontWeight.w600,
              ).copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
            Spacer(),
            Icon(
              LineAwesomeIcons.angle_right,
              size: 25,
            ),
          ],
        ),
      ),
    );
  }
}
