-- "addons\\zrewards\\lua\\zrewards\\languages\\zrew_lang_pl.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
--[[
    ZRewards 2 - (SH) LANGUAGE - Polish
    Developed by Zephruz
    Translated by Foxie
]]
 
-- WARNING: Don't replace %s they are for replacement values.
 
local LANG_PL = zrewards.lang:Register("pl")
 
--[[MENU: ADMIN]]
LANG_PL:addTranslation("admin", "Admin")
LANG_PL:addTranslation("generalInfo", "Ogólne info")
LANG_PL:addTranslation("users", "Gracze")
LANG_PL:addTranslation("accept", "Akceptuj")
LANG_PL:addTranslation("decline", "Odmów")
LANG_PL:addTranslation("serverStats", "Statystyki serwera")
LANG_PL:addTranslation("onlineUsers", "Gracze online")
LANG_PL:addTranslation("viewingUser", "Przeglądasz gracza '%s'")
LANG_PL:addTranslation("totalUsers", "Liczba graczy")
LANG_PL:addTranslation("totalRewards", "Liczba nagród")
LANG_PL:addTranslation("enterValueToFilter", "Wprowadź wartość do filtrowania...")
LANG_PL:addTranslation("copiedSteamID", "Skopiowano SteamID gracza %s")
LANG_PL:addTranslation("noServerStats", "Brak statystyk serwera!")
LANG_PL:addTranslation("noOnlineUsers", "Brak użytkowników online!")
LANG_PL:addTranslation("noUserInfo", "Brak informacji o graczu!")
 
--[[REWARDS]]
LANG_PL:addTranslation("rewards", "Nagrody")
LANG_PL:addTranslation("rewardHistory", "Historia nagród")
LANG_PL:addTranslation("yourHistoryOfRewards", "Twoja historia nagród")
LANG_PL:addTranslation("rewardSomethingWentWrong", "Coś poszło nie tak podczas przyznawania nagrody! %s")
LANG_PL:addTranslation("haveNoRewards", "Nie masz żadnych nagród!")
 
--[[METHODS]]
LANG_PL:addTranslation("totalMethods", "Liczba metod")
LANG_PL:addTranslation("clearMethods", "Wyczyść metody")
LANG_PL:addTranslation("clearedMethods", "Wyczyszczono metody gracza %s")
LANG_PL:addTranslation("rewardMethods", "Nagrody z metod")
LANG_PL:addTranslation("getRewardsForMethod", "Zdobądź nagrody za weryfikację tych metod")
LANG_PL:addTranslation("claim", "Odbierz")
LANG_PL:addTranslation("claimedOn", "Odebrano dnia")
LANG_PL:addTranslation("hasBeenRewardedMethod", "%s został nagrodzony.")
LANG_PL:addTranslation("toAlsoReceiveRewards", "Aby również otrzymać nagrody")
LANG_PL:addTranslation("verifySomethingWentWrong", "Coś poszło nie tak podczas weryfikacji! %s")
LANG_PL:addTranslation("successfullyRewarded", "Zostałeś pomyślnie zweryfikowany i nagrodzony!")
LANG_PL:addTranslation("noRewardMethods", "Brak dostępnych metod nagrody!")
 
-- DISCORD METHOD
LANG_PL:addTranslation("discordArentInGuild", "Nie jesteś na naszym serwerze Discord, możesz dołączyć! (otwieranie linku zapraszającego)")
LANG_PL:addTranslation("discordApplicationNotOpen", "Nie masz otwartej aplikacji Discord. Włącz ją, aby zweryfikować!")
LANG_PL:addTranslation("discordDisclaimer", "Uwaga: Twoja aplikacja Discord zostanie otwarta, nie przechowujemy żadnych informacji - służy to wyłącznie celom weryfikacyjnym.")
 
-- STEAM METHOD
LANG_PL:addTranslation("steamArentInGroup", "Nie jesteś na naszej grupie Steam, możesz dołączyć! (otwieranie strony grupy)")
 
-- NAMETAG
LANG_PL:addTranslation("nametagAddTagToName", "Dodaj nasz tag do swojej nazwy Steam! Tag: %s")
LANG_PL:addTranslation("nametagError", "Coś poszło nie tak podczas sprawdzania twojego tagu!")
 
--[[REFERRALS]]
LANG_PL:addTranslation("referralHiscoresDesc", "Największa liczba poleceń")
LANG_PL:addTranslation("referralHiscores", "Sala chwały")
LANG_PL:addTranslation("referring", "Polecasz")
LANG_PL:addTranslation("referrals", "Polecenia")
LANG_PL:addTranslation("referredOn", "Zaproszony dnia")
LANG_PL:addTranslation("getRewardsForReferring", "Zdobądź nagrody za zapraszanie graczy")
LANG_PL:addTranslation("setReferrer", "Ustaw polecającego")
LANG_PL:addTranslation("setAsReferrer", "Ustaw jako polecającego")
LANG_PL:addTranslation("viewReferrer", "Zobacz polecającego")
LANG_PL:addTranslation("copyReferralID", "Kopiuj ID polecenia")
LANG_PL:addTranslation("copyReferrerID", "Kopiuj ID polecającego")
LANG_PL:addTranslation("copiedReferralID", "Skopiowano ID polecenia gracza %s")
LANG_PL:addTranslation("copiedReferrerID", "Skopiowano ID polecającego gracza %s")
LANG_PL:addTranslation("copiedYourReferralID", "Skopiowano twoje ID polecenia")
LANG_PL:addTranslation("copiedYourReferrerID", "Skopiowano twoje ID polecającego")
LANG_PL:addTranslation("enterUserReferralID", "Wprowadź ID polecenia gracza...")
LANG_PL:addTranslation("clearReferrals", "Wyczyść polecenia")
LANG_PL:addTranslation("totalReferrals", "Liczba poleceń")
LANG_PL:addTranslation("referralID", "ID polecenia")
LANG_PL:addTranslation("referrerID", "ID polecającego")
LANG_PL:addTranslation("clearedReferrals", "Wyczyszczono polecenia gracza %s")
LANG_PL:addTranslation("hasBeenRewardedRefer", "%s został właśnie zaproszony. Polecaj graczom, aby także uzyskać nagrody!")
LANG_PL:addTranslation("haveNoReferrals", "Nie masz żadnych poleceń!")
 
-- Hiscores
LANG_PL:addTranslation("noReferralHiscores", "Brak dostępnych najlepszych wyników!")
 
--[[VGUI]]
LANG_PL:addTranslation("scrollPanelEmpty", "Nic tu nie ma!")