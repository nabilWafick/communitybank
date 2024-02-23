import 'package:communitybank/models/data/collector/collector.model.dart';
import 'package:communitybank/utils/colors/colors.util.dart';
import 'package:communitybank/views/widgets/definitions/collectors/collectors_list/collectors_list.widget.dart';
import 'package:communitybank/views/widgets/globals/text/text.widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CashOperationsCollectorProfil extends ConsumerWidget {
  final Collector? collector;
  const CashOperationsCollectorProfil({super.key, this.collector});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final collectorsListStream = ref.watch(collectorsListStreamProvider);

    return collector != null
        ? Consumer(
            builder: (context, ref, child) {
              return collectorsListStream.when(
                data: (data) {
                  final realTimeCollectorData = data.firstWhere(
                    (collectorData) => collector!.id == collectorData.id,
                  );
                  return Row(
                    children: [
                      Container(
                        height: 80.0,
                        width: 80.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            50.0,
                          ),
                          border: Border.all(
                            color: CBColors.sidebarTextColor.withOpacity(.5),
                            width: 1.5,
                          ),
                        ),
                        child: Center(
                          child: realTimeCollectorData.profile != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                    50.0,
                                  ),
                                  child: Image.network(
                                    realTimeCollectorData.profile!,
                                  ),
                                )
                              : const Center(
                                  child: Icon(
                                    Icons.person,
                                    size: 30.0,
                                    color: CBColors.primaryColor,
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(
                        width: 20.0,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CBText(
                            text:
                                '${realTimeCollectorData.name} ${realTimeCollectorData.firstnames}',
                            fontWeight: FontWeight.w500,
                            fontSize: 11.0,
                          ),
                          CBText(
                            text: realTimeCollectorData.phoneNumber,
                            fontSize: 10.0,
                          ),
                        ],
                      ),
                    ],
                  );
                },
                error: (error, stackTrace) => Row(
                  children: [
                    Container(
                      height: 80.0,
                      width: 80.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          50.0,
                        ),
                        border: Border.all(
                          color: CBColors.sidebarTextColor.withOpacity(.5),
                          width: 1.5,
                        ),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.person,
                          size: 30.0,
                          color: CBColors.primaryColor,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20.0,
                    ),
                    const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CBText(
                          text: '',
                          fontWeight: FontWeight.w500,
                          fontSize: 11.0,
                        ),
                        CBText(
                          text: '',
                          fontSize: 10.0,
                        ),
                      ],
                    ),
                  ],
                ),
                loading: () => Row(
                  children: [
                    Container(
                      height: 80.0,
                      width: 80.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          50.0,
                        ),
                        border: Border.all(
                          color: CBColors.sidebarTextColor.withOpacity(.5),
                          width: 1.5,
                        ),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.person,
                          size: 30.0,
                          color: CBColors.primaryColor,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20.0,
                    ),
                    const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CBText(
                          text: '',
                          fontWeight: FontWeight.w500,
                          fontSize: 11.0,
                        ),
                        CBText(
                          text: '',
                          fontSize: 10.0,
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          )
        : Row(
            children: [
              Container(
                height: 80.0,
                width: 80.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    50.0,
                  ),
                  border: Border.all(
                    color: CBColors.sidebarTextColor.withOpacity(.5),
                    width: 1.5,
                  ),
                ),
                child: const Center(
                  child: Icon(
                    Icons.person,
                    size: 30.0,
                    color: CBColors.primaryColor,
                  ),
                ),
              ),
              const SizedBox(
                width: 20.0,
              ),
              const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CBText(
                    text: '',
                    fontWeight: FontWeight.w500,
                    fontSize: 11.0,
                  ),
                  CBText(
                    text: '',
                    fontSize: 10.0,
                  ),
                ],
              ),
            ],
          );
  }
}
