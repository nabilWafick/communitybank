import 'package:communitybank/utils/utils.dart';
import 'package:communitybank/views/widgets/globals/text/text.widget.dart';
import 'package:communitybank/views/widgets/home/sidebar/sidebar.widget.dart';
import 'package:communitybank/views/widgets/home/sidebar/sidebar_suboption/sidebar_suboption.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final authenticatedAgentNameProvider = FutureProvider<String>((ref) async {
  //  set user data in shared preferences
  final prefs = await SharedPreferences.getInstance();
  final agentFistnames = prefs.getString(CBConstants.agentFirstnamesPrefKey);
  final agentName = prefs.getString(CBConstants.agentNamePrefKey);

  return '${agentFistnames ?? ''} ${agentName ?? ''}';
});

class MainAppbar extends ConsumerStatefulWidget {
  const MainAppbar({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainAppbarState();
}

class _MainAppbarState extends ConsumerState<MainAppbar> {
  final scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    final authenticatedAgentName = ref.watch(authenticatedAgentNameProvider);
    final screenSize = MediaQuery.of(context).size;
    final selectedSidebarOption = ref.watch(selectedSidebarOptionProvider);

    return Container(
      height: screenSize.height / 7,
      padding: const EdgeInsets.only(top: 25.0),
      // color: Colors.grey,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CBText(
                text: selectedSidebarOption.name,
                //   color: CBColors.sidebarTextColor,
                fontSize: 25.0,
                fontWeight: FontWeight.w600,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  /*  Icon(
                    Icons.notifications,
                    size: 25.0,
                    color: CBColors.tertiaryColor,
                  ),
                  SizedBox(
                    width: 30.0,
                  ),*/
                  CBText(
                    text: authenticatedAgentName.when(
                        data: (data) => data,
                        error: (error, stakTrace) => '',
                        loading: () => ''),
                    fontSize: 15.0,
                    fontWeight: FontWeight.w600,
                  ),
                  /*   SizedBox(
                    width: 20.0,
                  ),
                  Card(
                    color: CBColors.primaryColor,
                    elevation: 5.0,
                    child: SizedBox(
                      height: 25.0,
                      width: 25.0,
                    ),
                  )*/
                ],
              )
            ],
          ),
          const SizedBox(
            height: 12.0,
          ),
          /* Scrollbar(
            radius: const Radius.circular(
              15.0,
            ),
            controller: scrollController,
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(
                bottom: 20.0,
              ),
              controller: scrollController,
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: selectedSidebarOption.subOptions
                    .map(
                      (subOption) =>
                          SidebarSubOption(sidebarSubOptionData: subOption),
                    )
                    .toList(),
              ),
            ),
          ),*/
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 50,
            child: CustomHorizontalScroller(
              children: selectedSidebarOption.subOptions
                  .map(
                    (subOption) =>
                        SidebarSubOption(sidebarSubOptionData: subOption),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomHorizontalScroller extends StatefulWidget {
  final List<Widget> children;

  const CustomHorizontalScroller({super.key, required this.children});

  @override
  _CustomHorizontalScrollerState createState() =>
      _CustomHorizontalScrollerState();
}

class _CustomHorizontalScrollerState extends State<CustomHorizontalScroller> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: ListView(
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
                _scrollController.offset - MediaQuery.of(context).size.width,
                curve: Curves.linear,
                duration: const Duration(milliseconds: 100),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: CBColors.primaryColor,
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
          ),
        ),
        Positioned(
          right: 0,
          child: IconButton(
            icon: const Icon(Icons.arrow_forward),
            onPressed: () {
              _scrollController.animateTo(
                _scrollController.offset + MediaQuery.of(context).size.width,
                curve: Curves.linear,
                duration: const Duration(milliseconds: 100),
              );
            },
          ),
        ),
      ],
    );
  }
}
