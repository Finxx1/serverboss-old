hl1crowbar:
  type: item
  material: stick
  display name: <element[The &ns1 Crowbar].unescaped.color_gradient[from=#C00000;to=#606060]>
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13374398
    attribute_modifiers:
      generic_attack_speed:
        1:
          operation: add_scalar
          amount: 8
          slot: hand
          id: 10000000-1000-1000-1000-100000000000
  lore:
  - <element[...].color_gradient[from=#600000;to=#303030]>
  - 
  - <element[COLLECTOR'S].color[#800000].bold>

jujucrowbar:
  type: item
  material: stick
  display name: <element[The &ns7 Crowbar].unescaped.color_gradient[from=#C00040;to=#800030]>
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13374399
  lore:
  - <element[Who cares?].color_gradient[from=#600020;to=#40001C]>
  - 
  - <element[COLLECTOR'S].color[#800000].bold>


crowbartriggers:
  type: world
  debug: false
  events:
    on player damages entity with:hl1crowbar:
    - if <list[SPIDER|CAVE_SPIDER|SILVERFISH].contains_any[<context.entity.entity_type>]>:
      - determine 6 passively
      - playsound at:<context.damager.eye_location> sound:custom.shovelkill pitch:1 volume:2 custom
      - cast <context.entity> SLOW amplifier:7 duration:50t no_icon no_ambient hide_particles
      - cast <context.entity> WEAKNESS amplifier:7 duration:50t no_icon no_ambient hide_particles
      - repeat 16:
        - playeffect at:<context.entity.eye_location> effect:crit visibility:100 velocity:<location[0,0,0].random_offset[1]> quantity:1 offset:0.025
    - else:
      - determine 2 passively
    - playsound at:<context.damager.eye_location> sound:custom.shoveldeflect pitch:0 volume:2 custom
    - flag <context.entity> hl1speed expire:5t
    - adjust <context.entity> max_no_damage_duration:2t
    - wait 6t
    - if !<context.entity.has_flag[hl1speed]>:
      - adjust <context.entity> max_no_damage_duration:20t
    on player damages entity with:jujucrowbar:
    - playsound at:<context.damager.eye_location> sound:custom.shoveldeflect pitch:0.75 volume:2 custom
    - if <context.entity.item_in_hand.material.name> != air:
      - repeat 128:
        - playeffect at:<context.entity.eye_location> effect:item_crack special_data:<context.entity.item_in_hand.script.name||<context.entity.item_in_hand.material.name>> visibility:100 velocity:<location[0,0,0].random_offset[0.35]> quantity:3 offset:0.25
      - playsound <context.entity.eye_location> sound:block_glass_break pitch:0.75 volume:2
      - playsound <context.entity.eye_location> sound:ITEM_ARMOR_EQUIP_NETHERITE pitch:0.75 volume:2
      - playsound <context.entity.eye_location> sound:ITEM_SHIELD_BREAK pitch:0.75 volume:2
      - playsound <context.entity.eye_location> sound:ITEM_TOTEM_USE pitch:0.75 volume:2
      - if <context.entity.is_player>:
        - take slot:hand from:<context.entity.inventory> 
      - else:
        - adjust <context.entity> item_in_hand:air
      - repeat 6:
        - title "title:<element[JUJU DES7R#YED!!!].bold.italicize.color_gradient[from=#C00040;to=#800030]>" "subtitle:" targets:<context.entity>|<context.damager> fade_in:0t fade_out:1t stay:2t
        - wait 4t
    - else if <context.entity.item_in_offhand.material.name> != air:
      - repeat 128:
        - playeffect at:<context.entity.eye_location> effect:item_crack special_data:<context.entity.item_in_offhand.script.name||<context.entity.item_in_offhand.material.name>> visibility:100 velocity:<location[0,0,0].random_offset[0.35]> quantity:3 offset:0.25
      - playsound <context.entity.eye_location> sound:block_glass_break pitch:0.75 volume:2
      - playsound <context.entity.eye_location> sound:ITEM_ARMOR_EQUIP_NETHERITE pitch:0.75 volume:2
      - playsound <context.entity.eye_location> sound:ITEM_SHIELD_BREAK pitch:0.75 volume:2
      - playsound <context.entity.eye_location> sound:ITEM_TOTEM_USE pitch:0.75 volume:2
      - if <context.entity.is_player>:
        - take slot:offhand from:<context.entity.inventory> 
      - else:
        - adjust <context.entity> item_in_offhand:air
      - repeat 6:
        - title "title:<element[JUJU DES7R#YED!!!].bold.italicize.color_gradient[from=#C00040;to=#800030]>" "subtitle:" targets:<context.entity>|<context.damager> fade_in:0t fade_out:1t stay:2t
        - wait 4t
    on player left clicks block with:hl1crowbar:
    - determine cancelled passively
    - if <context.location||0> == 0:
      - stop
    - playsound at:<player.eye_location> sound:custom.shoveldeflect pitch:0 volume:2 custom
    on player left clicks block with:jujucrowbar:
    - determine cancelled passively
    - if <context.location||0> == 0:
      - stop
    - playsound at:<player.eye_location> sound:custom.shoveldeflect pitch:0.75 volume:2 custom