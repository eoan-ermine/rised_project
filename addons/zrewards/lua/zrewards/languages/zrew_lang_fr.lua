-- "addons\\zrewards\\lua\\zrewards\\languages\\zrew_lang_fr.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
--[[
    ZRewards 2 - (SH) LANGUAGE - French
    Developed by Zephruz - Edited by Iencli!
]]

-- WARNING: Don't replace %s they are for replacement values.

local LANG_FR = zrewards.lang:Register("fr")

--[[MENU: ADMIN]]
LANG_FR:addTranslation("admin", "Admin")
LANG_FR:addTranslation("generalInfo", "Infos générales")
LANG_FR:addTranslation("users", "Utilisateurs")
LANG_FR:addTranslation("serverStats", "Statistiques du serveur")
LANG_FR:addTranslation("onlineUsers", "Utilisateurs en ligne")
LANG_FR:addTranslation("viewingUser", "Regarde l'utilisateur'%s'")
LANG_FR:addTranslation("totalUsers", "Total des utilisateurs")
LANG_FR:addTranslation("totalRewards", "Total des récompenses")
LANG_FR:addTranslation("enterValueToFilter", "Entrez une valeur pour filtrer...")
LANG_FR:addTranslation("copiedSteamID", "SteamID de %s copié!")

--[[REWARDS]]
LANG_FR:addTranslation("rewards", "Récompenses")
LANG_FR:addTranslation("rewardHistory", "Historique des récompenses")
LANG_FR:addTranslation("yourHistoryOfRewards", "Ton historique des récompenses")
LANG_FR:addTranslation("rewardSomethingWentWrong", "Une erreur est apparue lors du traitement de ta récompense! %s")

--[[METHODS]]
LANG_FR:addTranslation("totalMethods", "Total des méthodes")
LANG_FR:addTranslation("clearMethods", "Effacer les méthodes")
LANG_FR:addTranslation("clearedMethods", "Nettoyage de %s méthodes")
LANG_FR:addTranslation("rewardMethods", "Méthodes de récompense")
LANG_FR:addTranslation("getRewardsForMethod", "Obtient des récompenses en vérifiant ces methodes!")
LANG_FR:addTranslation("claim", "Réclamer")
LANG_FR:addTranslation("claimedOn", "Réclamer sur")
LANG_FR:addTranslation("hasBeenRewardedMethod", "%s à été récompensé.")
LANG_FR:addTranslation("toAlsoReceiveRewards", "Pour aussi reçevoir des récompenses")
LANG_FR:addTranslation("verifySomethingWentWrong", "Une erreur est apparue lors de la vérification! %s")
LANG_FR:addTranslation("successfullyRewarded", "Tu as été vérifié et récompensé avec succès!")

-- DISCORD METHOD
LANG_FR:addTranslation("discordArentInGuild", "Tu n'es pas sur le serveur/guilde discord, rejoint le!")
LANG_FR:addTranslation("discordApplicationNotOpen", "Tu n'as pas l'application discord ouverte, ouvre là pour être vérifié!")

-- STEAM METHOD
LANG_FR:addTranslation("steamArentInGroup", "Tu n'es pas dans le groupe steam, rejoint le!")

-- NAMETAG
LANG_FR:addTranslation("nametagAddTagToName", "Merci d'ajouter le préfixe à ton nom! Préfixe: %s")

--[[REFERRALS]]
LANG_FR:addTranslation("referring", "Parrainage")
LANG_FR:addTranslation("referrals", "Parrainés")
LANG_FR:addTranslation("referredOn", "Parrainé à")
LANG_FR:addTranslation("getRewardsForReferring", "Obtient des récompenses en parrainant des joueurs!")
LANG_FR:addTranslation("setReferrer", "Ajouter un parrainé")
LANG_FR:addTranslation("setAsReferrer", "Ajouter un parrainé")
LANG_FR:addTranslation("viewReferrer", "Voir le parrain")
LANG_FR:addTranslation("copyReferralID", "Copier l'ID du parrainé")
LANG_FR:addTranslation("copyReferrerID", "Copier l'ID du parrain")
LANG_FR:addTranslation("copiedReferralID", "l'ID du parrainé %s à été copié")
LANG_FR:addTranslation("copiedReferrerID", "l'ID du parrain %s à été copié")
LANG_FR:addTranslation("copiedYourReferralID", "Tu as copié ton ID de parrainé")
LANG_FR:addTranslation("copiedYourReferrerID", "Tu as copié ton ID de parrain")
LANG_FR:addTranslation("enterUserReferralID", "Entre l'ID des parrainés")
LANG_FR:addTranslation("clearReferrals", "Supprimer les parrainés")
LANG_FR:addTranslation("totalReferrals", "Total des parrainés")
LANG_FR:addTranslation("referralID", "ID de parrainé")
LANG_FR:addTranslation("referrerID", "ID de parrain")
LANG_FR:addTranslation("clearedReferrals", "Tu as nettoyé les parrainés de %s")
LANG_FR:addTranslation("hasBeenRewardedRefer", "%s vient d'être parrainé, parrainez des joueurs pour obtenir des récompenses!")