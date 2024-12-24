zirconiumpants:
  type: item
  material: golden_leggings
  display name: <element[Zirconium Pants].color_gradient[from=#FF80C0;to=#C060A0]>
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13374200
  lore:
  - <element[Do you like how I walk?].color_gradient[from=#804060;to=#603050]>
  - <element[Do you like how I talk?].color_gradient[from=#804060;to=#603050]>
  - <element[Do you like how my face,].color_gradient[from=#804060;to=#603050]>
  - <element[Disintegrates into chalk?].color_gradient[from=#804060;to=#603050]>
  - 
  - <element[COLLECTOR'S].color[#800000].bold>

zirconiumtriggers:
  type: world
  debug: false
  events:
    on entity targets player:
    - if <context.entity.is_living>:
      - if <player.has_equipped[zirconiumpants]> && !<context.entity.has_flag[charmed]>:
        - if <util.random_chance[35]>:
          - determine cancelled passively
          - flag <context.entity> charmed expire:20s
          - repeat 10:
            - playeffect at:<context.entity.eye_location> effect:damage_indicator quantity:1 offset:0.5 visibility:100
            - wait 10t
            - attack <context.entity> target:<context.entity.eye_location.find.living_entities.within[32].exclude[<player>].exclude[<context.entity>].get[1]||0>
            - if !<context.entity.is_spawned>:
              - stop
      - if <context.entity.has_flag[charmed]>:
        - determine cancelled passively