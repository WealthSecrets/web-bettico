import 'package:betticos/core/core.dart';
import 'package:betticos/features/auth/data/models/user/user.dart';
import 'package:betticos/features/betticos/presentation/base/getx/base_screen_controller.dart';
import 'package:betticos/features/okx_swap/data/models/bank/bank.dart';
import 'package:betticos/features/okx_swap/presentation/usdt/getx/sell_usdt_controller.dart';
import 'package:betticos/features/p2p_betting/presentation/livescore/getx/live_score_controllers.dart';
import 'package:efficient_autocomplete_formfield/efficient_autocomplete_formfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:rxdart/rxdart.dart';

class SellUsdtScreen extends StatefulWidget {
  const SellUsdtScreen({super.key});

  @override
  State<SellUsdtScreen> createState() => _SellUsdtScreenState();
}

class _SellUsdtScreenState extends State<SellUsdtScreen> {
  final LiveScoreController lController = Get.find<LiveScoreController>();

  final SellUsdtController controller = Get.find<SellUsdtController>();

  final User user = Get.find<BaseScreenController>().user.value;

  final TextEditingController _searchBanksTextEditingController = TextEditingController();

  final PublishSubject<String> _subject = PublishSubject<String>();

  @override
  void initState() {
    super.initState();
    WidgetUtils.onWidgetDidBuild(() {
      controller.fetchBanksOrTelcos(context);
      _subject.debounceTime(const Duration(milliseconds: 1000)).listen(
        (String term) {
          controller.textEditingController.value.text = term;
          if (term.isNotEmpty) {
            controller.onAccountNumberInputChanged(term);
            controller.resolverAccountNumber(context, accNumber: term);
          }
        },
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
    _subject.close();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AppLoadingBox(
        loading: controller.isFetchingBanksTelcos.value || controller.isCreateingRecipient.value,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            leading: const AppBackButton(color: Colors.black),
            title: const Text(
              'Sell USDT',
              style: TextStyle(fontSize: 14, color: Colors.black),
            ),
            centerTitle: true,
            elevation: 0,
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: AppAnimatedColumn(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                AppTextInput(
                  labelText: 'AMOUNT (USDT)',
                  textInputType: TextInputType.number,
                  onChanged: controller.onAmountInputChanged,
                  backgroundColor: context.colors.primary.shade100,
                  validator: controller.validateAmount,
                ),
                const SizedBox(height: 16),
                Text(
                  'SELECT METHOD',
                  style: context.overline.copyWith(color: context.colors.text, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                Obx(
                  () => Row(
                    children: SellMethod.values
                        .map(
                          (SellMethod method) => Container(
                            margin: const EdgeInsets.only(right: 24),
                            child: AppConstrainedButton(
                              text: StringUtils.capitalizeFirst(method.name),
                              onPressed: () {
                                controller.sellMethod.value = method;
                                controller.fetchBanksOrTelcos(context);
                              },
                              constraints: const BoxConstraints(maxHeight: 40, minWidth: 80),
                              color: context.colors.primary,
                              textColor: Colors.white,
                              selected: controller.sellMethod.value == method,
                              borderRadius: AppBorderRadius.mediumAll,
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
                const AppSpacing(v: 16),
                AutoTextInputWrapper(
                  labelText: controller.sellMethod.value == SellMethod.bank ? 'SEARCH BANK' : 'SEARCH TELCOS',
                  child: _BankSearchTextField(
                    controller: _searchBanksTextEditingController,
                    banks: controller.banksTelcos,
                    onChanged: (Bank bank) {
                      _searchBanksTextEditingController.value = TextEditingValue(text: bank.name);
                      controller.selectedBank.value = bank;
                      // controller.resolverAccountNumber(context);
                    },
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(15),
                      fillColor: context.colors.primary.shade100,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                AppTextInput(
                  labelText: controller.sellMethod.value == SellMethod.bank ? 'ACCOUNT NUMBER' : 'PHONE NUMBER',
                  textInputType: TextInputType.number,
                  onChanged: _subject.add,
                  backgroundColor: context.colors.primary.shade100,
                  validator: controller.validateAccountNumber,
                ),
                if (controller.isResolvingAccount.value) const LoadingLogo(),
                if (!controller.isResolvingAccount.value && controller.resolvedName.value.isNotEmpty) ...<Widget>[
                  const SizedBox(height: 30),
                  Container(
                    height: 46,
                    decoration: BoxDecoration(
                      color: controller.resolvedName.value == 'invalid number'
                          ? context.colors.error.withOpacity(0.1)
                          : context.colors.primary.shade100,
                      borderRadius: AppBorderRadius.largeAll,
                    ),
                    child: Center(
                      child: Text(
                        controller.resolvedName.value.toUpperCase(),
                        style: context.caption.copyWith(
                          color: controller.resolvedName.value == 'invalid number'
                              ? context.colors.error
                              : context.colors.primary,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
                Align(
                  child: RichText(
                    text: TextSpan(
                      text: 'We\'ll send ',
                      style: TextStyle(color: context.colors.text, fontWeight: FontWeight.normal, fontSize: 12),
                      children: <TextSpan>[
                        TextSpan(
                          text: '\u{20B5}${controller.quantity.value} ',
                          style: TextStyle(
                            color: context.colors.primary,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                        TextSpan(
                          text: 'into your ',
                          style: TextStyle(
                            color: context.colors.text,
                            fontWeight: FontWeight.normal,
                            fontSize: 12,
                          ),
                        ),
                        TextSpan(
                          text: '${controller.sellMethod.value.name} ',
                          style: TextStyle(
                            color: context.colors.primary,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                        TextSpan(
                          text: 'account',
                          style: TextStyle(
                            color: context.colors.text,
                            fontWeight: FontWeight.normal,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 100),
                AppButton(
                  enabled: controller.formIsValid && !controller.isResolvingAccount.value,
                  padding: EdgeInsets.zero,
                  borderRadius: AppBorderRadius.largeAll,
                  backgroundColor: context.colors.primary,
                  onPressed: () => controller.createTransferRecipient(context),
                  child: const Text(
                    'NEXT',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _BankSearchTextField extends StatelessWidget {
  const _BankSearchTextField({
    required this.controller,
    required this.onChanged,
    required this.decoration,
    required this.banks,
  });

  final TextEditingController controller;
  final ValueChanged<Bank> onChanged;
  final InputDecoration decoration;
  final List<Bank> banks;

  @override
  Widget build(BuildContext context) {
    return EfficientAutocompleteFormField<Bank>(
      controller: controller,
      decoration: decoration.copyWith(
        filled: true,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        hintStyle: context.body1.copyWith(fontWeight: FontWeight.w400, color: context.colors.hint, height: 1.4),
      ),
      style: context.caption.copyWith(color: context.colors.textDark),
      itemBuilder: (BuildContext txtContext, Bank? bank) {
        if (bank != null) {
          return ListTile(
            leading: Icon(Ionicons.storefront, size: 24, color: context.colors.primary),
            title: Text(bank.name, style: context.body1.copyWith(color: Colors.black)),
            subtitle: Text(bank.code, style: context.caption.copyWith(color: context.colors.text)),
          );
        }
        return const SizedBox.shrink();
      },
      onSearch: (String search) async =>
          banks.where((Bank bank) => bank.name.toLowerCase().contains(search.toLowerCase())).toList(),
      itemFromString: (String string) {
        final List<Bank> matches = banks
            .where(
              (Bank bank) => bank.name.toLowerCase().contains(string.toLowerCase()),
            )
            .toList();

        return matches.isEmpty ? null : matches.first;
      },
      onChanged: (Bank? bank) {
        if (bank != null) {
          controller.text = StringUtils.capitalizeFirst(bank.name);
          onChanged(bank);
        }
      },
    );
  }
}
