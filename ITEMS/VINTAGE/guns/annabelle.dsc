annabelle:
  type: item
  material: iron_horse_armor
  display name: <element[Annabelle].color[#FFB000]>
  mechanisms:
    unbreakable: true
    custom_model_data: 13374331
    hides: all
  lore:
  - <element[Brother, aim for the head!].color[#805800]>
  - 
  - <element[VINTAGE].color[#404878].bold>

annabelletriggers:
  type: world
  events:
    on player right clicks block with:annabelle:
    - if <player.has_flag[riflecooldown]>:
      - stop
    - playsound at:<player.eye_location> sound:entity_iron_golem_hurt pitch:0 volume:1
    - playsound at:<player.eye_location> sound:entity_generic_explode pitch:1 volume:1
    - playsound at:<player.eye_location> sound:custom.classic_explode pitch:1 volume:1 custom
    - playsound at:<player.eye_location> sound:entity_firework_rocket_large_blast pitch:2 volume:1
    - playsound at:<player.eye_location> sound:entity_firework_rocket_large_blast pitch:1 volume:1
    - playsound at:<player.eye_location> sound:entity_firework_rocket_large_blast pitch:0 volume:1
    - flag <player> riflecooldown expire:20t
    - itemcooldown iron_horse_armor duration:20t
    - define aimtarg <player.eye_location.ray_trace[range=100;return=precise;default=air;nonsolids=false;entities=*;ignore=<player>;raysize=0.1]>
    - define posline <player.eye_location.points_between[<[aimtarg]>].distance[1]>
    - foreach <[posline]>:
      - playeffect at:<[value]> effect:smoke offset:0 quantity:2 visibility:100
    - define targeted <[aimtarg].find.living_entities.within[1.5].get[1]||0>
    - if <[targeted]> != 0:
      - if <list[husk|zombie|skeleton|stray|drowned|skeletonprince|skeletonking|bloaterzombie|hivezombie|knightzombie].contains_any[<[targeted].name>]>:
        - if <[targeted].health> < 36:
          - flag <player> mantles:<player.flag[mantles].add[1]||1>
        - hurt <[targeted]> amount:36 source:player
      - else:
        - if <[targeted].health> < 18:
          - flag <player> mantles:<player.flag[mantles].add[1]||1>
        - hurt <[targeted]> amount:18 source:player