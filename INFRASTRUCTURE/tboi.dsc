boi_roomentry:
  type: world
  debug: false
  events:
    on player respawns:
    - define playaspawn <player>
    - if <server.online_players.filter_tag[<[filter_value].gamemode.is[==].to[ADVENTURE]>].filter_tag[<[filter_value].health.is_more_than[1]>].exclude[<[playaspawn]>]||0> != 0:
      - cast <[playaspawn]> damage_resistance duration:100t amplifier:126 no_icon hide_particles no_ambient
      - determine <server.online_players.filter_tag[<[filter_value].gamemode.is[==].to[ADVENTURE]>].filter_tag[<[filter_value].health.is_more_than[1]>].exclude[<[playaspawn]>].random.location> passively
    on tick every:5:
    - foreach <server.list_online_players>:
      - if <[value].item_in_hand.material.name> == structure_void:
        - foreach <[value].eye_location.find_blocks[structure_void].within[20]> as:svoids:
#.filter_tag[<[filter_value].block.center.line_of_sight[<[value].eye_location>]>]
          - playeffect at:<[svoids].block.center> effect:redstone quantity:1 offset:0 special_data:2|<color[#008080]> visibility:100 targets:<[value]> velocity:<location[0,0,0]>
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
    - if !<context.area.has_flag[mobs]>:
#      - narrate "<&7>this room is not set up to have mobs, not doing anything."
      - stop
    - if <player.flag[boi_enteredrooms].contains[<context.area.note_name>]||false>:
      - stop
    - else:
      - foreach <server.online_players.filter_tag[<[filter_value].gamemode.is[==].to[ADVENTURE]>]>:
        - flag <[value]> boi_enteredrooms:->:<context.area.note_name>
      - foreach <server.online_players.filter_tag[<[filter_value].gamemode.is[==].to[ADVENTURE]>].exclude[<player>]>:
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
        - define spawnloc <context.area.blocks[*air|*water].filter_tag[<list[air|water].contains_any[<[filter_value].sub[0,1,0].block.material.name>].not>].filter_tag[<[filter_value].block.material.name.is[==].to[structure_void].not>].filter_tag[<[filter_value].sub[0,1,0].block.material.name.is[==].to[lava].not>].random.center>
        - spawn <[amob]> <[spawnloc]> save:mobflagging
        - define 4coinproj <entry[mobflagging].spawned_entities.get[1]>
        - wait 1t
        - flag <[4coinproj]> arenamob:<context.area.note_name>
        - playeffect effect:explode at:<[spawnloc]> quantity:32 offset:0.5 visibility:100
        - playsound sound:BLOCK_NOTE_BLOCK_PLING pitch:2 volume:2 at:<[spawnloc]>
        - light <[spawnloc]> 15 duration:10t
        - wait 5t
    on player dies:
    - if <server.online_players.filter_tag[<[filter_value].gamemode.is[==].to[ADVENTURE]>].exclude[<player>].size> == 0:
      - flag <player> boi_enteredrooms:!
      - foreach <player.location.cuboids[room_*].get[1].expand[65].living_entities.filter_tag[<[filter_value].is_player.not>]>:
        - kill <[value]>
      - foreach <context.area.expand[35].blocks_flagged[unlockedblock]> as:ffield:
        - modifyblock <[ffield]> <[ffield].flag[unlockedblock]>
        - flag <[ffield]> unlockedblock:!
      - stop
    - else:
      - wait 10t
      - teleport <player> <server.online_players.filter_tag[<[filter_value].gamemode.is[==].to[ADVENTURE]>].random||0>
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
    tab completions:
        1: show|add|remove
        2: <server.entity_types>
    usage: /boiroommobs
    script:
    - if <player.location.cuboids[room_*].size> != 1:
        - narrate "You're not standing in a valid location!<&nl>Expected 1 cuboid, found <player.location.cuboids[room_*].size>"
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


boi_progressclear:
    debug: false
    type: command
    name: boiclearprogress
    description: it does a thing
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