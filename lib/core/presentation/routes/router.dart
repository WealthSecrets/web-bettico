import 'package:betticos/features/presentation.dart';
import 'package:flutter/material.dart';
import '/core/presentation/widgets/success_screen.dart';
import 'app_routes.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.onboard:
      return _getPageRoute(const OnboardingScreen(), settings);
    case AppRoutes.profile:
      final ProfileScreenArgument argument = settings.arguments! as ProfileScreenArgument;
      return _getPageRoute(ProfileScreen(user: argument.user, showBackButton: argument.showBackButton), settings);
    case AppRoutes.members:
      return _getPageRoute(const MembersScreen(), settings);
    case AppRoutes.oddsters:
      return _getPageRoute(const OddstersScreen(), settings);
    case AppRoutes.oddboxes:
      return _getPageRoute(const OddsboxScreen(), settings);
    case AppRoutes.settings:
      return _getPageRoute(const SettingsScreen(), settings);
    case AppRoutes.livescore:
      return _getPageRoute(const NewLiveScore(), settings);
    case AppRoutes.timeline:
      return _getPageRoute(const TimelineScreen(), settings);
    case AppRoutes.referral:
      return _getPageRoute(const ReferralScreen(), settings);
    case AppRoutes.convertCrypto:
      return _getPageRoute(const ConvertCryptoScreen(), settings);
    case AppRoutes.okxOptions:
      return _getPageRoute(const CryptoFrontScreen(), settings);
    case AppRoutes.buySellCrypto:
      return _getPageRoute(const BuySellCryptoScreen(), settings);
    case AppRoutes.walletAddresses:
      return _getPageRoute(const AddressesScreen(), settings);
    case AppRoutes.currencies:
      return _getPageRoute(const AssetCurrenciesScreen(), settings);
    case AppRoutes.addressDetails:
      return _getPageRoute(const AddressDetailsScreen(), settings);
    case AppRoutes.depositHistory:
      return _getPageRoute(const DepositHistoryScreen(), settings);
    case AppRoutes.conversionSuccess:
      return _getPageRoute(ConversionSuccessScreen(), settings);
    case AppRoutes.conversionHistory:
      return _getPageRoute(const CovnersionHistoryScreen(), settings);
    case AppRoutes.moreScreen:
      return _getPageRoute(const MoreScreen(), settings);
    case AppRoutes.privateSales:
      return _getPageRoute(const PrivateSale(), settings);
    case AppRoutes.saleSuccess:
      return _getPageRoute(PrivateSaleCongratulationScreen(), settings);
    case AppRoutes.transactions:
      return _getPageRoute(const TransactionHistoryScreen(), settings);
    case AppRoutes.withdrawal:
      return _getPageRoute(const WithdrawalScreen(), settings);
    case AppRoutes.withdrawalHistory:
      return _getPageRoute(const WithdrawalHistoryScreen(), settings);
    case AppRoutes.withdrawalSuccess:
      return _getPageRoute(WithdrawalCongratulationsScreen(), settings);
    case AppRoutes.transferFunds:
      return _getPageRoute(const TransferFundsScreen(), settings);
    case AppRoutes.success:
      return _getPageRoute(const SucessScreen(), settings);
    case AppRoutes.transferHistory:
      return _getPageRoute(const TransferHistoryScreen(), settings);
    case AppRoutes.send:
      return _getPageRoute(const SendScreen(), settings);
    case AppRoutes.appwebview:
    // return _getPageRoute(const AppWebView(), settings);
    case AppRoutes.explore:
      return _getPageRoute(ExploreContainer(), settings);
    case AppRoutes.search:
      return _getPageRoute(SearchContainer(), settings);
    case AppRoutes.buyUsdt:
      return _getPageRoute(BuyUsdtScreen(), settings);
    case AppRoutes.adsProces:
      return _getPageRoute(const AdProcessScreen(), settings);
    case AppRoutes.professionalCategory:
      return _getPageRoute(const ProfessionalAccountCategoryScreen(), settings);
    case AppRoutes.businessType:
      return _getPageRoute(const BusinessTypeScreen(), settings);
    case AppRoutes.reviewAccount:
      return _getPageRoute(const ReviewAccountScreen(), settings);
    case AppRoutes.adAnalytics:
      final AdAnalyticsScreenRouteArgument argument = settings.arguments! as AdAnalyticsScreenRouteArgument;
      return _getPageRoute(AdAnalyticsScreen(post: argument.post), settings);
    case AppRoutes.professionalDashboard:
      return _getPageRoute(const ProfessionalDashboard(), settings);
    case AppRoutes.accountInsights:
      return _getPageRoute(const AccountInsightsScreen(), settings);
    case AppRoutes.accountReached:
      return _getPageRoute(const AccountReachedScreen(), settings);
    case AppRoutes.avatrade:
      return _getPageRoute(const Avatrade(), settings);
    case AppRoutes.creator:
      return _getPageRoute(const CreatorScreen(), settings);
    case AppRoutes.notifications:
      final NotificationsScreenRouteArgument argument = settings.arguments! as NotificationsScreenRouteArgument;
      return _getPageRoute(NotificationsScreen(contributions: argument.contributions), settings);
    case AppRoutes.createShares:
      return _getPageRoute(const CreateShareScreen(), settings);
    case AppRoutes.salesScreen:
      return _getPageRoute(const SalesScreen(), settings);
    case AppRoutes.saleDetails:
      final SaleDetailsScreenRouteArgument argument = settings.arguments! as SaleDetailsScreenRouteArgument;
      return _getPageRoute(SaleDetailsScreen(value: argument.value), settings);
    case AppRoutes.contribute:
      final ContributeScreenRouteArgument argument = settings.arguments! as ContributeScreenRouteArgument;
      return _getPageRoute(ContributeScreen(sale: argument.sale), settings);
    default:
      return _getPageRoute(const NotFoundScreen(), settings);
  }
}

PageRoute<Widget> _getPageRoute(Widget child, RouteSettings settings) {
  return _FadeRoute(child: child, settings: settings);
}

class _FadeRoute extends PageRouteBuilder<Widget> {
  _FadeRoute({required this.child, required this.settings})
      : super(
          settings: settings,
          pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) =>
              child,
          transitionsBuilder:
              (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) =>
                  FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
  final Widget child;
  @override
  final RouteSettings settings;
}
