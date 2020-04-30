import 'package:bujuan/entity/song_bean_entity.dart';

class Constants {
  static bool dark = false;

  static String playSongHistory = "PLAY_SONG_HISTORY";
  static String playSongListHistory = "PLAY_SONG_LIST_HISTORY";

  static String BLUR = 'BLUR';
  static String COOKIE = 'COOKIE';

  static String HIGH = 'HIGH';

  static String MINI_PLAY = 'MINNI_PLAY';

  static String USER_ID = 'USER_ID';

  static String USER_BACKGROUND = 'USER_BACKGROUND';

  static String MINI_NAV = 'MINI_NAV';

  static String BOTTOM_NAV = 'BOTTOM_NAV';

  static String PLAY_MODE = 'PLAY_MODE';

  static String LIKE_SONGS = 'LIKE_SONGS';

  static String ISFM = 'ISFM';

  static String LOCAL_SHEET = 'LOCAL_SHEET';

  static String bs_top = 'http://p1.music.126.net/DrRIg6CrgDfVLEph9SNh7w==/18696095720518497.jpg?param=300y200';

  static String new_top = 'http://p1.music.126.net/N2HO5xfYEqyQ8q6oxCw8IQ==/18713687906568048.jpg?param=300y200';

  static String yc_top = 'http://p1.music.126.net/sBzD11nforcuh1jdLSgX7g==/18740076185638788.jpg?param=300y200';

  static String hot_top = 'http://p2.music.126.net/GhhuF6Ep5Tq9IEvLsyCN7w==/18708190348409091.jpg?param=300y200';

  static String dy_top = 'http://p1.music.126.net/5tgOCD4jiPKBGt7znJl-2g==/18822539557941307.jpg?param=200y200';

  static String uk_top = 'http://p2.music.126.net/VQOMRRix9_omZbg4t-pVpw==/18930291695438269.jpg?param=200y200';

  static String billl_top = 'http://p1.music.126.net/EBRqPmY8k8qyVHyF8AyjdQ==/18641120139148117.jpg?param=200y200';

  static String krv_top = 'http://p1.music.126.net/H4Y7jxd_zwygcAmPMfwJnQ==/19174383276805159.jpg?param=200y200';

  static String rb_top = 'http://p2.music.126.net/Rgqbqsf4b3gNOzZKxOMxuw==/19029247741938160.jpg?param=200y200';

  static String itunes_top = 'http://p2.music.126.net/WTpbsVfxeB6qDs_3_rnQtg==/109951163601178881.jpg?param=200y200';
}

enum TopType { BS, NEW, YC, HOT }
enum PlayModeType { REPEAT, REPEAT_ONE, SHUFFLE }
enum OpenType { SETTING, DONATION, ABOUT }
enum MenuType { TODAY, SHEET, SINGER, RADIO, FM }
