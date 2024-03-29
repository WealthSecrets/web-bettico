import 'package:betticos/common/common.dart';
import 'package:betticos/core/core.dart';
import 'package:betticos/features/auth/presentation/login/widgets/unauth_login_container.dart';
import 'package:betticos/features/okx_swap/data/models/currency/currency.dart';
import 'package:betticos/features/presentation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class WidgetUtils {
  static void onWidgetDidBuild(Function callback) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      callback();
    });
  }

  static void showDeleteConnectionDialogue(
    BuildContext context, {
    String? title,
    Icon? icon,
    required Function() onPressed,
  }) {
    showAppModal<void>(
      context: context,
      alignment: Alignment.center,
      builder: (BuildContext context) {
        final bool isSmallScreen = ResponsiveWidget.isSmallScreen(context);
        final double width = ResponsiveWidget.isSmallScreen(context) ? MediaQuery.of(context).size.width : 370;
        return Center(
          child: Container(
            width: width,
            height: isSmallScreen ? 315 : 330,
            margin: EdgeInsets.symmetric(horizontal: isSmallScreen ? 16 : 0),
            child: AppOptionDialogueModal(
              modalContext: context,
              title: 'Disconnect Wallet',
              backgroundColor: context.colors.error,
              message:
                  'This will disconnect your wallet address from Bettico. Are you sure you want to disconnect wallet?',
              affirmButtonText: 'Disconnect'.toUpperCase(),
              onPressed: onPressed,
            ),
          ),
        );
      },
    );
  }

  static void showChainModal({
    required BuildContext context,
    required List<Currency> currencies,
    required OkxController controller,
    Function(Currency currency)? onTap,
  }) async {
    await showMaterialModalBottomSheet<void>(
      bounce: true,
      animationCurve: Curves.fastLinearToSlowEaseIn,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30),
          topLeft: Radius.circular(30),
        ),
      ),
      builder: (BuildContext context) {
        return ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * ((currencies.length * .05) + .2),
            minHeight: MediaQuery.of(context).size.height * ((currencies.length * 0.05) + .15),
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(30),
              topLeft: Radius.circular(30),
            ),
            child: Column(
              children: <Widget>[
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    children: <Widget>[
                      const Text(
                        'Choose Network',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: Icon(
                          Ionicons.close_sharp,
                          size: 20,
                          color: context.colors.error,
                        ),
                      )
                    ],
                  ),
                ),
                const Notice(
                  message:
                      'Please note that only supported networks on OKX platform are shown, if you deposit via another network your assets may be lost.',
                ),
                Obx(
                  () {
                    final String selectedChain = controller.selectedChain.value;
                    return Expanded(
                      child: ListView.separated(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        controller: ModalScrollController.of(context),
                        itemCount: currencies.length,
                        separatorBuilder: (_, __) => Divider(
                          color: context.colors.lightGrey,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          final Currency item = currencies[index];
                          return ListTile(
                            selectedColor: context.colors.primary.shade100,
                            selected: item.chain == selectedChain,
                            onTap: () {
                              onTap?.call(item);
                            },
                            title: Text(
                              item.chain?.toUpperCase() ?? '',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: item.chain == selectedChain ? context.colors.primary : Colors.black,
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
      context: context,
    );
  }

  static void showUnAuthorizedLoginContainer(
    BuildContext context, {
    String? title,
    Icon? icon,
  }) {
    final bool isSmallScreen = ResponsiveWidget.isSmallScreen(context);
    showAppModal<void>(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: Container(
            width: isSmallScreen ? double.infinity : 600,
            height: isSmallScreen ? 450 : 500,
            margin: AppPaddings.lH,
            child: ClipRRect(
              borderRadius: AppBorderRadius.largeAll,
              child: UnAuthLoginController(),
            ),
          ),
        );
      },
    );
  }

  static void showWithdrawSharesModal(
    BuildContext context, {
    required String saleId,
    required int shares,
    required double sharePrice,
    required double sharePriceUSD,
  }) {
    showMaterialModalBottomSheet<void>(
      shape: RoundedRectangleBorder(borderRadius: AppBorderRadius.card),
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 300,
          child:
              WithdrawSharesModal(saleId: saleId, shares: shares, sharePrice: sharePrice, sharePriceUSD: sharePriceUSD),
        );
      },
    );
  }

  static void showWithdrawBalanceModal(BuildContext context) {
    showMaterialModalBottomSheet<void>(
      shape: RoundedRectangleBorder(borderRadius: AppBorderRadius.card),
      context: context,
      builder: (BuildContext context) {
        return const SizedBox(height: 300, child: WithdrawBalanceModal());
      },
    );
  }
}
