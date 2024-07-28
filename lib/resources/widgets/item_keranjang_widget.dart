import 'package:uas_anisa/app/models/keranjang.dart';
import 'package:uas_anisa/config/const_vars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ItemKeranjangWidget extends StatefulWidget {
  final int index;
  final Function deleteFunc;

  const ItemKeranjangWidget(
    {
      Key? key,
      required this.index,
      required this.deleteFunc
    }
  )
      : super(key: key);
  @override
  State<ItemKeranjangWidget> createState() => _ItemKeranjangWidgetState();
}

class _ItemKeranjangWidgetState extends State<ItemKeranjangWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(top: 10),
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(globalKeranjang[widget.index].namaProduk, 
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                      style: GoogleFonts.aBeeZee(
                        fontSize: 13.sp,
                        color: colorUtama,
                        fontWeight: FontWeight.bold
                      ),),
                      Text(
                        "QTY : " + globalKeranjang[widget.index].qty.toString(), 
                        textAlign: TextAlign.start,
                        style: GoogleFonts.aBeeZee(
                        fontSize: 10.sp,
                        color: Colors.black.withOpacity(0.8),
                        fontWeight: FontWeight.bold
                      ),),
                    ],
                  ),
                ),
                SizedBox(width: 20,),
                InkWell(
                  onTap: (){
                    globalSelectedItemIDX = globalKeranjang[widget.index].idproduk;
                    widget.deleteFunc();
                  },
                  child: Icon(Icons.delete, color: Colors.red)
                )

              ],
            ),

          ],
        )
      )
    );
  }
}