-- "addons\\darkrpmodification\\lua\\darkrp_language\\english.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
--[[-----------------------------------------------------------------------
English (example) language file
---------------------------------------------------------------------------

This is the english language file. The things on the left side of the equals sign are the things you should leave alone
The parts between the quotes are the parts you should translate. You can also copy this file and create a new language.

= Warning =
Sometimes when DarkRP is updated, new phrases are added.
If you don't translate these phrases to your language, it will use the English sentence.
To fix this, join your server, open your console and enter darkp_getphrases yourlanguage
For English the command would be:
    darkrp_getphrases "en"
because "en" is the language code for English.

You can copy the missing phrases to this file and translate them.

= Note =
Make sure the language code is right at the bottom of this file

= Using a language =
Make sure the convar gmod_language is set to your language code. You can do that in a server CFG file.
---------------------------------------------------------------------------]]

local my_language = {
	-- Действия администратора
	need_admin = "Вам требуются права администратора, чтобы иметь возможность %s",
	need_sadmin = "Вам требуются права супер администратора, чтобы иметь возможность %s",
	no_privilege = "У вас нет прав для совершения данного действия",
	no_jail_pos = "Отсутствуют позиции тюрьмы",
	invalid_x = "Некорректный %s! %s",

	-- меню F1
	f1ChatCommandTitle = "Команды чата",
	f1Search = "Поиск...",

	-- Денежные операции:
	price = "Цена: %s%d",
	priceTag = "Цена: %s",
	reset_money = "%s сбросит деньги всех игроков!",
	has_given = "%s дал Вам %s",
	you_gave = "Вы дали %s %s",
	npc_killpay = "%s за убийство NPC!",
	profit = "доход",
	loss = "убыток",
    Donate = "Донат",
    you_donated = "Вы задонатили %s на %s!",
    has_donated = "%s задонатил %s!",

	-- backwards compatibility
	deducted_x = "Вычтено %s%d",
	need_x = "Требуется %s%d",

	deducted_money = "Вычтено %s",
	need_money = "Требуется %s",

	payday_message = "День выплаты зарплаты! Вы получили %s!",
	payday_unemployed = "Вы не получили зарплату, потому что вы безработный!",
	payday_missed = "День выплаты зарплаты пропущен! (Вы арестованы)",

	property_tax = "Налог на имущество! %s",
	property_tax_cant_afford = "Вы не смогли заплатить налоги! Ваше имущество было изъято у Вас!",
	taxday = "День оплаты налогов! %s%% из Вашего дохода было изъято!",

	found_cheque = "Вы нашли %s%s в чеке, выписанный на вас от %s.",
	cheque_details = "Это чек, выписанный на %s.",
	cheque_torn = "Вы разорвали чек",
	cheque_pay = "Выплачено: %s",
	signed = "Подписаный: %s",

	found_cash = "Вы нашли %s%d!", -- backwards compatibility
	found_money = "Вы нашли %s!",

	owner_poor = "%s владелец слишком беден, чтобы субсидировать продажу!",

    -- Police
    Wanted_text = "Разыскивается!",
	wanted = "Разыскивается альянсом!\nПричина: %s",
	youre_arrested = "Вы арестованы на %d секунд!",
	youre_arrested_by = "Вы были арестованы %s.",
	youre_unarrested_by = "Вы были освобождены %s.",
	hes_arrested = "%s был арестован на %d секунд!",
	hes_unarrested = "%s был освобожден из тюрьмы!",
	warrant_ordered = "%s выдал ордер на обыск %s. Причина: %s",
	warrant_request = "%s требует ордер на обыск %s\nПричина: %s",
	warrant_request2 = "Запрос ордера на обыск был отправлен мэру %s!",
	warrant_approved = "Ордер на обыск был одобрен для %s!\nПричина: %s\nЗапросил: %s",
	warrant_approved2 = "Теперь Вы можете произвести обыск его дома.",
	warrant_denied = "Мэр %s отклонил Ваш запрос ордера на обыск.",
	warrant_expired = "Ордер на обыск для %s истек!",
	warrant_required = "Вам требуется ордер на обыск, чтобы открыть эту дверь.",
	warrant_required_unfreeze = "Вам нужен ордер на разморозку пропа.",
	warrant_required_unweld = "Вам нужен ордер на снятие сварных швов этого пропа.",
	wanted_by_police = "%s разыскивается альянсом!\nПричина: %s\nЗапросил: %s",
	wanted_by_police_print = "%s сделал %s разыскиваемым, причина: %s",
	wanted_expired = "%s больше не разыскивается альянсом.",
	wanted_revoked = "%s больше не разыскивается альянсом.\nОтменил: %s",
	cant_arrest_other_cp = "Вы не можете арестовать других комбайнов!",
	must_be_wanted_for_arrest = "Игрок должен быть разыскиваемым, чтобы иметь возможность арестовать его.",
	cant_arrest_fadmin_jailed = "Вы не можете арестовать игрока, который был заключен в тюрьму админом.",
	cant_arrest_no_jail_pos = "Вы не можете арестовать людей, так как нет установленных позиций тюрьмы!",
	cant_arrest_spawning_players = "Вы не можете арестовать игроков, которые спавнятся.",

    suspect_doesnt_exist = "Не существует.",
    actor_doesnt_exist = "Не существует.",
    get_a_warrant = "получить ордер",
    remove_a_warrant = "удалить ордер",
    make_someone_wanted = "подать в розыск",
    remove_wanted_status = "убрать из розыска",
    already_a_warrant = "Уже есть ордер на обыск подозреваемого.",
    not_warranted = "Нет ордера на обыск подозреваемого.",
	already_wanted = "Подозреваемый уже разыскивается.",
	not_wanted = "Подозреваемый не разысиквается.",
	need_to_be_cp = "Вы должны быть комбайном.",
	suspect_must_be_alive_to_do_x = "Подозреваемый должен быть живым, чтобы %s.",
	suspect_already_arrested = "Подозреваемый сейчас в тюрьме.",

    -- Players
    health = "Health: %s",
    job = "Job: %s",
    salary = "Salary: %s%s",
    wallet = "Wallet: %s%s",
    weapon = "Weapon: %s",
    kills = "Kills: %s",
    deaths = "Deaths: %s",
    rpname_changed = "%s changed their RPName to: %s",
    disconnected_player = "Disconnected player",

    -- Teams
    need_to_be_before = "You need to be %s first in order to be able to become %s",
    need_to_make_vote = "You need to make a vote to become a %s!",
    team_limit_reached = "Вы не можете стать [ %s ], так как достигнут лимит по данной профессии!",
    wants_to_be = "%s\nwants to be\n%s",
    has_not_been_made_team = "%s has not been made %s!",
    job_has_become = "%s сменил специальность...",

    -- Disasters
    meteor_approaching = "WARNING: Meteor storm approaching!",
    meteor_passing = "Meteor storm passing.",
    meteor_enabled = "Meteor Storms are now enabled.",
    meteor_disabled = "Meteor Storms are now disabled.",
    earthquake_report = "Earthquake reported of magnitude %sMw",
    earthtremor_report = "Earth tremor reported of magnitude %sMw",

    -- Keys, vehicles and doors
    keys_allowed_to_coown = "Доступно к покупке\n",
    keys_other_allowed = "Совладельцы:",
    keys_allow_ownership = "",
    keys_disallow_ownership = "",
    keys_owned_by = "Владелец:",
    keys_unowned = "",
    keys_everyone = "",
    door_unown_arrested = "Вы не можете это сделать пока находитесь под арестом!",
    door_unownable = "Эта дверь не может быть куплена!",
    door_sold = "Продано за %s",
    door_already_owned = "Эта дверь уже кем-то куплена!",
    door_cannot_afford = "Вы не можете этого себе позволить!",
    door_hobo_unable = "Вы не можете покупать двери пока вы изгой!",
    vehicle_cannot_afford = "Вы не можете себе это позволить!",
    door_bought = "Куплено за %s%s",
    vehicle_bought = "Куплено за %s%s",
    door_need_to_own = "Нужно быть владельцем этой двери %s",
    door_rem_owners_unownable = "Вы не можете удалять владельцев, если вы не владелец!",
    door_add_owners_unownable = "Вы не можете добавлять владельцев, если вы не владелец!",
    rp_addowner_already_owns_door = "%s уже имеет доступ к двери!",
    add_owner = "Добавить владельца",
    remove_owner = "Удалить владельца",
    coown_x = "Совладельцы %s",
    allow_ownership = "Разрешить покупку",
    disallow_ownership = "Запретить покупку",
    edit_door_group = "Настроить для групп",
    door_groups = "Группы",
    door_group_doesnt_exist = "Группа не существует!",
    door_group_set = "Группа установлена.",
    sold_x_doors_for_y = "Вы продали %d двери за %s%d!", -- backwards compatibility
    sold_x_doors = "Вы продали %d двери за %s!",

    -- Entities
    drugs = "drugs",
    Drugs = "Drugs",
    drug_lab = "Drug Lab",
    gun_lab = "Gun Lab",
    any_lab = "any lab",
    gun = "gun",
    microwave = "Microwave",
    food = "food",
    Food = "Food",
    money_printer = "Money Printer",
    tip_jar = "Tip Jar",

    sign_this_letter = "Sign this letter",
    signed_yours = "Yours,",

    money_printer_exploded = "Your money printer has exploded!",
    money_printer_overheating = "Your money printer is overheating!",

    contents = "Contents: ",
    amount = "Amount: ",

    picking_lock = "Взлом",

    cannot_pocket_x = "You cannot put this in your pocket!",
    object_too_heavy = "This object is too heavy.",
    pocket_full = "Your pocket is full!",
    pocket_no_items = "Your pocket contains no items.",
    drop_item = "Drop item",

    bonus_destroying_entity = "destroying this illegal entity.",

    switched_burst = "Switched to burst-fire mode.",
    switched_fully_auto = "Switched to fully automatic fire mode.",
    switched_semi_auto = "Switched to semi-automatic fire mode.",

    keypad_checker_shoot_keypad = "Shoot a keypad to see what it controls.",
    keypad_checker_shoot_entity = "Shoot an entity to see which keypads are connected to it",
    keypad_checker_click_to_clear = "Right click to clear.",
    keypad_checker_entering_right_pass = "Entering the right password",
    keypad_checker_entering_wrong_pass = "Entering the wrong password",
    keypad_checker_after_right_pass = "after having entered the right password",
    keypad_checker_after_wrong_pass = "after having entered the wrong password",
    keypad_checker_right_pass_entered = "Right password entered",
    keypad_checker_wrong_pass_entered = "Wrong password entered",
    keypad_checker_controls_x_entities = "This keypad controls %d entities",
    keypad_checker_controlled_by_x_keypads = "This entity is controlled by %d keypads",
    keypad_on = "ON",
    keypad_off = "OFF",
    seconds = "seconds",

    persons_weapons = "%s's illegal weapons:",
    returned_persons_weapons = "Returned %s's confiscated weapons.",
    no_weapons_confiscated = "%s had no weapons confiscated!",
    no_illegal_weapons = "%s had no illegal weapons.",
    confiscated_these_weapons = "Confiscated these weapons:",
    checking_weapons = "Confiscating weapons",

    shipment_antispam_wait = "Please wait before spawning another shipment.",
    createshipment = "Create a shipment",
    splitshipment = "Split this shipment",
    shipment_cannot_split = "Cannot split this shipment.",

    -- Talking
    hear_noone = "No-one can hear you %s!",
    hear_everyone = "Everyone can hear you!",
    hear_certain_persons = "Players who can hear you %s: ",

    whisper = "whisper",
    yell = "yell",
    broadcast = "[Broadcast!]",
    radio = "radio",
    request = "(REQUEST!)",
    group = "(group)",
    demote = "(DEMOTE)",
    ooc = "OOC",
    radio_x = "Radio %d",

    talk = "talk",
    speak = "speak",

    speak_in_ooc = "speak in OOC",
    perform_your_action = "perform your action",
    talk_to_your_group = "talk to your group",

    channel_set_to_x = "Channel set to %s!",

    -- Notifies
    disabled = "%s has been disabled! %s",
    gm_spawnvehicle = "The spawning of vehicles",
    gm_spawnsent = "The spawning of scripted entities (SENTs)",
    gm_spawnnpc = "The spawning of Non-Player Characters (NPCs)",
    see_settings = "Please see the DarkRP settings.",
    limit = "You have reached the %s limit!",
    have_to_wait = "You need to wait another %d seconds before using %s!",
    must_be_looking_at = "Вам необходимо смотреть на %s!",
    incorrect_job = "You do not have the right job to %s",
    unavailable = "This %s is unavailable",
    unable = "You are unable to %s. %s",
    cant_afford = "You cannot afford this %s",
    created_x = "%s created a %s",
    cleaned_up = "Your %s were cleaned up.",
    you_bought_x = "Вы купили %s за %s%d.", -- backwards compatibility
    you_bought = "Вы купили %s за %s.",
    you_got_yourself = "You got yourself a %s.",
    you_received_x = "You have received %s for %s.",

    created_first_jailpos = "You have created the first jail position!",
    added_jailpos = "You have added one extra jail position!",
    reset_add_jailpos = "You have removed all jail positions and you have added a new one here.",
    created_spawnpos = "You have added a spawn position for %s.",
    updated_spawnpos = "You have removed all spawn positions for %s and added a new one here.",
    remove_spawnpos = "You have removed all spawn positions for %s.",
    do_not_own_ent = "Вы не владелец данного предмета!",
    cannot_drop_weapon = "Невозможно выбросить данное оружие!",
    job_switch = "Jobs switched successfully!",
    job_switch_question = "Switch jobs with %s?",
    job_switch_requested = "Job switch requested.",

    cooks_only = "Cooks only.",

    -- Misc
    unknown = "Unknown",
    arguments = "arguments",
    no_one = "no one",
    door = "door",
    vehicle = "vehicle",
    door_or_vehicle = "door/vehicle",
    driver = "",
    name = "Name: %s",
    locked = "Locked.",
    unlocked = "Unlocked.",
    player_doesnt_exist = "Player does not exist.",
    job_doesnt_exist = "Job does not exist!",
    must_be_alive_to_do_x = "You must be alive in order to %s.",
    banned_or_demoted = "Banned/demoted",
    wait_with_that = "Wait with that.",
    could_not_find = "Could not find %s",
    f3tovote = "Hit F3 to vote",
    listen_up = "Listen up:", -- In rp_tell or rp_tellall
    nlr = "New Life Rule: Do Not Revenge Arrest/Kill.",
    reset_settings = "You have reset all settings!",
    must_be_x = "You must be a %s in order to be able to %s.",
    agenda_updated = "The agenda has been updated",
    job_set = "%s has set his/her job to '%s'",
    demoted = "%s has been demoted",
    demoted_not = "%s has not been demoted",
    demote_vote_started = "%s has started a vote for the demotion of %s",
    demote_vote_text = "Demotion nominee:\n%s", -- '%s' is the reason here
    cant_demote_self = "You cannot demote yourself.",
    i_want_to_demote_you = "I want to demote you. Reason: %s",
    tried_to_avoid_demotion = "You tried to escape demotion. You failed and have been demoted.", -- naughty boy!
    lockdown_started = "Комендантский час. Оставайтесь в своих квартирах.",
    lockdown_ended = "Комендантский час закончился",
    gunlicense_requested = "%s has requested %s a gun license",
    gunlicense_granted = "%s has granted %s a gun license",
    gunlicense_denied = "%s has denied %s a gun license",
    gunlicense_question_text = "Grant %s a gun license?",
    gunlicense_remove_vote_text = "%s has started a vote for the gun license removal of %s",
    gunlicense_remove_vote_text2 = "Revoke gunlicense:\n%s", -- Where %s is the reason
    gunlicense_removed = "%s's license has been removed!",
    gunlicense_not_removed = "%s's license has not been removed!",
    vote_specify_reason = "You need to specify a reason!",
    vote_started = "The vote is created",
    vote_alone = "You have won the vote since you are alone in the server.",
    you_cannot_vote = "You cannot vote!",
    x_cancelled_vote = "%s cancelled the last vote.",
    cant_cancel_vote = "Could not cancel the last vote as there was no last vote to cancel!",
    jail_punishment = "Punishment for disconnecting! Jailed for: %d seconds.",
    admin_only = "Admin only!", -- When doing /addjailpos
    chief_or = "Chief or ",-- When doing /addjailpos
    frozen = "Frozen.",

    dead_in_jail = "You now are dead until your jail time is up!",
    died_in_jail = "%s has died in jail!",

    credits_for = "CREDITS FOR %s\n",
    credits_see_console = "DarkRP credits printed to console.",

    rp_getvehicles = "Available vehicles for custom vehicles:",

    data_not_loaded_one = "Your data has not been loaded yet. Please wait.",
    data_not_loaded_two = "If this persists, try rejoining or contacting an admin.",

    cant_spawn_weapons = "You cannot spawn weapons.",
    drive_disabled = "Drive disabled for now.",
    property_disabled = "Property disabled for now.",

    not_allowed_to_purchase = "You are not allowed to purchase this item.",

    rp_teamban_hint = "rp_teamban [player name/ID] [team name/id]. Use this to ban a player from a certain team.",
    rp_teamunban_hint = "rp_teamunban [player name/ID] [team name/id]. Use this to unban a player from a certain team.",
    x_teambanned_y = "%s has banned %s from being a %s.",
    x_teamunbanned_y = "%s has unbanned %s from being a %s.",

    -- Backwards compatibility:
    you_set_x_salary_to_y = "You set %s's salary to %s%d.",
    x_set_your_salary_to_y = "%s set your salary to %s%d.",
    you_set_x_money_to_y = "You set %s's money to %s%d.",
    x_set_your_money_to_y = "%s set your money to %s%d.",

    you_set_x_salary = "You set %s's salary to %s.",
    x_set_your_salary = "%s set your salary to %s.",
    you_set_x_money = "You set %s's money to %s.",
    x_set_your_money = "%s set your money to %s.",
    you_set_x_name = "You set %s's name to %s",
    x_set_your_name = "%s set your name to %s",

    someone_stole_steam_name = "Someone is already using your Steam name as their RP name so we gave you a '1' after your name.", -- Uh oh
    already_taken = "Already taken.",

    job_doesnt_require_vote_currently = "This job does not require a vote at the moment!",

    x_made_you_a_y = "%s has made you a %s!",

    cmd_cant_be_run_server_console = "This command cannot be run from the server console.",

    -- The lottery
    lottery_started = "There is a lottery! Participate for %s%d?", -- backwards compatibility
    lottery_has_started = "There is a lottery! Participate for %s?",
    lottery_entered = "You entered the lottery for %s",
    lottery_not_entered = "%s did not enter the lottery",
    lottery_noone_entered = "No-one has entered the lottery",
    lottery_won = "%s has won the lottery! He has won %s",

    -- Animations
    custom_animation = "Custom animation!",
    bow = "Bow",
    sexy_dance = "Sexy dance",
    follow_me = "Follow me!",
    laugh = "Laugh",
    lion_pose = "Lion pose",
    nonverbal_no = "Non-verbal no",
    thumbs_up = "Thumbs up",
    wave = "Wave",
    dance = "Dance",

    -- Hungermod
    starving = "Starving!",

    -- AFK
    afk_mode = "AFK Mode",
    unable_afk_spam_prevention = "Please wait before going AFK again.",
    salary_frozen = "Your salary has been frozen.",
    salary_restored = "Welcome back, your salary has now been restored.",
    no_auto_demote = "You will not be auto-demoted.",
    youre_afk_demoted = "You were demoted for being AFK for too long. Next time use /afk.",
    hes_afk_demoted = "%s has been demoted for being AFK for too long.",
    afk_cmd_to_exit = "Type /afk to exit AFK mode.",
    player_now_afk = "%s is now AFK.",
    player_no_longer_afk = "%s is no longer AFK.",

    -- Hitmenu
    hit = "заказ",
    hitman = "Киллер",
    current_hit = "Заказ: %s",
    cannot_request_hit = "Невозможно запросить заказ! %s",
    hitmenu_request = "Заказ",
    player_not_hitman = "Этот гражданин не является киллером!",
    distance_too_big = "Слишком далеко.",
    hitman_no_suicide = "Киллер не станет убивать себя.",
    hitman_no_self_order = "Киллер не может заказывать себя.",
    hitman_already_has_hit = "У киллера уже есть заказ.",
    price_too_low = "Слишком низкая цена!",
    hit_target_recently_killed_by_hit = "Цель была убита киллером,",
    customer_recently_bought_hit = "Клиент недавно делал заказ.",
    accept_hit_question = "Принять заказ на %s\nна %s за %s%d?", -- backwards compatibility
    accept_hit_request = "Принять заказ на %s\nна %s за %s?",
    hit_requested = "Заказ сделан!",
    hit_aborted = "Заказ отклонен! %s",
    hit_accepted = "Заказ принят!",
    hit_declined = "Киллер отклонил заказ!",
    hitman_left_server = "Киллер ушел от дел!",
    customer_left_server = "Заказчик уехал в другой город!",
    target_left_server = "Цель заказа уехала в другой город!",
    hit_price_set_to_x = "Установлена цена на заказ %s%d.", -- backwards compatibility
    hit_price_set = "Установлена цена на заказ %s.",
    hit_complete = "Заказ на %s выполнен!",
    hitman_died = "Киллер умер!",
    target_died = "Цель умерла!",
    hitman_arrested = "Киллер был арестован!",
    hitman_changed_team = "Киллер ушел от дел!",
    x_had_hit_ordered_by_y = "%s имеет активный заказ на %s",

    -- Vote Restrictions
    hobos_no_rights = "Hobos have no voting rights!",
    gangsters_cant_vote_for_government = "Gangsters cannot vote for government things!",
    government_cant_vote_for_gangsters = "Government officials cannot vote for gangster things!",

    -- VGUI and some more doors/vehicles
    vote = "Vote",
    time = "Time: %d",
    yes = "Yes",
    no = "No",
    ok = "Okay",
    cancel = "Cancel",
    add = "Add",
    remove = "Remove",
    none = "None",

    x_options = "%s меню",
    sell_x = "Продать %s",
    set_x_title = "Set %s title",
    set_x_title_long = "Set the title of the %s you are looking at.",
    jobs = "Jobs",
    buy_x = "Купить %s",

    -- F4menu
    ammo = "ammo",
    weapon_ = "weapon",
    no_extra_weapons = "This job has no extra weapons.",
    become_job = "Become job",
    create_vote_for_job = "Create vote",
    shipment = "shipment",
    Shipments = "Shipments",
    shipments = "shipments",
    F4guns = "Weapons",
    F4entities = "Miscellaneous",
    F4ammo = "Ammo",
    F4vehicles = "Vehicles",

    -- Tab 1
    give_money = "Give money to the player you're looking at",
    drop_money = "Drop money",
    change_name = "Change your DarkRP name",
    go_to_sleep = "Go to sleep/wake up",
    drop_weapon = "Drop current weapon",
    buy_health = "Buy health(%s)",
    request_gunlicense = "Request gunlicense",
    demote_player_menu = "Demote a player",

    searchwarrantbutton = "Make a player wanted",
    unwarrantbutton = "Remove the wanted status from a player",
    noone_available = "No one available",
    request_warrant = "Request a search warrant for a player",
    make_wanted = "Make someone wanted",
    make_unwanted = "Make someone unwanted",
    set_jailpos = "Set the jail position",
    add_jailpos = "Add a jail position",

    set_custom_job = "Set a custom job (press enter to activate)",

    set_agenda = "Set the agenda (press enter to activate)",

    initiate_lockdown = "Initiate a lockdown",
    stop_lockdown = "Stop the lockdown",
    start_lottery = "Start a lottery",
    give_license_lookingat = "Give <lookingat> a gun license",

    laws_of_the_land = "В Сити 17 категорически запрещено:",
    law_added = "Law added.",
    law_removed = "Law removed.",
    law_reset = "Laws reset.",
    law_too_short = "Law too short.",
    laws_full = "The laws are full.",
    default_law_change_denied = "You are not allowed to change the default laws.",

    -- Second tab
    job_name = "Name: ",
    job_description = "Description: ",
    job_weapons = "Weapons: ",

    -- Entities tab
    buy_a = "Buy %s: %s",

    -- Licenseweaponstab
    license_tab = [[License weapons

    Tick the weapons people should be able to get WITHOUT a license!
    ]],
    license_tab_other_weapons = "Other weapons:",
}

-- The language code is usually (but not always) a two-letter code. The default language is "en".
-- Other examples are "nl" (Dutch), "de" (German)
-- If you want to know what your language code is, open GMod, select a language at the bottom right
-- then enter gmod_language in console. It will show you the code.
-- Make sure language code is a valid entry for the convar gmod_language.
DarkRP.addLanguage("en", my_language)
