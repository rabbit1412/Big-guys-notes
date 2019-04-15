local MakePlayerCharacter = require "prefabs/player_common"
--读取游戏里创建人物的文件player_common的信息，
--需要注意的是，MakePlayerCharacter函数，单机和联机不同，单机只有一个fn，而联机有common_postinit,和master_postinit，前者是说要主机、客机都要执行的，后者是只在主机上执行的。对没有编程基础的人来说，要判断这个是比较困难的，只需要知道，大部分时候，全部写在主机执行的部分是没错的。除了像地图图标之类的，需要客机也接收的信息才会写在客机执行部分。还有某些特殊的情况，比如按键触发的，也需要些在客机执行里，否则客机无法执行按键触发)
--MakePlayerCharacter本身是内置了Prefab的，实际上人物创建是也是一个Prefab的创建，但官方把很多常用的内容都打包起来了，我们只需要在官方的基础上添加自己的内容，节约了我们编写代码的时间。


local assets = { --一系列的材质文件，注意你自己的文件添加在最下面。

Asset("ANIM", "anim/player_basic.zip" ),
Asset("ANIM", "anim/player_idles_shiver.zip" ),
Asset("ANIM", "anim/player_actions.zip" ),
Asset("ANIM", "anim/player_actions_axe.zip" ),
Asset("ANIM", "anim/player_actions_pickaxe.zip" ),
Asset("ANIM", "anim/player_actions_shovel.zip" ),
Asset("ANIM", "anim/player_actions_blowdart.zip" ),
Asset("ANIM", "anim/player_actions_eat.zip" ),
Asset("ANIM", "anim/player_actions_item.zip" ),
Asset("ANIM", "anim/player_actions_uniqueitem.zip" ),
Asset("ANIM", "anim/player_actions_bugnet.zip" ),
Asset("ANIM", "anim/player_actions_fishing.zip" ),
Asset("ANIM", "anim/player_actions_boomerang.zip" ),
Asset("ANIM", "anim/player_bush_hat.zip" ),
Asset("ANIM", "anim/player_attacks.zip" ),
Asset("ANIM", "anim/player_idles.zip" ),
Asset("ANIM", "anim/player_rebirth.zip" ),
Asset("ANIM", "anim/player_jump.zip" ),
Asset("ANIM", "anim/player_amulet_resurrect.zip" ),
Asset("ANIM", "anim/player_teleport.zip" ),
Asset("ANIM", "anim/wilson_fx.zip" ),
Asset("ANIM", "anim/player_one_man_band.zip" ),
Asset( "ANIM","anim/shadow_hands.zip" ),
Asset("SOUND", "sound/sfx.fsb" ),
Asset("SOUND", "sound/wilson.fsb" ),
Asset("ANIM", "anim/beard.zip" ),

Asset("ANIM", "anim/esctemplate.zip" ),---这就是我们要自己添加的材质，比如说人物的图像以及一些特殊的动画都添加在这下面，上面的部分请不要动。
Asset("ANIM", "anim/ghost_esctemplate_build.zip" ),
}


--在定义这个人物时，会用到的prefab，比如说你想给人物在某些时候添加prefab特效，就需要把那个特效的名字填在这里
local prefabs = {}

-- 开局物品，注意，如果要给多个同一物品，需要多次填写，同上，需要用逗号隔开。
local start_inv = {


}

-- 当这个人物恢复成人的时候执行这个函数
local function onbecamehuman(inst)
--设置人物的移动和跑动速度（在道路上的时候）
inst.components.locomotor.walkspeed= 4
inst.components.locomotor.runspeed= 6
end

-- 当读取游戏或者生成这个人物的时候执行这个函数
local function onload(inst)
inst:ListenForEvent("ms_respawnedfromghost", onbecamehuman) 监听从幽灵状态复活成人的事件，一旦监听到就触发onbecamehuman
if notinst:HasTag("playerghost") then
onbecamehuman(inst)
end
end


-- 这个函数会在主机和客机上都执行，标签可以添在这里
local common_postinit = function(inst)
--添加小地图图标
inst.MiniMapEntity:SetIcon("esctemplate.tex" )
end

-- 这个函数只在主机上执行，大多数组件都添加在这里
local master_postinit = function(inst)
--选择你的人物的声音（可以选择自己导入的，关于声音的导入请参考klei论坛的教程）
inst.soundsname= "willow"
--如果选择韦伯或者女武神的声音，就需要添加这一条，去掉前面的--
--inst.talker_path_override = "dontstarve_DLC001/characters/"


--设置人物的初始三围
inst.components.health:SetMaxHealth(150)
inst.components.hunger:SetMax(150)
inst.components.sanity:SetMax(200)

--设置伤害系数
inst.components.combat.damagemultiplier = 1

--设置饥饿倍率
inst.components.hunger.hungerrate=1*TUNING.WILSON_HUNGER_RATE
--设置读取存档和新生成人物时执行的函数，用于保存信息等，是中级的内容，此处不讲解。 
inst.OnLoad = onload
inst.OnNewSpawn = onload
end
--返回MakePlayerCharacter，完成人物创建。
return MakePlayerCharacter("esctemplate", prefabs, assets, common_postinit,master_postinit, start_inv)