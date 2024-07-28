import 'package:ndialog/ndialog.dart';
import 'package:uas_anisa/app/models/global.dart';
import 'package:uas_anisa/app/models/keranjang.dart';
import 'package:uas_anisa/app/networking/api_service.dart';
import 'package:uas_anisa/bootstrap/helpers.dart';
import 'package:uas_anisa/config/const_vars.dart';
import 'package:uas_anisa/resources/pages/auth/login_page.dart';
import 'package:uas_anisa/resources/widgets/accordion_history.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nylo_framework/nylo_framework.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class ProfileSection extends NyStatefulWidget {
  final Function notifyParent;
  final Function moveScreen;

  static const path = '/section-profile';

  ProfileSection({super.key, required this.notifyParent, required this.moveScreen}) : super(path, child: () => _ProfileSectionState());
}

class _ProfileSectionState extends NyState<ProfileSection> {

  @override
  init() async {
    super.init();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "User",
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: GoogleFonts.aBeeZee(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 15.sp
                      ),
                    ),
                    Text(
                      "email@email.com",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      textAlign: TextAlign.start,
                      style: GoogleFonts.aBeeZee(
                        color: Colors.black,
                        fontWeight: FontWeight.w300,
                        fontSize: 13.sp
                      ),
                    )
                  ],
                )
              ),
              SizedBox(width: 10,),
              GestureDetector(
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 25.0,
                  backgroundImage: AssetImage(getImageAsset("user.png")),
                ),
                onTap: () {},
              )

            ],
          ),
        ),

        // SizedBox(height: 20,),

        // GestureDetector(
        //   onTap: (){
        //     routeTo(LoginPage.path, navigationType: NavigationType.popAndPushNamed);
        //   },
        //   child: Container(
        //     margin: EdgeInsets.symmetric(horizontal: 10),
        //     padding: EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
        //     decoration: BoxDecoration(
        //       color: Colors.white,
        //       borderRadius: BorderRadius.all(Radius.circular(10))
        //     ),
        //     child: Row(
        //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //       children: [
        //         Text(
        //           "Logout",
        //           textAlign: TextAlign.start,
        //           style: GoogleFonts.aBeeZee(
        //             color: colorUtama,
        //           ),
        //         ),
        //         Icon(Icons.logout, color: colorUtama,)
        //       ],
        //     )
        //   ),
        // )

      ],
    );
  }

}