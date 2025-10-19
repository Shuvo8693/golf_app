import 'package:get/get.dart';
import 'package:golf_game_play/app/modules/create_winner_details/views/challenge_match_view.dart';
import 'package:golf_game_play/app/modules/create_winner_details/views/kps_view.dart';
import 'package:golf_game_play/app/modules/create_winner_details/views/score_view.dart';
import 'package:golf_game_play/app/modules/create_winner_details/views/skin_view.dart';

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
import '../modules/message/views/Messenger_view.dart';
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
import '../modules/requested_to_play_tournament/bindings/request_to_play_binding.dart';
import '../modules/requested_to_play_tournament/views/request_to_play_view.dart';
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
import '../modules/story_slider/bindings/story_slider_binding.dart';
import '../modules/story_slider/views/story_slider_view.dart';
import '../modules/subscription/bindings/subscription_binding.dart';
import '../modules/subscription/views/subscription_view.dart';
import '../modules/tee_sheet/bindings/tee_sheet_binding.dart';
import '../modules/tee_sheet/views/tee_sheet_view.dart';
import '../modules/top50/bindings/top50_binding.dart';
import '../modules/top50/views/top50_view.dart';
import '../modules/tournament_detail/bindings/gaggle_detail_binding.dart';
import '../modules/tournament_detail/views/tournament_detail_view.dart';
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
      transition: Transition.noTransition
    ),
    GetPage(
      name: _Paths.SPLASH_SCREEN,
      page: () => const SplashScreen(),
      binding: SplashScreenBinding(),
        transition: Transition.noTransition
    ),
    GetPage(
      name: _Paths.SIGN_IN,
      page: () => const LoginScreen(),
      binding: SignInBinding(),
        transition: Transition.noTransition
    ),
    GetPage(
      name: _Paths.SIGN_UP,
      page: () => SignUpView(),
      binding: SignUpBinding(),
        transition: Transition.noTransition
    ),
    GetPage(
      name: _Paths.PROFILE_UPDATE,
      page: () => ProfileUpdateView(),
      binding: ProfileUpdateBinding(),
        transition: Transition.noTransition
    ),
    GetPage(
      name: _Paths.GOLFERS,
      page: () => GolfersView(),
      binding: GolfersBinding(),
        transition: Transition.noTransition
    ),
    GetPage(
      name: _Paths.ENTERED,
      page: () => MyTournamentView(),
      binding: MyTournamentBinding(),
        transition: Transition.noTransition
    ),
    GetPage(
      name: _Paths.MESSAGE,
      page: () =>  MessageView(),
      binding: MessageBinding(),
        transition: Transition.noTransition
    ),
    GetPage(
      name: _Paths.TOP50,
      page: () => Top50View(),
      binding: Top50Binding(),
        transition: Transition.noTransition
    ),
    GetPage(
      name: _Paths.SPONSOR_SIGNUP,
      page: () => SponsorSignupView(),
      binding: SponsorSignupBinding(),
        transition: Transition.noTransition
    ),
    GetPage(
      name: _Paths.GAGGLE_DETAIL,
      page: () =>  TournamentDetailView(),
      binding: GaggleDetailBinding(),
        transition: Transition.noTransition
    ),
    GetPage(
      name: _Paths.CONTACT_US,
      page: () => ContactUsView(),
      binding: ContactUsBinding(),
        transition: Transition.noTransition
    ),
    GetPage(
      name: _Paths.USER_PROFILE,
      page: () => const UserProfileView(),
      binding: UserProfileBinding(),
        transition: Transition.noTransition
    ),
    GetPage(
      name: _Paths.TEE_SHEET,
      page: () =>  TeeSheetView(),
      binding: TeeSheetBinding(),
        transition: Transition.noTransition
    ),
    GetPage(
      name: _Paths.COMPLETED_GAMES,
      page: () => CompletedGamesView(),
      binding: CompletedGamesBinding(),
        transition: Transition.noTransition
    ),
    GetPage(
      name: _Paths.REQUEST_TO_PLAY,
      page: () => RequestedToPlayTournamentView(),
      binding: RequestToPlayBinding(),
        transition: Transition.noTransition
    ),
    GetPage(
      name: _Paths.WINNERS,
      page: () => WinnersView(),
      binding: WinnersBinding(),
        transition: Transition.noTransition
    ),
    GetPage(
      name: _Paths.ADD_TOURNAMENT,
      page: () => const AddTournamentView(),
      binding: AddTournamentBinding(),
        transition: Transition.noTransition
    ),
    GetPage(
      name: _Paths.ADD_SMALL_OUTING,
      page: () => const AddSmallOutingView(),
      binding: AddSmallOutingBinding(),
        transition: Transition.noTransition
    ),
    GetPage(
      name: _Paths.ASSIGN_GROUP,
      page: () => AssignGroupView(),
      binding: AssignGroupBinding(),
        transition: Transition.noTransition
    ),
    GetPage(
      name: _Paths.CREATE_CHALLENGE,
      page: () => const CreateChallengeView(),
      binding: CreateChallengeBinding(),
        transition: Transition.noTransition
    ),
    GetPage(
      name: _Paths.CREATE_LOOKING_TO_PLAY,
      page: () => const CreateLookingToPlayView(),
      binding: CreateLookingToPlayBinding(),
        transition: Transition.noTransition
    ),
    GetPage(
      name: _Paths.LOOKING_TO_PLAY,
      page: () => LookingToPlayView(),
      binding: LookingToPlayBinding(),
        transition: Transition.noTransition
    ),
    GetPage(
      name: _Paths.MESSAGE_INBOX,
      page: () => const MessageInboxView(),
      binding: MessageInboxBinding(),
        transition: Transition.noTransition
    ),
    GetPage(
      name: _Paths.SPONSORE_WEB,
      page: () => const SponsorWebView(),
      binding: SponsoreWebBinding(),
        transition: Transition.noTransition
    ),
    GetPage(
      name: _Paths.LOCATION_SELECTOR,
      page: () => const LocationSelectorView(),
      binding: LocationSelectorBinding(),
        transition: Transition.noTransition
    ),
    GetPage(
      name: _Paths.VERIFY_EMAIL,
      page: () => const VerifyEmailView(),
      binding: VerifyEmailBinding(),
        transition: Transition.noTransition
    ),
    GetPage(
      name: _Paths.OTP,
      page: () => const OtpView(),
      binding: OtpBinding(),
        transition: Transition.noTransition
    ),
    GetPage(
      name: _Paths.RESET_PASSWORD,
      page: () => ResetPasswordView(),
      binding: ResetPasswordBinding(),
        transition: Transition.noTransition
    ),
    GetPage(
      name: _Paths.MY_PROFILE,
      page: () => MyProfileView(),
      binding: MyProfileBinding(),
        transition: Transition.noTransition
    ),
    GetPage(
      name: _Paths.CREATE_WINNER_DETAILS,
      page: () => CreateWinnerDetailsView(),
      binding: CreateWinnerDetailsBinding(),
        transition: Transition.noTransition
    ),
    GetPage(
      name: _Paths.EDIT_WINNER_SKIN,
      page: () => EditWinnerSkinView(),
      binding: EditWinnerSkinBinding(),
        transition: Transition.noTransition
    ),
    GetPage(
      name: _Paths.NOTIFICATION,
      page: () => const NotificationView(),
      binding: NotificationBinding(),
        transition: Transition.noTransition
    ),
    GetPage(
      name: _Paths.CHALLENGE_MATCHES,
      page: () => const ChallengeMatchesView(),
      binding: ChallengeMatchesBinding(),
        transition: Transition.noTransition
    ),
    GetPage(
      name: _Paths.INVITATION,
      page: () =>  InvitationView(),
      binding: InvitationBinding(),
        transition: Transition.noTransition
    ),
    GetPage(
      name: _Paths.SUBSCRIPTION,
      page: () => SubscriptionView(),
      binding: SubscriptionBinding(),
        transition: Transition.noTransition
    ),
    GetPage(
      name: _Paths.SETTINGS,
      page: () => const SettingsView(),
      binding: SettingsBinding(),
        transition: Transition.noTransition
    ),
    GetPage(
      name: _Paths.ABOUT,
      page: () => const AboutScreen(),
      binding: AboutUsBinding(),
        transition: Transition.noTransition
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
        transition: Transition.noTransition
    ),
    GetPage(
      name: _Paths.TERMS_CONDITION,
      page: () => const TermsAndConditionsScreen(),
      binding: TermsBinding(),
        transition: Transition.noTransition
    ),
    GetPage(
      name: _Paths.SINGLE_MATCHES,
      page: () => const SingleMatchesView(),
      binding: SingleMatchesBinding(),
        transition: Transition.noTransition
    ),
    GetPage(
      name: _Paths.STORY_SLIDER,
      page: () => StorySliderView(),
      binding: StorySliderBinding(),
        transition: Transition.noTransition
    ),

    GetPage(
      name: _Paths.SKIN,
      page: () => SkinView(),
      binding: CreateWinnerDetailsBinding(),
        transition: Transition.noTransition
    ),
    GetPage(
      name: _Paths.KPS,
      page: () => KpsView(),
      binding: CreateWinnerDetailsBinding(),
        transition: Transition.noTransition
    ),
    GetPage(
      name: _Paths.TOP_WINNER,
      page: () => TopWinnerView(),
      binding: CreateWinnerDetailsBinding(),
        transition: Transition.noTransition
    ),
    GetPage(
      name: _Paths.SCORE,
      page: () => ScoreView(),
      binding: CreateWinnerDetailsBinding(),
        transition: Transition.noTransition
    ),
  ];
}
