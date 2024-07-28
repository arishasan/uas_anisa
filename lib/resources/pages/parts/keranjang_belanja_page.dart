import 'dart:convert';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ndialog/ndialog.dart';
import 'package:uas_anisa/app/models/global.dart';
import 'package:uas_anisa/app/models/keranjang.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nylo_framework/nylo_framework.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:uas_anisa/config/const_vars.dart';
import 'package:uas_anisa/resources/widgets/item_keranjang_widget.dart';

class KeranjangBelanjaSection extends NyStatefulWidget {
  final Function notifyParent;
  final Function moveScreen;

  static const path = '/section-keranjang-belanja';

  KeranjangBelanjaSection({super.key, required this.notifyParent, required this.moveScreen}) : super(path, child: () => _KeranjangBelanjaSectionState());
}

class _KeranjangBelanjaSectionState extends NyState<KeranjangBelanjaSection> {

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  init() async {
    super.init();
  }

  void _onRefresh() async{
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void deleteFunc() async {

    globalKeranjang.removeWhere((element) => element.idproduk == globalSelectedItemIDX);
    setState((){

    });
    widget.notifyParent();

  }


  @override
  void dispose() {
    super.dispose();
    _refreshController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        Expanded(
          child: Container(
            child: SmartRefresher(
              enablePullDown: true,
              header: WaterDropHeader(
                waterDropColor: Colors.black54,
                refresh: SpinKitCircle(
                  color: Colors.black54,
                ),
              ),
              
              footer: CustomFooter(
                builder: (context, mode) {
                  Widget body ;
                  if(mode==LoadStatus.idle){
                    body =  Text("pull up load", style: GoogleFonts.aBeeZee(color: Colors.black54),);
                  }
                  else if(mode==LoadStatus.loading){
                    body =  SpinKitPulsingGrid(
                      color: Colors.black54,
                    );
                  }
                  else if(mode == LoadStatus.failed){
                    body = Text("Load Failed!Click retry!", style: GoogleFonts.aBeeZee(color: Colors.black54),);
                  }
                  else if(mode == LoadStatus.canLoading){
                      body = Text("release to load more", style: GoogleFonts.aBeeZee(color: Colors.black54),);
                  }
                  else{
                    body = Text("No more Data", style: GoogleFonts.aBeeZee(color: Colors.black54),);
                  }
                  return Container(
                    height: 55.0,
                    child: Center(child:body),
                  );
                },
              ),
              controller: _refreshController,
              onRefresh: _onRefresh,
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemBuilder: (c, i) {
                  return ItemKeranjangWidget(index: i, deleteFunc: deleteFunc,);
                },
                // itemExtent: 100.0,
                itemCount: globalKeranjang.length,
              ),
            )
          )
        ),

        SizedBox(height: 20,)

      ],
    );
  }

}