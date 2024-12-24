zillyhoo:
  type: item
  material: netherite_axe
  display name: <element[Warhammer].color_gradient[from=#00C0FF;to=#0000FF]><element[ ]><element[of].color[#FFC000]><element[ ]><element[Zillyhoo].color_gradient[from=#FF0000;to=#FF00FF;style=HSB]><element[!].color[#FF80C0]>
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13374244
  lore:
  - <element[go and slam the sun!].color[#0715CD]>
  - <&7>
  - <element[COLLECTOR'S].color[#800000].bold>


zillyhootriggers:
  type: world
  debug: false
  events:
    on player damages entity with:zillyhoo:
    - if <context.damager.has_flag[zillyhoocooldown]>:
      - stop
    - flag <context.damager> zillyhoocooldown expire:4s
    - itemcooldown netherite_axe duration:4s
    - playeffect at:<context.entity.eye_location> offset:2.5 quantity:10 velocity:<location[0,0,0].random_offset[1]> visibility:100 effect:NOTE
    - playeffect at:<context.entity.eye_location> offset:0 quantity:1 visibility:100 effect:FLASH
    - foreach <context.entity.eye_location.find.living_entities.within[3].exclude[<player>]||0>:
      - hurt <[value]> 5 source:<context.entity>
    - playsound at:<context.entity.eye_location> sound:entity_generic_explode volume:2 pitch:0
    - adjust <context.entity> velocity:<context.entity.eye_location.sub[<context.damager.location>].mul[2.5]>
    - define awareness <context.entity.is_aware>
    - adjust <context.entity> is_aware:false
    - repeat 3:
      - look <context.entity> <context.entity.eye_location.random_offset[1,0,1]>
      - wait 20t
    - adjust <context.entity> is_aware:<[awareness]>