knightsword:
  type: item
  material: netherite_sword
  display name: <element[Knight Sword].color_gradient[from=#606060;to=#404040]>
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13374300
  lore:
  - <element[Holy shit this looks cool].color_gradient[from=#303030;to=#202020]>
  - 
  - <element[COLLECTOR'S].color[#800000].bold>

knightaxe:
  type: item
  material: netherite_axe
  display name: <element[Knight Axe].color_gradient[from=#404040;to=#606060]>
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13374291	
  lore:
  - <element[I will pierce you through].color_gradient[from=#202020;to=#303030]>
  - 
  - <element[COLLECTOR'S].color[#800000].bold>

knightpan:
  type: item
  material: netherite_shovel
  display name: <element[Knigh].color_gradient[from=#606060;to=#404040]><element[t Pan].color_gradient[from=#404040;to=#606060]>
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13374200
  lore:
  - <element[Ssssssssss].color_gradient[from=#303030;to=#202020]><element[ssssssssee?].color_gradient[from=#202020;to=#303030]>
  - 
  - <element[COLLECTOR'S].color[#800000].bold>

knightstriggers:
  type: world
  events:
    on player damages entity with:knightsword:
    - flag <context.damager> knightswordparry expire:20t
    on player damaged by entity:
    - if <context.entity.item_in_hand.script.name||0> == knightsword:
      - flag <context.entity> knightsworddeflectrapidfire:<context.entity.flag[knightsworddeflectrapidfire].add[1]||0> expire:25t
    - if <context.entity.has_flag[knightswordparry]> or <context.entity.flag[knightsworddeflectrapidfire]> > 2:
      - hurt <context.damager> amount:<context.damage>
      - adjust <context.damager> velocity:<context.entity.location.add[0,0.5,0].sub[<context.damager.eye_location>].normalize.mul[-2,-0.5,-2]>
      - playeffect effect:flash at <context.entity.eye_location.forward[0.2]> offset:0 quantity:1 visibility:100
      - playsound at:<context.entity.eye_location> sound:entity_zombie_attack_iron_door pitch:0 volume:2
      - determine cancelled passively
    on player damages entity with:knightaxe:
    - playsound at:<context.damager.eye_location> sound:entity_zombie_attack_iron_door pitch:0.75 volume:2 custom
    - if <context.entity.armor_bonus> > 0:
      - adjust <context.entity> armor_bonus:0
      - repeat 32:
        - playeffect at:<context.entity.eye_location.sub[0,0.5,0].random_offset[0,0.5,0]> effect:item_crack special_data:netherite_ingot visibility:100 velocity:<location[0,0,0].random_offset[0.35]> quantity:2 offset:0.7
      - playsound <context.entity.eye_location> sound:ITEM_SHIELD_BREAK pitch:0.75 volume:2
      - playsound at:<context.entity.eye_location> sound:entity_zombie_attack_iron_door pitch:0 volume:2 custom
      - wait 2t
    - foreach <context.entity.equipment_map> as:value key:zz_key:
      - if <[value].script.name||<[value].material.name>> != air:
        - repeat 32 as:shitface:
          - playeffect at:<context.entity.eye_location.sub[0,0.5,0].random_offset[0,0.5,0]> effect:item_crack special_data:<[value].script.name||<[value].material.name>> visibility:100 velocity:<location[0,0,0].random_offset[0.35]> quantity:3 offset:0.5
        - playsound <context.entity.eye_location> sound:block_glass_break pitch:0 volume:2
        - playsound <context.entity.eye_location> sound:ITEM_ARMOR_EQUIP_NETHERITE pitch:0.75 volume:2
        - playsound <context.entity.eye_location> sound:ITEM_SHIELD_BREAK pitch:0.75 volume:2
        - playsound at:<context.entity.eye_location> sound:entity_zombie_attack_iron_door pitch:0 volume:2 custom
        - choose <[zz_key]>:
          - case helmet:
            - equip <context.entity> head:<item[air]>
          - case chestplate:
            - equip <context.entity> chest:<item[air]>
          - case leggings:
            - equip <context.entity> legs:<item[air]>
          - case boots:
            - equip <context.entity> boots:<item[air]>
      - else:
        - foreach continue
      - wait 2t
    on player right clicks block with:knightaxe:
    - if <player.has_flag[knightaxechargecooldown]>:
      - stop
    - flag <player> knightaxechargecooldown expire:190t
    - itemcooldown netherite_axe duration:190t
    - playsound sound:entity_blaze_death at:<player.eye_location> pitch:0 volume:2
    - playsound sound:entity_bat_takeoff at:<player.eye_location> pitch:0 volume:2
    - playsound sound:entity_zombie_infect at:<player.eye_location> pitch:1 volume:2
    - playsound sound:entity_zombie_villager_cure at:<player.eye_location> pitch:0 volume:2
    - playsound sound:entity_wither_death at:<player.eye_location> pitch:2 volume:2
    - adjust <player> velocity:<player.velocity.add[<player.eye_location.direction.vector.normalize.mul[0.5].with_y[0.5]>]>
    - repeat 50:
      - cast <player> speed duration:10t amplifier:1 no_ambient no_icon hide_particles
      - cast <player> fast_digging duration:10t amplifier:1 no_ambient no_icon hide_particles
      - playeffect at:<player.eye_location.sub[0,0.5,0].forward[-0.5]> effect:flame offset:1 velocity:<player.eye_location.direction.vector.normalize.mul[-0.1]> quantity:4 visibility:100
      - adjust <player> velocity:<player.velocity.add[<player.eye_location.direction.vector.normalize.mul[0.095].with_y[0]>]>
      - if <[value]> > 30:
        - playsound sound:block_beacon_ambient at:<player.eye_location> pitch:2 volume:1
        - cast <player> increase_damage duration:25t amplifier:1 no_ambient no_icon hide_particles
      - if <player.location.find.living_entities.within[1].exclude[<player>].get[1]||0> != 0:
        - playsound sound:entity_zombie_attack_iron_door at:<player.eye_location> pitch:0 volume:2
        - playsound sound:entity_zombie_attack_wooden_door at:<player.eye_location> pitch:0 volume:2
        - playsound sound:entity_zombie_break_wooden_door at:<player.eye_location> pitch:0 volume:2
        - adjust <player> velocity:<location[0,0,0]>
        - cast <player> increase_damage duration:20t amplifier:5 no_ambient no_icon hide_particles
        - foreach <player.location.find.living_entities.within[1].exclude[<player>]> as:shieldbash:
          - adjust <[shieldbash]> velocity:<player.velocity.add[<player.eye_location.direction.vector.normalize.mul[0.5].with_y[0.5]>]>
          - hurt <[shieldbash]> amount:5
        - stop
      - wait 1t
    on player left clicks block with:knightpan type:!air:
    - if <context.location.block.material.name> != air:
      - determine cancelled passively
      - playsound sound:block_anvil_place at:<player.eye_location> pitch:0 volume:2
      - playsound sound:custom.shovelkill at:<player.entity.eye_location> pitch:2 volume:2 custom
      - playsound sound:entity_zombie_attack_iron_door at:<player.entity.eye_location> pitch:0 volume:2
    on player damages entity with:knightpan:
    - if <context.damager.location.y> > <context.entity.location.y>:
      - cast <context.entity> slow duration:20t amplifier:7 no_icon hide_particles no_ambient
    - playsound sound:block_anvil_place at:<context.entity.eye_location> pitch:0 volume:2
    - playsound sound:custom.shovelkill at:<context.entity.eye_location> pitch:1 volume:2 custom
    - playsound sound:entity_zombie_attack_iron_door at:<context.entity.eye_location> pitch:0 volume:2
    on player knocks back entity:
    - if <player.item_in_hand.script.name||0> == knightpan:
      - determine <context.acceleration.mul[2.5]>