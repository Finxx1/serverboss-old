supershotgun:
  type: item
  material: iron_horse_armor
  display name: <element[Super Shotgun].color[#80C080]>
  mechanisms:
    unbreakable: true
    custom_model_data: 13374303
    hides: all
  lore:
  - <element[Kra-Kaplow!].color[#406040]>
  - 
  - <element[VINTAGE].color[#404878].bold>

sshotguntriggers:
  type: world
  events:
    on player right clicks block with:supershotgun:
    - ratelimit <player> 1t
    - if !<player.has_flag[riflecooldown]>:
      - playsound <player.location> sound:entity_iron_golem_hurt pitch:0.75 volume:1
      - playsound <player.location> sound:entity_skeleton_hurt pitch:0.75 volume:1
      - playsound <player.location> sound:entity_generic_explode pitch:1 volume:1
      - playsound <player.location> sound:entity_zombie_attack_wooden_door pitch:0.75 volume:1
      - flag <player> riflecooldown expire:45t
      - itemcooldown iron_horse_armor duration:45t
      - define lookvec <player.eye_location.direction.vector.mul[0.75]>
      - adjust <player> velocity:<player.velocity.sub[<[lookvec]>]>
      - repeat 35:
        - shoot pellet origin:<player.eye_location.right[0.4].below[0.4]> speed:2 shooter:<player> spread:30 def:<player>|<player.eye_location.direction.vector>
      - repeat 20:
        - wait 1t
        - playeffect effect:smoke_large at:<player.eye_location.right[0.4].below[0.4]> offset:0 visibility:100


sshotgunhit:
  debug: false
  type: task
  definitions: shooterplayer|lookingdir
  script:
  - define hitbastard <[hit_entities].get[1]>
  - define shotbullet <[shot_entities].get[1]>
  - flag <[hitbastard]> beingshot expire:1s
  - adjust <[hitbastard]> max_no_damage_duration:1t
  - define dmg <[hitbastard].eye_location.find_entities[pellet].within[1.5].size.mul[2]>
  #- announce <[dmg]>
  - hurt <[hitbastard]> <[dmg]>
  - adjust <[hitbastard]> velocity:<[hitbastard].velocity.mul[1].add[<[lookingdir].div[<[proxamplif].mul[4]>]>]>
  - wait 2s
  - if !<[hitbastard].has_flag[beingshot]>:
    - adjust <[hitbastard]> max_no_damage_duration:20t