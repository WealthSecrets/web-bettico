import 'package:betticos/core/core.dart';
import 'package:betticos/features/advert/data/models/advert_model.dart';
import 'package:betticos/features/betticos/presentation/base/getx/base_screen_controller.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

import '../getx/getx.dart';
import '../widgets/step_controls.dart';
import 'ad_preview_step.dart';
import 'ads_summary_screen.dart';

class AdProcessScreen extends StatefulWidget {
  const AdProcessScreen({super.key});

  @override
  State<AdProcessScreen> createState() => _AdProcessScreenState();
}

class _AdProcessScreenState extends State<AdProcessScreen> {
  final AdsController controller = Get.find<AdsController>();

  @override
  void initState() {
    super.initState();
    controller.estimateReach();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => AppLoadingBox(
          loading: controller.isCreatingAd.value,
          child: Column(
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 60, child: AppBackButton(onPressed: () => Navigator.of(context).pop())),
                  const SizedBox(width: 8),
                  Expanded(child: _AdEasyStepper()),
                ],
              ),
              const SizedBox(height: 16),
              Expanded(child: switchWidgets(controller.currentStep.value)),
            ],
          ),
        ),
      ),
    );
  }

  Widget switchWidgets(int currentStep) {
    switch (currentStep) {
      case 0:
        return AdsPreviewStep();

      case 1:
        return _TargetAudienceStep();
      case 2:
        return _BudgetAndDuration();
      case 3:
        return const AdsSummaryScreen();
      default:
        return AdsPreviewStep();
    }
  }
}

class _AdEasyStepper extends StatelessWidget {
  _AdEasyStepper();

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
            icon: Icon(Ionicons.information, color: context.colors.text, size: 16),
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

class _TargetAudienceStep extends StatelessWidget {
  _TargetAudienceStep();
  final AdsController controller = Get.find<AdsController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          AppCountryPicker(
            onChanged: controller.addCountry,
            dialogTextStyle: context.caption.copyWith(color: context.colors.black),
            showFlagMain: false,
            showFlag: false,
            initialSelection: 'GH',
            showCountryOnly: true,
            showOnlyCountryWhenClosed: true,
            alignLeft: true,
            textStyle: context.caption.copyWith(color: context.colors.black),
            onInit: controller.addCountry,
          ),
          const SizedBox(height: 16),
          Obx(() {
            if (controller.countries.isNotEmpty) {
              return Text(
                'Selected Locations',
                style: context.caption.copyWith(fontWeight: FontWeight.bold, color: context.colors.black),
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
                            Text(code.name!, style: context.caption.copyWith(color: context.colors.black)),
                            Icon(Ionicons.checkmark_circle_sharp, color: context.colors.success)
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
              children: <Widget>[
                Text(
                  'Age Range: ',
                  style: context.caption.copyWith(color: context.colors.black, fontWeight: FontWeight.bold),
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
              onChanged: (RangeValues values) => controller.rangeValues.value = values,
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
                      constraints: const BoxConstraints(maxHeight: 40, minWidth: 80),
                      color: context.colors.primary,
                      textColor: Colors.white,
                      selected: controller.gender.value == gender,
                    ),
                  )
                  .toList(),
            ),
          ),
          const Spacer(),
          StepControls(),
          const SizedBox(height: 20)
        ],
      ),
    );
  }
}

class _BudgetAndDuration extends StatelessWidget {
  _BudgetAndDuration();

  final AdsController controller = Get.find<AdsController>();
  final BaseScreenController bController = Get.find<BaseScreenController>();
  final TextEditingController amountTextEditingController = TextEditingController();

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
                    () => _InfoCard(title: 'Total Spend', subtitle: '\$${controller.budget.value}'),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child:
                      _InfoCard(title: 'Estimated Reach', subtitle: controller.estimatedReach.value.toInt().toString()),
                ),
              ],
            ),
            const SizedBox(height: 16),
            AppTextInput(
              labelText: 'Amount (USD)',
              lableStyle: context.caption.copyWith(color: context.colors.black, fontWeight: FontWeight.bold),
              controller: amountTextEditingController,
              initialValue: controller.budget.value.toString(),
              textInputType: TextInputType.number,
              onChanged: (String value) {
                if (value.isNotEmpty) {
                  final int amount = int.parse(value);
                  controller.budget.value = amount;
                  if (amount > 1000 || amount == 1000) {
                    controller.maxAmount.value = amount;
                  }

                  controller.estimateReach();
                }
              },
              backgroundColor: context.colors.primary.shade100,
              validator: (String value) => null,
            ),
            Slider(
              value: controller.budget.value.toDouble(),
              onChanged: (double value) {
                controller.budget.value = value.toInt();
                amountTextEditingController.text = value.toInt().toString();
                controller.estimateReach();
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
                    style: context.caption.copyWith(color: context.colors.black),
                  ),
              ],
            ),
            TextButton(
              onPressed: () {
                controller.runUntilPaused.value = !controller.runUntilPaused.value;
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Run this ad until I pause it.',
                    textAlign: TextAlign.left,
                    style: context.body2.copyWith(color: context.colors.textDark, fontWeight: FontWeight.w400),
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
                onChanged: (double value) {
                  controller.duration.value = value.toInt();
                  controller.estimateReach();
                },
                min: 1,
                max: 30,
              ),
            const Spacer(),
            StepControls(),
            const SizedBox(height: 20)
          ],
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.title, required this.subtitle});

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
