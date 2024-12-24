icering:
  type: item
  material: diamond
  display name: <element[Snow Ring].color_gradient[from=#80C0FF;to=#8080FF]>
  mechanisms:
    unbreakable: true
    #hides: all
    custom_model_data: 13374250
  lore:
  - <element[Proceed].color_gradient[from=#406080;to=#404080]>
  - <&7>
  - <element[COLLECTOR'S].color[#800000].bold>

thornring:
  type: item
  material: diamond
  display name: <element[Thorn Ring].color_gradient[from=#80C0FF;to=#FF0000]>
  mechanisms:
    unbreakable: true
    #hides: all
    custom_model_data: 13374252
  lore:
  - <element[Proceed].color_gradient[from=#406080;to=#800000]>
  - <&7>
  - <element[HAUNTED].color[#38F0A8].bold>

iceringuse:
  type: world
  debug: false
  events:
    on tick every:8:
    - foreach <server.online_players>:
      - if <[value].item_in_hand.script.name||0> == icering && <[value].flag[tension]||0> < 100:
        - flag <[value]> tension:<[value].flag[tension].add[1].min[100]||0>
        - title "title:<element[❄ <[value].flag[tension]>% ❄].bold.italicize.color_gradient[from=#80C0FF;to=#8080FF]>" "subtitle:<element[❄].color[#404080]> <element[&pipe].unescaped.repeat[<[value].flag[tension].sub[1]>].color_gradient[from=#404080;to=#C0D8FF]><element[&pipe].unescaped.bold.color[#FFFFFF]><element[&pipe].unescaped.repeat[<element[100].sub[<[value].flag[tension]>]>].color_gradient[from=#C0D8FF;to=#404080]> <element[❄].color[#404080]>" fade_in:0 stay:10t fade_out:5t targets:<[value]>
      - if <[value].item_in_hand.script.name||0> == thornring && <[value].flag[tension]||0> < 100 && <[value].health> > <[value].health_max.mul[0.35]>:
        - hurt <[value]> 1
        - flag <[value]> tension:<[value].flag[tension].add[3].min[100]||0>
        - title "title:<element[❅ <[value].flag[tension]>% ❅].bold.italicize.color[#FF0000]>" "subtitle:<element[❅].color[#FF0000]> <element[&pipe].unescaped.repeat[<[value].flag[tension].sub[1]>].color_gradient[from=#202020;to=#FF0000]><element[&pipe].unescaped.bold.color[#000000]><element[&pipe].unescaped.repeat[<element[100].sub[<[value].flag[tension]>]>].color_gradient[from=#FF0000;to=#202020]> <element[❅].color[#FF0000]>" fade_in:0 stay:10t fade_out:5t targets:<[value]>
    on player right clicks block with:icering: 
    - if <player.flag[tension]||0> < 16:
      - stop
    - if <player.has_flag[iceringcooldown]>:
      - stop
    - flag <player> iceringcooldown expire:2s
    - flag <player> tension:<player.flag[tension].sub[16]>
    - itemcooldown diamond duration:2s
    - define lookvec <player.eye_location.direction.vector>
    - define lookpos <player.eye_location.add[<[lookvec].mul[11]>]>
    - define posline <player.eye_location.points_between[<[lookpos]>].distance[2]>
    - run playjingle def:<player.location>
#    - playsound <player.location> sound:block_note_block_bit pitch:2 volume:1
    - playsound <player.location> sound:entity_snowball_throw pitch:0 volume:1
    - playsound <player.location> sound:entity_blaze_shoot pitch:0 volume:1
    #- playsound <player.location> sound:entity_generic_splash pitch:0 volume:1
    - playsound <player.eye_location> sound:entity_ender_dragon_flap pitch:0 volume:1
    - foreach <[posline]>:
      - define blasted <[value].find_entities.within[3.5].exclude[<player>]||0>
      #- adjust <[blasted]> velocity:<[lookvec].add[0,1,0].mul[0.35]>
      - adjust <[blasted]> fire_time:0t
      - foreach <[blasted]>:
        - if !<[value].has_flag[mgk_frosty]>:
          - flag <[value]> mgk_frosty expire:10s
          - run frosty_run def:<[value]>
        - hurt <[value]> <[value].health_max.sub[<[value].health>].mul[0.35].add[1]>
      - playeffect effect:end_rod quantity:1 at:<[value]> offset:0.65,0.65,0.65 visibility:100
      - playeffect effect:redstone quantity:4 at:<[value]> special_data:1|white offset:1.24,1.24,1.24 visibility:100
      - playeffect effect:cloud quantity:10 at:<[value]> offset:1.25,1.25,1.25 visibility:100
      - wait 1t
    on player right clicks block with:thornring: 
    - if <player.flag[tension]||0> < 100:
      - stop
    - if <player.has_flag[iceringcooldown]>:
      - stop
    - flag <player> iceringcooldown expire:16s
    - flag <player> tension:0
    - itemcooldown diamond duration:16s
    - adjust <player> gravity:false
    - cast BLINDNESS <player> amplifier:1 duration:40t no_ambient no_icon hide_particles
    - repeat 2:
      - playeffect effect:crit_magic quantity:4 at:<player.eye_location> offset:2,2,2 visibility:100
      - playsound <player.location> sound:entity_arrow_hit_player pitch:<element[1].add[<[value].mul[0.2]>]> volume:2
      - playsound <player.location> sound:entity_experience_orb_pickup pitch:<element[1].add[<[value].mul[0.2]>]> volume:2
      - playsound <player.location> sound:entity_player_levelup pitch:<element[0.5].add[<[value].mul[0.2]>]> volume:2
      - wait 4t
    - repeat 2:
      - playeffect effect:crit_magic quantity:4 at:<player.eye_location> offset:2,2,2 visibility:100
      - playsound <player.location> sound:entity_arrow_hit_player pitch:<element[1].add[<[value].mul[0.2]>]> volume:2
      - playsound <player.location> sound:entity_experience_orb_pickup pitch:<element[1].add[<[value].mul[0.2]>]> volume:2
      - playsound <player.location> sound:entity_player_levelup pitch:<element[0.5].add[<[value].mul[0.2]>]> volume:2
      - wait 2t
    - repeat 3:
      - adjust <player> velocity:<player.velocity.add[0,0.015,0]>
      - playeffect effect:crit_magic quantity:10 at:<player.eye_location> offset:2,2,2 visibility:100
      - playsound <player.location> sound:entity_arrow_hit_player pitch:<element[0.5].add[<[value].mul[0.2]>]> volume:2
      - playsound <player.location> sound:entity_experience_orb_pickup pitch:<element[0.5].add[<[value].mul[0.2]>]> volume:2
      - playsound <player.location> sound:entity_player_levelup pitch:<element[0].add[<[value].mul[0.2]>]> volume:2
      - wait 2t
    - repeat 5:
      - adjust <player> velocity:<player.velocity.add[0,0.03,0]>
      - playeffect effect:crit_magic quantity:128 at:<player.eye_location> offset:2,2,2 visibility:100
      - playsound <player.location> sound:entity_arrow_hit_player pitch:<element[1].add[<[value].mul[0.2]>]> volume:2
      - playsound <player.location> sound:entity_experience_orb_pickup pitch:<element[1].add[<[value].mul[0.2]>]> volume:2
      - playsound <player.location> sound:entity_player_levelup pitch:<element[0.5].add[<[value].mul[0.2]>]> volume:2
      - wait 2t
    - define lookvec <player.eye_location.direction.vector>
    - define lookpos <player.eye_location.add[<[lookvec].mul[8]>]>
    - define posline <player.eye_location.points_between[<[lookpos]>].distance[2]>
    - playsound <player.location> sound:entity_snowball_throw pitch:0 volume:1
    - playsound <player.location> sound:entity_blaze_shoot pitch:0 volume:1
    #- playsound <player.location> sound:entity_generic_splash pitch:0 volume:1
    - playsound <player.eye_location> sound:entity_ender_dragon_flap pitch:0 volume:1
    - playsound <player.eye_location> sound:custom.psychicfire pitch:0 volume:1 custom
    - foreach <[posline]>:
      - define blasted <[value].find.living_entities.within[2.5].exclude[<player>]||0>
      #- adjust <[blasted]> velocity:<[lookvec].add[0,1,0].mul[0.35]>
      - adjust <[blasted]> fire_time:0t
      - foreach <[blasted]>:
        - if !<[value].has_flag[mgk_frosty]>:
          - flag <[value]> mgk_frosty expire:10s
          - run frosty_run_forcefreeze def:<[value]>
        - hurt <[value]> <[value].health_max.sub[<[value].health>].mul[0.5].add[2]>
      - playeffect effect:end_rod quantity:128 at:<[value]> offset:1.25,1.25,1.25 visibility:100
      - playeffect effect:redstone quantity:128 at:<[value]> special_data:2|white offset:4,4,4 visibility:100
      - playeffect effect:cloud quantity:128 at:<[value]> offset:2,2,2 visibility:100
      - playeffect effect:crit_magic quantity:128 at:<[value]> offset:4,4,4 visibility:100
      - playeffect effect:soul quantity:18 at:<[value]> offset:4,4,4 visibility:100 velocity:<[lookvec].mul[0.2]>
      - wait 2t
    - playsound <player.eye_location> sound:block_enchantment_table_use pitch:0 volume:2
    - playsound <player.eye_location> sound:block_enchantment_table_use pitch:1 volume:2
    - playsound <player.eye_location> sound:block_enchantment_table_use pitch:2 volume:2
    - wait 10t
    - adjust <player> gravity:true
    - repeat 3 as:volchange:
      - repeat 10:
        - playeffect effect:crit_magic quantity:3 at:<player.eye_location> offset:5,5,5 visibility:100
        - playeffect effect:soul quantity:1 at:<player.eye_location> offset:4,4,4 visibility:100 velocity:<[lookvec].mul[0.2]>
        - playsound <player.location> sound:entity_arrow_hit_player pitch:<element[2].sub[<[value].mul[0.15]>].sub[<[volchange].mul[0.33]>]> volume:<element[0.5].sub[<[volchange].mul[0.33]>]>
        - playsound <player.location> sound:entity_player_levelup pitch:<element[1].sub[<[value].mul[0.15]>].sub[<[volchange].mul[0.33]>]> volume:<element[0.5].sub[<[volchange].mul[0.33]>]>
        - wait 3t
    on entity damaged by suffocation:
    - if <list[<material[<frosted_ice[age=1]>]>|<material[<frosted_ice[age=2]>]>|<material[<frosted_ice[age=3]>]>|<material[frosted_ice]>].contains_any[<context.entity.eye_location.block.material>]>:
      - determine cancelled passively

playjingle:
  type: task
  debug: false
  definitions: playloc
  script:
  - repeat 3:
    - playsound <[playloc]> sound:block_note_block_bit pitch:<element[2].add[<[value].mul[0.33]>]> volume:2
    - playsound <[playloc]> sound:block_note_block_bass pitch:<element[2].add[<[value].mul[0.33]>]> volume:2
    - wait 1t
  - repeat 3:
    - playsound <[playloc]> sound:block_note_block_bit pitch:<element[1].add[<[value].mul[0.33]>]> volume:2
    - playsound <[playloc]> sound:block_note_block_bass pitch:<element[1].add[<[value].mul[0.33]>]> volume:2
    - wait 1t