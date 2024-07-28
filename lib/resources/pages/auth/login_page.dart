import 'dart:convert';

import 'package:ndialog/ndialog.dart';
import 'package:uas_anisa/app/models/global.dart';
import 'package:uas_anisa/app/networking/api_service.dart';
import 'package:uas_anisa/bootstrap/helpers.dart';
import 'package:uas_anisa/config/const_vars.dart';
import 'package:uas_anisa/resources/pages/main_page.dart';
import 'package:uas_anisa/resources/widgets/curve_widget.dart';
import 'package:uas_anisa/resources/widgets/custom_button_widget.dart';
import 'package:uas_anisa/resources/widgets/custom_textfield_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nylo_framework/nylo_framework.dart';
import 'package:flutter/material.dart';

class LoginPage extends NyStatefulWidget {
  static const path = '/login';

  LoginPage({super.key}) : super(path, child: () => _LoginPageState());
}

class _LoginPageState extends NyState<LoginPage> {

  String username = '';
  String password = '';
  bool showPass = false;
  TextEditingController uname = new TextEditingController(text: "mor_2314");
  TextEditingController pswd = new TextEditingController(text: "83r5^_");

  @override
  init() async {
    super.init();

  }

  Future<void> doLogin() async {

    FocusManager.instance.primaryFocus?.unfocus();

    if(uname.text.length == 0 || pswd.text.length == 0){
      showToastOops(description: "Username dan Password wajib diisi.");
      return;
    }

    ProgressDialog pdialog = showLoading(context);
    pdialog.show();

    Map<String, dynamic> formData;
    formData = {
      "username" : uname.text,
      "password" : pswd.text,
    };

    List<Notif> data = await ApiService().methodLogin(jsonEncode(formData));

    if(data.length > 0){

      pdialog.dismiss();

      print(data.first.data);
      print(data.first.message);

      if(data.first.error){
        showToastOops(description: data.first.message);
      }else{

        dynamic temp = data.first.data;
        globalToken = temp;

        List<Notif> dataUser = await ApiService().methodGET("/users/" + globalIDUser.toString());

        if(dataUser.first.error){}else{
          Map<String, dynamic> nama = dataUser.first.data['name'];
          globalEmailUser = dataUser.first.data['email'];
          globalNamaUser = (nama['firstname'] ?? '') + ' ' + nama['lastname'] ?? '';
        }

        pdialog.dismiss();

        routeTo(MainScreenPage.path, navigationType: NavigationType.popAndPushNamed);

      }

    }else{
      pdialog.dismiss();
      showToastOops(description: msgErrorGlobal);
    }

  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // First Column
                
                Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "N_Shop",
                        style: GoogleFonts.aBeeZee(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.bold,
                          color: colorUtama,
                        ),
                      ),
                      Text(
                        'Silahkan login',
                        style: GoogleFonts.aBeeZee(
                          color: Colors.black,
                          fontSize: 11.sp,
                        ),
                      )
                    ],
                  ),
                ),

                SizedBox(height: 20,),

                // Second Column
                Column(
                  children: [
                    CustomTextField(
                      hintText: 'Username',
                      // icon: Icons.person,
                      ctr: uname,
                      keyboardType: TextInputType.name,
                      onChanged: (value) {
                        username = value != '' ? value : '';
                      },
                    ),
                    CustomTextField(
                      hintText: 'Password',
                      // icon: Icons.lock,
                      ctr: pswd,
                      obscureText: showPass ? false : true,
                      keyboardType: TextInputType.visiblePassword,
                      onChanged: (value) {
                        password = value != '' ? value : '';
                      },
                    ),
                  ],
                ),

                // Third Column
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20.0,
                    right: 20.0,
                    bottom: 20.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      AuthenticationButton(
                        label: 'Masuk',
                        color: colorUtama,
                        onPressed: () {
                          doLogin();
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }

}