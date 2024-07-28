import 'package:ndialog/ndialog.dart';
import 'package:uas_anisa/app/models/global.dart';
import 'package:uas_anisa/app/models/keranjang.dart';
import 'package:uas_anisa/app/models/produk.dart';
import 'package:uas_anisa/app/networking/api_service.dart';
import 'package:uas_anisa/bootstrap/helpers.dart';
import 'package:uas_anisa/config/const_vars.dart';
import 'package:uas_anisa/resources/widgets/card_produk_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nylo_framework/nylo_framework.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class ProdukSection extends NyStatefulWidget {
  final Function notifyParent;
  final Function moveScreen;

  static const path = '/section-produk';

  ProdukSection({super.key, required this.notifyParent, required this.moveScreen}) : super(path, child: () => _ProdukSectionState());
}

class _ProdukSectionState extends NyState<ProdukSection> {

  RefreshController _refreshControllerTwo =
      RefreshController(initialRefresh: false);

  @override
  init() async {
    super.init();
    _loadProduk();
  }

  void _onRefresh() async{
    // monitor network fetch
    await _loadProduk();
    // if failed,use refreshFailed()
    _refreshControllerTwo.refreshCompleted();
  }

  Future<void> _loadProduk() async {

    globalProduk.clear();

    ProgressDialog pdialog = showLoading(context);
    pdialog.show();

    List<Notif> dataProduct = [];

    dataProduct = await ApiService().methodGET("/products");
      pdialog.dismiss();

    if(dataProduct.first.error){
      pdialog.dismiss();
    }else{

      pdialog.dismiss();
      List<dynamic> data = dataProduct.first.data;

      data.forEach((element) {
        globalProduk.add(
          Produk(id: element['id'], title: element['title'], price: double.tryParse(element['price'].toString()) ?? 0, category: element['category'], desc: element['description'], image: element['image'])
        );
      });

    }

    setState((){

    });

  }

  Future<void> masukkanKeranjang() async {

    int selectedProduk = globalProduk[globalSelectedItemIDX].id;
    String namaProduk = globalProduk[globalSelectedItemIDX].title;
    double priceProduk = globalProduk[globalSelectedItemIDX].price;

    int qty = 1;

    final bool _productIsInList = 
        globalKeranjang.any((product) => product.idproduk == selectedProduk);
    if (_productIsInList) {

      Iterable<Keranjang> same = globalKeranjang.where((element) => element.idproduk == selectedProduk);
      same.forEach((element) {
        
        element.qty = element.qty + qty;

      });
      
    } else {
      globalKeranjang.add(Keranjang(idproduk: selectedProduk, price: priceProduk,namaProduk: namaProduk, qty: qty));
    }

    showToastSuccess(description: "Berhasil menambahkan produk kedalam keranjang.");

    setState((){

    });

    widget.notifyParent();

    Navigator.of(context).pop();

  }

  @override
  void dispose() {
    super.dispose();
    _refreshControllerTwo.dispose();
  }

  void detailProduk() async {

    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierLabel: MaterialLocalizations.of(context)
          .modalBarrierDismissLabel,
      barrierColor: Colors.black45,
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (BuildContext buildContext,
          Animation animation,
          Animation secondaryAnimation) {
        return StatefulBuilder(
          builder: (contextInner, setStateInner){
            return AnimatedContainer(
              padding: MediaQuery.of(contextInner).viewInsets,
              duration: const Duration(milliseconds: 300),
              child: Center(
                child: Container(
                  margin: EdgeInsets.only(top: 50, bottom: 50),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(left: 25, right: 25, top: 10, bottom: 0),
                                child: Text(
                                  'Informasi',
                                  textAlign: TextAlign.start,
                                  style: GoogleFonts.aBeeZee(
                                    color: Colors.black,
                                    fontSize: 13.sp,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 0),
                                child: InkWell(
                                  onTap: (){
                                    Navigator.of(context).pop();
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(3),
                                    decoration: BoxDecoration(
                                      
                                      color: Colors.grey[400],
                                      borderRadius: BorderRadius.all(Radius.circular(20))
                                    ),
                                    child: Icon(Icons.close, color: Colors.white, size: 12.sp),
                                  )
                                )
                              ),
                            ],
                          ),

                          Divider(),

                          Image.network(globalProduk[globalSelectedItemIDX].image, width: 200,),

                          Padding(
                            padding: EdgeInsets.all(20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Text(
                                  globalProduk[globalSelectedItemIDX].title,
                                  textAlign: TextAlign.start,
                                  style: GoogleFonts.aBeeZee(
                                    color: colorUtama,
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),

                                Divider(),

                                Text(
                                  "USD " + globalProduk[globalSelectedItemIDX].price.toString(),
                                  textAlign: TextAlign.end,
                                  style: GoogleFonts.aBeeZee(
                                    color: Colors.black,
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                                
                                Text(
                                  globalProduk[globalSelectedItemIDX].category,
                                  textAlign: TextAlign.start,
                                  style: GoogleFonts.aBeeZee(
                                    color: Colors.black54,
                                    fontSize: 10.sp,
                                  ),
                                ),

                                SizedBox(height: 15,),
                                // Text(
                                //   "Deskripsi",
                                //   textAlign: TextAlign.start,
                                //   style: GoogleFonts.aBeeZee(
                                //     color: Colors.black,
                                //     fontSize: 11.sp,
                                //     fontWeight: FontWeight.bold
                                //   ),
                                // ),
                                // Divider(),
                                // SizedBox(height: 5,),

                                Text(
                                  globalProduk[globalSelectedItemIDX].desc.toString(),
                                  textAlign: TextAlign.start,
                                  style: GoogleFonts.aBeeZee(
                                    color: Colors.black54,
                                    fontSize: 10.sp,
                                  ),
                                ),

                                SizedBox(height: 30,),

                                InkWell(
                                  onTap: () async {

                                    await masukkanKeranjang();

                                  },
                                  child: Container(
                                    width: 1.sw,
                                    padding: EdgeInsets.only(left: 18, right: 18, top: 18, bottom: 18),
                                    decoration: BoxDecoration(
                                      color: colorUtama,
                                      borderRadius: BorderRadius.all(Radius.circular(10))
                                    ),
                                    child: Icon(Icons.add_shopping_cart, color: Colors.white,),
                                  )
                                )

                              ],
                            )
                          )

                          

                        ],
                      )
                    ),
                  ),
                ),
              )
            );
          },
        );
      });

  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Flexible(
          child: Container(
            child: SmartRefresher(
              enablePullDown: true,
              enablePullUp: false,
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
              controller: _refreshControllerTwo,
              onRefresh: _onRefresh,
              child: ListView.builder(
                // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                //   crossAxisCount: 2, // number of items in each row
                //   mainAxisSpacing: 8.0, // spacing between rows
                //   crossAxisSpacing: 8.0, // spacing between columns
                // ),
                physics: BouncingScrollPhysics(),
                itemBuilder: (c, i) {
                  return InkWell(
                    onTap: (){
                      globalSelectedItemIDX = i;
                      detailProduk();
                    },
                    child: CardProduk(index: i),
                  );
                },
                // itemExtent: 100.0,
                itemCount: globalProduk.length,
              ),
            )
          )
        ),

        SizedBox(height: 20,),

      ],
    );
  }

}