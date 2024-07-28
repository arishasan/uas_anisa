import 'package:uas_anisa/app/models/keranjang.dart';
import 'package:uas_anisa/config/const_vars.dart';
import 'package:uas_anisa/resources/pages/auth/login_page.dart';
import 'package:uas_anisa/resources/pages/parts/profile_page.dart';
import 'package:uas_anisa/resources/pages/parts/produk_page.dart';
import 'package:uas_anisa/resources/pages/parts/keranjang_belanja_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nylo_framework/nylo_framework.dart';
import 'package:flutter/material.dart';

class MainScreenPage extends NyStatefulWidget {
  static const path = '/main';

  MainScreenPage({super.key}) : super(path, child: () => _MainScreenPageState());
}

class _MainScreenPageState extends NyState<MainScreenPage> {

  Widget content = Column();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  changeScreen(){

    if(globalScreen == 'PRODUK'){
      content = ProdukSection(notifyParent: refresh, moveScreen: moveScreenCustomize);
    }else if(globalScreen == 'KERANJANG_BELANJA'){
      content = KeranjangBelanjaSection(notifyParent: refresh, moveScreen: moveScreenCustomize);
    }else if(globalScreen == 'PROFILE'){
      content = ProfileSection(notifyParent: refresh, moveScreen: moveScreenCustomize);
    }else{
      content = Column();
    }

  }

  @override
  init() async {
    super.init();
    changeScreen();
  }

  refresh(){
    setState(() { });
  }

  moveScreen(){
    changeScreen();
  }

  moveScreenCustomize(){
    setState(() { });
    changeScreen();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      extendBody: true,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leadingWidth: 0,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "N_Shop",
              textAlign: TextAlign.start,
              style: GoogleFonts.aBeeZee(
                color: colorUtama,
                fontSize: 18.sp,
                fontWeight: FontWeight.w300
              ),
            ),
            GestureDetector(
              child: Icon(Icons.logout, color: Colors.black54,),
              onTap: () {
                  routeTo(LoginPage.path, navigationType: NavigationType.popAndPushNamed);
              },
            ),
            // Text(
            //   globalScreen.replaceAll("_", " "),
            //   textAlign: TextAlign.end,
            //   style: GoogleFonts.aBeeZee(
            //     color: colorUtama,
            //     fontSize: 18.sp,
            //     fontWeight: FontWeight.w300
            //   ),
            // )
          ],
        ),
      ),
      body: Container(
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Expanded(
                    child: Container(),
                  ),
                  Opacity(
                    opacity: 1,
                    child: Image.asset("image_02.png").localAsset(),
                  )
                ],
              ),

              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                        child: content
                      )
                    ),

                    Container(
                      width: 1.sw,
                      // height: 70.h,
                      padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                      decoration: BoxDecoration(
                        color: colorUtama,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          
                          Flexible(
                            child: InkWell(
                              onTap: (){
                                setState((){
                                  globalScreen = 'PRODUK';
                                });
                                changeScreen();
                              },
                              child: Container(
                                child: Column(
                                  children: [
                                    Icon(Icons.home, size: 30.sp, color: globalScreen == "PRODUK" ? Colors.white : Colors.white.withOpacity(0.5),),
                                    Text(
                                      "Home",
                                      textAlign: TextAlign.start,
                                      style: GoogleFonts.aBeeZee(
                                        color: globalScreen == "PRODUK" ? Colors.white : Colors.white.withOpacity(0.5),
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w300
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            )
                          ),
                          SizedBox(width: 70,),
                          Flexible(
                            child: InkWell(
                              onTap: (){
                                setState((){
                                  globalScreen = 'KERANJANG_BELANJA';
                                });
                                changeScreen();
                              },
                              child: Container(
                                child: Column(
                                  children: [
                                    Icon(Icons.shopping_cart, size: 30.sp, color: globalScreen == 'KERANJANG_BELANJA' ? Colors.white : Colors.white.withOpacity(0.5),),
                                    Text(
                                      "Cart",
                                      textAlign: TextAlign.start,
                                      style: GoogleFonts.aBeeZee(
                                        color: globalScreen == 'KERANJANG_BELANJA' ? Colors.white : Colors.white.withOpacity(0.5),
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w300
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            )
                          ),
                          SizedBox(width: 70,),
                          Flexible(
                            child: InkWell(
                              onTap: (){
                                setState((){
                                  globalScreen = 'PROFILE';
                                });
                                changeScreen();
                              },
                              child: Container(
                                child: Column(
                                  children: [
                                    Icon(Icons.person, size: 30.sp, color: globalScreen == 'PROFILE' ? Colors.white : Colors.white.withOpacity(0.5),),
                                    Text(
                                      "Profile",
                                      textAlign: TextAlign.start,
                                      style: GoogleFonts.aBeeZee(
                                        color: globalScreen == 'PROFILE' ? Colors.white : Colors.white.withOpacity(0.5),
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w300
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            )
                          ),

                        ],
                      )
                    )

                  ],
                )
              )
              
            ],
          )
        ),
    );
  }

}