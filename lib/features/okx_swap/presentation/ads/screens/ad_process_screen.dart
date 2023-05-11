import 'package:betticos/core/core.dart';
import 'package:betticos/features/betticos/presentation/timeline/widgets/timeline_card.dart';
import 'package:betticos/features/okx_swap/presentation/ads/utils/special_category_type.dart';
import 'package:betticos/features/okx_swap/presentation/ads/widgets/category_widget.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

import '../getx/ads_controller.dart';

class AdProcessScreen extends StatefulWidget {
  const AdProcessScreen({Key? key}) : super(key: key);

  @override
  State<AdProcessScreen> createState() => _AdProcessScreenState();
}

class _AdProcessScreenState extends State<AdProcessScreen> {
  final AdsController controller = Get.find<AdsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 60,
                child:
                    AppBackButton(onPressed: () => Navigator.of(context).pop()),
              ),
              const SizedBox(width: 8),
              Expanded(child: _AdEasyStepper()),
            ],
          ),
          const SizedBox(height: 16),
          Obx(() =>
              Expanded(child: switchWidgets(controller.currentStep.value))),
        ],
      ),
    );
  }

  Widget switchWidgets(int currentStep) {
    switch (currentStep) {
      case 0:
        return _AdsPreviewStep();

      case 1:
        return _TargetAudienceStep();
      case 2:
        return _BudgetAndDuration();
      case 3:
        return Column(
          children: <Widget>[
            const Spacer(),
            _StepControls(),
            const SizedBox(height: 20)
          ],
        );
      default:
        return _AdsPreviewStep();
    }
  }
}

class _AdEasyStepper extends StatelessWidget {
  _AdEasyStepper({Key? key}) : super(key: key);

  final AdsController controller = Get.find<AdsController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return EasyStepper(
        activeStep: controller.currentStep.value,
        lineLength: 100,
        lineThickness: 2,
        lineSpace: 10,
        lineType: LineType.normal,
        defaultLineColor: Colors.purple.shade300,
        borderThickness: 3,
        activeStepBorderType: BorderType.normal,
        defaultStepBorderType: BorderType.normal,
        internalPadding: 20,
        loadingAnimation: AppAssetJson.loadingCircle,
        stepRadius: 20,
        steps: <EasyStep>[
          EasyStep(
            icon: Icon(Ionicons.cart, color: context.colors.text, size: 16),
            customTitle: Text(
              'Ad Preview',
              style: context.caption.copyWith(color: context.colors.text),
              textAlign: TextAlign.center,
            ),
          ),
          EasyStep(
            icon: Icon(Ionicons.information,
                color: context.colors.text, size: 16),
            customTitle: Text(
              'Target Audience',
              style: context.caption.copyWith(color: context.colors.text),
              textAlign: TextAlign.center,
            ),
          ),
          EasyStep(
            icon: Icon(Ionicons.cart, color: context.colors.text, size: 16),
            customTitle: Text(
              'Total Budget',
              style: context.caption.copyWith(color: context.colors.text),
              textAlign: TextAlign.center,
            ),
          ),
          EasyStep(
            icon: Icon(Ionicons.cash, color: context.colors.text, size: 16),
            customTitle: Text(
              'Summary',
              style: context.caption.copyWith(color: context.colors.text),
              textAlign: TextAlign.center,
            ),
          ),
        ],
        onStepReached: (int index) => controller.currentStep.value = index,
      );
    });
  }
}

class _AdsPreviewStep extends StatelessWidget {
  _AdsPreviewStep();

  final AdsController controller = Get.find<AdsController>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Obx(
        () => Column(
          children: <Widget>[
            TimelineCard(post: controller.post.value),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {
                controller.isSpecialAdCategory.value =
                    !controller.isSpecialAdCategory.value;
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Special Ad category',
                    textAlign: TextAlign.left,
                    style: context.body2.copyWith(
                        color: context.colors.textDark,
                        fontWeight: FontWeight.w400),
                  ),
                  IgnorePointer(
                    child: AppCheckBox(
                      checkBoxMargin: EdgeInsets.zero,
                      borderRadius: BorderRadius.circular(2),
                      height: 24,
                      value: controller.isSpecialAdCategory.value,
                      onChanged: (_) {},
                    ),
                  ),
                ],
              ),
            ),
            if (!controller.isSpecialAdCategory.value) ...<Widget>[
              const SizedBox(height: 5),
              Text(
                'If special Ad category is selected we will show your Ads to certain group of people.',
                style: context.caption.copyWith(
                  color: context.colors.text,
                ),
                textAlign: TextAlign.justify,
              ),
            ],
            if (controller.isSpecialAdCategory.value) ...<Widget>[
              const SizedBox(height: 8),
              _PopularCategorySection(),
            ],
            const Spacer(),
            _StepControls(),
            const SizedBox(height: 20)
          ],
        ),
      ),
    );
  }
}

class _TargetAudienceStep extends StatelessWidget {
  _TargetAudienceStep({Key? key}) : super(key: key);

  final AdsController controller = Get.find<AdsController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Add Location',
                style: context.caption.copyWith(
                  fontWeight: FontWeight.bold,
                  color: context.colors.black,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: context.colors.primary,
                    width: 2,
                    style: BorderStyle.solid,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: CountryCodePicker(
                  onChanged: controller.addCountry,
                  dialogTextStyle:
                      context.caption.copyWith(color: context.colors.black),
                  showFlagMain: false,
                  showFlag: false,
                  initialSelection: 'GH',
                  showCountryOnly: true,
                  showOnlyCountryWhenClosed: true,
                  alignLeft: true,
                  textStyle:
                      context.caption.copyWith(color: context.colors.black),
                  onInit: controller.addCountry,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Obx(() {
            if (controller.countries.isNotEmpty) {
              return Text(
                'Selected Locations',
                style: context.caption.copyWith(
                  fontWeight: FontWeight.bold,
                  color: context.colors.black,
                ),
              );
            }
            return const SizedBox.shrink();
          }),
          Obx(
            () => Column(
              children: controller.countries
                  .map(
                    (CountryCode code) => InkWell(
                      onTap: () => controller.removeCountry(code),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 3.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              code.name!,
                              style: context.caption
                                  .copyWith(color: context.colors.black),
                            ),
                            Icon(
                              Ionicons.checkmark_circle_sharp,
                              color: context.colors.success,
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          const SizedBox(height: 16),
          Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Age Range: ',
                  style: context.caption.copyWith(
                    color: context.colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${controller.rangeValues.value.start.toInt()} - ${controller.rangeValues.value.end.toInt()}',
                  style: context.caption.copyWith(color: context.colors.black),
                ),
              ],
            ),
          ),
          Obx(
            () => RangeSlider(
              values: controller.rangeValues.value,
              onChanged: (RangeValues values) =>
                  controller.rangeValues.value = values,
              min: 18,
              max: 65,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Gender',
            style: context.caption.copyWith(
              color: context.colors.black,
            ),
          ),
          const SizedBox(height: 3),
          Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: Gender.values
                  .map(
                    (Gender gender) => AppConstrainedButton(
                      text: StringUtils.capitalizeFirst(gender.name),
                      onPressed: () => controller.gender.value = gender,
                      constraints:
                          const BoxConstraints(maxHeight: 40, minWidth: 80),
                      color: context.colors.primary,
                      textColor: Colors.white,
                      selected: controller.gender.value == gender,
                    ),
                  )
                  .toList(),
            ),
          ),
          const Spacer(),
          _StepControls(),
          const SizedBox(height: 20)
        ],
      ),
    );
  }
}

class _BudgetAndDuration extends StatelessWidget {
  _BudgetAndDuration({Key? key}) : super(key: key);

  final AdsController controller = Get.find<AdsController>();
  final TextEditingController amountTextEditingController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Obx(
                    () => _InfoCard(
                      title: 'Total Spend',
                      subtitle: '\$${controller.amount.value}/day',
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                const Expanded(
                  child: _InfoCard(
                    title: 'Estimated Reach',
                    subtitle: r'23K - 60K',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            AppTextInput(
              labelText: 'Amount (USD)',
              lableStyle: context.caption.copyWith(
                color: context.colors.black,
                fontWeight: FontWeight.bold,
              ),
              controller: amountTextEditingController,
              initialValue: controller.amount.value.toString(),
              textInputType: TextInputType.number,
              onChanged: (String value) {
                if (value.isNotEmpty) {
                  final int amount = int.parse(value);
                  controller.amount.value = amount;
                  if (amount > 1000 || amount == 1000) {
                    controller.maxAmount.value = amount;
                  }
                }
              },
              backgroundColor: context.colors.primary.shade100,
              validator: (String value) => null,
            ),
            Slider(
              value: controller.amount.value.toDouble(),
              onChanged: (double value) {
                controller.amount.value = value.toInt();
                amountTextEditingController.text = value.toInt().toString();
              },
              min: 1,
              max: controller.maxAmount.value.toDouble(),
            ),
            const SizedBox(height: 16),
            Row(
              children: <Widget>[
                Text(
                  'Duration: ',
                  style: context.caption.copyWith(
                    color: context.colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (!controller.runUntilPaused.value)
                  Text(
                    '${controller.duration.value} days',
                    style:
                        context.caption.copyWith(color: context.colors.black),
                  ),
              ],
            ),
            TextButton(
              onPressed: () {
                controller.runUntilPaused.value =
                    !controller.runUntilPaused.value;
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Run this ad until I pause it.',
                    textAlign: TextAlign.left,
                    style: context.body2.copyWith(
                        color: context.colors.textDark,
                        fontWeight: FontWeight.w400),
                  ),
                  IgnorePointer(
                    child: AppCheckBox(
                      checkBoxMargin: EdgeInsets.zero,
                      borderRadius: BorderRadius.circular(2),
                      height: 24,
                      value: controller.runUntilPaused.value,
                      onChanged: (_) {},
                    ),
                  ),
                ],
              ),
            ),
            if (!controller.runUntilPaused.value)
              Slider(
                value: controller.duration.value.toDouble(),
                onChanged: (double value) =>
                    controller.duration.value = value.toInt(),
                min: 1,
                max: 30,
              ),
            const Spacer(),
            _StepControls(),
            const SizedBox(height: 20)
          ],
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({Key? key, required this.title, required this.subtitle})
      : super(key: key);

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      decoration: BoxDecoration(
        color: context.colors.faintGrey,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            title,
            style: context.caption.copyWith(color: context.colors.text),
          ),
          const SizedBox(height: 5),
          Text(
            subtitle,
            style: context.h5.copyWith(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    Key? key,
    required this.iconData,
    required this.textData,
    this.onPressed,
    this.reverse = false,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final bool reverse;
  final IconData iconData;
  final String textData;

  @override
  Widget build(BuildContext context) {
    final Icon icon = Icon(iconData, color: Colors.white, size: 20.0);
    final Text text = Text(textData,
        style: context.caption
            .copyWith(color: Colors.white, fontWeight: FontWeight.bold));
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.only(
            left: reverse ? 15 : 8, right: reverse ? 8 : 15, top: 8, bottom: 8),
        decoration: BoxDecoration(
          color: context.colors.primary,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Center(
            child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            if (!reverse) icon else text,
            if (!reverse) text else icon,
          ],
        )),
      ),
    );
  }
}

class _StepControls extends StatelessWidget {
  _StepControls({Key? key}) : super(key: key);

  final AdsController controller = Get.find<AdsController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        final MainAxisAlignment mainAxisAlignment =
            controller.currentStep.value == 0
                ? MainAxisAlignment.end
                : controller.currentStep.value == 3
                    ? MainAxisAlignment.start
                    : MainAxisAlignment.spaceBetween;
        return Row(
          mainAxisAlignment: mainAxisAlignment,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            if (controller.currentStep.value != 0)
              _ActionButton(
                iconData: Ionicons.chevron_back_outline,
                textData: 'Back'.toUpperCase(),
                onPressed: () => controller.currentStep.value -= 1,
              ),
            if (controller.currentStep.value != 3)
              _ActionButton(
                iconData: Ionicons.chevron_forward_outline,
                textData: 'Next'.toUpperCase(),
                onPressed: () => controller.currentStep.value += 1,
                reverse: true,
              ),
          ],
        );
      },
    );
  }
}

class _PopularCategorySection extends StatelessWidget {
  _PopularCategorySection();

  final AdsController controller = Get.find<AdsController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Wrap(
          spacing: 8,
          runSpacing: 16,
          children: SpecialCategoryType.values
              .map(
                (SpecialCategoryType type) => type.displayName.isNotEmpty
                    ? Obx(
                        () => CategoryWidget(
                          category: type.displayName,
                          isSelected: controller.category.value == type,
                          onPressed: () => controller.category.value = type,
                        ),
                      )
                    : const SizedBox.shrink(),
              )
              .toList(),
        ),
        const AppSpacing(v: 8),
        Obx(
          () => Text(
            controller.category.value.info,
            style: context.caption.copyWith(color: Colors.black),
            textAlign: TextAlign.start,
          ),
        ),
      ],
    );
  }
}

extension SpecialCateoryTypex on SpecialCategoryType {
  String get info {
    switch (this) {
      case SpecialCategoryType.credit:
        return 'Ads for credit card offers, auto loans, long-term financing or other related opportunities.';
      case SpecialCategoryType.employment:
        return 'Ads for job offers, internships, professional certification programs or other related opportunities.';
      case SpecialCategoryType.housing:
        return 'Ads for real estate listings, homeowners insurance, mortgage loands or other related opportunities.';
      case SpecialCategoryType.socialIssues:
        return 'Ads about social issues such as the economy or civiy and social rights.';
      case SpecialCategoryType.election:
        return 'Ads for elections such as national election, assembly, Member of parliament eelctions.';
      case SpecialCategoryType.politics:
        return 'Ads about politics, topics related to politics.';
      case SpecialCategoryType.unknown:
        return '';
    }
  }
}
