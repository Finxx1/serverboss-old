caledscratch:
  type: item
  material: diamond_sword
  display name: <element[The Caledscratch].color[#E00808]>
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13376942
  recipes:
    1:
      type: shapeless
      output_quantity: 1
      input: theworlditem[enchantments=map@[knockback=1]]|katana[attribute_modifiers=map@[GENERIC_ATTACK_SPEED=li@map@[name=GENERIC_ATTACK_SPEED;amount=0.15;operation=ADD_SCALAR;slot=HAND;id=10000000-1000-1000-1000-100000000000]|]]|glasssword[attribute_modifiers=map@[GENERIC_ATTACK_DAMAGE=li@map@[name=GENERIC_ATTACK_DAMAGE;amount=10;operation=ADD_NUMBER;slot=HAND;id=10000000-1000-1000-1000-100000000000]|]]
    2:
      type: shapeless
      output_quantity: 1
      input: caledscratch[custom_model_data=13375337]
  lore:
  - <element[could fuck a circus tent down a gas tank].color[#780404]>
  - 
  - <element[COLLECTOR'S].color[#800000].bold>

caledscratchtriggers:
  type: world
  events:
    on player left clicks block with:caledscratch:
    - determine cancelled passively
    - if <player.attack_cooldown_percent> < 100:
      - stop
    - playsound at:<player.location> volume:2 sound:item_trident_throw pitch:1
    - flag <player> melee_parrying duration:7t
    after player damages entity with:caledscratch:
    - flag <player> melee_parrying duration:7t
    - if <util.random_chance[5]> && <player.item_in_hand.custom_model_data> == 13376942:
      - repeat 64:
        - playeffect at:<player.eye_location> effect:item_crack special_data:caledscratch visibility:100 velocity:<location[0,0,0].random_offset[0.35]> quantity:3 offset:0.25
      - playsound <player.eye_location> sound:block_glass_break pitch:0 volume:2
      - playsound <player.eye_location> sound:ITEM_ARMOR_EQUIP_NETHERITE pitch:0 volume:2
      - playsound <player.eye_location> sound:ITEM_SHIELD_BREAK pitch:0 volume:2
      - playsound <player.eye_location> sound:ITEM_TOTEM_USE pitch:0 volume:2
      - inventory adjust "custom_model_data:13375337" destination:<player.inventory> slot:hand
      - repeat 10:
        - title "title:<element[HAPPEN!!!].bold.italicize.color[#E00808]>" "subtitle:" targets:<player> fade_in:0t fade_out:1t stay:2t
        - wait 4t
    on player damages entity with:caledscratch:
    - if <context.entity.has_flag[melee_parrying]>:
      - determine cancelled passively
      - narrate <element[+ ].italicize.bold.color[#FFFFFF]><element[CLASH].italicize.bold.color[#FFA000]> targets:<context.entity>
      - narrate <element[+ ].italicize.bold.color[#FFFFFF]><element[CLASH].italicize.bold.color[#FFA000]> targets:<context.damager>
      - playeffect at:<context.damager.eye_location.add[<context.entity.eye_location>].mul[0.5]> effect:flash offset:0 quantity:1 visibility:100
      - playsound at:<context.damager.eye_location> volume:2 sound:entity_zombie_attack_iron_door pitch:0
      - flag <context.entity> stylestatus:<context.entity.flag[stylestatus].add[250]>
      - flag <context.damager> stylestatus:<context.damager.flag[stylestatus].add[250]>
      - adjust <context.entity> velocity:<context.entity.velocity.add[<context.entity.location.sub[<context.damager.location>].normalize.mul[1]>].add[0,0.5,0]>
      - adjust <context.damager> velocity:<context.damager.velocity.add[<context.damager.location.sub[<context.entity.location>].normalize.mul[1]>].add[0,0.5,0]>
    on player right clicks block with:caledscratch:
    - if <player.has_flag[caledscratchcooldown]>:
      - stop
    - if <player.item_in_hand.custom_model_data> == 13376942:
      - define standuser <player>
      - define demtarget <[standuser].precise_target[6]||0>
      - if <[demtarget]> != 0:
        - flag <player> caledscratchcooldown expire:100t
        - itemcooldown diamond_sword duration:100t
        - playsound <[standuser].location> sound:custom.psychichit pitch:0 volume:2 custom
        - playsound <[standuser].location> sound:custom.dialup_stand_summon pitch:0 volume:2 custom
        - spawn lagpoint3 <[demtarget].location> save:dlrsv2
        - define laggy <entry[dlrsv2].spawned_entity>
        - run dialuprequiemfreezeframelag def:<[laggy]>|<[demtarget]>
        - attach <[standuser]> cancel
        - playsound <[standuser].location> sound:block_stone_button_click_off pitch:0 volume:4
      - else: 
        - playsound <[standuser].location> sound:block_note_block_bass pitch:0 volume:4
    - else:
      - define standuser <player>
      - flag <player> caledscratchcooldown expire:180t
      - itemcooldown diamond_sword duration:180t
      - playsound <[standuser].location> sound:block_stone_button_click_on pitch:0 volume:4
      - define loc1 <[standuser].location>
      - wait 4s
      - playsound <[standuser].location> sound:custom.psychichit pitch:0 volume:2 custom
      - playsound <[standuser].location> sound:custom.endoftime_stand_summon pitch:1 volume:2 custom
      - define loc2 <[standuser].location>
      - teleport <[standuser]> <[loc1]>
      - wait 4s
      - playsound <[standuser].location> sound:custom.psychichit pitch:0 volume:2 custom
      - teleport <[standuser]> <[loc2]>