PrefabFiles = {--同上面的modmain部分，这里不再多解释
"esctemplate",
}


Assets = {--同上面的modmain部分，这里不再多解释
Asset( "IMAGE", "images/saveslot_portraits/esctemplate.tex" ),
Asset( "ATLAS", "images/saveslot_portraits/esctemplate.xml" ),


Asset( "IMAGE", "images/selectscreen_portraits/esctemplate.tex" ),
Asset( "ATLAS", "images/selectscreen_portraits/esctemplate.xml" ),

Asset( "IMAGE", "images/selectscreen_portraits/esctemplate_silho.tex" ),
Asset( "ATLAS", "images/selectscreen_portraits/esctemplate_silho.xml" ),


Asset( "IMAGE", "bigportraits/esctemplate.tex" ),
Asset( "ATLAS", "bigportraits/esctemplate.xml" ),

Asset( "IMAGE", "images/map_icons/esctemplate.tex" ),
Asset( "ATLAS", "images/map_icons/esctemplate.xml" ),

Asset( "IMAGE", "images/avatars/avatar_esctemplate.tex" ),
Asset( "ATLAS", "images/avatars/avatar_esctemplate.xml" ),

Asset( "IMAGE", "images/avatars/avatar_ghost_esctemplate.tex" ),
Asset( "ATLAS", "images/avatars/avatar_ghost_esctemplate.xml" ),


}
--一些预设置的内容。前面说过了，modmain的运行环境是独立于游戏的，要调用游戏的变量/常量，就需要GLOBAL声明。
local require = GLOBAL.require
local STRINGS = GLOBAL.STRINGS


-- 人物选择界面的字符串
STRINGS.CHARACTER_TITLES.esctemplate = "The SampleCharacter" --人物的头衔，就是选择界面头上那一串文字
STRINGS.CHARACTER_NAMES.esctemplate = "Esc" --人物的名字
STRINGS.CHARACTER_DESCRIPTIONS.esctemplate = "*Perk 1\n*Perk2\n*Perk 3" --人物的描述，\n为换行符号，最多填三行。
STRINGS.CHARACTER_QUOTES.esctemplate ="\"Quote\"" --人物的格言

-- 人物的特别话语，就是在检查物品，攻击怪物之类的活动时会说的话。
STRINGS.CHARACTERS.ESCTEMPLATE = require"speech_esctemplate"--话语文件的名字，保存在scipts文件夹下。如果没有的话，可以用默认的speech_wilson

-- 人物在游戏里的名字，与前面显示在选人界面的不同，这个是在游戏里显示的。
STRINGS.NAMES.ESCTEMPLATE = "Esc"

-- 其他人点到这个人物时会说的话，根据不同的状态说不同的话。
STRINGS.CHARACTERS.GENERIC.DESCRIBE.ESCTEMPLATE =
{
GENERIC = "It'sEsc!",
ATTACKER = "That Esclooks shifty...",
MURDERER ="Murderer!",
REVIVER = "Esc, friend ofghosts.",
GHOST = "Esc could use aheart.",
}

--添加小地图图标
AddMinimapAtlas("images/map_icons/esctemplate.xml")

-- 添加人物到游戏中，第一个是人物的名字，第二个是性别，男为male,女为female，无性可以不填。
AddModCharacter("esctemplate","FEMALE")