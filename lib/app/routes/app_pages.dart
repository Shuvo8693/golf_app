import 'package:get/get.dart';

import '../modules/add_small_outing/bindings/add_small_outing_binding.dart';
import '../modules/add_small_outing/views/add_small_outing_view.dart';
import '../modules/add_tournament/bindings/add_tournament_binding.dart';
import '../modules/add_tournament/views/add_tournament_view.dart';
import '../modules/assign_group/bindings/assign_group_binding.dart';
import '../modules/assign_group/views/assign_group_view.dart';
import '../modules/challenge_matches/bindings/challenge_matches_binding.dart';
import '../modules/challenge_matches/views/challenge_matches_view.dart';
import '../modules/completed_games/bindings/completed_games_binding.dart';
import '../modules/completed_games/views/completed_games_view.dart';
import '../modules/contact_us/bindings/contact_us_binding.dart';
import '../modules/contact_us/views/contact_us_view.dart';
import '../modules/create_challenge/bindings/create_challenge_binding.dart';
import '../modules/create_challenge/views/create_challenge_view.dart';
import '../modules/create_looking_to_play/bindings/create_looking_to_play_binding.dart';
import '../modules/create_looking_to_play/views/create_looking_to_play_view.dart';
import '../modules/create_winner_details/bindings/create_winner_details_binding.dart';
import '../modules/create_winner_details/views/create_winner_details_view.dart';
import '../modules/edit_winner_skin/bindings/edit_winner_skin_binding.dart';
import '../modules/edit_winner_skin/views/edit_winner_skin_view.dart';
import '../modules/golfers/bindings/golfers_binding.dart';
import '../modules/golfers/views/golfers_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/invitation/bindings/invitation_binding.dart';
import '../modules/invitation/views/invitation_view.dart';
import '../modules/location_selector/bindings/location_selector_binding.dart';
import '../modules/location_selector/views/location_selector_view.dart';
import '../modules/looking_to_play/bindings/looking_to_play_binding.dart';
import '../modules/looking_to_play/views/looking_to_play_view.dart';
import '../modules/message/bindings/message_binding.dart';
import '../modules/message/views/message_view.dart';
import '../modules/message_inbox/bindings/message_inbox_binding.dart';
import '../modules/message_inbox/views/message_inbox_view.dart';
import '../modules/my_profile/bindings/my_profile_binding.dart';
import '../modules/my_profile/views/my_profile_view.dart';
import '../modules/my_tournament/bindings/my_tournament_binding.dart';
import '../modules/my_tournament/views/my_tournament_view.dart';
import '../modules/notification/bindings/notification_binding.dart';
import '../modules/notification/views/notification_view.dart';
import '../modules/otp/bindings/otp_binding.dart';
import '../modules/otp/views/otp_view.dart';
import '../modules/profile_update/bindings/profile_update_binding.dart';
import '../modules/profile_update/views/profile_update_view.dart';
import '../modules/request_to_play/bindings/request_to_play_binding.dart';
import '../modules/request_to_play/views/request_to_play_view.dart';
import '../modules/reset_password/bindings/reset_password_binding.dart';
import '../modules/reset_password/views/reset_password_view.dart';
import '../modules/settings/bindings/about_us_binding.dart';
import '../modules/settings/bindings/privacy_binding.dart';
import '../modules/settings/bindings/settings_binding.dart';
import '../modules/settings/bindings/support_binding.dart';
import '../modules/settings/bindings/terms_binding.dart';
import '../modules/settings/views/about_screen.dart';
import '../modules/settings/views/privacy_police.dart';
import '../modules/settings/views/settings_view.dart';
import '../modules/settings/views/support_screen.dart';
import '../modules/settings/views/terms_screen.dart';
import '../modules/sign_in/bindings/sign_in_binding.dart';
import '../modules/sign_in/views/login_screen.dart';
import '../modules/sign_up/bindings/sign_up_binding.dart';
import '../modules/sign_up/views/sign_up_view.dart';
import '../modules/single_matches/bindings/single_matches_binding.dart';
import '../modules/single_matches/views/single_matches_view.dart';
import '../modules/splash_screen/bindings/splash_screen_binding.dart';
import '../modules/splash_screen/views/splash_screen.dart';
import '../modules/sponsor_signup/bindings/sponsor_signup_binding.dart';
import '../modules/sponsor_signup/views/sponsor_signup_view.dart';
import '../modules/sponsore_web/bindings/sponsore_web_binding.dart';
import '../modules/sponsore_web/views/sponsore_web_view.dart';
import '../modules/subscription/bindings/subscription_binding.dart';
import '../modules/subscription/views/subscription_view.dart';
import '../modules/tee_sheet/bindings/tee_sheet_binding.dart';
import '../modules/tee_sheet/views/tee_sheet_view.dart';
import '../modules/top50/bindings/top50_binding.dart';
import '../modules/top50/views/top50_view.dart';
import '../modules/tournament_detail/bindings/gaggle_detail_binding.dart';
import '../modules/tournament_detail/views/gaggle_detail_view.dart';
import '../modules/user_profile/bindings/user_profile_binding.dart';
import '../modules/user_profile/views/user_profile_view.dart';
import '../modules/verify_email/bindings/verify_email_binding.dart';
import '../modules/verify_email/views/verify_email_view.dart';
import '../modules/winners/bindings/winners_binding.dart';
import '../modules/winners/views/winners_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH_SCREEN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH_SCREEN,
      page: () => const SplashScreen(),
      binding: SplashScreenBinding(),
    ),
    GetPage(
      name: _Paths.SIGN_IN,
      page: () => const LoginScreen(),
      binding: SignInBinding(),
    ),
    GetPage(
      name: _Paths.SIGN_UP,
      page: () => SignUpView(),
      binding: SignUpBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE_UPDATE,
      page: () => ProfileUpdateView(),
      binding: ProfileUpdateBinding(),
    ),
    GetPage(
      name: _Paths.GOLFERS,
      page: () => GolfersView(),
      binding: GolfersBinding(),
    ),
    GetPage(
      name: _Paths.ENTERED,
      page: () => MyTournamentView(),
      binding: MyTournamentBinding(),
    ),
    GetPage(
      name: _Paths.MESSAGE,
      page: () => const MessageView(),
      binding: MessageBinding(),
    ),
    GetPage(
      name: _Paths.TOP50,
      page: () => Top50View(),
      binding: Top50Binding(),
    ),
    GetPage(
      name: _Paths.SPONSOR_SIGNUP,
      page: () => SponsorSignupView(),
      binding: SponsorSignupBinding(),
    ),
    GetPage(
      name: _Paths.GAGGLE_DETAIL,
      page: () => const GaggleDetailView(),
      binding: GaggleDetailBinding(),
    ),
    GetPage(
      name: _Paths.CONTACT_US,
      page: () => ContactUsView(),
      binding: ContactUsBinding(),
    ),
    GetPage(
      name: _Paths.USER_PROFILE,
      page: () => const UserProfileView(),
      binding: UserProfileBinding(),
    ),
    GetPage(
      name: _Paths.TEE_SHEET,
      page: () => const TeeSheetView(),
      binding: TeeSheetBinding(),
    ),
    GetPage(
      name: _Paths.COMPLETED_GAMES,
      page: () => CompletedGamesView(),
      binding: CompletedGamesBinding(),
    ),
    GetPage(
      name: _Paths.REQUEST_TO_PLAY,
      page: () => RequestToPlayView(),
      binding: RequestToPlayBinding(),
    ),
    GetPage(
      name: _Paths.WINNERS,
      page: () => WinnersView(),
      binding: WinnersBinding(),
    ),
    GetPage(
      name: _Paths.ADD_TOURNAMENT,
      page: () => const AddTournamentView(),
      binding: AddTournamentBinding(),
    ),
    GetPage(
      name: _Paths.ADD_SMALL_OUTING,
      page: () => const AddSmallOutingView(),
      binding: AddSmallOutingBinding(),
    ),
    GetPage(
      name: _Paths.ASSIGN_GROUP,
      page: () => AssignGroupView(),
      binding: AssignGroupBinding(),
    ),
    GetPage(
      name: _Paths.CREATE_CHALLENGE,
      page: () => const CreateChallengeView(),
      binding: CreateChallengeBinding(),
    ),
    GetPage(
      name: _Paths.CREATE_LOOKING_TO_PLAY,
      page: () => const CreateLookingToPlayView(),
      binding: CreateLookingToPlayBinding(),
    ),
    GetPage(
      name: _Paths.LOOKING_TO_PLAY,
      page: () => LookingToPlayView(),
      binding: LookingToPlayBinding(),
    ),
    GetPage(
      name: _Paths.MESSAGE_INBOX,
      page: () => const MessageInboxView(),
      binding: MessageInboxBinding(),
    ),
    GetPage(
      name: _Paths.SPONSORE_WEB,
      page: () => const SponsorWebView(),
      binding: SponsoreWebBinding(),
    ),
    GetPage(
      name: _Paths.LOCATION_SELECTOR,
      page: () => const LocationSelectorView(),
      binding: LocationSelectorBinding(),
    ),
    GetPage(
      name: _Paths.VERIFY_EMAIL,
      page: () => const VerifyEmailView(),
      binding: VerifyEmailBinding(),
    ),
    GetPage(
      name: _Paths.OTP,
      page: () => const OtpView(),
      binding: OtpBinding(),
    ),
    GetPage(
      name: _Paths.RESET_PASSWORD,
      page: () => ResetPasswordView(),
      binding: ResetPasswordBinding(),
    ),
    GetPage(
      name: _Paths.MY_PROFILE,
      page: () => MyProfileView(),
      binding: MyProfileBinding(),
    ),
    GetPage(
      name: _Paths.CREATE_WINNER_DETAILS,
      page: () => CreateWinnerDetailsView(),
      binding: CreateWinnerDetailsBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_WINNER_SKIN,
      page: () => EditWinnerSkinView(),
      binding: EditWinnerSkinBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFICATION,
      page: () => const NotificationView(),
      binding: NotificationBinding(),
    ),
    GetPage(
      name: _Paths.CHALLENGE_MATCHES,
      page: () => const ChallengeMatchesView(),
      binding: ChallengeMatchesBinding(),
    ),
    GetPage(
      name: _Paths.INVITATION,
      page: () => const InvitationView(),
      binding: InvitationBinding(),
    ),
    GetPage(
      name: _Paths.SUBSCRIPTION,
      page: () => SubscriptionView(),
      binding: SubscriptionBinding(),
    ),
    GetPage(
      name: _Paths.SETTINGS,
      page: () => const SettingsView(),
      binding: SettingsBinding(),
    ),
    GetPage(
      name: _Paths.ABOUT,
      page: () => const AboutScreen(),
      binding: AboutUsBinding(),
    ),
    GetPage(
      name: _Paths.PRIVAACY_POLICY,
      page: () => const PrivacyPoliceScreen(),
      binding: PrivacyBinding(),
    ),
    GetPage(
      name: _Paths.SUPPORT,
      page: () => const SupportScreen(),
      binding: SupportBinding(),
    ),
    GetPage(
      name: _Paths.TERMS_CONDITION,
      page: () => const TermsAndConditionsScreen(),
      binding: TermsBinding(),
    ),
    GetPage(
      name: _Paths.SINGLE_MATCHES,
      page: () => const SingleMatchesView(),
      binding: SingleMatchesBinding(),
    ),
  ];
}
