###
###     WHITELIST SYSTEM,
###     NOT AUTOMATIC
###     DEVELOPPED BY LWZ#2051
###

1. Log in on your phpMyAdmin database (or whatever your using)
2. Click on your database name
3. Click on SQL (on top of the website)
4. Copy this :

CREATE TABLE whitelistlwz
(
	ID int(11),
	Steam text,
	GameLicense text,
	IP text,
	DiscordUID text,
	SteamName text,
	SteamLink text,
	Reason text,
	Other text
)

5. Click on "Execute" in bottom right corner
6. Go back on your database name and on "SQL" category
7. Now, copy this :

INSERT INTO wwwtest (ID, Steam, GameLicense, IP, DiscordUID, SteamName, SteamLink, Reason, Other) VALUES 
('1', 'steam:XXX', 'license:XXX', 'X.X.X.X', 'discord:XXX', 'Exemple Steam Name', 'https://steamcommunity.com/id/exemple_steam_link', 'Whitelist reason', 'Other text');

8. Click on "Execute" in bottom right corner again
9. Thats it
10. Its not automatic so you need to add it manually