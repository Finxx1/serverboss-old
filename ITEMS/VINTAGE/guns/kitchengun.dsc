kitchengun:
  type: item
  material: iron_horse_armor
  display name: <element[Kitchen Gun].color[#80C0FF]>
  mechanisms:
    unbreakable: true
    custom_model_data: 13374312
    hides: all
  lore:
  - <element[BANG! BANG! BANG!].color[#406080]>
  - 
  - <element[VINTAGE].color[#404878].bold>

kitchenguntriggers:
  type: world
  events:
    on player right clicks block with:kitchengun:
    - if !<player.has_flag[riflecooldown]>:
      - announce <element[<player.display_name> &gt&gt BANG!].unescaped>
      - playsound <player.location> sound:entity_iron_golem_hurt pitch:2 volume:1
      - playsound <player.location> sound:entity_skeleton_hurt pitch:2 volume:1
      - playsound <player.location> sound:entity_zombie_attack_wooden_door pitch:2 volume:1
      - playsound <player.location> sound:weather_rain pitch:1 volume:1
      - playsound <player.location> sound:entity_generic_explode pitch:2 volume:1
      - playsound <player.location> sound:entity_generic_explode pitch:1 volume:1
      - define lookvec <player.eye_location.direction.vector>
      - flag <player> riflecooldown expire:15t
      - itemcooldown iron_horse_armor duration:15t
      - define aimtarg <player.eye_location.ray_trace[range=100;return=precise;default=air;nonsolids=false;entities=*;ignore=<player>;raysize=0.5]>
      - define posline <player.eye_location.points_between[<[aimtarg]>].distance[1]>
      - foreach <[posline]>:
        - playeffect effect:splash quantity:2 at:<[value]> offset:0.1 visibility:100
        - playeffect effect:bubble_pop quantity:2 at:<[value]> offset:0.1 visibility:100
        - playeffect effect:falling_water quantity:2 at:<[value]> offset:0.1 visibility:100
      - playeffect effect:splash quantity:20 at:<[aimtarg]> offset:2 visibility:100
      - playeffect effect:bubble_pop quantity:20 at:<[aimtarg]> offset:2 visibility:100
      - playeffect effect:falling_water quantity:20 at:<[aimtarg]> offset:2 visibility:100
      - define hittarg <[aimtarg].find.living_entities.within[1.5].exclude[<player>].get[1]||0>
      - hurt <[hittarg]> amount:6 source:<player>
      - if <[hittarg].health> <= 6:
        - announce <element[<player.display_name> &gt&gt <list[<element[AND THE LIMESCALE'S GONE!]>|<element[SPARKLES LIKE NEW!]>|<element[GOODBYE DIRT!]>|<element[I LOVE YOU KITCHEN GUN!]>|<element[AHAHAHAHAA!!!]>|<element[THERE, ALL CLEAN AGAIN!]>].random>].unescaped>
      - define hit2 <[aimtarg].find.living_entities.within[3].exclude[<player>]||0>
      - foreach <[hit2]>:
        - adjust <[value]> fire_time:0t
        - adjust <[value]> velocity:<[lookvec].add[0,1,0].mul[0.5]>
        - if !<[value].has_flag[mgk_wet]>:
          - flag <[value]> mgk_wet expire:8s
          - run wet_run def:<[value]>
        - else:
          - flag <[value]> mgk_wet expire:8s
