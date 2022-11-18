import 'package:betticos/core/core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'widgets/crypto_converter_input.dart';

class ConvertCryptoScreen extends StatefulWidget {
  const ConvertCryptoScreen({Key? key}) : super(key: key);

  @override
  State<ConvertCryptoScreen> createState() => _ConvertCryptoScreenState();
}

class _ConvertCryptoScreenState extends State<ConvertCryptoScreen> {
  late final TextEditingController fromController;
  late final TextEditingController toController;


  @override
  void initState() {
    fromController = TextEditingController();
    toController = TextEditingController(text: '0.00000000');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30).add(const EdgeInsets.only(top: 40)),
      child: Column(
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: Text(
              'Swap Crypto Currencies',
              style: TextStyle(
                color: context.colors.textDark,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          const SizedBox(height: 30),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'You Swap',
              style: TextStyle(
                color: context.colors.textDark,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
          const AppSpacing(v: 5),
          CryptoConverterInput(
            controller: fromController,
            selectedCurrency: 'BNB',
            onAmountChanged: (double amount) {},
            onCurrencyChanged: (String currency) {
            },
          ),
          _PreviewContentSection(),
          const AppSpacing(v: 8),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'You Get',
              style: TextStyle(
                color: context.colors.textDark,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
          const AppSpacing(v: 5),
          CryptoConverterInput(
            disableAmountInput: true,
            controller: toController,
            selectedCurrency: 'USDT',
            onAmountChanged: (double amount) {},
            onCurrencyChanged: (String currency){},
          ),

          const AppSpacing(v: 50),
          AppButton(
            onPressed: () {
            },
            child: const Text(
              'Swap',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontSize:14),
            ),
          ),
          const AppSpacing(v: 20),
        ],
      ),
    );
  }
}

class _PreviewContentSection extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return ClipRRect(
      borderRadius: AppBorderRadius.mediumAll,
      child: AppLoadingBox(
        loaderSize: 20,
        backgroundColor: Colors.black.withOpacity(.2),
        loaderColor: Colors.white,
        loading: false,
        child: AnimatedSize(
          duration: const Duration(milliseconds: 400),
          curve: Curves.ease,
          child: Builder(
            builder: (BuildContext context) {

                return _BuildConvertedPreviewWidget();

            },
          ),
        ),
      ),
    );
  }
}

class _BuildConvertedPreviewWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPaddings.homeH,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
           _GeneratedDottedLine(5),
          _InfoTile(
            description: "Amount we'll convert",
            icon: Icons.add,
            title: '18.56BNB',
          ),
           _GeneratedDottedLine(5),
           _InfoTile(
            description: 'Crypto rate (24 Hrs)',
            icon: CupertinoIcons.divide,
            title: '0.00009483',
          ),
           _GeneratedDottedLine(3),
        ],
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  const _InfoTile({
    required this.title,
    required this.icon,
    required this.description,
  });

  final String title;
  final IconData icon;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 18,
          padding: const EdgeInsets.all(3),
          decoration: const BoxDecoration(
            color: Color(0xFF879DAD),
            shape: BoxShape.circle,
          ),
          child: FittedBox(
            child: Icon(
              icon,
              color: Colors.white,
            ),
          ),
        ),
        const AppSpacing(h: 10),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color:  Color(0xFF879DAD),
              fontSize: 12,
            ),
          ),
        ),
        const AppSpacing(h: 10),
        Expanded(
          child: Text(
            description,
            style: TextStyle(
              color: context.colors.textDark,
              fontSize: 10,
            ),
          ),
        ),
      ],
    );
  }
}

class _GeneratedDottedLine extends StatelessWidget {
  const _GeneratedDottedLine(this.numberOfDots);

  final int numberOfDots;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List<Widget>.generate(
        3,
            (_) => Padding(
          padding: const EdgeInsets.only(left: 7),
          child: Container(
            width: 3,
            height: 3,
            margin: const EdgeInsets.symmetric(vertical: 1.5),
            decoration: const BoxDecoration(
              color: Color(0xFF879DAD),
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    );
  }
}
