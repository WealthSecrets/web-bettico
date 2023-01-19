import 'package:barcode/barcode.dart';
import 'package:betticos/core/core.dart';
import 'package:betticos/features/okx_swap/data/models/okx_address/okx_address.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ionicons/ionicons.dart';

class AddressDetails extends StatefulWidget {
  const AddressDetails({Key? key, required this.address}) : super(key: key);

  final OkxAddress address;

  @override
  State<AddressDetails> createState() => _ShareQRViewState();
}

class _ShareQRViewState extends State<AddressDetails> {
  static const double _boxHeight = 200;

  @override
  Widget build(BuildContext context) {
    const Widget loadingBox =
        SizedBox(height: _boxHeight, child: LoadingLogo(color: Colors.white));

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerRight,
            child: InkWell(
              onTap: () => Navigator.of(context).pop(),
              child: Icon(
                Ionicons.close_sharp,
                size: 24,
                color: context.colors.error,
              ),
            ),
          ),
          const SizedBox(height: 30),
          Align(
            alignment: Alignment.center,
            child: FutureBuilder<String>(
              future: generateQrCode(widget.address.address),
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                final String? data = snapshot.data;
                if (data != null) {
                  return SvgPicture.string(
                    data,
                    color: Colors.black,
                    height: _boxHeight,
                  );
                }

                return loadingBox;
              },
            ),
          ),
          const SizedBox(height: 16),
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: 290,
              child: Text(
                'Please send only ${widget.address.currency.toUpperCase()} to this deposit address. There might be loss of assets if you different token is sent.',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: context.colors.text,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const SizedBox(height: 32),
          _WalletAddressRow(address: widget.address),
          const SizedBox(height: 16),
          if (widget.address.chain != null)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  'Chain (Network)',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: context.colors.text,
                    fontSize: 14,
                  ),
                ),
                Text(
                  widget.address.chain!,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: context.colors.textDark,
                  ),
                ),
              ],
            ),
          const Spacer(),
          Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: AppButton(
                  padding: EdgeInsets.zero,
                  borderRadius: AppBorderRadius.largeAll,
                  backgroundColor: context.colors.grey,
                  onPressed: () {},
                  child: const Text(
                    'WITHDRAW',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                flex: 1,
                child: AppButton(
                  padding: EdgeInsets.zero,
                  borderRadius: AppBorderRadius.largeAll,
                  backgroundColor: context.colors.primary,
                  onPressed: () {},
                  child: const Text(
                    'DEPOSIT',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<String> generateQrCode(String data) async {
    const double size = _ShareQRViewState._boxHeight * 2;
    return Barcode.qrCode()
        .toSvg(data, width: size, height: size, color: 0x1F1056);
  }
}

class _WalletAddressRow extends StatelessWidget {
  const _WalletAddressRow({
    Key? key,
    required this.address,
  }) : super(key: key);

  final OkxAddress address;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Wallet Address',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: context.colors.text,
                  fontSize: 14,
                ),
              ),
              Text(
                address.address,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: context.colors.textDark,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 5),
        IconButton(
          onPressed: () {
            Clipboard.setData(ClipboardData(text: address.address));

            AppSnacks.show(
              context,
              message: 'Address copied to clipboard',
              backgroundColor: context.colors.success,
              leadingIcon: const Icon(
                Ionicons.checkmark_circle_sharp,
                size: 20,
                color: Colors.white,
              ),
            );
          },
          icon: Image.asset(
            AssetImages.copyFile,
            height: 24,
            width: 24,
            color: const Color(0xFF999999),
          ),
        )
      ],
    );
  }
}
