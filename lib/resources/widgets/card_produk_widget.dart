import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uas_anisa/app/models/produk.dart';
import 'package:uas_anisa/config/const_vars.dart';

class CardProduk extends StatefulWidget {
  final int index;

  const CardProduk(
    {
      Key? key,
      required this.index
    }
  )
      : super(key: key);
  @override
  State<CardProduk> createState() => CardProdukState();
}

class CardProdukState extends State<CardProduk> {

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          SizedBox(width: 10,),
          Image.network(globalProduk[widget.index].image, height: 70, width: 70,),

          SizedBox(width: 20,),
          
          Flexible(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(globalProduk[widget.index].title, 
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.aBeeZee(
                  fontSize: 10.sp,
                  color: Colors.black54,
                  fontWeight: FontWeight.bold
                ),),

                SizedBox(height: 5,),

                Text('USD ' + globalProduk[widget.index].price.toString(), 
                style: GoogleFonts.aBeeZee(
                  fontSize: 12.sp,
                  color: colorUtama,
                  fontWeight: FontWeight.bold
                ),),

                SizedBox(height: 5,),

              ],
            )
          ),
          SizedBox(width: 10,),

        ],
      ),
    );
  }
}