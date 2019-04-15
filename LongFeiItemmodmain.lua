--[[
这个文件是mod的主函数，mod里所有的资源，最后都要经过这里传送到游戏里去。其中的内容非常复杂，这里只说些基本的部分，更多的请自己阅读其他人的mod去积累
要设置一个新的Prefab，假设名字为myprefab，则必须要在mymod/scrpits/prefabs下添加一个文件，文件名写成myprefab.lua 然后在modmain.lua的PrefabFiles表内写入”myprefab” 。在给出这个prefab的注释之前，先说一下基本的概念，每个prefab的的结尾，都有类似这样的语句
return Prefab("common/inventory/spear", fn, assets)


Prefab是系统提供的一个创建预设物的函数，第一个参数，最后一个斜杠后填的是你的prefab的名字，而前面那一段，则建议参考同类prefab来填写，比如说长矛是物品栏物品，就是common/inventory，如果是蜘蛛，是怪物，就是common/monster。

第二个参数fn，则是描述这个prefab的主函数，实际上，一个prefab，不管代码写得多长，最后所有的信息，都要集中到这个fn里来处理。所以如果你想了解一个prefab的信息，直接看这个prefab的fn就可以了。第三个，就是所附加的材质了，就是图片，动画之类的东西。
]]

PrefabFiles = { --预设物文件表，你所有自己写的prefab脚本，都必须要在这里添加，才能使用。
"samansha",
"hat_eyeshade",
}

Assets = { --添加材质文件，包括动画啊，图片什么的，都在这里添加。不过在这里只需要添加在modmain函数中会用到的部分，prefab专属的材质文件不需要放在这里。
Asset( "IMAGE","images/saveslot_portraits/samansha.tex" ),
Asset( "ATLAS","images/saveslot_portraits/samansha.xml" ),
}
--[[
其他的，需要注意，modmain运行时，是一个独立的环境，如果需要使用全局变量或常量，如TUNING，SpawnPrefab，都需要添加GLOBAL声明，如：
local TUNING = GLOBAL.TUNING

所有的MOD API，也必须写在这个文件里。
需要注意的是，如果是联机版，API在客机上运行时，有可能会产生错误。建议添加如下指令：
If GLOBAL.TheNet:GetIsServer() then --这一句判断当前电脑是否为主机
API内容
end]]