class Translates {
  static const PC = "account";

  static Map<String, String> getTranslates(String langCode) {
    if (langCode == "en") {
      return EnTranslates().getTranslate();
    }
    return RuTranslates().getTranslate();
  }

  static Map<String, String> getPushTranslates(String langCode) {
    Map<String, String> result = {};

    if (langCode == "en") {
      result.addAll(EnTranslates._getPush());
      result.addAll(EnTranslates._getAlarmExact());
    } else {
      result.addAll(RuTranslates._getPush());
      result.addAll(RuTranslates._getAlarmExact());
    }

    return result;
  }
}

class EnTranslates extends RuTranslates {
  static const PC = Translates.PC;

  @override
  Map<String, String> getTranslate() {
    final translates = super.getTranslate();
    translates.addAll(_getWidgets());
    translates.addAll(_getError());
    translates.addAll(_getLogin());
    translates.addAll(_getEditPassword());
    // @begin recovery password
    translates.addAll(_getRecoveryPassword());
    translates.addAll(_getRestorePasswordCode());
    translates.addAll(_getChangePassword());
    // @end recovery password
    translates.addAll(_getAccountList());
    translates.addAll(_getListDialog());
    translates.addAll(_getPasscode());
    translates.addAll(_getFilial());
    translates.addAll(_getSelectFilialBottomSheet());
    translates.addAll(_getLocalAuthentication());
    translates.addAll(_getBottomMenuWidget());
    translates.addAll(_getSelectAccountDialog());
    translates.addAll(_getSelectServerUrlBottomSheet());
    translates.addAll(_getUserActiveDevices());
    translates.addAll(RuTranslates._getAppMetricaReports());
    translates.addAll(_getSelectLangauge());
    translates.addAll(_getPush());
    translates.addAll(_getAlarmExact());
    return translates;
  }

  static Map<String, String> _getWidgets() {
    return {
      "back_btn": "Back",
      "search": "Search",
      "search_by_name": "Search by name",
    }.keyWithPrefix("$PC:widgets:");
  }

  static Map<String, String> _getError() {
    return {
      "error_number_invalid_format": "Invalid format: enter only numbers",
      "error_invalid_url": "Link is out of date",
      "error_tls_record_242":
          "Incorrect protocol entered. Replace https with http in the address bar and try again",
    }.keyWithPrefix("$PC:error:");
  }

  static Map<String, String> _getLogin() {
    return {
      "auth_toolbar_title": "Authorization",
      "add_account_toolbar_title": "Add profile",
      "login_form_header_title": "Account data",
      "sign_in": "Login to your account",
      "back": "Back",
      "login_and_company": "Enter your username and your company name",
      "error_title": "Error",
      "btn_sing_in": "Sign in",
      "hint_login": "Enter login@company",
      "label_login": "Login@company",
      "error_login_incorrect": "Specify the company through the @ symbol",
      "hint_password": "Enter password",
      "label_password": "Password",
      "error_password_field_empty": "Enter password",
      "hint_enter_server_url": "Enter the server address",
      "label_server_url": "Server address",
      "error_server_field_empty": "Server address is empty",
      "error_no_internet_connect": "No internet connection",
      "error_server_code_not_found": "Enter the correct server address",
      "error_login_not_found": "the login field must not be empty",
      "error_password_not_found": "the password field must not be empty",
      "login_or_password_not_found": "Wrong login or password ",
      "forgot_password": "Forgot your password?",
      "accounts": "Accounts",
    }.keyWithPrefix("$PC:login:");
  }

  static Map<String, String> _getEditPassword() {
    return {
      "toolbar_title": "Change password",
      "btn_save": "Change",
      "hint_current_password": "Current password",
      "label_current_password": "Current password",
      "hint_new_password": "New password",
      "label_new_password": "New password",
      "hint_rewritten_password": "Rewritten password",
      "label_rewritten_password": "Rewritten password",
      "error_old_password_not_found": "Current password is empty",
      "error_new_password_not_found": "New password is empty",
      "error_rewritten_password_not_found": "Password confirmation is empty",
      "error_rewritten_and_new_password_not_equals":
          "Your new password and confirmation password do not match ",
      "strength_numerals": "Password must contain at least one number ",
      "strength_length": "Password must be at least 8 characters",
      "strength_upper_case_letters": "Password must contain at least one uppercase letter",
      "strength_signs":
          "The password must contain at least one special character, for example: @, !, # и т.п.",
      "strength_personal_data":
          "The password should not contain personal information, for example: full name, login, etc.",
      "user_not_authenticated": "User not authenticated",
    }.keyWithPrefix("$PC:edit_password:");
  }

  static Map<String, String> _getRecoveryPassword() {
    return {
      "toolbar_title": "Restore password",
      "recover_password_info":
          "Enter your login. An email will be sent to your mailbox specified during registration with further steps to restore your account. ",
      "hint_login": "Enter login@company ",
      "label_login": "Login@company ",
      "hint_server_url": "Enter the server address",
      "label_server_url": "Server address",
      "next_btn": "Next",
      "error_server_empty": "Server field must not be empty",
      "error_login_empty": "Login field must not be empty",
      "error_login_incorrect": "Specify the company through the @ symbol",
    }.keyWithPrefix("$PC:recovery_password:");
  }

  static Map<String, String> _getRestorePasswordCode() {
    return {
      "toolbar_title": "Confirmation",
      "toolbar_subtitle": "Password recovery",
      "next_btn": "Next",
      "check_recover_password_code_message":
          "A confirmation email has been sent to your profile mailbox %1s. Please enter it in the field below.",
      "left_time": "Remaining: %1s",
      "re_send": "Send code again",
      "hint_code": "Confirmation code",
      "label_code": "Confirmation code",
      "quit_dialog_title": "Are you sure?",
      "quit_dialog_message":
          "The password recovery process will not complete.\nAre you sure you want to cancel the process?",
      "quit_dialog_negative_btn": "No, stay",
      "quit_dialog_positive_btn": "Yes, Cancel process",
    }.keyWithPrefix("$PC:recover_password_code:");
  }

  static Map<String, String> _getChangePassword() {
    return {
      "toolbar_title": "New password",
      "toolbar_subtitle": "Password recovery",
      "change_password_info": "Set a new password for your profile.",
      "hint_new_password": "New password",
      "label_new_password": "New password",
      "hint_rewritten_password": "Repeat password",
      "label_rewritten_password": "Repeat password",
      "btn_change": "Install",
      "error_password_not_equals": "Rewritten and new password are not equal",
      "quit_dialog_title": "Are you sure?",
      "quit_dialog_message":
          "The password recovery process will not complete.\nAre you sure you want to cancel the process?",
      "quit_dialog_negative_btn": "No, stay",
      "quit_dialog_positive_btn": "Yes, Cancel process",
    }.keyWithPrefix("$PC:change_password:");
  }

  static Map<String, String> _getLocalAuthentication() {
    return {
      "toolbar_title": "Fingerprint login",
      "touch_id_description": "Place your finger on the sensor",
      "back_bottom_button": "Back",
      "skip_bottom_button": "Skip",
      "set_enable_bottom_button": "Add",
    }.keyWithPrefix("$PC:local_authentication:");
  }

  static Map<String, String> _getFilial() {
    return {
      "toolbar_title": "Organization",
      "menu_account_hint": "Accounts",
      "list_is_empty_title": "Swipe down to update the list of organizations",
      "list_is_empty":
          "Organization list is empty,\ncontact your administrator to connect you to one of your company's organization",
    }.keyWithPrefix("$PC:filial:");
  }

  static Map<String, String> _getSelectFilialBottomSheet() {
    return {
      "title": "Organizations",
      "close": "Close",
      "choose": "Select",
      "cannot_select_filial_title": "Warning",
      "cannot_select_filial_info": "You have one organization, so you cannot select a branch",
    }.keyWithPrefix("$PC:select_filial_bottom_sheet:");
  }

  static Map<String, String> _getBottomMenuWidget() {
    return {
      "back_button": "Back",
      "search": "Search",
      "search_hint": "What are we looking for? ?",
    }.keyWithPrefix("$PC:bottom_menu_widget:");
  }

  static Map<String, String> _getListDialog() {
    return {
      "add_new_btn": "Add",
      "oauth_btn": "Sign in",
    }.keyWithPrefix("$PC:list_dialog:");
  }

  static Map<String, String> _getAccountList() {
    return {
      "list_is_empty_title": "Add a profile",
      "list_is_empty_description":
          "The application does not yet contain any user profiles. Add your profile by clicking the button below.",
      "toolbar_title": "Profiles",
      "back": "Back",
      "add_account_btn": "Add profile",
      "filial_list_is_empty": "No organizations found",
      "remove_account_title": "Delete profile?",
      "remove_account_message":
          "Profile \"%1s\" will be removed from this device, but not from the server.\nAfter deleting, you can log in to this profile again from this or another device. All information not synchronized with the server will be lost.",
      "remove_account_negative_btn": "Cancel",
      "remove_account_positive_btn": "Yes, Remove",
    }.keyWithPrefix("$PC:account_list:");
  }

  static Map<String, String> _getPasscode() {
    return {
      "touch_id_description":
          "Use Touch-ID when logging into current account\nPlace your finger on the sensor ",
      "set_new_passcode": "Add PIN",
      "enter_passcode": "Enter PIN",
      "replay_passcode": "Repeat PIN",
      "toolbar_title": "Application password",
      "back_bottom_button": "Back",
      "skip_bottom_button": "Skip",
      "sign_in": "Sign in",
      "set_passcode_bottom_button": "Add",
      "enable_touch_id": "Fingerprint login",
      "add_pin": "Add PIN",
      "repeat_pin": "Repeat PIN",
      "enter_pin": "Enter PIN",
      "remove_pin": "Remove PIN?",
      "current_pin": "Current PIN",
      "new_pin": "New PIN",
      "confirm_pin": "Repeat new PIN",
      "passcode_new": "New PIN",
      "passcode_remove": "Reset PIN",
      "passcode_update": "Change PIN",
      "accounts": "Accounts",
    }.keyWithPrefix("$PC:passcode:");
  }

  static Map<String, String> _getUserActiveDevices() {
    return {
      "toolbar_title": "Active sessions",
      "app_version_and_device_kind": "Smartup 5x %1s %2s",
      "device_name_and_version": "%1s, %2s %3s",
      "android": "Android",
      "ios": "IOS",
      "list_is_empty": "The list of active sessions is empty",
      "delete_dialog_title": "Are you sure?",
      "delete_dialog_message": "Delete this session",
      "delete_dialog_positive_btn": "Delete session",
      "delete_dialog_negative_btn": "To stay",
      "current_session": "Current session",
      "active_sessions": "Active sessions",
      "online": "Online",
      "user_not_authenticated": "User not authenticated",
    }.keyWithPrefix("$PC:user_active_sessions:");
  }

  static Map<String, String> _getSelectAccountDialog() {
    return {
      "select_account_title": "Select a profile",
      "add_account_btn": "Add profile",
      "close_dialog_btn": "Close",
      "choose": "Select",
      "add_account": "Add account",
      "cannot_select_filial_title": "Warning",
      "cannot_select_filial_info":
          "You are attached to one organization, there are restrictions on choosing an organization",
      "remove_account_title": "Delete profile?",
      "remove_account_message":
          "Profile \"%1s\" will be deleted from this device, but not from the server .\nAfter deletion, you will be able to log in to this profile again from this or another device. All information not synchronized with the server will be lost.",
      "remove_account_negative_btn": "Cancel",
      "remove_account_positive_btn": "Yes, Remove",
    }.keyWithPrefix("$PC:select_account_dialog:");
  }

  static Map<String, String> _getSelectServerUrlBottomSheet() {
    return {
      "close": "Close",
      "choose": "Select",
      "select_server_url_title": "Select server address",
    }.keyWithPrefix("$PC:select_server_url_bottom_sheet:");
  }

  static Map<String, String> _getSelectLangauge() {
    return {
      "select_language_title": "Language",
      "close": "Close",
    }.keyWithPrefix("$PC:select_language_dialog:");
  }

  static Map<String, String> _getPush() {
    return {
      "waning": "Warning",
      "primary": "Primary",
      "information": "Information",
      "success": "Success",
      "danger": "Danger",
      "timesheet_hour": "%1s h",
      "timesheet_minute": "%1s min",
      "timesheet_fact_time": "%1s h %2s min",
    }.keyWithPrefix("push:");
  }

  static Map<String, String> _getAlarmExact() {
    return {
      "exact_permission_title": "Alarm and reminders settings",
      "exact_permission_message":
          "Alarm and reminders are off. To check In and check Out in offline mode, go to settings and turn on them for Smartup X",
      "exact_permission_negative": "Not now",
      "exact_permission_positive": "Go to settings",
    }.keyWithPrefix("alarm_exact:");
  }
}

class RuTranslates {
  static const PC = Translates.PC;

  Map<String, String> getTranslate() {
    Map<String, String> result = {};
    result.addAll(_getWidgets());
    result.addAll(_getError());
    result.addAll(_getLogin());
    result.addAll(_getEditPassword());
    // @begin recovery password
    result.addAll(_getRecoveryPassword());
    result.addAll(_getRestorePasswordCode());
    result.addAll(_getChangePassword());
    // @end recovery password
    result.addAll(_getAccountList());
    result.addAll(_getListDialog());
    result.addAll(_getPasscode());
    result.addAll(_getFilial());
    result.addAll(_getSelectFilialBottomSheet());
    result.addAll(_getLocalAuthentication());
    result.addAll(_getBottomMenuWidget());
    result.addAll(_getSelectAccountDialog());
    result.addAll(_getSelectServerUrlBottomSheet());
    result.addAll(_getUserActiveDevices());
    result.addAll(_getAppMetricaReports());
    result.addAll(_getSelectLangauge());
    result.addAll(_getPush());
    result.addAll(_getAlarmExact());
    return result;
  }

  static Map<String, String> _getWidgets() {
    return {
      "back_btn": "Назад",
      "search": "Поиск",
      "search_by_name": "Поиск по названию",
    }.keyWithPrefix("$PC:widgets:");
  }

  static Map<String, String> _getError() {
    return {
      "error_number_invalid_format": "Неверный формат: введите только цифры",
      "error_invalid_url": "Ссылка не актуальна",
      "error_tls_record_242":
          "Введен некорректный протокол. Замените https на http в адресной строке и попробуйте заново",
    }.keyWithPrefix("$PC:error:");
  }

  static Map<String, String> _getLogin() {
    return {
      "auth_toolbar_title": "Авторизация",
      "add_account_toolbar_title": "Добавить профиль",
      "login_form_header_title": "Данные аккаунта",
      "sign_in": "Вход в аккаунт",
      "back": "Назад",
      "login_and_company": "Укажите имя пользователя и название своей компании",
      "error_title": "Ошибка",
      "btn_sing_in": "Войти",
      "hint_login": "Введите логин@компанию",
      "label_login": "Логин@компания",
      "error_login_incorrect": "Укажите компанию через @ символ",
      "hint_password": "Введите пароль",
      "label_password": "Пароль",
      "error_password_field_empty": "Введите пароль",
      "hint_enter_server_url": "Введите адрес сервера",
      "label_server_url": "Адрес сервера",
      "error_server_field_empty": "Адрес сервера пуст",
      "error_no_internet_connect": "Отсутствует интернет соединение",
      "error_server_code_not_found": "Введите корректный адрес сервера",
      "error_login_not_found": "поле логин не должно быть пустым",
      "error_password_not_found": "поле пароль не должно быть пустым",
      "login_or_password_not_found": "Неверный логин или пароль",
      "forgot_password": "Забыли пароль?",
      "accounts": "Аккаунты",
    }.keyWithPrefix("$PC:login:");
  }

  static Map<String, String> _getEditPassword() {
    return {
      "toolbar_title": "Изменить пароль",
      "btn_save": "Изменить",
      "hint_current_password": "Текущий пароль",
      "label_current_password": "Текущий пароль",
      "hint_new_password": "Новый пароль",
      "label_new_password": "Новый пароль",
      "hint_rewritten_password": "Повторите пароль",
      "label_rewritten_password": "Повторите пароль",
      "error_old_password_not_found": "Текущий пароль не найден",
      "error_new_password_not_found": "Новый пароль не найден",
      "error_rewritten_password_not_found": "Подтверждение пароля не найдено",
      "error_rewritten_and_new_password_not_equals":
          "Ваш новый пароль и подтверждение пароля не совпадают",
      "strength_numerals": "Пароль должен содержать минимум одну цифру",
      "strength_length": "Пароль должен содержать не менее 8 символов",
      "strength_upper_case_letters": "Пароль должен содержать минимум одну заглавную букву",
      "strength_signs": "Пароль должен содержать хотя бы один спецсимвол, например: @, !, # и т.п.",
      "strength_personal_data":
          "Пароль не должен содержать личную информацию, например: Ф.И.О, логин и т.п.",
      "user_not_authenticated": "Пользователь не аутентифицирован",
    }.keyWithPrefix("$PC:edit_password:");
  }

  static Map<String, String> _getRecoveryPassword() {
    return {
      "toolbar_title": "Восстановить пароль",
      "recover_password_info":
          "Введите ваш логин. На ваш почтовый ящик, указанный при регистрации, будет отправлено"
              " письмо с дальнейшими шагами по восстановлению учетной записи.",
      "hint_login": "Введите логин@компанию",
      "label_login": "Логин@компания",
      "hint_server_url": "Введите адрес сервера",
      "label_server_url": "Адрес сервера",
      "next_btn": "Далее",
      "error_server_empty": "Поле сервер не должно быть пустым",
      "error_login_empty": "Поле логин не должно быть пустым",
      "error_login_incorrect": "Укажите компанию через @ символ",
    }.keyWithPrefix("$PC:recovery_password:");
  }

  static Map<String, String> _getRestorePasswordCode() {
    return {
      "toolbar_title": "Подтверждение",
      "toolbar_subtitle": "Восстановление пароля",
      "next_btn": "Далее",
      "check_recover_password_code_message":
          "На %1s почтовый ящик Вашего профиля было отправлено письмо с кодом подтверждения. Пожалуйста, введите его в поле ниже.",
      "left_time": "Осталось: %1s",
      "re_send": "Отправить код еще раз",
      "hint_code": "Код подтверждения",
      "label_code": "Код подтверждения",
      "quit_dialog_title": "Вы уверены?",
      "quit_dialog_message":
          "Процесс восстановления пароля не будет завершен.\nВы действительно хотите отменить процесс?",
      "quit_dialog_negative_btn": "Нет, Остаться",
      "quit_dialog_positive_btn": "Да, Отменить процесс",
    }.keyWithPrefix("$PC:recover_password_code:");
  }

  static Map<String, String> _getChangePassword() {
    return {
      "toolbar_title": "Новый пароль",
      "toolbar_subtitle": "Восстановление пароля",
      "change_password_info": "Установите новый пароль для своего профиля.",
      "hint_new_password": "Новый пароль",
      "label_new_password": "Новый пароль",
      "hint_rewritten_password": "Повторите пароль",
      "label_rewritten_password": "Повторите пароль",
      "btn_change": "Установить",
      "error_password_not_equals": "Переписанный и новый пароль не равны",
      "quit_dialog_title": "Вы уверены?",
      "quit_dialog_message":
          "Процесс восстановления пароля не будет завершен.\nВы действительно хотите отменить процесс?",
      "quit_dialog_negative_btn": "Нет, Остаться",
      "quit_dialog_positive_btn": "Да, Отменить процесс",
    }.keyWithPrefix("$PC:change_password:");
  }

  static Map<String, String> _getLocalAuthentication() {
    return {
      "toolbar_title": "Вход по отпечатку",
      "touch_id_description": "Приложите палец к датчику",
      "back_bottom_button": "Назад",
      "skip_bottom_button": "Пропустить",
      "set_enable_bottom_button": "Добавить",
    }.keyWithPrefix("$PC:local_authentication:");
  }

  static Map<String, String> _getFilial() {
    return {
      "toolbar_title": "Организации",
      "menu_account_hint": "Аккаунты",
      "list_is_empty_title": "Свайпните вниз для обновление список организаций",
      "list_is_empty":
          "Список организация пуст,\nобратитесь к вашему администратору для подключения вас к одному из организация вашей компании",
    }.keyWithPrefix("$PC:filial:");
  }

  static Map<String, String> _getSelectFilialBottomSheet() {
    return {
      "title": "Организации",
      "close": "Закрыть",
      "choose": "Выбрать",
      "cannot_select_filial_title": "Предупреждение",
      "cannot_select_filial_info": "У вас одна организация, поэтому вы не можете выбрать филиал",
    }.keyWithPrefix("$PC:select_filial_bottom_sheet:");
  }

  static Map<String, String> _getBottomMenuWidget() {
    return {
      "back_button": "Назад",
      "search": "Поиск",
      "search_hint": "Что ищем?",
    }.keyWithPrefix("$PC:bottom_menu_widget:");
  }

  static Map<String, String> _getListDialog() {
    return {
      "add_new_btn": "Добавить",
      "oauth_btn": "Войти",
    }.keyWithPrefix("$PC:list_dialog:");
  }

  static Map<String, String> _getAccountList() {
    return {
      "list_is_empty_title": "Добавьте профиль",
      "list_is_empty_description":
          "В приложении пока не содержится ни одного профиля пользователя. Добавьте свой профиль, нажав кнопку внизу.",
      "toolbar_title": "Профили",
      "back": "Назад",
      "add_account_btn": "Добавить профиль",
      "filial_list_is_empty": "Не найдены организации",
      "remove_account_title": "Удалить профиль?",
      "remove_account_message":
          "Профиль \"%1s\" будет удалён с данного устройства, но не с сервера.\nПосле удаления Вы сможете снова авторизоваться в данном профиле с этого, либо другого устройства. Вся несинхронизированная с сервером информация будет потеряна.",
      "remove_account_negative_btn": "Отмена",
      "remove_account_positive_btn": "Да, Удалить",
    }.keyWithPrefix("$PC:account_list:");
  }

  static Map<String, String> _getPasscode() {
    return {
      "touch_id_description":
          "Используйте Touch-ID при входе в текущий аккаунт\nПриложите палец к датчику",
      "set_new_passcode": "Добавить PIN-код",
      "enter_passcode": "Введите PIN-код",
      "replay_passcode": "Повторите PIN-код",
      "toolbar_title": "Пароль приложения",
      "back_bottom_button": "Назад",
      "skip_bottom_button": "Пропустить",
      "sign_in": "Войти",
      "set_passcode_bottom_button": "Добавить",
      "enable_touch_id": "Вход по отпечатку",
      "add_pin": "Добавьте PIN-код",
      "repeat_pin": "Повторите PIN-код",
      "enter_pin": "Введите PIN-код",
      "remove_pin": "Удалить PIN-код?",
      "current_pin": "Текущий PIN-код",
      "new_pin": "Новый PIN-код",
      "confirm_pin": "Повторите новый PIN-код",
      "passcode_new": "Пожалуйста, запомните Ваш PIN-код и не сообщайте его другим людям.",
      "passcode_remove": "Сбросить PIN-код",
      "passcode_update": "Изменить PIN-код",
      "accounts": "Аккаунты",
    }.keyWithPrefix("$PC:passcode:");
  }

  static Map<String, String> _getUserActiveDevices() {
    return {
      "toolbar_title": "Активные сеансы",
      "app_version_and_device_kind": "Smartup 5x %1s %2s",
      "device_name_and_version": "%1s, %2s %3s",
      "android": "Android",
      "ios": "IOS",
      "list_is_empty": "Список активных сеансов пуст",
      "delete_dialog_title": "Вы уверены?",
      "delete_dialog_message": "Удалить этот сеанс",
      "delete_dialog_positive_btn": "Удалить сеанс",
      "delete_dialog_negative_btn": "Остаться",
      "current_session": "Текущий сеанс",
      "active_sessions": "Активные сеансы",
      "online": "Онлайн",
      "user_not_authenticated": "Пользователь не аутентифицирован",
    }.keyWithPrefix("$PC:user_active_sessions:");
  }

  static Map<String, String> _getSelectAccountDialog() {
    return {
      "select_account_title": "Выбрать профиль",
      "add_account_btn": "Добавить профиль",
      "close_dialog_btn": "Закрыть",
      "choose": "Выбрать",
      "add_account": "Добавить аккаунт",
      "cannot_select_filial_title": "Предупреждение",
      "cannot_select_filial_info":
          "Вы прикреплены к одной организации,  имеются ограничения выбора организации",
      "remove_account_title": "Удалить профиль?",
      "remove_account_message":
          "Профиль \"%1s\" будет удалён с данного устройства, но не с сервера.\nПосле удаления Вы сможете снова авторизоваться в данном профиле с этого, либо другого устройства. Вся несинхронизированная с сервером информация будет потеряна.",
      "remove_account_negative_btn": "Отмена",
      "remove_account_positive_btn": "Да, Удалить",
    }.keyWithPrefix("$PC:select_account_dialog:");
  }

  static Map<String, String> _getSelectServerUrlBottomSheet() {
    return {
      "close": "Закрыть",
      "choose": "Выбрать",
      "select_server_url_title": "Выбрать адрес сервер",
    }.keyWithPrefix("$PC:select_server_url_bottom_sheet:");
  }

  static Map<String, String> _getAppMetricaReports() {
    return {};
    // return {
    //   IntroScreen.ROUTE_NAME: "intro fragment",
    //   DeveloperScreen.ROUTE_NAME: "developer fragment ",
    //   ComponentScreen.ROUTE_NAME: "developer ui components",
    //   LoginAccountScreen.ROUTE_NAME: "log in account",
    //   PhotoViewerFragment.ROUTE_NAME: "photo viewer",
    //   PasscodeScreen.ROUTE_NAME: "passcode fragment",
    //   EditPasswordScreen.ROUTE_NAME: "edit account password",
    //   RecoveryPasswordScreen.ROUTE_NAME: "recovery password",
    //   RecoverPasswordCodeScreen.ROUTE_NAME: " check recovery account password code",
    //   ChangePasswordScreen.ROUTE_NAME: "change account password",
    //   FilialListScreen.ROUTE_NAME: "filial list",
    //   UserActiveSessionsScreen.ROUTE_NAME: "user active sessions list",
    //   PhotoViewerScreen.ROUTE_NAME: "photo view gallery",
    //   VideoViewerScreen.ROUTE_NAME: "video view gallery",
    //   VideoViewerItemScreen.ROUTE_NAME: "video player",
    // }.keyWithPrefix("report_definition:");
  }

  static Map<String, String> _getSelectLangauge() {
    return {
      "select_language_title": "Язык",
      "close": "Закрыть",
    }.keyWithPrefix("$PC:select_language_dialog:");
  }

  static Map<String, String> _getPush() {
    return {
      "waning": "Предупреждение",
      "primary": "Начальный",
      "information": "Информация",
      "success": "Успех",
      "danger": "Опасность",
      "push:timesheet_hour": "%1s ч",
      "push:timesheet_minute": "%1s мин",
      "push:timesheet_fact_time": "%1s ч %2s мин",
    }.keyWithPrefix("push:");
  }

  static Map<String, String> _getAlarmExact() {
    return {
      "exact_permission_title": "Настройки будильника и напоминания",
      "exact_permission_message":
          "Отключены настройки будильника и напоминания. Для того чтобы отмечаться в системе (приходы и уходы) в оффлайн режиме, перейдите к настройкам и включите их для приложения Smartup X.",
      "exact_permission_negative": "Не сейчас",
      "exact_permission_positive": "Перейти к настройке",
    }.keyWithPrefix("alarm_exact:");
  }
}

extension MapKeyPrefix on Map<String, String> {
  Map<String, String> keyWithPrefix(String prefix) {
    return map((key, value) => MapEntry("$prefix$key", value));
  }
}
