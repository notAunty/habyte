// Constants should be ALL_CAPS
// ignore_for_file: constant_identifier_names
const APP_TITLE = 'Habyte';

// Hive Box
const BOX_NAME = 'default';
const BOX_SETTINGS_THEME = 'settings-theme';
const BOX_USER = 'user';
const BOX_TASK = 'task';
const BOX_REWARD = 'reward';
const BOX_TASK_ENTRY = 'taskEntry';
const BOX_REMINDER_ENTRY = 'reminderEntry';

// Constant Value
const MODEL_ID_LENGTH = 4;
const SKIPPED_MARKS_DEDUCTED = 1;
const NULL_STRING_PLACEHOLDER = 'null';
const NULL_INT_PLACEHOLDER = -1;
const NULL_BOOL_PLACEHOLDER = false;

const REMINDER_BODY = 'Habyte task reminder';
const MEMBERSHIP_TIER = ['Novice', 'Apprentice', 'Expert', 'Master'];
const MEMBERSHIP_TIER_MIN_SCORE = {
  'Novice': 0,
  'Apprentice': 10,
  'Expert': 20,
  'Master': 30
};
// User Keys
const USER_FIRST_NAME = "firstName";
const USER_LAST_NAME = "lastName";
const USER_ABOUT = "about";
const USER_PROFILE_PIC_PATH = "profilePicPath";
const USER_POINTS = "points";
const USER_SCORES = "scores";
const USER_LAST_SCORE_DEDUCTED_DATE_TIME = "lastScoreDeductedDateTime";

// Task Keys
const TASK_ID = "id";
const TASK_NAME = "name";
const TASK_POINTS = "points";
const TASK_START_DATE = "startDate";
const TASK_END_DATE = "endDate";

// Reward Keys
const REWARD_ID = "id";
const REWARD_NAME = "name";
const REWARD_POINTS = "points";
const REWARD_AVAILABLE = "available";
const REWARD_REDEEMED = "redeemed";

// ReminderEntry Keys
const REMINDER_ENTRY_ID = "id";
const REMINDER_ENTRY_TASK_ID = "taskId";
const REMINDER_ENTRY_STATUS = "status";
const REMINDER_ENTRY_TIME = "reminderTime";

// TaskEntry Keys
const TASK_ENTRY_ID = "id";
const TASK_ENTRY_TASK_ID = "taskId";
const TASK_ENTRY_COMPLETED_DATE = "completedDate";
