ballz:
  type: item
  material: clay_ball
  display name: <element[B].color[#FF8080]><element[a].color[#FFFF80]><element[l].color[#80FF80]><element[l].color[#8080FF]>
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13374359
  lore:
  - <element[D].color[#804040]><element[e].color[#808040]><element[e].color[#408040]><element[z].color[#404080]>
  - <&7>
  - <element[GENUINE].color[#206030].bold>

ballz_ball:
  type: entity
  entity_type: snowball
  mechanisms:
    item: ballz

ball_GR:
  type: item
  material: clay_ball
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13374360
ball_RD:
  type: item
  material: clay_ball
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13374361
ball_YL:
  type: item
  material: clay_ball
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13374362
ball_GN:
  type: item
  material: clay_ball
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13374363
ball_BL:
  type: item
  material: clay_ball
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13374364

ball_gray:
  type: entity
  entity_type: snowball
  mechanisms:
     item: ball_GR
ball_red:
  type: entity
  entity_type: snowball
  mechanisms:
     item: ball_RD
ball_yellow:
  type: entity
  entity_type: snowball
  mechanisms:
     item: ball_YL
ball_green:
  type: entity
  entity_type: snowball
  mechanisms:
     item: ball_GN
ball_blue:
  type: entity
  entity_type: snowball
  mechanisms:
     item: ball_BL

gballtriggers:
  type: world
  debug: false
  events:
    on ball_gray hits player:
    - run achievementgive def:<player>|gray
    on player right clicks block with:ballz:
    - determine cancelled passively
    - take item_in_hand quantity:1
    - shoot ballz_ball speed:1 spread:0 origin:<player.eye_location.below[0.2].right[0.3]> shooter:<player>
    - playsound at:<player.eye_location> sound:entity_snowball_throw volume:6 pitch:0
    on ball_* hits block:
    - define projvel <context.projectile.velocity>
    - define projbnc <context.projectile.flag[bounces]||0>
    - define shootercont <context.projectile.shooter>
    - define hitface <context.hit_face>
    - if <[projbnc]> < 1:
      - stop
    - define pvel2 <location[<[projvel].x.mul[<[hitface].x.abs.mul[-2].add[1]>]>,<[projvel].y.mul[<[hitface].y.abs.mul[-2].add[1]>]>,<[projvel].z.mul[<[hitface].z.abs.mul[-2].add[1]>]>].mul[0.8]>
    - define bounceloc <context.location.add[0.5,0.5,0.5].add[<context.hit_face>]>
    - playsound <[bounceloc]> sound:custom.ballbounce pitch:<element[1].add[<[projbnc].div[10]>]> volume:0.8 custom
    - playsound <[bounceloc]> sound:entity_item_pickup pitch:<element[1].add[<[projbnc].div[10]>]> volume:0.8
    - spawn <context.projectile.script.name>[flag_map=[bounces=<[projbnc].sub[1]>];velocity=<[pvel2].random_offset[0.1]>;shooter=<[shootercont]>] <[bounceloc]>
    on ballz_ball hits block:
    - define projvel <context.projectile.velocity>
    - define hitface <context.hit_face>
    - define bounceloc <context.location.add[0.5,0.5,0.5].add[<context.hit_face>]>
    - define pvel2 <location[<[projvel].x.mul[<[hitface].x.abs.mul[-2].add[1]>]>,<[projvel].y.mul[<[hitface].y.abs.mul[-2].add[1]>]>,<[projvel].z.mul[<[hitface].z.abs.mul[-2].add[1]>]>].mul[0.8]>
    - playsound <player.location> sound:custom.ballbounce pitch:<element[1].add[<[projbnc].div[10]>]> volume:1 custom
    - playsound <player.location> sound:entity_item_pickup pitch:<element[1].add[<[projbnc].div[10]>]> volume:1
    - repeat 25:
      - if <util.random_chance[1]>:
        - spawn ball_gray[flag_map=[bounces=24];velocity=<[pvel2].mul[0.9].random_offset[0.3]>;shooter=<context.projectile.shooter>] <[bounceloc]> save:projbouncing
      - else:
        - spawn ball_<list[red|yellow|green|blue].random>[flag_map=[bounces=<list[9|7|8|11].random>];velocity=<[pvel2].random_offset[0.4]>;shooter=<context.projectile.shooter>] <[bounceloc]> save:projbouncing
    on ball_* hits entity:
    - define projvel <context.projectile.velocity>
    - define projbnc <context.projectile.flag[bounces]||0>
    - define shootercont <context.shooter>
    - define hitface <context.projectile.location.sub[<context.hit_entity.location.add[<context.hit_entity.eye_location>].mul[0.5]>].vector.normalize>
    - if <[projbnc]> < 1:
      - stop
    - define pvel2 <location[<[projvel].x.mul[<[hitface].x.abs.mul[-2].add[1]>]>,<[projvel].y.mul[<[hitface].y.abs.mul[-2].add[1]>]>,<[projvel].z.mul[<[hitface].z.abs.mul[-2].add[1]>]>].mul[0.8]>
    - define bounceloc <context.location.add[0.5,0.5,0.5].add[<context.hit_face>]>
    - spawn <context.projectile.script.name>[flag_map=[bounces=<[projbnc].sub[1]>];velocity=<[pvel2].random_offset[0.1]>;shooter=<[shootercont]>] <[bounceloc]>
    - if <context.hit_entity> == <[shootercont]>:
      - playsound sound:entity_player_burp at:<[shootercont].eye_location> pitch:2 volume:2
      - playsound sound:entity_player_burp at:<[shootercont].eye_location> pitch:2 volume:2
      - heal <[shootercont]> amount:2
      - feed <[shootercont]> amount:2 saturation:4
    - else:
      - hurt <context.hit_entity> amount:2
      - adjust <context.hit_entity> velocity:<context.hit_entity.velocity.add[<[projvel]>].add[0,0.1,0]>
      - playsound <context.hit_entity.eye_location> sound:custom.ballhit pitch:2 volume:2 custom
      - playsound <context.hit_entity.eye_location> sound:entity_item_pickup pitch:2 volume:2