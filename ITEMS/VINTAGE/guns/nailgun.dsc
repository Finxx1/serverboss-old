nailgun:
  type: item
  material: iron_horse_armor
  display name: <element[Nailgun].color[#C06020]>
  mechanisms:
    unbreakable: true
    custom_model_data: 13374327
    hides: all
  lore:
  - <element[Pew pew pew pew!!!].color[#603010]>
  - 
  - <element[VINTAGE].color[#404878].bold>

nailguntriggers:
  type: world
  events:
    on player right clicks block with:nailgun:
    - if !<player.has_flag[riflecooldown]>:
      - flag <player> riflecooldown expire:6t
      - itemcooldown iron_horse_armor duration:6t
      - choose <player.gamemode>:
        - case CREATIVE:
          - repeat 3:
            - playsound <player.location> sound:entity_iron_golem_hurt pitch:2 volume:1
            - playsound <player.location> sound:entity_skeleton_hurt pitch:2 volume:1
            - playsound <player.location> sound:entity_zombie_attack_wooden_door pitch:2 volume:1
            - playsound <player.location> sound:custom.classic_bow_shoot pitch:2 volume:1 custom
            - playsound <player.location> sound:entity_generic_explode pitch:2 volume:1
            - shoot arrow[critical=<util.random_chance[25]>] origin:<player.eye_location.right[0.4].below[0.4]> speed:2.5 script:riflehit shooter:<player> spread:3
            - wait 2t
        - default:
          - repeat 3:
            - if <player.inventory.contains_item[arrow]>:
              - take item:arrow quantity:1 from:<player.inventory>
              - playsound <player.location> sound:entity_iron_golem_hurt pitch:2 volume:1
              - playsound <player.location> sound:entity_skeleton_hurt pitch:2 volume:1
              - playsound <player.location> sound:entity_zombie_attack_wooden_door pitch:2 volume:1
              - playsound <player.location> sound:custom.classic_bow_shoot pitch:2 volume:1 custom
              - playsound <player.location> sound:entity_generic_explode pitch:2 volume:1
              - shoot arrow[critical=<util.random_chance[25]>] origin:<player.eye_location.right[0.4].below[0.4]> speed:2.5 script:riflehit shooter:<player> spread:3
              - wait 2t
            - else:
              - playsound <player.location> sound:block_note_block_didgeridoo pitch:0 volume:1
              - playsound <player.location> sound:block_piston_contract pitch:1 volume:1