-- "addons\\zrewards\\lua\\zrewards\\languages\\zrew_lang_de.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
--[[
    ZRewards 2 - (SH) LANGUAGE - English
    Developed by Zephruz
]]

-- WARNING: Don't replace %s they are for replacement values.

local LANG_DE = zrewards.lang:Register("de")

--[[MENU: ADMIN]]
LANG_DE:addTranslation("admin", "Admin")
LANG_DE:addTranslation("generalInfo", "Allgemeine Infos")
LANG_DE:addTranslation("users", "Benutzer")
LANG_DE:addTranslation("accept", "Akzeptieren")
LANG_DE:addTranslation("decline", "Ablehnen")
LANG_DE:addTranslation("serverStats", "Serverstatistiken")
LANG_DE:addTranslation("onlineUsers", "Benutzer Online")
LANG_DE:addTranslation("viewingUser", "Benutzer ansehen '%s'")
LANG_DE:addTranslation("totalUsers", "Gesamte Benutzer")
LANG_DE:addTranslation("totalRewards", "Gesamte Belohnungen")
LANG_DE:addTranslation("enterValueToFilter", "Geben Sie den zu filternden Wert ein...")
LANG_DE:addTranslation("copiedSteamID", "kopiert %s's SteamID")
LANG_DE:addTranslation("noServerStats", "Keine Serverstatistiken verfügbar!")
LANG_DE:addTranslation("noOnlineUsers", "Keine Benutzer Online!")
LANG_DE:addTranslation("noUserInfo", "Keine Benutzerinformationen!")

--[[REWARDS]]
LANG_DE:addTranslation("rewards", "Belohnungen")
LANG_DE:addTranslation("invoiceHistory", "Reward History")
LANG_DE:addTranslation("yourHistoryOfRewards", "Ihre Geschichte der Belohnungen")
LANG_DE:addTranslation("invoiceSomethingWentWrong", "Beim Versuch, Sie zu belohnen, ist ein Fehler aufgetreten! %s")
LANG_DE:addTranslation("haveNoRewards", "Sie haben keine Belohnungen!")

--[[METHODS]]
LANG_DE:addTranslation("totalMethods", "Gesamte Methoden")
LANG_DE:addTranslation("clearMethods", "Methoden löschen")
LANG_DE:addTranslation("clearedMethods", "%s Methoden gelöscht")
LANG_DE:addTranslation("invoiceMethods", "Belohnungsmethoden")
LANG_DE:addTranslation("getRewardsForMethod", "Belohnungen für die Überprüfung dieser Methoden erhalten")
LANG_DE:addTranslation("claim", "Claim")
LANG_DE:addTranslation("claimOn", "Claimed on")
LANG_DE:addTranslation("hasBeenRewardedMethod", "%s wurde belohnt.")
LANG_DE:addTranslation("toAlsoReceiveRewards", "Um auch Belohnungen zu erhalten")
LANG_DE:addTranslation("verifySomethingWentWrong", "Beim Überprüfen ist ein Fehler aufgetreten! %s")
LANG_DE:addTranslation("successfulRewarded", "Sie wurden erfolgreich verifiziert und belohnt!")
LANG_DE:addTranslation("noRewardMethods", "Keine Belohnungsmethoden verfügbar!")

-- DISCORD-METHODE
LANG_DE:addTranslation("discordArentInGuild", "Du bist nicht in unserer Discord-Gilde / Server, mach mit! (Link zum Öffnen der Einladung)")
LANG_DE:addTranslation("discordApplicationNotOpen", "Sie haben die Discord-Anwendung nicht geöffnet, bitte starten Sie sie zur Bestätigung!")
LANG_DE:addTranslation("discordDisclaimer", "Bitte beachten Sie: Ihre Discord-App wird geöffnet, wir speichern keine Informationen - dies dient nur zu Überprüfungszwecken.")

-- DAMPFVERFAHREN
LANG_DE:addTranslation("steamArentInGroup", "Du bist nicht in unserer Steam-Gruppe, mach mit! (Eröffnungsgruppenseite)")

-- NAMENSSCHILD
LANG_DE:addTranslation("nametagAddTagToName", "Bitte fügen Sie unseren Tag Ihrem Namen hinzu! Tag (s): %s")
LANG_DE:addTranslation("nametagError", "Bei der Validierung Ihres Namensschilds ist ein Fehler aufgetreten!")

--[[REFERRALS]]
LANG_DE:addTranslation("referralHiscoresDesc", "Top Referrer auf dem Server")
LANG_DE:addTranslation("referralHiscores", "Referral Hiscores")
LANG_DE:addTranslation("referring", "verweisend")
LANG_DE:addTranslation("referrals", "Verweise")
LANG_DE:addTranslation("referedOn", "Weitergeleitet am")
LANG_DE:addTranslation("getRewardsForReferring", "Belohnungen für verweisende Spieler erhalten")
LANG_DE:addTranslation("setReferrer", "Referrer setzen")
LANG_DE:addTranslation("setAsReferrer", "Als Verweis festlegen")
LANG_DE:addTranslation("viewReferrer", "Referrer ansehen")
LANG_DE:addTranslation("copyReferralID", "kopiere Referral ID")
LANG_DE:addTranslation("copyReferrerID", "kopiere Referrer ID")
LANG_DE:addTranslation("copiedReferralID", "Verweis-ID von %s kopiert")
LANG_DE:addTranslation("copiedReferrerID", "Kopierte %s's Referrer ID")
LANG_DE:addTranslation("copiedYourReferralID", "Kopiert Ihre Referral ID")
LANG_DE:addTranslation("copiedYourReferrerID", "Kopiert Ihre Referrer ID")
LANG_DE:addTranslation("enterUserReferralID", "Benutzerempfehlungs-ID eingeben ...")
LANG_DE:addTranslation("clearReferrals", "lösche Referrals")
LANG_DE:addTranslation("totalReferrals", "gesamte Referrals")
LANG_DE:addTranslation("referralID", "Referral ID")
LANG_DE:addTranslation("referrerID", "Referrer ID")
LANG_DE:addTranslation("clearedReferrals", "Verweise von %s gelöscht")
LANG_DE:addTranslation("hasBeenRewardedRefer", "%s wurde gerade empfohlen, verweise Spieler, um auch Belohnungen zu erhalten!")
LANG_DE:addTranslation("haveNoReferrals", "Sie haben keine Verweise!")

-- Hiscores
LANG_DE:addTranslation("noReferralHiscores", "Keine hiscores verfügbar!")

-- [[VGUI]]
LANG_DE:addTranslation("scrollPanelEmpty", "Nichts hier!")