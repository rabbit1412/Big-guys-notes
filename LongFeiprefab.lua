local assets=
{
Asset("ANIM", "anim/spear.zip"),--加载长矛 放在地面状态的 动画
Asset("ANIM", "anim/swap_spear.zip"),--加载长矛 拿在手上的动画
}


local function onfinished(inst)
inst:Remove()--耐久用完后，移除长矛这个物体
end


local function onequip(inst, owner) 
owner.AnimState:OverrideSymbol("swap_object", "swap_spear", "swap_spear")--装备长矛后，持有者的状态 加上长矛的状态，第一个参数是对应持有武器的手的位置，第二个参数是动画的build名称，第三个参数是动画的bank名称
owner.AnimState:Show("ARM_carry") --装备长矛后，持有者 持有之手 显示出来
owner.AnimState:Hide("ARM_normal") --装备长矛后，持有者 空闲之手 隐藏 （在动画里，持有手 和 空闲手 是 在一起的，根据不同的情况 来选择 谁隐藏 谁显示）
end


local function onunequip(inst, owner) 
owner.AnimState:Hide("ARM_carry") --卸下长矛后，持有者 持有之手 隐藏
owner.AnimState:Show("ARM_normal") ----卸下长矛后，持有者 空闲之手 显示（原理同上）
end




local function fn(Sim)
local inst = CreateEntity()--定义inst这个变量，初始化，创造这个物体，变量名为inst
local trans = inst.entity:AddTransform()--为inst这个实体 增加 Transform 标准组件，Transform负责的是 实体的大小，位置，形状等等。
local anim = inst.entity:AddAnimState()--为inst这个实体 增加 AnimState 标准组件, AnimState负责 实体 的 动画效果，颜色滤镜等等。
MakeInventoryPhysics(inst)--这个定义的是inst这个实体 的 物理系统， 这个标准组建参考 scripts/standardcomponents.lua，里面有队友各个Make啥啥啥Physics函数的定义

anim:SetBank("spear")--动画效果 的 bank名称，bank就是 动画模板的 轮廓，控制的是 动画中 所有对应像素 的范围和边界（我只能理解到这一步）
--本文作者附言：现在新增加的理解是，bank还控制着所有的动画。


anim:SetBuild("spear")--动画效果 的 build名称，build就是 动画 的模型，比如长矛的 具体像素分布，即长矛长啥样 （注意，这句话和前一句话指的是 长矛放在地面的状态，拿在手上的状态看前面 装备长矛后 的注释）
anim:PlayAnimation("idle")--动画效果初始化，比如长矛出现时 第一眼是什么动画， 就是"idle"这个静止状态，关于动画的话，在data/anim文件夹内有 各种zip文件，需要用ktools转换成spriter可以查看的scml文件，从scml文件的动画列表里就有各种动画状态，比如“idle”就是之一

inst:AddTag("sharp")--这个是增加“sharp”标签Tag，关于Tag的应用，是方便其他文件或组件进行不同情况的筛选 的作用。在此"sharp"这个Tag目前 我还不知道是什么作用


inst:AddComponent("weapon")--增加 武器 组件，长矛是武器嘛
inst.components.weapon:SetDamage(TUNING.SPEAR_DAMAGE)--设置武器攻击力，里面的TUNING是指 在scripts/tuning.lua里定义了 SPEAR_DAMAGE这个常量的数值。

-------

inst:AddComponent("finiteuses")--增加 有限耐久 组件，长矛作为武器 是有耐久的嘛
inst.components.finiteuses:SetMaxUses(TUNING.SPEAR_USES)--设置 最大耐久
inst.components.finiteuses:SetUses(TUNING.SPEAR_USES)--设置 当前耐久，一般情况下，崭新的长矛的 当前耐久=它的最大耐久， 在有些情况 比如彩蛋里或迷宫里的箱子，不一定是满的耐久

inst.components.finiteuses:SetOnFinished( onfinished ) --设置 长矛用完的时候该怎么办，看看前面定义的 onfinished函数，就是移除长矛。 很多道具耐久用完就 删除本身，但是 矿工帽和 提灯 就不会，就是因为这个函数定义的不同咯。


inst:AddComponent("inspectable")--增加 检阅组件，就是 玩家 检查/查看 长矛，会说对应的 话

inst:AddComponent("inventoryitem") --增加 物品栏物品 组件， 长矛当然可以放在 物品栏或容器里 啦

inst:AddComponent("equippable")--增加 可装备 组件，长矛 当然 装备后才能战斗嘛。
inst.components.equippable:SetOnEquip( onequip ) --装备 长矛后，调用onequip函数，前面有定义
inst.components.equippable:SetOnUnequip( onunequip ) -- 卸下长矛后，调用onunequip函数

return inst --刚开始 local inst = CreateEntity() 这句话只是创建长矛这个物体的开始，通过后面的代码逐渐完善， 直到这句 return inst 就正式说明 长矛这个物体定义完成了！！！
end


return Prefab( "common/inventory/spear", fn, assets) -- return inst 之后 并不能 把定义好的 长矛 归为 游戏正规的物品啊，那么 这句话 return Prefab 就是把长矛这个物体 加载完成，fn是定义长矛的主函数，assets是长矛的材质

附言：在联机版中，还需要在fn函数体中加入如下代码
inst.entity:AddNetwork() --添加网络变量，如果你想要你的prefab被其他人看到的话必须添加
if not TheWorld.ismastersim then --这个判断是否是主机，因为这些信息只在主机上运行计算，计算好之后再把信息传递到客机上。
return inst 
end
inst.entity:SetPristine()--字面意思是设置初始化，具体什么用途我还没搞清楚，但几乎每个联机版的prefab都有这句话。