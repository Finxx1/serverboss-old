hivezombie:
  type: entity
  entity_type: zombie
  mechanisms:
    age: adult
    equipment: <map[helmet=<item[bee_nest]>;chestplate=<item[air]>;leggings=<item[air]>;boots=<item[air]>]>
    item_in_hand: air
    item_in_offhand: air

hivezombiehandler:
  type: world
  events:
    on hivezombie damaged:
    - if <util.random_chance[35]>:
      - playeffect effect:redstone special_data:2|<color[#FFC000]> quantity:16 offset:0.5 visibility:100 at:<context.entity.eye_location>
      - repeat <list[1|2|3].random>:
        - spawn killerbee[flag_map=[beeowner=<context.entity>;beespeed=0.05;arenamob=<context.entity.flag[arenamob]>];velocity=<location[0,0,0].random_offset[0.2]>] at:<context.entity.eye_location>
      - wait 2t
      - playsound sound:entity_zombie_villager_step pitch:0 at:<context.entity.eye_location> volume:2
    after hivezombie spawns:
    - libsdisguise player target:<context.entity> name:jotero_van hide_name