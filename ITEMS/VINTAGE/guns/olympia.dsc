olympia:
  type: item
  material: iron_horse_armor
  display name: <element[Olympia].color[#A0C080]>
  mechanisms:
    unbreakable: true
    custom_model_data: 13374304
    hides: all
  lore:
  - <element[Kfra-Kaplffshow!].color[#506040]>
  - 
  - <element[VINTAGE].color[#404878].bold>

olympiatriggers:
  type: world
  events:
    on player right clicks block with:olympia:
    - ratelimit <player> 1t
    - if !<player.has_flag[riflecooldown]>:
      - playsound <player.location> sound:entity_iron_golem_hurt pitch:0.75 volume:1
      - playsound <player.location> sound:entity_skeleton_hurt pitch:0.75 volume:1
      - playsound <player.location> sound:entity_generic_explode pitch:1 volume:1
      - playsound <player.location> sound:entity_zombie_attack_wooden_door pitch:0.75 volume:1
      - playsound <player.location> sound:block_fire_extinguish pitch:0 volume:1
      - playsound <player.location> sound:entity_blaze_shoot pitch:0 volume:1
      - playsound <player.location> sound:entity_blaze_shoot pitch:1 volume:1
      - playsound <player.location> sound:block_fire_ambient pitch:1 volume:1
      - playsound <player.location> sound:block_fire_ambient pitch:0 volume:1
      - flag <player> riflecooldown expire:55t
      - itemcooldown iron_horse_armor duration:55t
      - define lookvec <player.eye_location.direction.vector.mul[0.5]>
      - adjust <player> velocity:<player.velocity.sub[<[lookvec]>]>
      - repeat 20:
        - shoot pellet[fire_time=<list[10t|1s|2s].random>] origin:<player.eye_location.right[0.4].below[0.4]> speed:2 shooter:<player> spread:30 def:<player>|<player.eye_location.direction.vector>
      - playeffect effect:flame at:<player.eye_location.right[0.4].below[0.4].forward[1]> offset:1 quantity:20 visibility:100
      - repeat 30:
        - wait 1t
        - playeffect effect:smoke_large at:<player.eye_location.right[0.4].below[0.4]> offset:0 visibility:100