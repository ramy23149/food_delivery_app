import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:food_delivery_app/Core/constats.dart';
import 'package:food_delivery_app/Core/text_styles/Styles.dart';
import 'package:food_delivery_app/Core/widgets/custom_bottom.dart';

import '../../../../Core/widgets/Custom_text_bottom.dart';
import '../../../../Core/widgets/custom_appBar.dart';
import 'custom_wallet_contaner.dart';


class WalletViewBody extends StatelessWidget {
  const WalletViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CustomAppBar(),
        const SizedBox(
          height: 20,
        ),
        const CustomWalletContaner(),
          const SizedBox(
          height: 20,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Text(
                "Add money",
                style: Styles.textStyle20Extra,
              ),
            ),
              const SizedBox(
          height: 10,
        ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 11.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomTextButtom(
                      text: "\$100",
                    ),
                    CustomTextButtom(
                      text: "\$500",
                    ),
                    CustomTextButtom(
                      text: "\$1000",
                    ),
                    CustomTextButtom(
                      text: "\$2000",
                    ),
                  ],
                ),
              ),
            ),
              const SizedBox(
          height: 45,
        ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: CustomBotton(
                borderRadius: BorderRadius.circular(5),
                width: MediaQuery.of(context).size.width,
                textColor: kWhite,
                backgroundColor: const Color(0xff017476),
                text: "Add Money",
              ),
            ),
          ],
        )
      ],
    );
  }
}
