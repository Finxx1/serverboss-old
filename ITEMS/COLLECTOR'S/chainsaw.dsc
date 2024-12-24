chainsaw:
  type: item
  material: netherite_sword
  display name: <element[Chainsaw].color_gradient[from=#C08080;to=#606060]>
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13374298
  lore:
  - <element[Another psychotic episode coming up!].color_gradient[from=#604040;to=#303030]>
  - 
  - <element[COLLECTOR'S].color[#800000].bold>

chainsawtriggers:
  type: world
  events:
    on player right clicks entity with:chainsaw:
    - ratelimit 1t <player>
    - if <context.entity.entity_type> == item_frame:
      - stop
    - if <player.has_flag[gascooldown]>:
      - stop
    - if <player.flag[gasolineused]||0> == 100:
      - title "title:<element[REFILLING!].color_gradient[from=#C08080;to=#606060]>" "subtitle:" fade_in:0 stay:200t targets:<player>
      - flag <player> gascooldown expire:10s
      - itemcooldown rabbit_foot duration:10s
      - flag <player> gasolineused:0
      - playsound at:<player.eye_location> sound:item_bucket_fill_lava pitch:0 volume:2
      - stop
    - flag <player> gasolineused:<player.flag[gasolineused].add[2].min[100]||0>
    - title "title:" "subtitle:<element[<player.flag[gasolineused].mul[-1].add[100]>%].color_gradient[from=#604040;to=#303030]>" fade_in:0 stay:5t targets:<player>
    - if !<player.has_flag[chaining]>:
      - playsound at:<player.eye_location> sound:custom.chainsaw_intro pitch:1 volume:3 custom
      - flag <player> chainstartsfx expire:42t
    - flag <player> chaining expire:10t
    - repeat 2:
      - adjust <context.entity> max_no_damage_duration:1t
      - hurt <context.entity> amount:1
      - adjust <context.entity> max_no_damage_duration:20t
      - look <context.entity> <context.entity.eye_location.forward[1].random_offset[0.25]>
      - playeffect at:<context.entity.eye_location> effect:block_crack special_data:redstone_wire offset:0.45 quantity:45
      - playeffect at:<context.entity.eye_location> effect:item_crack special_data:redstone offset:0.45 quantity:45
      - playeffect at:<context.entity.eye_location> effect:item_crack special_data:red_dye offset:0.45 quantity:45
      - playeffect at:<context.entity.eye_location> effect:block_crack special_data:redstone_block offset:0.45 quantity:45
      - if !<player.has_flag[chainstartsfx]> && !<player.has_flag[chainloopsfx]>:
        - adjust <player> stop_sound:minecraft:custom.chainsaw_loop
        - playsound at:<player.eye_location> sound:custom.chainsaw_loop pitch:1 volume:3 custom
        - flag <player> chainloopsfx expire:31t
      - wait 2t

