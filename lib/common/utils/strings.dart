import 'package:get/get.dart';

class AppStrings extends Translations {
  @override
  Map<String, Map<String, String>> get keys => <String, Map<String, String>>{
        'en_US': <String, String>{
          'signin_to': 'Sign In to ',
          'email_address': 'Email/Username',
          'verify_email': 'Verify Email',
          'password': 'Password',
          'forgot_pass': 'Forgot Password?',
          'forgot_password':
              'Enter a secure password that you can easily remember',
          'sign_in': 'Sign In',
          'no_account': 'Don\'t have an account? ',
          'register_now': 'Register Now',
          'login_mobile': 'Login with mobile',
          'login_email': 'Login with email',
          'create_account': 'Create an account.',
          'address_verification': 'Address Verification',
          'signup_info':
              'Please provide your email and password and click \'Next\' to continue.',
          'confirm_pass': 'Confirm Password',
          'ref_code_opt': 'REFERRAL CODE (OPTIONAL)',
          'oddster_select': 'Sign up as Oddster',
          'next': 'Next',
          'personal_info': 'Personal Information',
          'fill_form':
              'Please fill in the form  If you are satisfied with the content, please click \'Next\'',
          'first_name': 'First Name',
          'last_name': 'Last Name',
          'username': 'Username',
          'user': 'user',
          'dob': 'Date of Birth',
          'phone_number': 'Phone number',
          'phone': 'Phone',
          'email': 'Email',
          'otp_msg_1': 'Please enter the 6-digit code sent to the',
          'otp_msg_2': 'you provided during registration',
          'resend_code': 'Resend verification code in: ',
          'skip': 'Skip',
          'upload_doc':
              'Please upload an identification document to complete your profile.',
          'identification': 'Identification',
          'iden_type': 'Identification Type',
          'iden_number': 'Identification Number',
          'exp_date': 'Expiry Date',
          'doc_image': 'Take Document Image',
          'timeline': 'Timeline',
          'updates': 'Updates',
          'promos': 'Promos',
          'profile': 'Profile',
          'odd_box': 'Odds Box',
          'odd_boxes': 'Odds Boxes',
          'members': 'Members',
          'oddsters': 'Oddsters',
          'payments': 'Payments',
          'payment_screen': 'Payment Screen',
          'bet_comp': 'Bet Competitions',
          'bet_comp_screen': 'Bet Competitions Screen',
          'refer_friend': 'Refer a Friend',
          'settings': 'Settings',
          'settings_screen': 'Settings screen',
          'set_photo': 'Set Your Profile Photo',
          'take_photo':
              'Please take a clear photo of yourself to continue. Ensure your face shows clearly and is properly lit.',
          'tap_to_take': 'Tap to take Photo',
          'become_oddster': 'Become an Oddster',
          'logout': 'Logout',
          'sure_logout': 'Are you sure you want to logout?',
          'cancel': 'Cancel',
          'nothing_to_see': 'Nothing to See Here',
          'no_records': 'No update records were found',
          'no_followers': 'No followers were found',
          'have_to_say': 'What do you have to say?',
          'no_members': 'You have no members yet',
          'sure_remove_code': 'Are you sure you want to remove this slip code?',
          'add_reply': 'Add your reply',
          'add_code': 'Add Code',
          'choose_img': 'Choose Image',
          'choose_profile_photo': 'Choose Profile photo',
          'post': 'Post',
          'posts': 'Posts',
          'my_profile': 'My Profile',
          'edit_profile': 'Edit Profile',
          'update_profile': 'Update Profile',
          'following': 'Following',
          'followers': 'Followers',
          'follow': 'Follow',
          'subscribe': 'Subscribe',
          'subscribed': 'Subscribed',
          'explore': 'Explore',
          'refer_earn': 'Refer And Earn',
          'going_further': 'Together, we are \n going further!',
          'copy': 'Copy',
          'copied': 'Copied to clipboard',
          'refer_code': 'Referral Code',
          'refer_by_email': 'Refer by Email',
          'odds': 'Odds',
          'remove': 'Remove',
          'report_issue': 'Report an issue',
          'problem': 'What is wrong with this',
          'unfollow': 'Unfollow',
          'mute': 'Mute',
          'block': 'Block',
          'report_user': 'Report User',
          'report_post': 'Report Post',
          'verification': 'Verification',
          'didnt_receive': 'Didn\'t receive verification code?',
          'send_again': 'Send code again',
          'no_oddboxes': 'No odd boxes were found.',
          'no_posts': 'No posts were found.',
          'enjoy_exclusive_1':
              'Enjoy exclusive offers on odds by signing up with Xviral.',
          'enjoy_exclusive_2':
              'Download the app here: https://play.google.com/store/apps/details?id=com.betticos.mobile',
          'slip_code': 'Slip Code',
          'remove_slip_code': 'Remove Slip Code',
          'fast_betting':
              'Fast live betting for over 2,000 live games everyday.',
          'sporting': 'Sporting',
          'sport_news':
              'Sports news, previews, reviews and betting tips and interviews with stars of horse racing, football & much more...',
          'online_odds': 'Online Odds',
          'have_lost':
              'Have you ever lost a potential big WIN just because of one match?',
          'liked_by': 'Liked by',
          'follow_oddsters': 'Follow oddsters',
          'sure_bet': 'Sure Betting',
          'exclusive_odds': 'Exclusive Odds',
          'get_slip_code': 'Get Slip Code',
          'strategized': 'Strategized',
          'success': 'Success',
          'win_bet': 'Win Bet',
          'be_happy': 'Be Happy',
          'win_again': 'Win Again',
          'enter': 'Enter',
          'remember_now': 'You remember now? ',
          'img_post_tut':
              'Make your posts more graphical by adding images here',
          'slip_code_tut': 'Add your odds slip code here',
          'send_post_tut':
              'Finally, click here to share your awesome post with the world',
          'view_posts_tut': 'View all interesting posts here',
          'create_posts_tut':
              'Create your awesome contributions and posts here',
          'update_tut': 'Check the hottest oddsters out here',
          'promo_tut': 'Check out your favorite promos and products here',
          'lang': 'language',
          'enable_tut': 'Enable tutorial mode',
          'general': 'General',
          'p2p_bet': 'P2P Betting',
          'account_type': 'Account Type',
          'personal_account': 'Personal Account',
          'oddster_account': 'Oddster Account',
          'personal_account_info':
              'These accounts are for individuals who do not want to create odds, make money from your subscribers then please register as an oddster.',
          'oddster_account_info':
              'These accounts are for oddsters to create odds, get subscribers and make money and join P2P bettings.',
        },
        'zh_CN': <String, String>{
          'signin_to': '登录到 ',
          'email_address': '电子邮件/用户名',
          'verify_email': '验证邮件',
          'password': '密码',
          'forgot_pass': '忘记密码？',
          'forgot_password': '输入您可以轻松记住的安全密码',
          'sign_in': '登入',
          'no_account': '没有帐户？',
          'register_now': '现在注册',
          'login_mobile': '用手机登录',
          'login_email': '使用电子邮件登录',
          'create_account': '创建一个帐户',
          'address_verification': '地址验证',
          'signup_info': '请提供您的电子邮件和密码，然后单击“下一步”继续。',
          'confirm_pass': '确认密码',
          'ref_code_opt': '推荐代码（可选）',
          'oddster_select': '注册为 Oddster',
          'next': '下一个',
          'personal_info': '个人信息',
          'fill_form': '请填写表格如果您对内容满意，请点击“下一步”',
          'first_name': '名',
          'last_name': '姓',
          'username': '用户名',
          'dob': '出生日期',
          'phone_number': '电话号码',
          'email': '电子邮件',
          'phone': '電話',
          'otp_msg_1': '请输入发送至邮箱的 6 位数代码',
          'otp_msg_2': '您在注册时提供',
          'resend_code': '重新发送验证码：',
          'skip': '跳过',
          'upload_doc': '请上传身份证明文件以完成您的个人资料。',
          'identification': '鉴别',
          'iden_type': '识别类型',
          'iden_number': '识别号',
          'exp_date': '到期日',
          'doc_image': '拍摄文档图像',
          'timeline': '时间线',
          'updates': '更新',
          'promos': '促销',
          'profile': '轮廓',
          'odd_box': '赔率框',
          'members': '成员',
          'oddsters': '奇怪的人',
          'payments': '付款',
          'bet_comp': '投注比赛',
          'refer_friend': '介绍个朋友',
          'settings': '设置',
          'set_photo': '设置您的个人资料照片',
          'take_photo': '请为自己拍一张清晰的照片以继续。确保您的脸部清晰可见并且光线充足',
          'become_oddster': '成为一个奇怪的人',
          'logout': '登出',
          'sure_logout': '您确定要退出吗？',
          'cancel': '取消',
          'nothing_to_see': '这没东西看',
          'no_records': '没有找到更新记录',
          'have_to_say': '你有什么要说的？',
          'sure_remove_code': '您确定要删除此单据代码吗？',
          'add_reply': '添加您的回复',
          'add_code': '添加代码',
          'choose_img': '选择图片',
          'post': '邮政',
          'posts': '帖子',
          'no_followers': '未找到关注者',
          'my_profile': '我的简历',
          'edit_profile': '编辑个人资料',
          'following': '下列的',
          'followers': '追随者',
          'follow': '跟随',
          'subscribe': '订阅',
          'subscribed': '订阅',
          'explore': '探索',
          'refer_earn': '推荐并赚取',
          'going_further': '我们在一起 \n 走得更远！',
          'copy': '复制',
          'refer_code': '推荐代码',
          'refer_by_email': '通过电子邮件推荐',
          'odds': '赔率',
          'remove': '消除',
          'report_issue': '报告问题',
          'problem': '这有什么问题',
          'unfollow': '取消关注',
          'mute': '沉默的',
          'block': '堵塞',
          'report_user': '举报用户',
          'report_post': '举报帖',
          'verification': '確認',
          'didnt_receive': '没有收到验证码？',
          'send_again': '再次发送代码',
          'tap_to_take': '点按即可拍照',
          'bet_comp_screen': '投注比赛屏幕',
          'no_members': '您还没有会员',
          'odd_boxes': '赔率盒',
          'no_oddboxes': '没有发现奇怪的盒子。',
          'payment_screen': '支付画面',
          'no_posts': '没有找到帖子',
          'choose_profile_photo': '选择个人资料照片',
          'update_profile': '更新个人信息',
          'enjoy_exclusive_1': '注册 Xviral 即可享受独家赔率优惠。',
          'enjoy_exclusive_2':
              '在此处下载应用程序：https://play.google.com/store/apps/details?id=com.betticos.mobile',
          'copied': '复制到剪贴板',
          'user': '用户',
          'settings_screen': '设定画面',
          'slip_code': '滑码',
          'remove_slip_code': '删除滑码',
          'fast_betting': '每天为超过 2,000 场现场比赛进行快速现场投注。',
          'sporting': '运动',
          'sport_news': '体育新闻、预览、评论和投注技巧以及对赛马、足球等明星的采访...',
          'online_odds': '在线赔率',
          'have_lost': '你有没有因为一场比赛而输掉一场潜在的大胜利？',
          'liked_by': '喜欢的人',
          'follow_oddsters': '跟随 oddsters',
          'sure_bet': '确定投注',
          'exclusive_odds': '独家赔率',
          'get_slip_code': '获取滑码',
          'strategized': '有策略的',
          'success': '成功',
          'win_bet': '赢得赌注',
          'be_happy': '要开心',
          'win_again': '再次获胜',
          'enter': '进入',
          'remember_now': '现在还记得吗？ ',
          'img_post_tut': '通过在此处添加图像使您的帖子更加图形化',
          'slip_code_tut': '在此处添加您的赔率单代码',
          'send_post_tut': '最后，单击此处与世界分享您的精彩帖子',
          'view_posts_tut': '在这里查看所有有趣的帖子',
          'create_posts_tut': '在此处创建您的精彩贡献和帖子',
          'update_tut': '在这里查看最热门的赔率',
          'promo_tut': '在这里查看您最喜欢的促销和产品',
          'lang': '语言',
          'enable_tut': '启用教程模式',
          'general': '一般的',
          'p2p_bet': '点对点投注',
          'account_type': '帐户类型',
          'personal_account': '个人账户',
          'oddster_account': 'Oddster 帐户',
          'personal_account_info': '这些帐户适用于不想创造赔率的个人，从您的订阅者那里赚钱然后请注册为 oddster',
          'oddster_account_info': '这些帐户用于 oddster 创造赔率、获得订阅者、赚钱并加入 P2P 投注。'
        }
      };
}