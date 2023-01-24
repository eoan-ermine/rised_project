-- "addons\\zrewards\\lua\\zrewards\\languages\\zrew_lang_dk.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
--[[
    ZRewards 2 - (SH) LANGUAGE - Danish
    Developed by Zephruz
]]

-- WARNING: Don't replace %s they are for replacement values.

local LANG_DK = zrewards.lang:Register("dk")

--[[MENU: ADMIN]]
LANG_DK:addTranslation("admin", "Admin")
LANG_DK:addTranslation("generalInfo", "General Information")
LANG_DK:addTranslation("users", "Brugere")
LANG_DK:addTranslation("serverStats", "Server Status")
LANG_DK:addTranslation("onlineUsers", "Online Brugere")
LANG_DK:addTranslation("viewingUser", "Viser Brugers '%s'")
LANG_DK:addTranslation("totalUsers", "Totale Brugere")
LANG_DK:addTranslation("totalRewards", "Totale Belønninger")
LANG_DK:addTranslation("enterValueToFilter", "Indsæt for at filtrere...")
LANG_DK:addTranslation("copiedSteamID", "Kopier %s's SteamID")

--[[REWARDS]]
LANG_DK:addTranslation("rewards", "Belønninger")
LANG_DK:addTranslation("rewardHistory", "Belønning Historik")
LANG_DK:addTranslation("yourHistoryOfRewards", "Din historik af belønninger")
LANG_DK:addTranslation("rewardSomethingWentWrong", "Noget gik galt imens du prøvede at få en belønning! %s")

--[[METHODS]]
LANG_DK:addTranslation("totalMethods", "Totale Metoder")
LANG_DK:addTranslation("clearMethods", "Rens Metoder")
LANG_DK:addTranslation("clearedMethods", "Rensede %s's Metoder")
LANG_DK:addTranslation("rewardMethods", "Belønnings Metoder")
LANG_DK:addTranslation("getRewardsForMethod", "Få belønninger for at verificere disse metoder.")
LANG_DK:addTranslation("claim", "Tag")
LANG_DK:addTranslation("claimedOn", "Taget")
LANG_DK:addTranslation("hasBeenRewardedMethod", "%s har fået en belønning")
LANG_DK:addTranslation("toAlsoReceiveRewards", "Også at belønne")
LANG_DK:addTranslation("verifySomethingWentWrong", "Noget gik galt imens den verificere %s")
LANG_DK:addTranslation("successfullyRewarded", "Du har succesfuldt verificeret og fået din belønning!")

-- DISCORD METHOD
LANG_DK:addTranslation("discordArentInGuild", "Du er ikke i vores Discord server, tilslut venligst! (åben invitations link)")
LANG_DK:addTranslation("discordApplicationNotOpen", "Du har ikke Discord åben, start det for at verificere!")

-- STEAM METHOD
LANG_DK:addTranslation("steamArentInGroup", "Du er ikke medlem af vores Steam gruppe, meld dig ind!(åben steam gruppe)")

-- NAMETAG
LANG_DK:addTranslation("nametagAddTagToName", "Tilføj venligst vores tag til dit navn! Tag: %s")

--[[REFERRALS]]
LANG_DK:addTranslation("referring", "Henviser")
LANG_DK:addTranslation("referrals", "Henvisninger")
LANG_DK:addTranslation("referredOn", "Henvist fra")
LANG_DK:addTranslation("getRewardsForReferring", "Få belønninger for at henvise andre spillere")
LANG_DK:addTranslation("setReferrer", "Set Henvisninger")
LANG_DK:addTranslation("setAsReferrer", "Set som henviser")
LANG_DK:addTranslation("viewReferrer", "Se Henvisninger")
LANG_DK:addTranslation("copyReferralID", "Kopier henvisnings ID")
LANG_DK:addTranslation("copyReferrerID", "Kopier henvisers ID")
LANG_DK:addTranslation("copiedReferralID", "Kopieret %s's henvisnings ID")
LANG_DK:addTranslation("copiedReferrerID", "Kopieret %s's henvisers ID")
LANG_DK:addTranslation("copiedYourReferralID", "Kopieret dit reference ID")
LANG_DK:addTranslation("copiedYourReferrerID", "Kopieret din henvisers ID")
LANG_DK:addTranslation("enterUserReferralID", "Skriv spillers reference ID...")
LANG_DK:addTranslation("clearReferrals", "Rens Henvisninger")
LANG_DK:addTranslation("totalReferrals", "Totale Henvisninger")
LANG_DK:addTranslation("referralID", "Reference ID")
LANG_DK:addTranslation("referrerID", "Henvisers ID")
LANG_DK:addTranslation("clearedReferrals", "Renset %s's Henvisninger")
LANG_DK:addTranslation("hasBeenRewardedRefer", "%s er blevet henvist. Henvis spillere for at få belønninger!")