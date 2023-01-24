-- "addons\\zrewards\\lua\\zrewards\\languages\\zrew_lang_ru.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
--[[
    ZRewards 2 - (SH) LANGUAGE - Russian
    Developed by Zephruz
]]

-- WARNING: Don't replace %s they are for replacement values.

local LANG_RU = zrewards.lang:Register("ru")

--[[MENU: ADMIN]]
LANG_RU:addTranslation("admin", "Админ")
LANG_RU:addTranslation("generalInfo", "Главная")
LANG_RU:addTranslation("users", "Игроки")
LANG_RU:addTranslation("accept", "Принять")
LANG_RU:addTranslation("decline", "Отмена")
LANG_RU:addTranslation("serverStats", "Статистика")
LANG_RU:addTranslation("onlineUsers", "Игроки онлайн")
LANG_RU:addTranslation("viewingUser", "Просмотр информации игрока '%s'")
LANG_RU:addTranslation("totalUsers", "Всего игроков")
LANG_RU:addTranslation("totalRewards", "Всего наград")
LANG_RU:addTranslation("enterValueToFilter", "Фильтр ...")
LANG_RU:addTranslation("copiedSteamID", "Скопирован SteamID %s")
LANG_RU:addTranslation("noServerStats", "Статистика сервера недоступна!")
LANG_RU:addTranslation("noOnlineUsers", "Нет игроков онлайн!")
LANG_RU:addTranslation("noUserInfo", "Нет информации")

--[[REWARDS]]
LANG_RU:addTranslation("rewards", "Награда")
LANG_RU:addTranslation("rewardHistory", "История")
LANG_RU:addTranslation("yourHistoryOfRewards", "Ваша история наград")
LANG_RU:addTranslation("rewardSomethingWentWrong", "Возникла ошибка при получении награды! %s")
LANG_RU:addTranslation("haveNoRewards", "Нет информации")

--[[METHODS]]
LANG_RU:addTranslation("totalMethods", "Всего способов")
LANG_RU:addTranslation("clearMethods", "Очистить методы")
LANG_RU:addTranslation("clearedMethods", "Очистить методы %s's")
LANG_RU:addTranslation("rewardMethods", "Награды")
LANG_RU:addTranslation("rewardMethodsMain", "Способы получения наград")
LANG_RU:addTranslation("getRewardsForMethod", "Получайте вознаграждение за активность")
LANG_RU:addTranslation("claim", "Получить")
LANG_RU:addTranslation("claimedOn", "Получено")
LANG_RU:addTranslation("hasBeenRewardedMethod", "%s получил награду! ")
LANG_RU:addTranslation("toAlsoReceiveRewards", "чтобы получить вознаграждение!")
LANG_RU:addTranslation("verifySomethingWentWrong", "Что-то пошло не так! %s")
LANG_RU:addTranslation("successfullyRewarded", "Успешно! Получена награда!")
LANG_RU:addTranslation("noRewardMethods", "Нет информации")

-- DISCORD METHOD
LANG_RU:addTranslation("discordArentInGuild", "Вы не являетесь участником нашего сервера дискорд. Откройте ссылку-приглашение, чтобы присоединиться и получить награду.")
LANG_RU:addTranslation("discordApplicationNotOpen", "Запустите дискорд, чтобы авторизироваться и получить награду.")

-- STEAM METHOD
LANG_RU:addTranslation("steamArentInGroup", "Вы не состоите в нашей группе стим. Присоединяйтесь к нашей группе стим, чтобы получить награду!")

-- NAMETAG
LANG_RU:addTranslation("nametagAddTagToName", "Тег в нике отсутствует. Доступные теги: %s")
LANG_RU:addTranslation("nametagError", "Что-то пошло не так! Возможно ник содержит некорректные символы.")

--[[REFERRALS]]
LANG_RU:addTranslation("referralHiscoresDesc", "Топ рефералов")
LANG_RU:addTranslation("referralHiscores", "Топ рефералов")
LANG_RU:addTranslation("referring", "Реферальная система")
LANG_RU:addTranslation("referrals", "Рефералы")
LANG_RU:addTranslation("referredOn", "Стал рефералом")
LANG_RU:addTranslation("getRewardsForReferring", "10 премиум поинтов за каждого реферала")
LANG_RU:addTranslation("setReferrer", "Ввести код")
LANG_RU:addTranslation("setAsReferrer", "Назначить рефералом")
LANG_RU:addTranslation("viewReferrer", "Список рефералов")
LANG_RU:addTranslation("copyReferralID", "Скопировать код")
LANG_RU:addTranslation("copyReferrerID", "Скопир. код")
LANG_RU:addTranslation("copiedReferralID", "Реферальный код %s's скопирован")
LANG_RU:addTranslation("copiedReferrerID", "Реферальный код %s's скопирован")
LANG_RU:addTranslation("copiedYourReferralID", "Реферальный код успешно скопирован")
LANG_RU:addTranslation("copiedYourReferrerID", "Реферальный код успешно скопирован")
LANG_RU:addTranslation("enterUserReferralID", "Введите реферальный код ...")
LANG_RU:addTranslation("clearReferrals", "Удалить рефералов")
LANG_RU:addTranslation("totalReferrals", "Всего рефералов")
LANG_RU:addTranslation("referralID", "Реферальный код")
LANG_RU:addTranslation("referrerID", "Реферальный код")
LANG_RU:addTranslation("clearedReferrals", "Реферальны %s's удалены")
LANG_RU:addTranslation("hasBeenRewardedRefer", "%s стал рефералом! Получайте вознаграждения за активацию вашего реферального кода!")
LANG_RU:addTranslation("haveNoReferrals", "Нет информации")

-- Hiscores
LANG_RU:addTranslation("noReferralHiscores", "Нет информации")

--[[VGUI]]
LANG_RU:addTranslation("scrollPanelEmpty", "Нет информации")