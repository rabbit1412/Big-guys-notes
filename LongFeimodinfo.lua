name = "[DST]Samansha" --mod的名字
description = "The princess of Elf"---mod的描述
author = "dangdang"--mod的作者
version = "1.0" -- Mod的版本，当你在创意工坊要想更新MOD的时候，版本必须不一样。
forumthread = "" klei论坛的下载地址，没有可以不写。

api_version = 10 --API版本，当前而言，联机版填10，单机版填6

dst_compatible = true --以下几个参数都是设置是否兼容的，第一个是联机版，后面三个分别是单机原版，巨人统治和海难
dont_starve_compatible = false
reign_of_giants_compatible = false
shipwrecked_compatible = false

all_clients_require_mod = true --联机版特有，当你要加入自己设计的图画的时候，必须在这一项填true
client_only_mod = false --联机版特有，是否为客户端mod，如果填了true，上面的必须填false。
icon_atlas = "modicon.xml" --以下两项控制mod的图标
icon = "modicon.tex"


server_filter_tags = {"Samansha",}--服务器标签，加载了这个mod的房间/服务器，会在房间信息的标签栏里显示相应的标签信息。

configuration_options = {} --mod设置，没有可以不写，