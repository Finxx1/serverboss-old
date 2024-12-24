rifle3:
  type: item
  material: iron_horse_armor
  display name: <element[AR3].color[#406060]>
  mechanisms:
    unbreakable: true
    custom_model_data: 13374313
    hides: all
  lore:
  - <element[Ratatatatatatatatata!!].color[#203030]>
  - 
  - <element[VINTAGE].color[#404878].bold>

rifle3triggers:
  type: world
  events:
    on player right clicks block with:rifle3:
    - ratelimit <player> 1t
    - if !<player.has_flag[riflecooldown]>:
      - flag <player> riflecooldown expire:5t
      - itemcooldown iron_horse_armor duration:5t
      - playsound <player.location> sound:entity_iron_golem_hurt pitch:1 volume:1
      - playsound <player.location> sound:entity_skeleton_hurt pitch:2 volume:1
      - playsound <player.location> sound:entity_zombie_attack_iron_door pitch:0 volume:1
      - playsound <player.location> sound:entity_generic_explode pitch:1.5 volume:1
      - shoot ricoshot origin:<player.eye_location.right[0.4].below[0.4]> speed:2.5 shooter:<player> spread:0 save:ar3shot
      - flag <entry[ar3shot].shot_entity> bounces:10