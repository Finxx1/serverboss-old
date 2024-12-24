shotcoil:
  type: item
  material: iron_horse_armor
  display name: <element[Shotcoil].color[#801030]>
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13374305
  lore:
  - <element[Look I dont think a shotgun is supposed to].color[#400818]>
  - <element[have THAT many shells shoved into the front].color[#400818]>
  - <element[barrel at once this seems kinda dangerous].color[#400818]>
  - 
  - <element[VINTAGE].color[#404878].bold>

shotcoiltriggers:
  type: world
  debug: false
  events:
    on player right clicks block with:shotcoil:
    - if !<player.has_flag[riflecooldown]>:
      - playsound <player.location> sound:entity_iron_golem_hurt pitch:0 volume:3
      - playsound <player.location> sound:entity_skeleton_hurt pitch:0 volume:3
      - playsound <player.location> sound:entity_zombie_attack_wooden_door pitch:0 volume:3
      - playsound <player.location> sound:entity_zombie_attack_iron_door pitch:0 volume:3
      - playsound <player.location> sound:entity_creeper_explode pitch:0 volume:3
      - playsound <player.location> sound:entity_creeper_primed pitch:0 volume:3
      - flag <player> riflecooldown expire:200t
      - itemcooldown iron_horse_armor duration:200t
      - run shotcoilmultithread def:<player>
      - explode <player.eye_location.right[0.4].below[0.4]> power:1 source:<player>
      - define lookvec <player.eye_location.direction.vector.mul[3]>
      - adjust <player> velocity:<player.velocity.sub[<[lookvec]>]>
      - repeat 80:
        - wait 1t
        - playeffect effect:smoke_large at:<player.eye_location.right[0.4].below[0.4]> offset:0 visibility:100

shotcoilmultithread:
  type: task
  debug: false
  definitions: playa
  script:
  - define shotloc <[playa].eye_location.right[0.4].below[0.4]>
  - wait 1t
  - repeat 80:
    - shoot pellet origin:<[shotloc]> speed:2 shooter:<[playa]> spread:50
  - wait 1t
  - repeat 80:
    - shoot pellet origin:<[shotloc]> speed:2 shooter:<[playa]> spread:50