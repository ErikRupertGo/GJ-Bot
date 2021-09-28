# GJBot
 
A bot for managing the team categories for Game Jam discords such as Global Game Jam and Game Jame+

The bot is developed by Erik Go from ID 119

The code for the bot is actually just the bare-bones version of my personal bot: https://github.com/ErikRupertGo/FG-Bot

To get the server template of the server use [this link](https://discord.new/U32pRqxsqUKS) to set up the server automatically.

## Installation
By now, you're probably wondering how to set up and install the bot.

### 1. Install Luvit
Luvit is the runtime of the bot, using the Lua programming language.

First, make sure to make a root directory for your bot. After that, press the address bar and type cmd. This will open the command prompt on the directory.

After that, follow the instructions on how to install Luvit on their website: https://luvit.io/install.html

By now, there should be luvit.exe, luvi.exe, and lit.exe in your directory.

### 2. Install Discordia
Luvit is just the runtime for the Bot. To use the Discord API, you need to have a wrapper for it. The library that I chose for my bot is Discordia by SinisterRectus.

On the command prompt of the directory, 
Type: lit install `SinisterRectus/discordia`. Not that `discordia` is in lowercase, that's because of the package handling of lit.

## Downloading the code
Once you installed Discordia, it's time for you to clone the repository to the directory or to download the repo.
You can do this by pressing the code button and clone it, or downloading the zip.

After downloading, make sure to extract the zip into the folder. The runtime won't use zips to start the bot.

## Setting up the bot
In order to get a bot account, you have to tell discord to create one for you.
To create one, you have to go to [Discord Developer Portal](https://discord.com/developers/applications) and on the top right, left side of your profile picture, there's a button there named "New Application"

Once you have made an application, you have to get the bot token of your bot. This is basically the key to your bot.

To get it, press the "Bot" tab on the left side, and make the application a bot. Ignore the warning that the action is irreversible.
After creating the bot. You can copy the token to your clipboard.

***WARNING: DO NOT SHARE THE TOKEN TO ANYONE ELSE. ONCE SOMEONE HAS IT, THEY HAVE FULL CONTROL OF YOUR BOT***

Once you have the token, create a file named `token` in the bot directory, take note to not put any extensions in the file. It is not a text file.
Paste the token into the token file.

## Settings
At this point, you are almost done in setting up the bot, you just have to define the constants.
I made 3 constants for the roles Moderator, Judge, and the Benildean Press Corps. You can add more overwrites, just follow the syntax.

Edit `createTeam.lua` at lines 33, 37, and 41. Change the strings into the id of the respective roles. Google search if you don't know how to get the role ID's

Once the constants have been edited, you can now invite the bot to the server.

## Inviting the Bot
To invite the bot, copy the client ID, **NOT THE TOKEN** from the Discord Developers Portal in your application's OAth2 page into `https://discord.com/oauth2/authorize?client_id=123456789&scope=bot`

Make sure to replace the numbers in the link to your client ID.

## Turning on the bot
The moment of truth.
Open command prompt in the directory of the bot, and type `luvit bot.lua` for windows, `./luvit bot.lua` on Linux. You can also use the terminal in VSCode by using `./luvit bot.lua`

After this, you will see in the command prompt that the bot is now online.
If you close this command prompt, the bot will shutdown, so you have the find a way to make the bot stay alive 24/7

I hosted the bot in my 24/7 server, but you can also host it on your machine.

# Usage

There are 4 available commands in the bot, namely prefix, lua, createTeam, and invite.

## prefix

The command is pretty self explanatory, just type `=prefix =` to change the prefix to =

## lua

Usage of this command is very powerful, so I limited it only the bot owner.

To use it just type 
-lua \`\`\` some code here\`\`\`

To get the client class from inside the command.
use this line of code: `client = commands.lua.extra.client`

## createTeam

To use this command type `-createTeam "Team Name" @Someone`

Where as words inside the quotation marks will be the team name and the mentioned users will be the members.
You can add multiple members by mentioning more users.

Additionally, you can make a solo team by not mentioning a user e.g. `-createTeam "Team Name"`

## invite

This command invites other people into your team, if you ever forgot to add them using `createTeam`

Usage of the command is `-invite @Someone @AnotherOne`

whereas all the mentioned users will be given the role of your team, and be invited to the category.

Mentioning no one will prompt the message author that they did not mention anyone

## removeTeam

The opposite of createTeam. This command like `prefix` requires the manage guild permission.

To use it simply tag the team roles in the message. You can also put multiple teams to delete in bulk

Example: -removeTeam @Team1 @Team2