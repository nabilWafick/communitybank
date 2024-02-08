import 'package:communitybank/utils/colors/colors.util.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CashOperationsCustomerCardsHorizontalScroller
    extends StatefulHookConsumerWidget {
  final List<Widget> children;

  const CashOperationsCustomerCardsHorizontalScroller(
      {super.key, required this.children});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CashOperationsCustomerCardsHorizontalScrollerState();
}

class _CashOperationsCustomerCardsHorizontalScrollerState
    extends ConsumerState<CashOperationsCustomerCardsHorizontalScroller> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.center,
          margin: const EdgeInsets.symmetric(
            horizontal: 30.0,
          ),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            controller: _scrollController,
            children: widget.children,
          ),
        ),
        Positioned(
          left: 0,
          child: InkWell(
            onTap: () {
              _scrollController.animateTo(
                _scrollController.offset -
                    MediaQuery.of(context).size.width / 5,
                curve: Curves.linear,
                duration: const Duration(milliseconds: 100),
              );
            },
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  10,
                ),
              ),
              elevation: 5.0,
              color: CBColors.backgroundColor,
              //  color: CBColors.primaryColor,
              shadowColor: Colors.white,
              child: const Padding(
                padding: EdgeInsets.all(7.0),
                child: Icon(
                  Icons.arrow_back_ios_rounded,
                  //  color: Colors.white,
                  color: CBColors.primaryColor,
                  size: 12.0,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          right: 0,
          child: InkWell(
            onTap: () {
              _scrollController.animateTo(
                _scrollController.offset +
                    MediaQuery.of(context).size.width / 5,
                curve: Curves.linear,
                duration: const Duration(milliseconds: 100),
              );
            },
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  10,
                ),
              ),
              elevation: 5.0,
              color: CBColors.backgroundColor,
              // color: CBColors.primaryColor,
              child: const Padding(
                padding: EdgeInsets.all(7.0),
                child: Icon(
                  Icons.arrow_forward_ios_rounded,
                  //  color: Colors.white,
                  color: CBColors.primaryColor,
                  size: 12.0,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
