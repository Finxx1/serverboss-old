beegun:
  type: item
  material: iron_horse_armor
  display name: <element[Bee Gun].color[#C0C040]>
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13374320
  lore:
  - <element[bzzzzm tsZk!].color[#606020]>
  - 
  - <element[VINTAGE].color[#404878].bold>

beeguntriggers:
  type: world
  events:
    on player right clicks block with:beegun:
    - ratelimit 0t <player>
    - if !<player.has_flag[riflecooldown]>:
      - flag <player> riflecooldown expire:3t
      - itemcooldown iron_horse_armor duration:3t
      - playsound <player.location> sound:entity_iron_golem_hurt pitch:2 volume:1
      - playsound <player.location> sound:entity_zombie_attack_wooden_door pitch:1 volume:1
      - playsound sound:ENTITY_BEE_HURT pitch:1 volume:2 at:<player.eye_location>
      - shoot killerbee[flag_map=[beeowner=<player>;beespeed=0.2]] origin:<player.eye_location.right[0.4].below[0.4]> speed:4 shooter:<player> spread:5