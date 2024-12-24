jumppad:
  debug: false
  type: world
  events:
    on player steps on dead_fire_coral_block:
    - hurt <player> cause:FIRE
    - burn <player> duration:120t
    on player steps on light_blue_glazed_terracotta:
    - adjust <player> velocity:<player.velocity.with_y[<player.velocity.y.max[0]>].add[0,2,0].add[<player.eye_location.with_pitch[0].direction.vector.normalize.mul[1]>]>
    - cast <player> slow_falling amplifier:0 duration:40t
    - playeffect effect:redstone special_data:2|<color[#80C0FF]> at:<player.eye_location> offset:0.75 quantity:64 visibility:100
    - playsound sound:entity_wither_shoot at:<player.eye_location> pitch:2 volume:2
    - playsound sound:entity_player_levelup at:<player.eye_location> pitch:2 volume:2
    - playsound sound:block_beacon_power_select at:<player.eye_location> pitch:2 volume:2
    - flag <player> soaring
    on player steps on magenta_glazed_terracotta:
    - choose <context.location.material.direction>:
      - case EAST:
        - define dirvec <location[-1,0,0]>
      - case NORTH:
        - define dirvec <location[0,0,1]>
      - case WEST:
        - define dirvec <location[1,0,0]>
      - case SOUTH:
        - define dirvec <location[0,0,-1]>
    - adjust <player> velocity:<player.velocity.with_y[<player.velocity.y.max[0]>].add[0,0.25,0].add[<[dirvec].mul[5]>]>
    - cast <player> speed amplifier:5 duration:40t
    - playeffect effect:redstone special_data:2|<color[#E060FF]> at:<player.eye_location> offset:0.75 quantity:64 visibility:100
    - playsound sound:entity_blaze_shoot at:<player.eye_location> pitch:1 volume:2
    - playsound sound:entity_generic_extinguish_fire at:<player.eye_location> pitch:1 volume:2
    - playsound sound:block_beacon_activate at:<player.eye_location> pitch:2 volume:2
    - flag <player> soaring
    on player damaged by FALL:
    - if <player.has_flag[soaring]>:
      - determine cancelled passively
      - flag <player> soaring:!
    on tick every:10:
    - foreach <server.online_players||0>:
      - foreach <[value].location.find.living_entities.within[64].exclude[<[value]>]||0> as:hitones:
        - if <[hitones].location.sub[0,0.1,0].block.material.name> == white_glazed_terracotta:
          - run GOREBURSTPRO def:<[hitones].location.add[0,0.5,0].with_pitch[-90]>|0.3
          - kill <[hitones]>
          - stop
        - if !<[hitones].has_flag[draggedtohell]> && <[hitones].entity_type> != PLAYER:
          - run cryfortheweeper def:<[hitones]> 
    on tick every:8:
    - foreach <server.online_players||0>:
      - foreach <[value].location.find.living_entities.within[64].exclude[<[value]>]||0> as:hitones:
        - if !<[hitones].has_flag[bstrdized]> && <[hitones].entity_type> != PLAYER:
          - if <[hitones].location.sub[0,0.1,0].block.material.name> == red_glazed_terracotta:
            - flag <[hitones]> bstrdized
            - playsound at:<[hitones].eye_location> sound:custom.bstrd<list[1|2|3].random> pitch:1 volume:2 custom
            - playeffect at:<[hitones].eye_location> offset:1 quantity:12 effect:redstone special_data:1.5|<color[#FF0000]>
            - playeffect at:<[hitones].eye_location> offset:1 quantity:12 effect:redstone special_data:2|<color[#FFC000]>
            - equip <[hitones]> helmet:bstrdhead
        - if <[hitones].has_flag[bstrdized]>:
          - cast <[hitones]> effect:speed amplifier:1 duration:99999t no_icon hide_particles no_ambient
          - cast <[hitones]> effect:increase_damage amplifier:0 duration:99999t no_icon hide_particles no_ambient
          - cast <[hitones]> effect:damage_resistance amplifier:1 duration:99999t no_icon hide_particles no_ambient
          - cast <[hitones]> effect:fire_resistance amplifier:0 duration:99999t no_icon hide_particles no_ambient
#          - cast <[hitones]> effect:glowing amplifier:0 duration:99999t no_icon hide_particles no_ambient
    on player steps on white_glazed_terracotta:
    - run GOREBURSTPRO def:<player.location.add[0,0.5,0].with_pitch[-90]>|0.3
    - kill <player>
    on player steps on sea_lantern:
    - if <player.has_flag[draggedtohell]>:
      - stop
    - while <player.location.sub[0,0.1,0].block.material.name> == sea_lantern:
      - flag <player> draggedtohell expire:15t
      - hurt <player.health_max.div[6.5].round_down> <player> cause:SUFFOCATION
      - playeffect at:<player.location> offset:0.35 quantity:12 effect:redstone special_data:2|<color[#FF0000]>
      - playsound at:<player.location> sound:entity_evoker_fangs_attack pitch:0 volume:0.5
      - playsound at:<player.location> sound:entity_zombie_villager_step pitch:0 volume:1.5
      - playsound at:<player.location> sound:custom.gib pitch:0 volume:0.2 custom
      - wait 10t
    on player steps on pink_glazed_terracotta:
    - if <context.location.block.has_flag[blowingtfup]>:
      - stop
    - flag <context.location.block> blowingtfup expire:40t
    - wait 1t
    - playsound at:<context.location.block.add[0.5,0.5,0.5]> sound:entity_creeper_primed volume:2 pitch:1.5
    - wait 10t
    - repeat 5:
      - playsound at:<context.location.block.add[0.5,0.5,0.5]> sound:block_note_block_pling pitch:2 volume:2
      - wait 2t
    - playsound at:<context.location.block.add[0.5,0.5,0.5]> sound:custom.classic_explode pitch:1 volume:2 custom
    - foreach <context.location.block.add[0.5,0.5,0.5].find_entities.within[3]>:
      - adjust <[value]> velocity:<[value].velocity.add[<context.location.block.add[0.5,0.5,0.5].sub[<[value].eye_location>].normalize.mul[-0.9]>]>
      - hurt <[value]> 10
    - modifyblock <context.location.block> air
    - repeat 3:
      - playeffect effect:large_explode offset:1 at:<context.location.block.add[0.5,0.5,0.5]> quantity:3 visibility:100
      - wait 3t
    - wait 300t
    - playsound sound:block_bell_resonate pitch:0 volume:2 at <context.location.block.add[0.5,0.5,0.5]>
    - wait 83t
    - modifyblock <context.location.block> pink_glazed_terracotta
    on small_fireball hits block:
    - determine cancelled passively
#    - announce PUSSAY
    on player left clicks blue_glazed_terracotta:
    - flag <context.location.block> powblocked
    - modifyblock <context.location.block> air
    - playsound at:<context.location.block.add[0.5,0.5,0.5]> sound:custom.classic_explode pitch:0 volume:2 custom
#    - playsound at:<context.location.block.add[0.5,0.5,0.5]> sound:custom.classic_explode pitch:1 volume:2 custom
    - playeffect at:<context.location.block.add[0.5,0.5,0.5]> effect:flash quantity:1 offset:0 visibility:100
    - foreach <context.location.block.add[0.5,0.5,0.5].find_entities.within[50]>:
      - adjust <[value]> velocity:<[value].velocity.add[<[value].eye_location.sub[<context.location.block.add[0.5,0.5,0.5]>].normalize.mul[1.5]>]>
    - foreach <context.location.block.add[0.5,0.5,0.5].find.living_entities.within[50].exclude[<player>]>:
      - hurt <[value]> <[value].health_max.div[3]>
    on player right clicks gray_stained_glass with:ironkey:
    - playsound at:<context.location.block.add[0.5,0.5,0.5]> sound:custom.unlock volume:2 pitch:1 custom
    - take from:<player.inventory> iteminhand
    - run unlocking def:<player>|<context.location.block>
    on player right clicks block with:stonekey:
    - foreach <player.eye_location.find_blocks_flagged[unlockedblock].within[50]>:
      - playsound at:<player.eye_location> sound:custom.unlock volume:1 pitch:2 custom
      - playsound at:<player.eye_location> sound:custom.unlock volume:1 pitch:1 custom
      - playsound at:<player.eye_location> sound:custom.unlock volume:1 pitch:0 custom
      - playeffect effect:block_crack at:<[value].add[0.5,0.5,0.5]> special_data:<[value].flag[unlockedblock]> offset:0.4 quantity:64 visibility:100
      - modifyblock <[value]> <[value].flag[unlockedblock]>
      - flag <[value]> unlockedblock:!
      - if <[loop_index].mod[32]> == 0:
        - wait 4t
    on tick every:40:
    - foreach <server.online_players>:
      - define spiky <[value].location.find_blocks_flagged[spiketype].within[50].filter_tag[<[filter_value].flag[spiketype].is[==].to[timed]>]||0>
#      - announce <[spiky]>
#      - announce <[spiky].size>
      - if <[spiky].size> == 0:
        - foreach next
      - foreach <[spiky]> as:spikez:
        - run skibby def:<[spikez]>
      - if <[spiky].size> < 2:
        - run skibby2 def:<[spiky].get[1]>
      - else:
        - foreach <[spiky].get[2]> as:generalskibby:
          - run skibby2 def:<[generalskibby]>
    on player breaks cyan_glazed_terracotta:
    - flag <context.location> spiketype:!
    on tick:
    - foreach <server.online_players>:
      - if <[value].location.with_pitch[90].ray_trace[range=6.5;return=block;default=null;nonsolids=false;ignore=*].material.name||0> == light_gray_glazed_terracotta && !<[value].is_sneaking>:
        - adjust <[value]> velocity:<[value].velocity.mul[1.35].with_y[<[value].velocity.y.add[0.2].max[-1].min[2.5]>]>
      - foreach <[value].location.find_blocks_flagged[fans].within[64]> as:val2:
        - if <util.random_chance[20]>:
          - playeffect at:<[val2].add[0,0.5,0]> effect:cloud offset:0.75,0,0.75 velocity:<location[0,0.35,0]> visibility:100
        - wait 1t
#        - playsound at:<[val2]> sound:entity_bee_loop pitch:1 volume:0.05
    on player places light_gray_glazed_terracotta:
    - flag <context.location> fans 
    on player breaks light_gray_glazed_terracotta:
    - flag <context.location> fans:!
    on player steps on cyan_glazed_terracotta:
#    - announce <context.location.material.direction> 
    - if <context.location.material.direction> == south || <context.location.material.direction> == east:
      - playsound at:<context.location.block.center> sound:item_trident_hit pitch:1
      - playsound at:<context.location.block.center> sound:entity_player_hurt_sweet_berry_bush pitch:1
      - playsound at:<context.location.block.center> sound:entity_player_hurt_sweet_berry_bush pitch:0
      - playsound at:<context.location.block.center> sound:block_honey_step pitch:1
      - playsound at:<context.location.block.center> sound:block_honey_step pitch:0
      - cast <player> SLOW amplifier:2 duration:80t no_icon hide_particles no_ambient
      - cast <player> JUMP amplifier:254 duration:80t no_icon hide_particles no_ambient
      - hurt <player> amount:5
    - else if <context.location.flag[spiketype]||permanent> == trigger:
      - playsound at:<context.location.block.center> sound:block_lever_click pitch:0
      - playsound at:<context.location.block.center> sound:block_lever_click pitch:1
      - wait 10t
      - adjustblock <context.location.block> direction:south
      - foreach <context.location.above[1].find.living_entities.within[1].filter_tag[<[filter_value].entity_type.is[==].to[PLAYER].not>]||0>:
        - playsound at:<context.location.block.center> sound:entity_player_hurt_sweet_berry_bush pitch:1
        - playsound at:<context.location.block.center> sound:entity_player_hurt_sweet_berry_bush pitch:0
        - playsound at:<context.location.block.center> sound:block_honey_step pitch:1
        - playsound at:<context.location.block.center> sound:block_honey_step pitch:0
        - cast <[value]> SLOW amplifier:2 duration:80t no_icon hide_particles no_ambient
        - hurt <[value]> amount:5
      - foreach <context.location.above[1].find.living_entities.within[0.5].filter_tag[<[filter_value].entity_type.is[==].to[PLAYER]>]||0>:
        - playsound at:<context.location.block.center> sound:entity_player_hurt_sweet_berry_bush pitch:1
        - playsound at:<context.location.block.center> sound:entity_player_hurt_sweet_berry_bush pitch:0
        - playsound at:<context.location.block.center> sound:block_honey_step pitch:1
        - playsound at:<context.location.block.center> sound:block_honey_step pitch:0
        - cast <[value]> SLOW amplifier:2 duration:80t no_icon hide_particles no_ambient
        - cast <[value]> JUMP amplifier:254 duration:80t no_icon hide_particles no_ambient
        - hurt <[value]> amount:5
      - playsound at:<context.location.block.center> sound:item_trident_throw pitch:1
      - playsound at:<context.location.block.center> sound:item_trident_throw pitch:2
      - wait 80t
      - playsound at:<context.location.block.center> sound:block_lever_click pitch:0
      - adjustblock <context.location.block> direction:north
    on player right clicks cyan_glazed_terracotta with:wrench:
    - playsound at:<context.location.block.center> sound:block_lever_click pitch:2
    - choose <context.location.block.flag[spiketype]||trigger>:
      - case permanent:
        - flag <context.location.block> spiketype:timed
        - announce "<element[Changed spike block functionality to: ].color[#C0C0C0]><element[timed].color[#FF8000]>"
        - adjustblock <context.location.block> direction:south
      - case timed:
        - flag <context.location.block> spiketype:trigger
        - announce "<element[Changed spike block functionality to: ].color[#C0C0C0]><element[trigger].color[#FFFF00]>"
        - adjustblock <context.location.block> direction:north
      - case trigger:
        - flag <context.location.block> spiketype:fake
        - announce "<element[Changed spike block functionality to: ].color[#C0C0C0]><element[fake].color[#80FF00]>"
      - case fake:
        - flag <context.location.block> spiketype:permanent
        - announce "<element[Changed spike block functionality to: ].color[#C0C0C0]><element[permanent].color[#FF0000]>"
        - adjustblock <context.location.block> direction:south
    on player dies:
    - if <context.entity.location.sub[0,0.5,0].material.name> == cyan_glazed_terracotta && <context.entity.location.sub[0,0.5,0].material.direction> == south:
      - run achievementgive def:<player>|iwbtg
        
ironkey:
  type: item
  material: paper
  display name: <element[Iron Key].color_gradient[from=#808080;to=#F0F0F0]>
  mechanisms:
    custom_model_data: 13375405
  lore:
  - <element[Opens locks!].color_gradient[from=#404040;to=#808080]>
  - <&7>
  - <element[GENUINE].color[#206030].bold>

stonekey:
  type: item
  material: paper
  display name: <element[Stone Key].color_gradient[from=#606060;to=#C0C0C0]>
  mechanisms:
    custom_model_data: 13375406
  lore:
  - <element[Closes locks!].color_gradient[from=#303030;to=#606060]>
  - <&7>
  - <element[DEVELOPER].color[#525252].bold>

unlocking:
  debug: false
  type: task
  definitions: playr|blocloc
  script:
  - if <[blocloc].material.name> == air:
    - stop
  - if <[blocloc].has_flag[irontransfer]>:
    - stop
  - if <[blocloc].material.name> != iron_block:
    - flag <[blocloc]> unlockedblock:<[blocloc].material.name>
    - modifyblock <[blocloc]> air
    - playsound at:<[blocloc].add[0.5,0.5,0.5]> sound:custom.keys volume:1 pitch:<list[0.05|-0.05].random.add[1].add[<list[0.1|-0.1].random>]> custom
    - playeffect effect:block_crack at:<[blocloc].add[0.5,0.5,0.5]> special_data:<[blocloc].flag[unlockedblock]> offset:0.4 quantity:64 visibility:100
  - else:
    - flag <[blocloc]> irontransfer expire:20t
  - playsound at:<[blocloc].add[0.5,0.5,0.5]> sound:item_armor_equip_chain volume:1 pitch:<list[0.05|-0.05].random.add[1].add[<list[0.1|-0.1].random>]>
  - wait 3t
  - foreach <list[<[blocloc].add[1,0,0]>|<[blocloc].add[0,1,0]>|<[blocloc].add[0,0,1]>|<[blocloc].add[-1,0,0]>|<[blocloc].add[0,-1,0]>|<[blocloc].add[0,0,-1]>]>:
    - if <list[gray_stained_glass|light_gray_stained_glass|light_gray_stained_glass_pane|iron_block].contains_any[<[value].material.name>]>:
      - run unlocking def:<[playr]>|<[value]>

skibby2:
  type: task
  debug: false
  definitions: spikey
  script:
    - if <[spikey].add[0,0,0]||0> == 0:
      - stop
    - playsound at:<[spikey].block.center> sound:item_trident_throw pitch:1 volume:0.5
    - playsound at:<[spikey].block.center> sound:item_trident_throw pitch:2 volume:0.5
    - wait 10t
    - playsound at:<[spikey].block.center> sound:block_lever_click pitch:0 volume:0.5
    - if <[spikey].block.material.name> != cyan_glazed_terracotta:
      - flag <[spikey].block> spiketype:!

skibby:
  type: task
  debug: false
  definitions: spikey
  script:
    - adjustblock <[spikey].block> direction:south
    - foreach <[spikey].above[1].find.living_entities.within[1].filter_tag[<[filter_value].entity_type.is[==].to[PLAYER].not>]>:
      - playsound at:<[spikey].block.center> sound:entity_player_hurt_sweet_berry_bush pitch:1
      - playsound at:<[spikey].block.center> sound:entity_player_hurt_sweet_berry_bush pitch:0
      - playsound at:<[spikey].block.center> sound:block_honey_step pitch:1
      - playsound at:<[spikey].block.center> sound:block_honey_step pitch:0
      - cast <[value]> SLOW amplifier:2 duration:80t no_icon hide_particles no_ambient
      - hurt <[value]> amount:5
    - foreach <[spikey].above[1].find.living_entities.within[0.5].filter_tag[<[filter_value].entity_type.is[==].to[PLAYER]>]>:
      - playsound at:<[spikey].block.center> sound:entity_player_hurt_sweet_berry_bush pitch:1
      - playsound at:<[spikey].block.center> sound:entity_player_hurt_sweet_berry_bush pitch:0
      - playsound at:<[spikey].block.center> sound:block_honey_step pitch:1
      - playsound at:<[spikey].block.center> sound:block_honey_step pitch:0
      - cast <[value]> SLOW amplifier:2 duration:80t no_icon hide_particles no_ambient
      - cast <[value]> JUMP amplifier:254 duration:80t no_icon hide_particles no_ambient
      - hurt <[value]> amount:5
    - wait 15t
    - adjustblock <[spikey].block> direction:north

cryfortheweeper:
  debug: false
  type: task
  definitions: hate
  script:
  - while <[hate].location.sub[0,0.1,0].block.material.name> == sea_lantern:
    - flag <[hate]> draggedtohell expire:15t
    - hurt <[hate].health_max.div[6.5].round_down> <[hate]> cause:SUFFOCATION
    - playeffect at:<[hate].location> offset:0.35 quantity:12 effect:redstone special_data:2|<color[#FF0000]>
    - playsound at:<[hate].location> sound:entity_evoker_fangs_attack pitch:0 volume:0.5
    - playsound at:<[hate].location> sound:entity_zombie_villager_step pitch:0 volume:1.5
    - playsound at:<[hate].location> sound:custom.gib pitch:0 volume:0.2 custom
    - wait 15t