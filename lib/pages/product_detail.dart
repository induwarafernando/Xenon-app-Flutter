import 'package:flutter/material.dart';
import 'package:xenon_app/product_detail/color.dart';
import 'package:xenon_app/product_detail/style.dart';
import 'package:xenon_app/models/shoe.dart';

class ProductDetails extends StatelessWidget {
  final Shoe shoe;
  const ProductDetails({Key? key, required this.shoe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            child: Container(
              alignment: Alignment.topCenter,
              height: size.height / 2.2,
              width: size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  alignment: Alignment.bottomRight,
                  fit: BoxFit.cover,
                  image: AssetImage(shoe.imagePath),
                ),
              ),
            ),
          ),
          Positioned(
              top: 60,
              right: 20,
              child: Container(
                height: 32,
                width: 32,
                decoration: BoxDecoration(
                    color: AppColor.primary,
                    borderRadius: BorderRadius.circular(11)),
                child: Image.asset(shoe.imagePath),
              )),
          Positioned(
            top: 150,
            right: 24,
            child: Container(
              height: 276,
              width: 73,
              decoration: BoxDecoration(
                  gradient: AppColor.gradient,
                  borderRadius: BorderRadius.circular(20)),
              child: Column(children: [
                Container(
                  margin: const EdgeInsets.only(top: 6),
                  height: 61,
                  width: 61,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColor.primary, width: 2),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(shoe.imagePath))),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 6),
                  height: 61,
                  width: 61,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(shoe.imagePath))),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 6),
                  height: 61,
                  width: 61,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(shoe.imagePath))),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 6),
                  height: 61,
                  width: 61,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(shoe.imagePath))),
                ),
              ]),
            ),
          ),
          Positioned(
              bottom: 0,
              child: Container(
                height: size.height / 2.2,
                width: size.width,
                decoration: const BoxDecoration(
                  color: AppColor.secondary,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(32),
                      topRight: Radius.circular(32)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 16),
                          height: 5,
                          width: 32 * 1.5,
                          decoration: BoxDecoration(
                            gradient: AppColor.gradient,
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                      ),
                      ProductNameAndPrice(shoe: shoe),
                      const SizedBox(
                        height: 16,
                      ),
                      Text('Size',
                          style: AppStyle.text.copyWith(
                              color: Color.fromARGB(255, 6, 1, 37)
                                  .withOpacity(.8))),
                      const Spacing(),
                      const Row(
                        children: [
                          RectButtonSelected(
                            label: 'S',
                          ),
                          RectButton(
                            label: 'M',
                          ),
                          RectButton(
                            label: 'L',
                          ),
                          RectButton(
                            label: 'XL',
                          ),
                        ],
                      ),
                      const Spacing(),
                      const Row(
                        children: [
                          TabTitle(label: 'Details', selected: true),
                          SizedBox(width: 8),
                          TabTitle(label: 'Review', selected: false),
                        ],
                      ),
                      const Spacing(),
                      Text(
                        shoe.description,
                        style: AppStyle.bodyText
                            .copyWith(color: Color.fromARGB(255, 25, 1, 72)),
                      ),
                      const Spacing(),
                      Center(
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      AppColor.primary),
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(16))),
                                  minimumSize: MaterialStateProperty.all(
                                      Size(size.width / 1.4, 37))),
                              onPressed: () {},
                              child: Text('Add To Cart',
                                  style: AppStyle.h3
                                      .copyWith(color: Colors.white))))
                    ],
                  ),
                ),
              ))
        ],
      ),
    );
  }
}

class ProductNameAndPrice extends StatelessWidget {
  final Shoe shoe;
  const ProductNameAndPrice({
    Key? key,
    required this.shoe,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          shoe.name,
          style: AppStyle.h1Light,
        ),
        Text(
          '\$${shoe.price}',
          style: AppStyle.h1Light
              .copyWith(color: AppColor.primary, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}

class TabTitle extends StatelessWidget {
  final String label;
  final bool selected;
  const TabTitle({
    Key? key,
    required this.label,
    required this.selected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            label,
            style: AppStyle.text.copyWith(color: Color.fromARGB(255, 1, 6, 54)),
          ),
          const SizedBox(
            height: 4,
          ),
          if (selected)
            Container(
              width: 21,
              height: 2,
              decoration: const BoxDecoration(color: AppColor.primary),
            )
        ])
      ],
    );
  }
}

class Spacing extends StatelessWidget {
  const Spacing({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 16,
    );
  }
}

class RectButtonSelected extends StatelessWidget {
  final String label;
  const RectButtonSelected({
    Key? key,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 14),
      height: 32,
      width: 32,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9), gradient: AppColor.gradient),
      child: Center(
          child: Text(
        label,
        style: AppStyle.text,
      )),
    );
  }
}

class RectButton extends StatelessWidget {
  final String label;
  const RectButton({
    Key? key,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 14),
      height: 32,
      width: 32,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9),
          border: Border.all(color: AppColor.primary)),
      child: Center(
          child: Text(
        label,
        style: AppStyle.text.copyWith(color: Color.fromARGB(255, 15, 2, 62)),
      )),
    );
  }
}
