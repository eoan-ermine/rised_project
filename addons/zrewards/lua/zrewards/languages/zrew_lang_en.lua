-- "addons\\zrewards\\lua\\zrewards\\languages\\zrew_lang_en.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
--[[
    ZRewards 2 - (SH) LANGUAGE - English
    Developed by Zephruz
]]

-- WARNING: Don't replace %s they are for replacement values.

local LANG_EN = zrewards.lang:Register("en")

--[[MENU: ADMIN]]
LANG_EN:addTranslation("admin", "Admin")
LANG_EN:addTranslation("generalInfo", "General Info")
LANG_EN:addTranslation("users", "Users")
LANG_EN:addTranslation("accept", "Accept")
LANG_EN:addTranslation("decline", "Decline")
LANG_EN:addTranslation("serverStats", "Server Stats")
LANG_EN:addTranslation("onlineUsers", "Online Users")
LANG_EN:addTranslation("viewingUser", "Viewing User '%s'")
LANG_EN:addTranslation("totalUsers", "Total Users")
LANG_EN:addTranslation("totalRewards", "Total Rewards")
LANG_EN:addTranslation("enterValueToFilter", "Enter value to filter...")
LANG_EN:addTranslation("copiedSteamID", "Copied %s's SteamID")
LANG_EN:addTranslation("noServerStats", "No server stats available!")
LANG_EN:addTranslation("noOnlineUsers", "No online users!")
LANG_EN:addTranslation("noUserInfo", "No user info!")
LANG_EN:addTranslation("copiedToClipboard", "Copied to clipboard!")

--[[REWARDS]]
LANG_EN:addTranslation("rewards", "Rewards")
LANG_EN:addTranslation("rewardHistory", "Reward History")
LANG_EN:addTranslation("yourHistoryOfRewards", "Your history of rewards")
LANG_EN:addTranslation("rewardSomethingWentWrong", "Something went wrong while trying to reward you! %s")
LANG_EN:addTranslation("haveNoRewards", "You don't have any rewards!")

--[[METHODS]]
LANG_EN:addTranslation("totalMethods", "Total Methods")
LANG_EN:addTranslation("clearMethods", "Delete Methods")
LANG_EN:addTranslation("clearedMethods", "Deleted %s's Methods")
LANG_EN:addTranslation("rewardMethods", "Reward Methods")
LANG_EN:addTranslation("getRewardsForMethod", "Verify for rewards!")
LANG_EN:addTranslation("claim", "Claim")
LANG_EN:addTranslation("verify", "Verify")
LANG_EN:addTranslation("claimedOn", "Claimed on")
LANG_EN:addTranslation("hasBeenRewardedMethod", "%s has been rewarded.")
LANG_EN:addTranslation("toAlsoReceiveRewards", "To also receive rewards")
LANG_EN:addTranslation("verifySomethingWentWrong", "Something went wrong while verifying! %s")
LANG_EN:addTranslation("successfullyRewarded", "You have successfully been verified and rewarded!")
LANG_EN:addTranslation("noRewardMethods", "No reward methods available!")

-- DISCORD METHOD
LANG_EN:addTranslation("discordArentInGuild", "You aren't in our Discord guild/server, please join! (opening invite link)")
LANG_EN:addTranslation("discordArentBooster", "You aren't a booster in our Discord server!")
LANG_EN:addTranslation("discordApplicationNotOpen", "You don't have the Discord application open, please start it to verify!")
LANG_EN:addTranslation("discordDisclaimer", "Please note: Your Discord app will be opened, we do not store any information - this is just for verification purposes.")
    
-- STEAM METHOD
LANG_EN:addTranslation("steamArentInGroup", "You aren't in our Steam Group, please join! (opening group page)")

-- NAMETAG
LANG_EN:addTranslation("nametagAddTagToName", "Please add our tag to your name! Tag(s): %s")
LANG_EN:addTranslation("nametagError", "Something went wrong when validating your nametag!")

--[[REFERRALS]]
LANG_EN:addTranslation("referralHiscoresDesc", "Top referrers on the server")
LANG_EN:addTranslation("referralHiscores", "Highscores")
LANG_EN:addTranslation("referring", "Referring")
LANG_EN:addTranslation("referrals", "Referrals")
LANG_EN:addTranslation("yourReferrals", "Your Referrals")
LANG_EN:addTranslation("referredOn", "Referred on")
LANG_EN:addTranslation("getRewardsForReferring", "Refer for rewards!")
LANG_EN:addTranslation("yourReferrer", "Your Referrer")
LANG_EN:addTranslation("setReferrer", "Set Referrer")
LANG_EN:addTranslation("setAsReferrer", "Set As Referrer")
LANG_EN:addTranslation("viewReferrer", "View Referrer")
LANG_EN:addTranslation("copyReferralID", "Copy ID")
LANG_EN:addTranslation("copyReferrerID", "Copy Referrer ID")
LANG_EN:addTranslation("copiedReferralID", "Copied %s's Referral ID")
LANG_EN:addTranslation("copiedReferrerID", "Copied %s's Referrer ID")
LANG_EN:addTranslation("copiedYourReferralID", "Copied your Referral ID")
LANG_EN:addTranslation("copiedYourReferrerID", "Copied your Referrer ID")
LANG_EN:addTranslation("enterUserReferralID", "Enter users referral ID...")
LANG_EN:addTranslation("clearReferrals", "Delete Referrals")
LANG_EN:addTranslation("totalReferrals", "Total Referrals")
LANG_EN:addTranslation("referralID", "Referral ID")
LANG_EN:addTranslation("referrerID", "Referrer ID")
LANG_EN:addTranslation("clearedReferrals", "Deleted %s's Referrals")
LANG_EN:addTranslation("hasBeenRewardedRefer", "%s has just been referred, refer players to get also rewards!")
LANG_EN:addTranslation("haveNoReferrals", "You don't have any referrals!")
LANG_EN:addTranslation("whoReferredYou", "Player who referred you")
LANG_EN:addTranslation("whoYouveReferred", "Players you have referred")
LANG_EN:addTranslation("yourReferrerSet", "Your referrer has been set")
LANG_EN:addTranslation("cantReferSelf", "You can't refer yourself")
LANG_EN:addTranslation("alreadyReferred", "You are already referred by someone")
LANG_EN:addTranslation("invalidReferrer", "That referral ID doesn't exist")

-- Highscores
LANG_EN:addTranslation("noReferralHiscores", "No highscores available!")

--[[VGUI]]
LANG_EN:addTranslation("scrollPanelEmpty", "Nothing here!")