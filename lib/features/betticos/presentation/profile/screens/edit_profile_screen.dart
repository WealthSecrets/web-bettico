import 'package:betticos/assets/assets.dart';
import 'package:betticos/common/common.dart';
import 'package:betticos/core/core.dart';
import 'package:flutter/material.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _ProfileImageStack(user: user),
            const SizedBox(height: 40),
            Padding(
              padding: AppPaddings.lH,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        user.firstName ?? user.lastName ?? '',
                        style: context.body1
                            .copyWith(fontWeight: FontWeight.w600, color: context.colors.black, letterSpacing: 0.1),
                      ),
                      const SizedBox(width: 3),
                      Image.asset(AppAssetIcons.tick, height: 12, width: 12),
                      const SizedBox(width: 3),
                      Text(
                        'LEVEL 1',
                        style: context.overline.copyWith(
                          fontWeight: FontWeight.w300,
                          fontSize: AppFontSizes.overline,
                          color: const Color(0xFF4A545E),
                          letterSpacing: 0.1,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    user.username != null ? '@${user.username}' : '',
                    style: context.body1
                        .copyWith(color: context.colors.darkenText, fontWeight: FontWeight.w300, letterSpacing: .1),
                  ),
                  const SizedBox(height: 24),
                  _ProfileFieldInput(
                    title: 'Name',
                    subtitle: '${user.firstName ?? ''} ${user.lastName ?? ''}',
                    onPressed: () => WidgetUtils.showFirstNameLastNameModalBottomSheet(context, user: user),
                  ),
                  const SizedBox(height: 16),
                  _ProfileFieldInput(
                    title: 'Email',
                    subtitle: user.email ?? '',
                    onPressed: () {},
                  ),
                  const SizedBox(height: 16),
                  _ProfileFieldInput(
                    title: 'Bio',
                    subtitle: user.bio ?? 'N/A',
                    trailingText: '160',
                    onPressed: () {},
                  ),
                  const SizedBox(height: 16),
                  _ProfileFieldInput(
                    title: 'Website',
                    subtitle: user.website ?? 'N/A',
                    onPressed: () {},
                  ),
                  const SizedBox(height: 16),
                  _ProfileFieldInput(
                    title: 'Date of Birth',
                    subtitle: user.dateOfBirth != null ? AppDateUtils.format(user.dateOfBirth!) : 'N/A',
                    onPressed: () {},
                  ),
                  const SizedBox(height: 56),
                  Container(
                    padding: AppPaddings.lA,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: <BoxShadow>[
                        BoxShadow(color: const Color(0xFF8A8A8A).withOpacity(0.12), blurRadius: 4)
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(AppAssetIcons.ticks, width: 53.66, height: 14.64),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            'Upgrade Verification level',
                            style: context.body2
                                .copyWith(color: context.colors.text, fontWeight: FontWeight.w400, letterSpacing: .2),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Image.asset(AppAssetIcons.arrowRightRec, height: 24, width: 24),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _ProfileFieldInput extends StatelessWidget {
  const _ProfileFieldInput({required this.title, required this.subtitle, this.trailingText, required this.onPressed});

  final String title;
  final String subtitle;
  final String? trailingText;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(color: const Color(0xFFFBFCFD), borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: AppPaddings.lA,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title.toUpperCase(),
                style: context.caption.copyWith(
                  color: context.colors.darkenText,
                  letterSpacing: 0.2,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                subtitle,
                style: context.body2.copyWith(
                  color: context.colors.textInputText,
                  letterSpacing: 0.2,
                  fontWeight: FontWeight.w400,
                ),
              ),
              if (trailingText != null) ...<Widget>[
                const SizedBox(height: 5),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    '160',
                    style: context.caption.copyWith(
                      color: context.colors.darkenText,
                      letterSpacing: 0.2,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfileImageStack extends StatelessWidget {
  const _ProfileImageStack({required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: <Widget>[
        Container(
          height: 138,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage(AssetImages.topbar), fit: BoxFit.cover),
          ),
        ),
        Positioned(
          bottom: -32.50,
          left: 16,
          child: Container(
            height: 65,
            width: 65,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(45),
              border: Border.all(color: Colors.white, width: 3),
              image: const DecorationImage(
                image: NetworkImage(
                  'https://images.pexels.com/photos/415829/pexels-photo-415829.jpeg?auto=compress&cs=tinysrgb&w=800',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
