import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/Core/constats.dart';
import 'package:food_delivery_app/Core/helper/custom_snakBar.dart';
import 'package:food_delivery_app/Core/text_styles/Styles.dart';
import 'package:food_delivery_app/Core/widgets/custom_bottom.dart';
import 'package:food_delivery_app/featurs/home/Presentation/Manager/cubits/add_to_curt_cubit/add_to_curt_cubit.dart';
import 'package:food_delivery_app/featurs/home/Presentation/Manager/providers/customer_data_provider.dart';
import 'package:food_delivery_app/featurs/home/Presentation/views/widgets/custom_image.dart';
import 'package:food_delivery_app/featurs/home/data/models/product_model.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../../auth/data/enums/user_role_enum.dart';
import 'custom_counter.dart';

class ProductDetalisBody extends StatefulWidget {
  const ProductDetalisBody({
    super.key,
    required this.productModel,
  });
  final ProductModel productModel;

  @override
  State<ProductDetalisBody> createState() => _ProductDetalisBodyState();
}

class _ProductDetalisBodyState extends State<ProductDetalisBody> {
  late int curantprice;

  int count = 1;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    curantprice = widget.productModel.price;
  }

@override
Widget build(BuildContext context) {
  return BlocBuilder<AddToCurtCubit, AddToCurtState>(
    builder: (context, state) {
      if (state is AddToCurtSuccess) {
        Future.microtask(() {
          showSnackBar(context, 'تمت الإضافة إلى عربة التسوق بنجاح');
        });
      }
      return ModalProgressHUD(
        inAsyncCall: state is AddToCartLoading,
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomImage(image: widget.productModel.imageUrl),
                        const SizedBox(height: 15),
                        // Store Info Section
                        Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              children: [
                                // Store Logo
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: widget.productModel.storeInfo['image'] == ""
                                      ? const Icon(Icons.store,
                                          size: 50, color: Colors.grey)
                                      : CachedNetworkImage(
                                          imageUrl:
                                              widget.productModel.storeInfo['image'],
                                          height: 50,
                                          width: 50,
                                          fit: BoxFit.cover,
                                          placeholder: (context, url) =>
                                              const CircularProgressIndicator(),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error,
                                                  size: 50, color: Colors.red),
                                        ),
                                ),
                                const SizedBox(width: 12),
                                // Store Details
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        widget.productModel.storeInfo['name'],
                                        style: Styles.textStyle20,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        widget.productModel
                                            .storeInfo['districte'],
                                        style: Styles.textStyle14
                                            .copyWith(color: Colors.grey),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 5),
                                      Row(
                                        children: [
                                          const Icon(Icons.phone,
                                              size: 16, color: Colors.grey),
                                          const SizedBox(width: 5),
                                          Text(
                                            widget.productModel
                                                .storeInfo['phoneNumber']
                                                .toString()
                                                .substring(2),
                                            style: Styles.textStyle14,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        // Product Info Section
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                widget.productModel.name,
                                style: Styles.textStyle20,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            CustomCounter(
                              onCounterValueChanged: (value) {
                                setState(() {
                                  curantprice = widget.productModel.price * value;
                                  count = value;
                                });
                              },
                            )
                          ],
                        ),
                        const SizedBox(height: 7),
                        Text(
                          widget.productModel.desc,
                          style: Styles.textStyle14,
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 27),
                        Directionality(
                          textDirection: TextDirection.rtl,
                          child: Row(
                            children: [
                              const Icon(Icons.alarm_outlined,
                                  color: Color(0xffB2ACB2)),
                              const SizedBox(width: 5),
                              const Text(
                                'وقت التوصيل:',
                                style: Styles.textStyle20,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                'خلال ثلاث أيام',
                                style: Styles.textStyle20.copyWith(
                                    color: Colors.red),
                              ),
                              const SizedBox(width: 10),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                      
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                const Text(':المجموع', style: Styles.textStyle18),
                                Text('$curantprice EGP',
                                    style: Styles.textStyle20),
                              ],
                            ),
                          ],
                        ),
                  context.read<CustomerDataProvider>().userRole == UserRoleEnum.user.getDisplayName ?   CustomBotton(
                      onPressed: () {
                        BlocProvider.of<AddToCurtCubit>(context).addToCurt(
                          productModel: widget.productModel,
                          count: count,
                          totalPrice: curantprice,
                          context: context,
                        );
                      },
                      borderRadius: BorderRadius.circular(16),
                      textColor: kWhite,
                      backgroundColor: kMainAppColor,
                      text: 'إضافة إلى العربة 🛒',
                    ):const SizedBox() ,
                  ],
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      );
    },
  );
}
}




// class ProductDetalisBody extends StatefulWidget {
//   const ProductDetalisBody({
//     super.key,
//     required this.productModel,
//   });
//   final ProductModel productModel;

//   @override
//   State<ProductDetalisBody> createState() => _ProductDetalisBodyState();
// }

// class _ProductDetalisBodyState extends State<ProductDetalisBody> {
//   late int curantprice;

//   int count = 1;

//   bool isLoading = false;

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     curantprice = widget.productModel.price;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<AddToCurtCubit, AddToCurtState>(
//       builder: (context, state) {
//         if (state is AddToCurtSuccess) {
//           Future.microtask(() {
//             showSnackBar(context, 'تمت الاضافه الى عربه التسوق بنجاح');
//           });
//         }
//         return ModalProgressHUD(
//           inAsyncCall: state is AddToCartLoading,
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 12.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 CustomImage(image: widget.productModel.imageUrl),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Expanded(
//                         child: Text(
//                       widget.productModel.name,
//                       style: Styles.textStyle20,
//                       overflow: TextOverflow.ellipsis,
//                     )),
//                     CustomCounter(
//                       onCounterValueChanged: (value) {
//                         setState(() {
//                           curantprice =
//                               widget.productModel.price * value;
//                           count = value;
//                         });
//                       },
//                     )
//                   ],
//                 ),
//                 const SizedBox(
//                   height: 7,
//                 ),
//                 Text(
//                   widget.productModel.desc,
//                   style: Styles.textStyle14,
//                   maxLines: 5,
//                   overflow: TextOverflow.fade,
//                 ),
//                 const SizedBox(
//                   height: 27,
//                 ),
//                 const Row(
//                   children: [
//                     Text(
//                       ':وقت التوصيل',
//                       style: Styles.textStyle20,
//                     ),
//                     SizedBox(
//                       width: 40,
//                     ),
//                     Icon(
//                       Icons.alarm_outlined,
//                       color: Color(0xffB2ACB2),
//                     ),
//                     Text(
//                       ' خلال ثلاث ايام',
//                       style: Styles.textStyle20,
//                     ),
//                   ],
//                 ),
//                 const Spacer(),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Column(
//                       children: [
//                         const Text(
//                           ':المجموع',
//                           style: Styles.textStyle18,
//                         ),
//                         Text(
//                           '$curantprice EGP',
//                           style: Styles.textStyle20,
//                         )
//                       ],
//                     ),
//                     CustomBotton(
//                         onPressed: () {
//                           BlocProvider.of<AddToCurtCubit>(context).addToCurt(
//                               productModel: widget.productModel,
//                               count: count,
//                               totalPrice: curantprice,
//                               context: context);
//                         },
//                         borderRadius: BorderRadius.circular(16),
//                         textColor: kWhite,
//                         backgroundColor: kMainAppColor,
//                         text: 'اضافه الى العربه  🛒')
//                   ],
//                 ),
//                 const SizedBox(
//                   height: 5,
//                 )
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
