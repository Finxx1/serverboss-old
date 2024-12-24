brightweapon:
  type: item
  material: iron_horse_armor
  display name: <element[Bright Weaponry].color[#FFFFFF]>
  mechanisms:
    unbreakable: true
    custom_model_data: 13374330
    hides: all
  lore:
  - <element[BADASS!!!].color[#808080]>
  - 
  - <element[VINTAGE].color[#404878].bold>

brightweapontriggers:
  type: world
  events:
    on player holds item item:brightweapon:
    - playsound at:<player.eye_location> sound:custom.click1 pitch:<list[0.9|1|1.1].random> volume:2 custom
    on player right clicks block with:brightweapon:
    - if <player.has_flag[riflecooldown]>:
      - stop
    - flag <player> riflecooldown
    - itemcooldown iron_horse_armor duration:9000t
    - hurt <player> amount:3
    - repeat 20:
      - define target <player.eye_location.forward[6].find.living_entities.within[5].exclude[<player>].filter_tag[<player.eye_location.line_of_sight[<[filter_value].eye_location>]>].random||0>
      - define enemyloc <[target].eye_location>
      - define pointsline <player.eye_location.sub[0,0.25,0].points_between[<[enemyloc]>].distance[0.5].first[6]>
      - define pointsaim <player.eye_location.sub[0,0.25,0].points_between[<player.eye_location.forward[3]>].distance[0.5]>
      - if <[target]> != 0:
        - foreach <[pointsline]> as:value2:
          - playeffect at:<[value2]> effect:large_smoke offset:0.05 visibility:100
        - hurt <[target]> amount:<list[4|4|4|16].random> source:<player>
        - adjust <[target]> no_damage_duration:1t
        - if <util.random_chance[25]>:
          - repeat 64 as:ballsack:
            - playeffect at:<[target].eye_location> effect:crit offset:0.1 quantity:1 visibility:100 velocity:<location[0,0,0].random_offset[0.1]>
          - cast <[target]> SLOW amplifier:6 duration:100t no_ambient no_icon hide_particles
      - else:
        - foreach <[pointsaim]> as:value2:
          - playeffect at:<[value2]> effect:large_smoke offset:0.05 visibility:100
      - playsound at:<player.eye_location> sound:custom.shot<list[1|2|3|4|5|6|7].random> pitch:<list[0.9|1|1.1].random> volume:2 custom
      - wait 4t
      - if <[value]> > 5:
        - if <util.random_chance[20]>:
          - repeat stop
    - flag <player> riflecooldown expire:30t
    - itemcooldown iron_horse_armor duration:30t
    - wait 15t
    - playsound at:<player.eye_location> sound:custom.click2 pitch:<list[0.9|1|1.1].random> volume:2 custom