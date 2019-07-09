abstract class LGMatchListType {
 static const int today = 1;
 static const int rolling = 2;
 static const int prepare = 3;
 static const int finished = 4;
}

abstract class LGMatchStatus {
  static const int prepare = 1;
  static const int rolling = 2;
  static const int finished = 3;
  static const int cancel = 4;
}

abstract class LGMatchOddsStatus {
  static const int normal = 1;
  static const int locked = 2;
  static const int hidden = 4;
  static const int finished = 5;
  static const int exception = 99;
}

@pragma('MatchKey')
const String kMatchKeyGameID                       = "game_id";
const String kMatchKeyStatus                       = "status";
const String kMatchKeyID                           = "id";
const String kMatchKeyEnableParlay                 = "enable_parlay";
const String kMatchKeyGameName                     = "game_name";
const String kMatchKeyMatchName                    = "match_name";
const String kMatchKeyMatchShortName               = "match_short_name";
const String kMatchKeyStartTime                    = "start_time";
const String kMatchKeyEndTime                      = "end_time";
const String kMatchKeyStartTimeStamp               = "start_time_ms";
const String kMatchKeyEndTimeStamp                 = "end_time_ms";
const String kMatchKeyRound                        = "round";
const String kMatchKeyTournamentID                 = "tournament_id";
const String kMatchKeyTournamentName               = "tournament_name";
const String kMatchKeyTournamentShortName          = "tournament_short_name";
const String kMatchKeyPlayCount                    = "play_count";
const String kMatchKeyTeamArray                    = "team";
const String kMatchKeyOddsArray                    = "odds";
const String kMatchKeyLiveUrl                      = "live_url";

@pragma('TeamKey')
const String kMatchTeamKeyTeamID                   = "team_id";
const String kMatchTeamKeyLogo                     = "team_logo";
const String kMatchTeamKeyName                     = "team_name";
const String kMatchTeamKeyShortName                = "team_short_name";
const String kMatchTeamKeyScore                    = "score";
const String kMatchTeamKeyPos                      = "pos";
const String kMatchTeamKeyID                       = "id";
const String kMatchTeamKeyMatchID                  = "match_id";

@pragma('ScoreKey')
const String kMatchScoreKeyTotal                   = "total";

@pragma('OddsKey')
const String kMatchOddsKeyEnableParlay             = "enable_parlay";
const String kMatchOddsKeyGameID                   = "game_id";
const String kMatchOddsKeyTournamentID             = "tournament_id";
const String kMatchOddsKeySortIndex                = "sort_index";
const String kMatchOddsKeyGroupID                  = "group_id";
const String kMatchOddsKeyValue                    = "value";
const String kMatchOddsKeyWin                      = "win";
const String kMatchOddsKeyStatus                   = "status";
const String kMatchOddsKeyBetLimit                 = "bet_limit";
const String kMatchOddsKeyLastUpdate               = "last_update";
const String kMatchOddsKeyMatchStage               = "match_stage";
const String kMatchOddsKeyMatchName                = "match_name";
const String kMatchOddsKeyGroupName                = "group_name";
const String kMatchOddsKeyGroupShortName           = "group_short_name";
const String kMatchOddsKeyID                       = "id";
const String kMatchOddsKeyOddsID                   = "id";
const String kMatchOddsKeyTeamID                   = "team_id";
const String kMatchOddsKeyName                     = "name";
const String kMatchOddsKeyMatchID                  = "match_id";
const String kMatchOddsKeyOddsValue                = "odds";
const String kMatchOddsKeyTag                      = "tag";
const String kMatchOddsExoticKeyIsSelected         = "isSelected";