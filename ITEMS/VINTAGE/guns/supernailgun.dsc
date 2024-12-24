perforator:
  type: item
  material: iron_horse_armor
  display name: <element[Super Nailgun].color[#C06050]>
  mechanisms:
    unbreakable: true
    custom_model_data: 13374332
    hides: all
  lore:
  - <element[PEWPEWPEWPEWPEWPEWPEWPEWPEW!!!].color[#603028]>
  - 
  - <element[VINTAGE].color[#404878].bold>

perforatortriggers:
  type: world
  events:
    on player right clicks block with:perforator:
    - if <player.has_flag[snailon]>:
      - flag <player> snailon expire:10t
      - stop
    - if !<player.has_flag[snailon]>:
      - flag <player> snailon expire:10t
      - choose <player.gamemode>:
        - case CREATIVE:
          - while <player.has_flag[snailon]>:
            - playsound <player.location> sound:entity_iron_golem_hurt pitch:2 volume:1
            - playsound <player.location> sound:entity_skeleton_hurt pitch:2 volume:1
            - playsound <player.location> sound:entity_zombie_attack_wooden_door pitch:2 volume:1
            - playsound <player.location> sound:custom.classic_bow_shoot pitch:2 volume:1 custom
            - playsound <player.location> sound:entity_generic_explode pitch:2 volume:1
            - shoot arrow[critical=true] origin:<player.eye_location.right[0.4].below[0.4]> speed:4 script:riflehit shooter:<player> spread:5
            - wait 2t
        - default:
          - while <player.has_flag[snailon]>:
            - if <player.inventory.contains_item[arrow]>:
              - take item:arrow quantity:1 from:<player.inventory>
              - playsound <player.location> sound:entity_iron_golem_hurt pitch:2 volume:1
              - playsound <player.location> sound:entity_skeleton_hurt pitch:2 volume:1
              - playsound <player.location> sound:entity_zombie_attack_wooden_door pitch:2 volume:1
              - playsound <player.location> sound:custom.classic_bow_shoot pitch:2 volume:1 custom
              - playsound <player.location> sound:entity_generic_explode pitch:2 volume:1
              - shoot arrow[critical=true] origin:<player.eye_location.right[0.4].below[0.4]> speed:4 script:riflehit shooter:<player> spread:5
              - wait 2t
            - else:
              - while stop
      - playsound <player.location> sound:block_note_block_didgeridoo pitch:0 volume:1
      - playsound <player.location> sound:block_piston_contract pitch:0 volume:1
      - flag <player> riflecooldown expire:40t
      - itemcooldown iron_horse_armor duration:40t