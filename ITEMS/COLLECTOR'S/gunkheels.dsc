gunkheels:
  type: item
  material: leather_boots
  display name: <element[Gunk Heels].color_gradient[from=#60C030;to=#306018]>
  mechanisms:
    unbreakable: true
    hides: all
    color: <color[#60C030]>
  lore:
  - <element[Klwampoonsch!].color_gradient[from=#306018;to=#18300C]>
  -
  - <element[COLLECTOR'S].color[#800000].bold>


gunkheelstriggers:
  type: world
  events:
    on player damaged by FALL:
    - if <player.has_equipped[gunkheels]||0> && !<player.is_sneaking>:
      - determine cancelled passively
      - playsound sound:block_slime_block_break at:<player.location> pitch:1 volume:1
      #- announce <context.damage.mul[0.1].min[2.6]>
      #- announce <player.velocity.y>
      #- announce <player.fall_distance>
      - adjust <player> velocity:<location[<player.velocity.x.mul[<context.entity.fall_distance.min[20].div[5].add[1]>]>,<context.entity.fall_distance.min[20].div[11]>,<player.velocity.z.mul[<context.entity.fall_distance.min[20].div[5].add[1]>]>]>
      - repeat 160:
        - playeffect effect:block_crack quantity:1 at:<player.location> special_data:slime_block offset:0.1 visibility:64 velocity:<location[0,0.2,0].random_offset[1]> 