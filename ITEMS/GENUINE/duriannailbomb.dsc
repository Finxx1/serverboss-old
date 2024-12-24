ndurian:
  type: item
  material: clay_ball
  display name: <element[Durian ].color_gradient[from=#D8C080;to=#FFC8A0]><element[Nailbomb].color_gradient[from=#281808;to=#483828]>
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13374254
  lore:
  - <element[I honestly wouldn't expect you to eat this one either way].color_gradient[from=#6C6040;to=#806450]>
  - <&7>
  - <element[GENUINE].color[#206030].bold>

nduriantriggers:
  type: world
  debug: false
  events:
    on player right clicks block with:ndurian:
    - determine cancelled passively
    - take item_in_hand quantity:1
    - shoot ndurianproj speed:1 spread:0 origin:<player.eye_location.below[0.2].right[0.3].forward[0.5]> script:duriansplit
    - playsound at:<player.eye_location> sound:entity_snowball_throw volume:2 pitch:0
    on entity dies:
    - if <context.entity.has_flag[nailsembedded]>:
      - repeat <context.entity.flag[nailsembedded].mul[6]>:
        - shoot duriannailsproj speed:<list[0.55|0.85|1.15].random> spread:0 origin:<context.entity.location> destination:<context.entity.location.random_offset[1,0.25,1]> script:duriannailsprojectiles
    on entity damaged:
    - if <context.entity.has_flag[nailsembedded]>:
      - determine <context.damage.mul[<context.entity.flag[nailsembedded].div[2].add[1]>]>

duriansplit:
  type: task
  debug: false
  script:
  - playeffect at:<[location]> effect:redstone special_data:3|<color[#D8C080]> visibility:100 quantity:15 offset:0.5
  - playsound sound:custom.gib pitch:0 at:<[location]> volume:2 custom
  - playsound sound:entity_wither_break_block pitch:2 at:<[location]> volume:2
  - explode <[location]> power:1
  - repeat 128:
    - shoot duriannailsproj speed:<list[0.25|0.55|0.85|1.15|1.45].random> spread:0 origin:<[location]> destination:<[location].random_offset[1,0.25,1]> script:duriannailsprojectiles

duriannailsprojectiles:
  type: task
  debug: false
  script:
  - if <[hit_entities].is_empty>:
    - stop
  - playsound sound:entity_player_hurt_sweet_berry_bush pitch:<list[1|1.5|2].random> at:<[location]> volume:2
  - foreach <[hit_entities]>:
    - adjust <[value]> max_no_damage_duration:1t
    - hurt <[value]> amount:12
    - adjust <[value]> max_no_damage_duration:20t
    - flag <[value]> nailsembedded:<[value].flag[nailsembedded].add[1]||0> expire:10s