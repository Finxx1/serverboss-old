microwavegun:
  type: item
  material: golden_horse_armor
  display name: <element[Microwave Gun].color[#606060]>
  mechanisms:
    unbreakable: true
    custom_model_data: 13374315
    hides: all
  lore:
  - <element[vbmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm].color[#303030]>
  - 
  - <element[VINTAGE].color[#404878].bold>

microwavefire:
  type: world
  debug: false
  events:
    on player right clicks block with:microwavegun:
    - if <player.has_flag[microwavecooldown]>:
      - stop
    - flag <player> microwavecooldown expire:40t
    - itemcooldown golden_horse_armor duration:40t
    - playsound at:<player.eye_location> sound:block_beehive_work pitch:0 volume:2
    - playsound at:<player.eye_location> sound:custom.dialup_stand_summon pitch:2 volume:2 custom
    - define aimtarg <player.eye_location.ray_trace[range=35;return=precise;default=air;nonsolids=false;ignore=*;raysize=0.5]> 
    - define posline <player.eye_location.points_between[<[aimtarg]>].distance[1]>
    - foreach <[posline]>:
      - define hittarg <[value].find.living_entities.within[2].exclude[<player>]>
      - foreach <[hittarg]> as:unlucky:
        - hurt <[unlucky]> amount:3 source:<player>
        - burn <[unlucky]> duration:<list[30|50|85].random>t
        - define enttype <[unlucky].script.name||<[unlucky].entity_type>>
        - if <list[IRON_GOLEM|axemachine].contains_any[<[enttype]>]>:
          - run mgk_chainlightning def:<player>|<[unlucky]>|<element[8]>
          - foreach stop
      - if <util.random_chance[50]>:
        - playeffect effect:cloud at:<[value]> offset:1 quantity:1 visibility:100