import 'package:flutter/material.dart';
import 'package:hanaang_app/components/customs/btn_default.dart';
import 'package:hanaang_app/components/customs/footer_dialog.dart';
import 'package:hanaang_app/components/customs/header_dialog.dart';
import 'package:hanaang_app/components/texts/h2.dart';
import 'package:hanaang_app/components/texts/normal.dart';
import 'package:hanaang_app/models/banner_model.dart';
import 'package:hanaang_app/utilities/base_url.dart';
import 'package:hanaang_app/utilities/next_to.dart';

void BannerDetail(BuildContext context, BannerModel data, String userRole) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                children: [
                  const HeaderDialog(title: 'Detail Banner'),
                  Positioned(
                    top: 0,
                    right: 5,
                    child: IconButton(
                      onPressed: () {
                        Next.back(context);
                      },
                      icon: Container(
                        width: 35,
                        height: 35,
                        padding: EdgeInsets.all(0),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Icon(
                          Icons.close,
                          size: 25,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              AspectRatio(
                aspectRatio: 16 / 9,
                child: Image.network(
                    fit: BoxFit.cover,
                    BaseUrl.baseUrl + "/storage/" + data.image),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextH2(
                      text: data.title,
                      fontWeight: FontWeight.bold,
                    ),
                    Divider(
                      height: 10,
                    ),
                    TextNormal(
                      text: data.description,
                      fontWeight: FontWeight.w500,
                      textAlign: TextAlign.justify,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ["super admin", "admin order"].contains(userRole)
                        ? SizedBox(
                            width: double.infinity,
                            child: Row(children: [
                              Expanded(
                                  child: BtnDefault(
                                      name: "Hapus",
                                      color: Colors.red,
                                      onTap: () {})),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  child:
                                      BtnDefault(name: "Update", onTap: () {})),
                            ]),
                          )
                        : SizedBox(),
                  ],
                ),
              ),
              const FooterDialog()
            ],
          ),
        ),
      );
    },
  );
}
