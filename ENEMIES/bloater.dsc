bloaterzombie:
  type: entity
  entity_type: husk
  mechanisms:
    age: adult
    equipment: <map[helmet=<item[air]>;chestplate=<item[air]>;leggings=<item[air]>;boots=<item[air]>]>
    item_in_hand: air
    item_in_offhand: air

bloaterzombiehandler:
  type: world
  events:
    on bloaterzombie dies:
    - define locshoot <context.entity.location.add[0,0.5,0].with_pitch[-90]>
    - playsound sound:entity_zombie_villager_cure pitch:2 volume:2 at:<context.entity.location>
    - playsound sound:entity_zombie_villager_step pitch:0 volume:2 at:<context.entity.location>
    - playeffect at:<context.entity.location.add[0,1,0]> effect:redstone offset:0.5 quantity:32 special_data:2|<color[#<list[80|40|00].random>FF00]> visibility:100
    - remove <context.entity>
    - repeat 16:
      - shoot acidparticle origin:<[locshoot]> speed:<list[0.3|0.6|0.9].random> spread:80
    after bloaterzombie spawns:
    - libsdisguise player target:<context.entity> name:MrKiweh hide_name