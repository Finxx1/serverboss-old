dnagun:
  type: item
  material: iron_horse_armor
  display name: <element[Parasonic C3].color[#20C040]><element[ ]><element[DNA Scrambler].color_gradient[from=#FF0020;to=#2000FF;style=HSB]>
  mechanisms:
    unbreakable: true
    custom_model_data: 13374318
    hides: all
  lore:
  - <element[Pew Pew Pe- ].color[#106020]><element[OH GOD WHAT THE FUCK].color_gradient[from=#800010;to=#100080;style=HSB]>
  - 
  - <element[VINTAGE].color[#404878].bold>

dnabullet:
  type: entity
  entity_type: snowball
  mechanisms:
    item: dnabulletsprite

dnaguntriggers:
  type: world
  events:
    on player right clicks block with:dnagun:
    - if !<player.has_flag[riflecooldown]>:
      - playsound <player.location> sound:entity_iron_golem_hurt pitch:2 volume:2
      - playsound <player.location> sound:item_crossbow_shoot pitch:2 volume:2
      - playsound <player.location> sound:item_snowball_throw pitch:2 volume:2
      - playsound <player.location> sound:ambient_underwater_exit pitch:0 volume:2
      - playsound <player.location> sound:item_bucket_empty pitch:0 volume:2
      - flag <player> riflecooldown expire:20t
      - itemcooldown iron_horse_armor duration:20t
      - shoot dnabullet origin:<player.eye_location.right[0.4].below[0.4]> speed:3.5 script:pistolhit shooter:<player> spread:1
    on dnabullet hits entity:
    - if <context.hit_entity.health> <= 5:
      - run goreburstatloc def:<context.hit_entity.eye_location>
      - run goreburstatloc def:<context.hit_entity.eye_location>
      - flag <context.hit_entity> infected expire:2s
      - cast <context.hit_entity> poison duration:25t amplifier:0 hide_particles no_icon no_ambient
      - hurt <context.hit_entity> amount:10
      - remove <context.hit_entity>
    - else:
      - hurt <context.hit_entity> amount:5
      - playsound <context.hit_entity.eye_location> sound:ENTITY_PLAYER_HURT_SWEET_BERRY_BUSH pitch:0 volume:2
      - playsound <context.hit_entity.eye_location> sound:ENTITY_PLAYER_HURT_SWEET_BERRY_BUSH pitch:1 volume:2
      - playsound <context.hit_entity.eye_location> sound:ENTITY_PLAYER_HURT_SWEET_BERRY_BUSH pitch:2 volume:2