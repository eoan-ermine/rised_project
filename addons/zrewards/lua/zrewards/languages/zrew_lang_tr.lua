-- "addons\\zrewards\\lua\\zrewards\\languages\\zrew_lang_tr.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
--[[
    ZRewards 2 - (SH) LANGUAGE - Turkish
    Developed by Zephruz
    Translated by saviorsoldier
]]

local LANG_TR = zrewards.lang:Register("tr")

--[[MENU: ADMIN]]
LANG_TR:addTranslation("admin", "Admin")
LANG_TR:addTranslation("generalInfo", "Genel Bilgi")
LANG_TR:addTranslation("users", "Kullanıcılar")
LANG_TR:addTranslation("accept", "Kabul et")
LANG_TR:addTranslation("decline", "Reddet")
LANG_TR:addTranslation("serverStats", "Sunucu İstatistikleri")
LANG_TR:addTranslation("onlineUsers", "Online Kullanıcılar")
LANG_TR:addTranslation("viewingUser", "'%s' Kullanıcısı İnceleniyor")
LANG_TR:addTranslation("totalUsers", "Toplam Kullanıcılar")
LANG_TR:addTranslation("totalRewards", "Toplam Ödüller")
LANG_TR:addTranslation("enterValueToFilter", "Filtreye bir değer girin...")
LANG_TR:addTranslation("copiedSteamID", "%s'in SteamID'si kopyalandı!")
LANG_TR:addTranslation("noServerStats", "Sunucu istatistikleri bulunmuyor!")
LANG_TR:addTranslation("noOnlineUsers", "Online kullanıcı yok!")
LANG_TR:addTranslation("noUserInfo", "Kullanıcı bilgisi yok!")

--[[REWARDS]]
LANG_TR:addTranslation("rewards", "Ödüller")
LANG_TR:addTranslation("rewardHistory", "Ödül Geçmişi")
LANG_TR:addTranslation("yourHistoryOfRewards", "Ödül geçmişiniz")
LANG_TR:addTranslation("rewardSomethingWentWrong", "Ödül verilirken bir şeyler ters gitti! %s")
LANG_TR:addTranslation("haveNoRewards", "Ödülün yok!")

--[[METHODS]]
LANG_TR:addTranslation("totalMethods", "Toplam Metodlar")
LANG_TR:addTranslation("clearMethods", "Metodları Sil")
LANG_TR:addTranslation("clearedMethods", "%s'in Metodlarını Sil")
LANG_TR:addTranslation("rewardMethods", "Metod Ver")
LANG_TR:addTranslation("getRewardsForMethod", "Bu metodları kullanarak ödül alabilirsin")
LANG_TR:addTranslation("claim", "Al")
LANG_TR:addTranslation("claimedOn", "Alındı")
LANG_TR:addTranslation("hasBeenRewardedMethod", "%s ödüllendirildi.")
LANG_TR:addTranslation("toAlsoReceiveRewards", "Ödül almak için")
LANG_TR:addTranslation("verifySomethingWentWrong", "Doğrulama yapılırken bir şeyler ters gitti! %s")
LANG_TR:addTranslation("successfullyRewarded", "Başarıyla doğrulandın ve ödüllendirildin!")
LANG_TR:addTranslation("noRewardMethods", "Ödül almak için yöntem yok!")

-- DISCORD METHOD
LANG_TR:addTranslation("discordArentInGuild", "Discord sunucumuzda değilsin, lütfen katıl!")
LANG_TR:addTranslation("discordApplicationNotOpen", "Discord uygulaması açık değil, doğrulanmak için uygulamayı başlat!")
LANG_TR:addTranslation("discordDisclaimer", "Dikkat edin: Discord uygulaması doğrulama işlemi amacıyla açılacaktır. Herhangi bir bilginizi depolamıyoruz.")

-- STEAM METHOD
LANG_TR:addTranslation("steamArentInGroup", "Steam grubumuzda değilsin, lütfen katıl!")

-- NAMETAG
LANG_TR:addTranslation("nametagAddTagToName", "Lütfen ismine tagimizi ekle! Tag: %s")
LANG_TR:addTranslation("nametagError", "Tagin doğrulanırken bir hata oluştu!")

--[[REFERRALS]]
LANG_TR:addTranslation("referralHiscoresDesc", "En fazla referans verenler")
LANG_TR:addTranslation("referralHiscores", "Referans Skorları")
LANG_TR:addTranslation("referring", "Referans Ol")
LANG_TR:addTranslation("referrals", "Referansçılar")
LANG_TR:addTranslation("referredOn", "Referans oldun")
LANG_TR:addTranslation("getRewardsForReferring", "Oyunculara referans olarak ödülleri alın")
LANG_TR:addTranslation("setReferrer", "Referans Ayarla")
LANG_TR:addTranslation("setAsReferrer", "Referans Olarak Ayarla")
LANG_TR:addTranslation("viewReferrer", "Referanslara Bak")
LANG_TR:addTranslation("copyReferralID", "Referans ID Kopyala")
LANG_TR:addTranslation("copyReferrerID", "Referansçı ID Kopyala")
LANG_TR:addTranslation("copiedReferralID", "%s'ın Referans ID'sini Kopyaladın")
LANG_TR:addTranslation("copiedReferrerID", "%s'ın Referansçı ID'sini Kopyaladın")
LANG_TR:addTranslation("copiedYourReferralID", "Referans ID'ni kopyaladı")
LANG_TR:addTranslation("copiedYourReferrerID", "Referansçı ID'ni kopyaladı")
LANG_TR:addTranslation("enterUserReferralID", "Kullanıcı referans ID'sini gir...")
LANG_TR:addTranslation("clearReferrals", "Referansları Temizle")
LANG_TR:addTranslation("totalReferrals", "Toplam Referanslar")
LANG_TR:addTranslation("referralID", "Referans ID")
LANG_TR:addTranslation("referrerID", "Referansçı ID")
LANG_TR:addTranslation("clearedReferrals", "%s'ın Referanslarını Sildin")
LANG_TR:addTranslation("hasBeenRewardedRefer", "%s referans olarak alındı, ödül almak için siz de referans olun!")
LANG_TR:addTranslation("haveNoReferrals", "Referansın yok!")

-- Hiscores
LANG_TR:addTranslation("noReferralHiscores", "Skor bulunamadı!")

--[[VGUI]]
LANG_TR:addTranslation("scrollPanelEmpty", "Burada bir şey yok!")