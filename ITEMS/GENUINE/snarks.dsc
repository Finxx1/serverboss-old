snarks:
  type: item
  material: clay_ball
  display name: <element[Snarks].color_gradient[from=#C0C0C0;to=#80C0C0]>
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13374356
  lore:
  - <element[Snarks].color_gradient[from=#606060;to=#406060]>
  - <&7>
  - <element[GENUINE].color[#206030].bold>

snark:
  type: entity
  entity_type: silverfish
  mechanisms:
    max_health: 2
    health: 2
    speed: 0.35

snarktriggers:
  type: world
  debug: false
  events:
    on player right clicks block with:snarks:
    - determine cancelled passively
    - shoot snark origin:<player.eye_location.sub[0,0.5,0]> speed:1.5 spread:1 save:snarkyboi
    - define fuckeduplilshit <entry[snarkyboi].shot_entity>
    - flag <[fuckeduplilshit]> snarkowner:<player>
    - take item_in_hand quantity:1
    on snark damaged by FALL:
    - determine cancelled passively
    on snark changes block:
    - determine cancelled passively
    on snark targets player:
    - if <player> == <context.entity.flag[snarkowner]>:
      - determine cancelled passively
      - attack <context.entity> target:<context.entity.eye_location.find.living_entities.within[15].exclude[<context.entity>].exclude[<context.entity.flag[snarkowner]>].filter_tag[<[filter_value].script.name.is[==].to[snark].not||<[filter_value].name.is[==].to[snark].not>>].get[1]||0>
    on snark dies:
    - explode <context.entity.eye_location> power:1
    on snark damages entity:
    - determine 6
    after snark spawns:
    - repeat 100:
      - if !<context.entity.is_spawned>:
        - stop
      - define targel <context.entity.eye_location.find.living_entities.within[15].exclude[<context.entity>].exclude[<context.entity.flag[snarkowner]>].filter_tag[<[filter_value].script.name.is[==].to[snark].not||<[filter_value].name.is[==].to[snark].not>>].get[1]||0>
#      - announce <[targel]>
      - attack <context.entity> target:<[targel]>
      - if <[targel].location.distance[<context.entity.location>]> < 2 && <context.entity.is_on_ground>:
        - adjust <context.entity> velocity:<context.entity.location.sub[<[targel].eye_location>].normalize.mul[-0.5]>
      - wait 2t
    - kill <context.entity>