import 'package:betticos/core/core.dart';
import 'package:betticos/features/p2p_betting/presentation/p2p_betting/getx/p2pbet_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:intl/intl.dart';

import 'selectable_button.dart';

class SearchFilterBottomSheet extends GetWidget<P2PBetController> {
  const SearchFilterBottomSheet({super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: .47.sh,
      width: MediaQuery.of(context).size.width,
      child: ClipRRect(
        borderRadius: AppBorderRadius.largeTop,
        child: Padding(
          padding: AppPaddings.homeH.add(AppPaddings.lT),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      'Filter by',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: context.colors.textDark,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.resetSearch();
                      Navigator.of(context).pop();
                    },
                    child: Image.asset(
                      AssetImages.closeSmall,
                      height: 15,
                      width: 15,
                    ),
                  ),
                ],
              ),
              const AppSpacing(v: 20),
              Obx(
                () => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: AppDatePicker(
                            labelText: 'From Date',
                            initialDate:
                                controller.from.value.isNotEmpty ? DateTime.parse(controller.from.value) : null,
                            validator: (_) => null,
                            onDateTimeChanged: (DateTime from) {
                              final DateFormat formatter = DateFormat('yyyy-MM-dd');
                              final String formatted = formatter.format(from);
                              controller.from.value = formatted;
                            },
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: AppDatePicker(
                            labelText: 'To Date',
                            initialDate: controller.to.value.isNotEmpty ? DateTime.parse(controller.to.value) : null,
                            validator: (DateTime? from) {
                              return null;
                            },
                            onDateTimeChanged: (DateTime to) {
                              final DateFormat formatter = DateFormat('yyyy-MM-dd');
                              final String formatted = formatter.format(to);
                              controller.to.value = formatted;
                            },
                          ),
                        )
                      ],
                    ),
                    const AppSpacing(v: 8),
                    const Text(
                      'Type',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 10,
                      ),
                    ),
                    const AppSpacing(v: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        SelectableButton(
                          text: 'Awaiting',
                          selected: controller.searchStatus.value == 'awaiting',
                          onPressed: () {
                            controller.searchStatus.value = 'awaiting';
                            controller.selectedButton.value = 'awaiting';
                          },
                        ),
                        SelectableButton(
                          text: 'Ongoing',
                          selected: controller.searchStatus.value == 'ongoing',
                          onPressed: () {
                            controller.searchStatus.value = 'ongoing';
                            controller.selectedButton.value = 'ongoing';
                          },
                        ),
                        SelectableButton(
                          text: 'Completed',
                          selected: controller.searchStatus.value == 'completed',
                          onPressed: () {
                            controller.searchStatus.value = 'completed';
                            controller.selectedButton.value = 'completed';
                          },
                        ),
                      ],
                    ),
                    const AppSpacing(v: 49),
                    AppButton(
                      onPressed: () {
                        controller.filterBets();
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        'Apply',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
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
