shotgun:
  type: item
  material: iron_horse_armor
  display name: <element[Shotgun].color[#C0C080]>
  mechanisms:
    unbreakable: true
    custom_model_data: 13374302
    hides: all
  lore:
  - <element[Kaplow!].color[#606040]>
  - 
  - <element[VINTAGE].color[#404878].bold>

shotguntriggers:
  type: world
  events:
    on player right clicks block with:shotgun:
    - ratelimit <player> 1t
    - if !<player.has_flag[riflecooldown]>:
      - playsound <player.location> sound:entity_iron_golem_hurt pitch:1.5 volume:1
      - playsound <player.location> sound:entity_skeleton_hurt pitch:1.5 volume:1
      - playsound <player.location> sound:entity_generic_explode pitch:1.5 volume:1
      - playsound <player.location> sound:entity_zombie_attack_wooden_door pitch:1.5 volume:1
      - flag <player> riflecooldown expire:15t
      - itemcooldown iron_horse_armor duration:15t
      - repeat 10:
        - shoot pellet origin:<player.eye_location.right[0.4].below[0.4]> speed:2 shooter:<player> spread:15 def:<player>|<player.eye_location.direction.vector>


shotgunhit:
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