teslarifle:
  type: item
  material: golden_horse_armor
  display name: <element[Tesla Rifle].color[#00C0C0]>
  mechanisms:
    unbreakable: true
    custom_model_data: 13374313
    hides: all
  lore:
  - <element[ZAP!].color[#006060]>
  - 
  - <element[VINTAGE].color[#404878].bold>

teslabolt:
  type: item
  material: clay_ball
  display name: <element[Tesla Bolt].color[#00FFFF]>
  mechanisms:
    unbreakable: true
    custom_model_data: 13374310
    hides: all
  lore:
  - <element[you shouldnt have this!!].color[#008080]>
#  - 
#  - <element[VINTAGE].color[#404878].bold>


teslarifletriggers:
  type: world
  debug: false
  events:
    on player right clicks block with:teslarifle:
    - if !<player.has_flag[teslariflecooldown]>:
      - flag <player> teslariflecooldown expire:35t
      - itemcooldown golden_horse_armor duration:35t
      - define lookfwd <player.eye_location.forward[13]>
      - shoot teslabullet origin:<player.eye_location.right[0.4].below[0.4]> speed:3.5 shooter:<player> spread:1
      - playsound <player.location> sound:entity_iron_golem_hurt pitch:0 volume:1
      - playsound <player.location> sound:item_trident_return pitch:0 volume:1
      - playsound <player.location> sound:custom.lightning_charge pitch:1 volume:1 custom
      - playsound <player.location> sound:custom.lightning_discharge pitch:1 volume:1 custom
      - playsound <player.location> sound:custom.lightning_charge pitch:0 volume:1 custom
      - playsound <player.location> sound:custom.lightning_discharge pitch:0 volume:1 custom
      - playsound <player.location> sound:BLOCK_RESPAWN_ANCHOR_DEPLETE pitch:0 volume:2
      - repeat 8:
        - shoot teslabullet origin:<player.eye_location.right[0.4].below[0.4]> speed:3 shooter:<player> spread:15
      - foreach <player.eye_location.points_between[<[lookfwd]>].distance[1]>:
        - repeat 8 as:val_aux:
          - playeffect at:<[value].forward[<[val_aux]>]> effect:magic_crit quantity:2 offset:<element[0.1].add[<[val_aux]>]> velocity:<location[0,0,0].random_offset[2]> visibility:100
    on teslabullet hits entity:
    - run mgk_chainlightning def:<context.shooter>|<context.hit_entity>|<element[5]>
    on teslabullet hits block:
    - repeat 16:
      - playeffect <context.projectile.location> effect:magic_crit quantity:2 offset:1.5 velocity:<location[0,0,0].random_offset[1]> visibility:100
    - playsound <context.projectile.location> sound:custom.lightning_<list[discharge|charge].random> pitch:2 volume:1 custom