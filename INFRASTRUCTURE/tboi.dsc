boi_roomentry:
  type: world
  debug: false
  events:
    on player enters warp_*:
	- if <player.gamemode> == SPECTATOR:
      - stop
    - if <player.gamemode> == SURVIVAL:
      - kill <player>
      - announce <element[DONT ENTER SERVERBOSS IN SURVIVAL BAD SHIT HAPPENS].color[#FF0000]>
      - determine cancelled
    - if <player.gamemode> == CREATIVE:
      - narrate "entered <context.area.note_name>"
      - narrate "you're in creative, edit this area with <&e>/boiwarplink"
      - stop
	- if <player.gamemode> == ADVENTURE:
	  - if !<context.area.has_flag[warp_spot]>:
        - announce <element[Warp brush is missing teleport exit!].color[#FF00FF]>
		- stop
	  - teleport <player> <context.area.flag[warp_spot]>
	  - playsound at:<context.area.flag[warpspot]> sound:entity.enderman.teleport pitch:1 volume:2
    on player enters dev_warp_*:
	- if <player.gamemode> == SPECTATOR:
      - stop
	- else:
	  - if !<context.area.has_flag[warp_spot]>:
        - announce <element[Warp brush is missing teleport exit!].color[#FF00FF]>
		- stop
	  - teleport <player> <context.area.flag[warp_spot]>
	  - playsound at:<context.area.flag[warpspot]> sound:entity.enderman.teleport pitch:1 volume:2
      - stop
    - if <player.gamemode> == CREATIVE:
      - narrate "entered <context.area.note_name>"
      - narrate "you're in creative, edit this area with <&e>/boiwarplink"
    on delta time secondly:
    - foreach <server.online_players>:
      - if <[value].last_damage.duration> == d@0s:
        - adjust <[value]> max_no_damage_duration:20t
    on player respawns:
    - define playaspawn <player>
    - if <server.online_players.filter_tag[<[filter_value].gamemode.is[==].to[ADVENTURE]>].filter_tag[<[filter_value].health.is_more_than[1]>].filter_tag[<[filter_value].flag[tethering].if_null[nah].is[==].to[<player.flag[tethering].if_null[nah]>]>].exclude[<[playaspawn]>]||0> != 0:
      - cast <[playaspawn]> damage_resistance duration:100t amplifier:126 no_icon hide_particles no_ambient
      - determine <server.online_players.filter_tag[<[filter_value].gamemode.is[==].to[ADVENTURE]>].filter_tag[<[filter_value].health.is_more_than[1]>].filter_tag[<[filter_value].flag[tethering].if_null[nah].is[==].to[<player.flag[tethering].if_null[nah]>]>].exclude[<[playaspawn]>].random.location> passively
    on tick every:5:
    - foreach <server.list_online_players>:
      - if <[value].item_in_hand.material.name> == structure_void:
        - foreach <[value].eye_location.find_blocks[structure_void].within[20]> as:svoids:
#.filter_tag[<[filter_value].block.center.line_of_sight[<[value].eye_location>]>]
          - playeffect at:<[svoids].block.center> effect:redstone quantity:1 offset:0 special_data:2|<color[#008080]> visibility:100 targets:<[value]> velocity:<location[0,0,0]>
        - foreach <[value].eye_location.find_blocks_flagged[unspawnable].within[20]> as:svoids:
#.filter_tag[<[filter_value].block.center.line_of_sight[<[value].eye_location>]>]
          - playeffect at:<[svoids].block.center> effect:redstone quantity:1 offset:0 special_data:2|<color[#800080]> visibility:100 targets:<[value]> velocity:<location[0,0,0]>
    on player damaged by FALL in:drop_*:
    - determine cancelled passively
	- playeffect at:<player.location> effect:BLOCK_CRACK special_data:<player.location.block.below[1].material> quantity:100 offset:<location[1,0,1]> visibility:100
	- playsound sound:entity_zombie_break_wooden_door at:<player.location> pitch:1 volume:2
	- cast <player> SLOW duration:40t amplifier:3 no_icon no_ambient hide_particles
    on player enters kill_*:
    - if <player.gamemode> == ADVENTURE:
      - kill <player>
    on player enters deny_*:
    - if <player.gamemode> == ADVENTURE:
      - define slingshot <context.to.sub[<context.from>].with_y[0].normalize.mul[-0.5].with_y[0.25]>
#      - announce <[slingshot]>
#      - adjust <player> velocity:<location[1,1,1]>
#      - determine cancelled passively
      - wait 1t
      - adjust <player> velocity:<[slingshot]>
    on player enters trigger_once_*:
    - if <player.flag[boi_enteredrooms].contains[<context.area.note_name>]||false>:
      - stop
    - define relayblocks <context.area.expand[5].blocks[yellow_glazed_terracotta].filter_tag[<[filter_value].flag[gearbox].is[==].to[trigger_relay].if_null[false]>]||0>
    - flag <player> boi_enteredrooms:->:<context.area.note_name>
    - foreach <server.online_players.filter_tag[<[filter_value].gamemode.is[==].to[ADVENTURE]>].filter_tag[<[filter_value].health.is_more_than[1]>].filter_tag[<[filter_value].flag[tethering].if_null[nah].is[==].to[<player.flag[tethering].if_null[nah]>]>].exclude[<player>]||0>:
      - flag <[value]> boi_enteredrooms:->:<context.area.note_name>
    - foreach <[relayblocks]>:
      - modifyblock <[value]> redstone_block
    - wait 10t
    - foreach <[relayblocks]>:
      - modifyblock <[value]> yellow_glazed_terracotta
    on player enters trigger_multiple_*:
    - define relayblocks <context.area.expand[5].blocks_flagged[gearbox].filter_tag[<[filter_value].flag[gearbox].is[==].to[trigger_relay].if_null[false]>]||0>
    - foreach <[relayblocks]>:
      - modifyblock <[value]> redstone_block
    on player exits trigger_multiple_*:
    - define relayblocks <context.area.expand[5].blocks_flagged[gearbox].filter_tag[<[filter_value].flag[gearbox].is[==].to[trigger_relay].if_null[false]>]||0>
    - foreach <[relayblocks]>:
      - modifyblock <[value]> yellow_glazed_terracotta
    on player enters secret_*:
    - if <player.flag[boi_enteredrooms].contains[<context.area.note_name>]||false>:
      - stop
    - if <player.gamemode> == ADVENTURE:
      - playsound sound:custom.secret pitch:1 volume:2 at:<player.eye_location> custom
      - flag <player> actionbarmode:secrets expire:40t
      - flag <player> secretsfound:++
      - flag <player> boi_enteredrooms:->:<context.area.note_name>
    on player enters room_*:
    - if <player.gamemode> == SPECTATOR:
      - stop
    - if <player.gamemode> == SURVIVAL:
      - kill <player>
      - announce <element[DONT ENTER SERVERBOSS IN SURVIVAL BAD SHIT HAPPENS].color[#FF0000]>
      - determine cancelled
    - if <player.gamemode> == CREATIVE:
       - narrate "entered <context.area.note_name>"
       - narrate "you're in creative, edit this area with <&e>/boiroommobs"
       - stop
#    - narrate "entered <context.area.note_name>"
    - if <context.area.has_flag[backtrace]>:
      - if !<player.flag[boi_enteredrooms].contains[<context.area.flag[backtrace]>]||false>:
        - stop
    - if !<context.area.has_flag[mobs]>:
#      - narrate "<&7>this room is not set up to have mobs, not doing anything."
      - stop
    - if <player.flag[boi_enteredrooms].contains[<context.area.note_name>]||false>:
      - stop
    - else:
      - foreach <server.online_players.filter_tag[<[filter_value].gamemode.is[==].to[ADVENTURE]>].filter_tag[<[filter_value].flag[tethering].if_null[nah].is[==].to[<player.flag[tethering].if_null[nah]>]>]>:
        - flag <[value]> boi_enteredrooms:->:<context.area.note_name>
      - foreach <server.online_players.filter_tag[<[filter_value].gamemode.is[==].to[ADVENTURE]>].filter_tag[<[filter_value].flag[tethering].if_null[nah].is[==].to[<player.flag[tethering].if_null[nah]>]>].exclude[<player>]>:
        - teleport <[value]> <player.location>
      - wait 20t
      - playsound <player.eye_location> sound:block_note_block_digeridoo pitch:0 volume:2
      - playsound <player.eye_location> sound:custom.reload_error pitch:0 volume:2 custom
      - foreach <context.area.expand[35].blocks[*_door]> as:door:
        - if <[door].material.half> == BOTTOM:
          - switch <[door]> off
      - foreach <context.area.expand[35].blocks[*moving_piston]> as:ffield:
         - modifyblock <[ffield]> pink_stained_glass
      - foreach <context.area.expand[35].blocks_flagged[waterseal]> as:ffield:
         - modifyblock <[ffield]> blue_stained_glass
         - flag <[ffield]> waterseal:!
      - wait 20t
      - foreach <context.area.flag[mobs]> as:amob:
        - define spawnloc <context.area.blocks[*air|*water].filter_tag[<list[air|water|structure_void|fire].contains_any[<[filter_value].sub[0,1,0].block.material.name>].not>].filter_tag[<[filter_value].has_flag[unspawnable].not>].filter_tag[<[filter_value].block.material.name.is[==].to[void_air].not>].filter_tag[<[filter_value].block.material.name.is[==].to[structure_void].not>].filter_tag[<[filter_value].sub[0,1,0].block.material.name.is[==].to[lava].not>].random.center>
        - spawn <[amob]> <[spawnloc]> save:mobflagging
        - define 4coinproj <entry[mobflagging].spawned_entities.get[1]>
        - wait 1t
        - flag <[4coinproj]> arenamob:<context.area.note_name>
        - playeffect effect:explode at:<[spawnloc]> quantity:32 offset:0.5 visibility:100
        - playsound sound:BLOCK_NOTE_BLOCK_PLING pitch:2 volume:2 at:<[spawnloc]>
        - light <[spawnloc]> 15 duration:10t
        - wait 5t
    on player dies:
    - if <server.online_players.filter_tag[<[filter_value].gamemode.is[==].to[ADVENTURE]>].filter_tag[<[filter_value].flag[tethering].if_null[nah].is[==].to[<player.flag[tethering].if_null[nah]>]>].exclude[<player>].size> == 0:
      - flag <player> boi_enteredrooms:!
      - foreach <player.location.cuboids[room_*].get[1].expand[65].living_entities.filter_tag[<[filter_value].is_player.not>]>:
        - kill <[value]>
      - foreach <context.area.expand[35].blocks_flagged[unlockedblock]> as:ffield:
        - modifyblock <[ffield]> <[ffield].flag[unlockedblock]>
        - flag <[ffield]> unlockedblock:!
      - stop
    - else:
      - wait 10t
      - teleport <player> <server.online_players.filter_tag[<[filter_value].gamemode.is[==].to[ADVENTURE]>].filter_tag[<[filter_value].flag[tethering].if_null[nah].is[==].to[<player.flag[tethering].if_null[nah]>]>].exclude[<player>].random||0>
    on !player dies:
    - define ourarea <context.entity.flag[arenamob]||0>
    - if <[ourarea]> == 0:
      - stop
    - define deathplaxe <context.entity.location>
#    - foreach <context.entity.eye_location.find.living_entities.within[70].exclude[<context.entity>]>:
#      - announce <[value].flag[arenamob]||0>
    - if <context.entity.eye_location.find.living_entities.within[70].filter_tag[<[filter_value].flag[arenamob].is[=].to[<[ourarea]>]>].filter_tag[<[filter_value].health.is_less_than_or_equal_to[0].not>].exclude[<context.entity>].filter_tag[<[filter_value].script.name.is[==].to[shadowman].not.if_null[true]>].size> == 0:
      - wait 20t
      - define value <cuboid[<[ourarea]>]>
      - foreach <[value].expand[35].blocks[*_door]> as:door:
        - if <[door].material.half> == BOTTOM && <[door].sub[0,2,0].material.name> != BEDROCK:
          - switch <[door]> on
          - playsound <[door]> sound:block_iron_door_open volume:2
      - foreach <[value].expand[35].blocks[*pink_stained_glass]> as:ffield:
        - modifyblock <[ffield]> moving_piston
      - foreach <[value].expand[35].blocks[blue_stained_glass]> as:ffield:
        - flag <[ffield]> waterseal
        - modifyblock <[ffield]> water
      - foreach <[value].expand[35].blocks_flagged[powblocked]> as:ffield:
        - modifyblock <[ffield]> blue_glazed_terracotta
        - flag <[ffield]> powblocked:!
      - playsound <[deathplaxe]> sound:block_note_block_bell pitch:0 volume:2
      - playsound <[deathplaxe]> sound:block_note_block_bell pitch:1 volume:2
      - playsound <[deathplaxe]> sound:block_note_block_bell pitch:2 volume:2
      - playsound <[deathplaxe]> sound:block_bell_use pitch:0 volume:2
      - playsound <[deathplaxe]> sound:block_bell_use pitch:1 volume:2
      - playsound <[deathplaxe]> sound:block_bell_use pitch:2 volume:2
      - playsound <[deathplaxe]> sound:entity_wither_ambient pitch:0 volume:2

boi_roommarker:
    debug: false
    type: command
    name: boiroommobs
    description: it does a thing
    aliases:
    - brm
    tab completions:
        1: show|add|remove|wipe|backtrace|normalize
        2: <server.entity_types>
    usage: /boiroommobs
    script:
    - if <player.location.cuboids[room_*|warp_*].size> != 1:
        - narrate "You're not standing in a valid location!<&nl>Expected 1 cuboid, found <player.location.cuboids[room_*|warp*].size>"
        - stop
    - else:
        - if <context.args.get[1]> == show:
            - narrate <player.location.cuboids[room_*].get[1].flag[mobs]||nothing>
            - stop
        - if <context.args.size> != 2:
            - narrate "Invalid number of arguments (needs 2)"
            - stop
        - if <context.args.get[1]> == add:
            - flag <player.location.cuboids[room_*].get[1]> mobs:->:<context.args.get[2]>
            - narrate ok
            - narrate <player.location.cuboids[room_*].get[1].flag[mobs]||nothing>
        - if <context.args.get[1]> == remove:
            - flag <player.location.cuboids[room_*].get[1]> mobs:<-:<context.args.get[2]>
            - narrate ok
            - if <player.location.cuboids[room_*].get[1].flag[mobs].size> <= 0:
                - flag <player.location.cuboids[room_*].get[1]> mobs:!
            - narrate <player.location.cuboids[room_*].get[1].flag[mobs]||nothing>
        - if <context.args.get[1]> == wipe:
            - flag <player.location.cuboids[room_*].get[1]> mobs:!
            - narrate wiped encounter
        - if <context.args.get[1]> == backtrace:
            - flag <player.location.cuboids[room_*].get[1]> backtrace:<context.args.get[2]>
            - narrate linked encounter <player.location.cuboids[room_*].get[1]> to <context.args.get[2]>
        - if <context.args.get[1]> == normalize:
            - flag <player.location.cuboids[room_*].get[1]> backtrace:!
            - narrate removed links from <player.location.cuboids[room_*].get[1]>


boi_roomlink:
    debug: false
    type: command
    name: boiwarplink
    description: it does a thing
    aliases:
	- bwl
	tab completions:
        1: link|exit
    usage: /boiwarplink
	script:
	- if <context.args.get[1]> == link:
	  - if <player.has_flag[link]>:
	    - flag <player> link:!
	    - narrate "cancelled linking!"
		- stop
      - flag <player> link:<player.location.cuboids[warp_*|dev_warp_*].get[1]||nothing>
      - narrate "started linking brush <player.flag[link].note_name>"
    - if <context.args.get[1]> == exit:
	  - define locset <player.location>
	  - flag <player.flag[link]> warp_spot:<[locset]>
      - narrate "linked brush <player.flag[link].note_name> to <[locset].x.round_to_precision[<0.01>]>, <[locset].y.round_to_precision[<0.01>]>, <[locset].z.round_to_precision[<0.01>]>!"
      - flag <player> link:!

sever:
    debug: false
    type: command
    name: sever
    description: it does a thing
    usage: /sever
    script:
    - announce <element[Severed everyone!].color[#FF0080]>
    - foreach <server.online_players>:
      - flag <[value]> tethering:<[value]>
      - playsound sound:ENTITY_SHEEP_SHEAR at:<[value].eye_location> volume:1.5 pitch:0
      - playsound sound:ENTITY_SHEEP_SHEAR at:<[value].eye_location> volume:1.5 pitch:1
      - playsound sound:ENTITY_SHEEP_SHEAR at:<[value].eye_location> volume:1.5 pitch:2

showstructurevoids:
    debug: false
    type: command
    name: showstructurevoids
    description: it does a thing
    aliases:
    - ssv
    usage: /showstructurevoids [radius]
    script:
    - foreach <player.location.find_blocks_flagged[unspawnable].within[<context.args.get[1]>]>:
      - flag <[value]> unspawnable:!
      - modifyblock <[value]> structure_void

hidestructurevoids:
    debug: false
    type: command
    name: hidestructurevoids
    description: it does a thing
    aliases:
    - hsv
    usage: /hidestructurevoids [radius]
    script:
    - foreach <player.location.find_blocks[structure_void].within[<context.args.get[1]>]>:
      - flag <[value]> unspawnable
      - modifyblock <[value]> air

tether:
    debug: false
    type: command
    name: tether
    description: it does a thing
    usage: /tether
    script:
    - define id <element[<util.random.int[0].to[9]><util.random.int[0].to[9]><util.random.int[0].to[9]><util.random.int[0].to[9]><util.random.int[0].to[9]><util.random.int[0].to[9]>]>
    - foreach <player.location.find_players_within[<context.args.get[1]>]>:
      - flag <[value]> tethering:<[id]>
      - announce <element[Tethered <[value].display_name> to code ]><element[<[id]>].color[#FFC0FF]>
      - playsound sound:ITEM_FLINTANDSTEEL_USE at:<[value].eye_location> volume:1.5 pitch:2
      - playsound sound:ITEM_FLINTANDSTEEL_USE at:<[value].eye_location> volume:1.5 pitch:1
      - playsound sound:ITEM_FLINTANDSTEEL_USE at:<[value].eye_location> volume:1.5 pitch:0
    

boi_progressclear:
    debug: false
    type: command
    name: boiclearprogress
    description: it does a thing
    aliases:
    - bcp
    usage: /boiclearprogress
    script:
    - flag <player> secretsfound:!
    - flag <player> boi_enteredrooms:!
    - flag <player> gennedchests:!
    - narrate "cleared all visited rooms flag"

healxp:
  type: world
  debug: false
  events:
    on tick:
    - foreach <server.online_players>:
      - if <[value].calculate_xp> > 0 && <[value].health> < <[value].health_max>:
        - experience take player:<[value]> 1
        - cast <[value]> regeneration amplifier:2 duration:2t no_icon hide_particles no_ambient
        - heal <[value]> 1
    on tick every:5:
    - foreach <server.online_players>:
      - if <[value].calculate_xp> > 0 && <[value].health> >= <[value].health_max>:
        - experience take player:<[value]> 1