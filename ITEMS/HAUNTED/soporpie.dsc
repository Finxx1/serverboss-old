soporpie:
  type: item
  material: pumpkin_pie
  mechanisms:
    custom_model_data: 13374200
  display name: <element[Sopor Pie].color_gradient[from=#E8B878;to=#40FF00]>
  lore:
  - <element[Sending shivers down my spine].color_gradient[from=#745C3C;to=#208000]>
  - <&7>
  - <element[HAUNTED].color[#38F0A8].bold>

soporpieeat:
  debug: false
  type: world
  events:
    on player consumes soporpie:
    - determine cancelled passively
    - feed <player> 200
    - playsound sound:custom.honk at:<player.eye_location> pitch:0 volume:2 custom
    - playsound sound:block_slime_block_break at:<player.eye_location> pitch:0 volume:2 
    - playeffect effect:redstone special_data:2|<color[#40FF00]> at:<player.eye_location> offset:0.5 quantity:16 visibility:100
    - adjust <player> health:<player.health_max>
    - if <player.has_flag[sopor]>:
      - flag <player> sopor expires:1200t
      - title "title:" "subtitle:<element[shoosh...].color[#40FF00]>" fade_in:10t stay:3t fade_out:10t targets:<player>
    - else:
      - flag <player> sopor expires:1200t
      - cast <player> slow duration:240t amplifier:0 no_icon no_ambient hide_particles
      - cast <player> slow_digging duration:240t amplifier:0 no_icon no_ambient hide_particles
      - wait 240t
      - repeat 40:
        - if !<player.has_flag[sopor]>:
          - hurt <player> amount:<list[1|2].random>
          - cast <player> increase_damage duration:120t amplifier:1 no_icon no_ambient hide_particles
          - wait 40t
          - if <util.random_chance[99]>:
            - playsound sound:custom.honk at:<player.eye_location> pitch:<list[0.85|1|1.15].random> volume:2 custom
          - else:
            - playsound sound:custom.jlaugh3 at:<player.eye_location> pitch:<list[0.85|1|1.15].random> volume:2 custom
        - wait 40t
        