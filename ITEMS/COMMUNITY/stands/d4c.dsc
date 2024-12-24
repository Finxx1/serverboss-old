d4chide:
  type: item
  material: light_blue_concrete
  display name: <element[ゴ ゴ D4C ゴ ゴ].color_gradient[from=#98E8FF;to=#FF98C8]>
  lore:
  - <element[Dojyaaaan~~~].color_gradient[from=#98E8FF;to=#804CC4]>
  - <&7>
  - <element[COMMUNITY].color[#B0E060].bold>

d4ccommand:
  debug: false
  type: world
  events:
    on player left clicks block with:d4chide:
    - if !<player.has_flag[d4ccooldown]>:
      - run d4cscript def:<player>
      - determine cancelled passively

d4cscript:
  debug: false
  type: task
  definitions: standuser
  script:
  - define trolled <[standuser].location.find_players_within[60].exclude[<[standuser]>].get[1]>
  - waituntil !<[trolled].location.line_of_sight[<[standuser].location>]>
  - cast <[standuser]> invisibility duration:999999s amplifier:0 no_ambient hide_particles no_icon
  - waituntil <[trolled].location.line_of_sight[<[standuser].location>]>
  - waituntil !<[trolled].location.line_of_sight[<[standuser].location>]>
  - cast <[standuser]> remove invisibility
  - waituntil <[trolled].location.line_of_sight[<[standuser].location>]>
  - flag <[standuser]> d4ccooldown expire:12s
  - itemcooldown light_blue_concrete duration:12s

mihdial:
  debug: false
  type: task
  definitions: standuser
  script:
  - define trolled <[standuser].location.find_players_within[60].exclude[<[standuser]>].get[1]>
  - repeat 120:
    - teleport <[standuser]> <[trolled].location.random_offset[1.5,0.2,1.5]>
    - look <[standuser]> <[trolled].eye_location>
    - wait 1t