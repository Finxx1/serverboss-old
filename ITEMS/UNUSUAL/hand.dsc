THEHAND2:
  type: item
  display name: <element[「The Hand」].color_gradient[from=#0000ff;to=#FFFFFF]>
  material: gold_ingot
  enchantments:
  - damage_all:1
  mechanisms:
    custom_model_data: 13371999
    hides:
    - ALL
  lore:
  - <element[-= Scrapes and erases the fabric of space =-].color_gradient[from=#000080;to=#808080]>
  - 
  - <element[UNUSUAL].color[#9040C0].bold>

TheHandWorld2:
  type: world
  debug: false
  events:
    on player damages entity priority:-1:
      - if <context.cause> == entity_attack && <player.item_in_hand.script.name||null> == THEHAND2 && <context.entity.has_flag[ded].not>:
        - determine cancelled passively
    on player right clicks block with:THEHAND2:
      - if <context.click_type> == PHYSICAL:
        - stop
      - determine cancelled passively
      - define tpmode yes
      - run TheHandScript2 def:<[tpmode]>
    on player left clicks block with:THEHAND2:
      - if <context.click_type> == PHYSICAL:
        - stop
      - determine cancelled passively
      - define tpmode false
      - run TheHandScript2 def:<[tpmode]>

thehandcooldown2:
  type: task
  debug: false
  speed: 0
  script:
  - flag <player> thehandcooldown2 duration:6s
  - itemcooldown gold_ingot duration:6s

thehandcooldown3:
  type: task
  debug: false
  speed: 0
  script:
  - flag <player> thehandcooldown2 duration:1s
  - itemcooldown gold_ingot duration:1s

TheHandScript2:
  type: task
  debug: false
  speed: 0
  script:
  - if <player.has_flag[thehandcooldown2]>:
    - playsound <player> sound:UI_BUTTON_CLICK
    - stop
  - define tpmode <[1]>
  - if <[tpmode]> == yes:
    - run thehandcooldown3
  - else:
    - run thehandcooldown2
  - if <[tpmode]> == yes:
    - flag <player> thehanduse2 duration:0.25s
  - else:
    - flag <player> thehanduse2 duration:0.5s
  - playsound <player.location> sound:BLOCK_NOTE_BLOCK_DIDGERIDOO pitch:0 volume:3
  - while <player.has_flag[thehanduse2]>:
    - if <player.eye_location.ray_trace[range=2.4;return=block]||null> == null:
      - define locs:->:<player.eye_location.forward[2].add[<[locs].last>].div[2]>
      - define locs:->:<player.eye_location.forward[2]>
    - else:
      - define locs:->:<player.eye_location.ray_trace[range=2.4;return=block].add[<[locs].last>].div[2]>>
      - define locs:->:<player.eye_location.ray_trace[range=2.4;return=block]>
    - playeffect at:<[locs].last> effect:REDSTONE special_data:1|blue quantity:15 offset:0.1,0.1,0.1
    - wait 1t
  - waituntil !<player.has_flag[thehanduse2]>
  - if <server.online_players_flagged[theworld].is_empty.not>:
    - waituntil <server.online_players_flagged[theworld].is_empty>
  - wait 1t
  - define sizehalf <[locs].size.div[2].round>
  - define middleloc1 <[locs].get[<[sizehalf]>]>
  - if <[tpmode]> == yes:
    - define middleloc2 <[middleloc1].with_pose[<player>]>
    - define middleloc <[middleloc2].forward>
    - define velocity <player.location.backward[2].face[<[middleloc]>].direction.vector.with_y[<player.location.face[<[middleloc]>].direction.vector.y.div[4]>]>
    - teleport <player> <[middleloc]>
    - adjust <player> velocity:<[velocity]>
  - if <[tpmode]> == yes:
    - playsound <[middleloc1]> sound:custom.hand_short pitch:1 v:4 custom
  - else:
    - playsound <[middleloc1]> sound:custom.hand pitch:1 v:4 custom
  - foreach <[locs]> as:loc:
    - repeat <[locs].size>:
      - playeffect at:<[loc]> effect:REDSTONE special_data:2.4|<color[#<list[4000|0080].random>FF]> quantity:1 offset:0.15
#      - playsound <[loc]> sound:BLOCK_NOTE_BLOCK_DIDGERIDOO pitch:0 volume:3
#      - playsound <[loc]> sound:BLOCK_NOTE_BLOCK_BASS pitch:0 volume:3
#      - playsound <[loc]> sound:BLOCK_NOTE_BLOCK_BASS_DRUM pitch:0 volume:3
    - define entities <[loc].find_entities.within[2].exclude[<player>]>
    - foreach <[entities]> as:entity:
      - if <[entity].is_npc>:
        - if <[entity].has_flag[user]>:
          - define player <[entity].flag[user]>
          - flag <[player]> standentity:!
          - flag <[player]> standsummoned:false
          - remove <[entity]>
          - run thehandplayererasure2 def:<[player]>
        - else:
          - hurt 20 <[entity]> source:<player>
          - wait 1t
          - despawn <[entity]>
      - if <[entity].is_player>:
        - run thehandplayererasure2 def:<[entity]>
      - if <[entity].is_player.not> && <[entity].is_npc.not> && <[tpmode].is[!=].to[yes]>:
        - adjust <[entity]> remove_effects
        - if <[entity].health.sub[<element[30].div[<[entities].size>]>]> <= 0:
          - remove <[entity]>
        - else:
          - hurt <element[30].div[<[entities].size>]> <[entity]>
        #- remove <[entity]>
    #- define blocks <[loc].find_blocks.within[1.5].filter[material.name.is[!=].to[air]]>
    #- foreach <[blocks]> as:block:
    #  - if <[block].is_within[boxofbadaround]>:
    #    - foreach next
    #  - if <[block].is_within[superflatspawn]>:
    #    - foreach next
    #  - modifyblock <[block]> air source:<player>

thehandplayererasure2:
  type: task
  debug: false
  speed: 0
  definitions: player
  script:
  - if <[player].god_mode>:
    - adjust <[player]> god_mode:false
    - define god true
  - else:
    - define god false
  - define gamemode <[player].gamemode>
  - adjust <[player]> gamemode:survival
  - adjust <[player]> remove_effects
  - flag <[player]> ded duration:2s
  - cast invisibility duration:2s <[player]>
  - hurt <[player]> 20000000 source:<player>
  - adjust <[player]> location:<[player].location.with_y[-800]>
  - adjust <[player]> god_mode:<[god]>
  - adjust <[player]> gamemode:<[gamemode]>