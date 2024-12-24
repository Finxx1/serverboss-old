1up:
  type: item
  material: diamond
  display name: <element[1-UP].color_gradient[from=#FFFFFF;to=#00FF00]>
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13375234
  lore:
  - <element[toad's house is fucking rigged].color_gradient[from=#808080;to=#008000]>
  - <&7>
  - <element[GENUINE].color[#206030].bold>

3up:
  type: item
  material: diamond
  display name: <element[3-UP].color_gradient[from=#FFFF00;to=#FFC000]>
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13375235
  lore:
  - <element[toad's house is SUPER fucking rigged].color_gradient[from=#808000;to=#806000]>
  - <&7>
  - <element[GENUINE].color[#206030].bold>

starman:
  type: item
  material: diamond
  display name: <element[Starman].color_gradient[from=#FFCF00;to=#FF8000]>
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13375236
  lore:
  - <element["Well yeah it's- it's crack yeah it's good it makes you high"].color_gradient[from=#806000;to=#804000]>
  - <&7>
  - <element[GENUINE].color[#206030].bold>

1uptriggers:
  type: world
  debug: false
  events:
    on player right clicks block with:1up:
    - determine cancelled passively
    - repeat 10:
      - playeffect effect:item_crack at:<player.eye_location.below[0.1]> offset:0.1,0.1,0.1 special_data:1up quantity:1 velocity:<[lookvec].div[10].random_offset[0.1]>
    - playsound sound:entity_generic_eat at:<player.location> pitch:1 volume:2
    - playsound sound:entity_player_levelup at:<player.location> pitch:0 volume:2
    - playsound sound:entity_player_levelup at:<player.location> pitch:1 volume:2
    - playsound sound:entity_player_levelup at:<player.location> pitch:2 volume:2
    - take iteminhand quantity:1 from:<player>
    - flag <player> 1ups:<player.flag[1ups].add[1]||1>
    on player right clicks block with:3up:
    - determine cancelled passively
    - repeat 10:
      - playeffect effect:item_crack at:<player.eye_location.below[0.1]> offset:0.1,0.1,0.1 special_data:3up quantity:1 velocity:<[lookvec].div[10].random_offset[0.1]>
    - playsound sound:entity_generic_eat at:<player.location> pitch:1 volume:2
    - playsound sound:entity_player_levelup at:<player.location> pitch:0 volume:2
    - playsound sound:entity_player_levelup at:<player.location> pitch:1 volume:2
    - playsound sound:entity_player_levelup at:<player.location> pitch:2 volume:2
    - playsound sound:block_bell_resonate at:<player.location> pitch:0 volume:2
    - playsound sound:block_bell_resonate at:<player.location> pitch:1 volume:2
    - playsound sound:block_bell_resonate at:<player.location> pitch:2 volume:2
    - take iteminhand quantity:1 from:<player>
    - flag <player> 1ups:<player.flag[1ups].add[3]||1>
    on player right clicks block with:starman:
    - determine cancelled passively
    - repeat 10:
      - playeffect effect:item_crack at:<player.eye_location.below[0.1]> offset:0.1,0.1,0.1 special_data:starman quantity:1 velocity:<[lookvec].div[10].random_offset[0.1]>
    - playsound sound:entity_generic_eat at:<player.location> pitch:1 volume:2
    - playsound sound:entity_player_levelup at:<player.location> pitch:0 volume:2
    - playsound sound:entity_player_levelup at:<player.location> pitch:1 volume:2
    - playsound sound:block_end_portal_spawn at:<player.location> pitch:1 volume:2
    - take iteminhand quantity:1 from:<player>
    - if <player.has_flag[starmaninvinc]>:
      - stop
    - flag <player> starmaninvinc expire:260t
    - playsound at:<player.eye_location> <player> sound:custom.starman pitch:1 volume:10 custom
    - playeffect at:<player.eye_location> effect:flash quantity:1 offset:0 visibility:100
    - repeat 260:
      - cast <player> speed duration:5t amplifier:4 no_icon hide_particles no_ambient
      - cast <player> fast_digging duration:5t amplifier:1 no_icon hide_particles no_ambient
      - heal <player> amount:1
      - feed <player> amount:1
      - playeffect at:<player.location> effect:redstone special_data:1|<color[#FF0000]> quantity:2 offset:0.2,0,0.2 visibility:100
      - playeffect at:<player.location.add[0,0.2,0]> effect:redstone special_data:1|<color[#FF8000]> quantity:2 offset:0.2,0,0.2 visibility:100
      - playeffect at:<player.location.add[0,0.4,0]> effect:redstone special_data:1|<color[#FFFF00]> quantity:2 offset:0.2,0,0.2 visibility:100
      - playeffect at:<player.location.add[0,0.6,0]> effect:redstone special_data:1|<color[#80FF00]> quantity:2 offset:0.2,0,0.2 visibility:100
      - playeffect at:<player.location.add[0,0.8,0]> effect:redstone special_data:1|<color[#00FF00]> quantity:2 offset:0.2,0,0.2 visibility:100
      - playeffect at:<player.location.add[0,1.0,0]> effect:redstone special_data:1|<color[#00FF80]> quantity:2 offset:0.2,0,0.2 visibility:100
      - playeffect at:<player.location.add[0,1.2,0]> effect:redstone special_data:1|<color[#0080FF]> quantity:2 offset:0.2,0,0.2 visibility:100
      - playeffect at:<player.location.add[0,1.4,0]> effect:redstone special_data:1|<color[#0000FF]> quantity:2 offset:0.2,0,0.2 visibility:100
      - playeffect at:<player.location.add[0,1.6,0]> effect:redstone special_data:1|<color[#8000FF]> quantity:2 offset:0.2,0,0.2 visibility:100
      - playeffect at:<player.location.add[0,1.8,0]> effect:redstone special_data:1|<color[#FF00FF]> quantity:2 offset:0.2,0,0.2 visibility:100
      - playeffect at:<player.eye_location> effect:redstone special_data:1|<color[#FFFFFF]> quantity:2 offset:1 visibility:100
      - wait 1t
      - if <[value].mod[3]> == 0:
        - title "title:<element[⚝<list[INVULNERABLE|INFINITE|INVINCIBLE|INDESTRUCTIBLE|INDOMITABLE|IMPENETRABLE].random>⚝].bold.italicize.color_gradient[from=#FF0000;to=#FF00FF;style=HSB]>" "subtitle:" targets:<player> fade_in:0t fade_out:2t stay:1t
    - playeffect at:<player.eye_location> effect:flash quantity:1 offset:0 visibility:100
    - playsound sound:entity_player_levelup at:<player.location> pitch:0 volume:2
    - playsound sound:block_end_portal_spawn at:<player.location> pitch:2 volume:2
    - flag <player> starmaninvinc:!
    on player damaged:
    - if <context.entity.has_flag[starmaninvinc]>:
      - determine cancelled passively
      - playeffect at:<context.damager.eye_location> effect:flash quantity:1 offset:0 visibility:100
      - adjust <context.damager> velocity:<context.damager.velocity.add[<context.damager.eye_location.sub[<context.entity.location.add[0,0.25,0]>]>]>
      - playsound at:<context.entity.eye_location> sound:custom.shoveldeflect pitch:2 volume:2 custom
      - playsound at:<context.entity.eye_location> sound:entity_generic_explode pitch:2 volume:2
    on player dies priority:-999:
    - if <player.flag[1ups]||0> > 0:
      - determine cancelled passively
      - flag <player> 1ups:<player.flag[1ups].sub[1]>
