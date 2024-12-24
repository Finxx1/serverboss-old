playerdie:
  debug: false
  type: world
  events:
    on player dies:
    - choose <player.name>:
# EGG
      - case Eggtaroo:
        - playsound <player.location> sound:entity_wither_break_block pitch:1 volume:3
        - playeffect effect:item_crack at:<player.location.add[0,1,0]> offset:0.8,0.8,0.8 special_data:egg quantity:60 velocity:5
        - if <util.random_chance[25]>:
          - spawn chicken <player.location>
# ICE
      - case IcefTheo:
        - define loc <player.location>
        - playsound <player.location> sound:entity_generic_splash pitch:1 volume:3
        - playeffect effect:splash at:<[loc].add[0,1,0]> offset:0.5,0.5,0.5 quantity:120 velocity:5
        - wait 2t
        - playeffect effect:splash at:<[loc].add[0,1,0]> offset:0.5,0.5,0.5 quantity:120 velocity:5
        - wait 2t
        - playeffect effect:splash at:<[loc].add[0,1,0]> offset:0.5,0.5,0.5 quantity:120 velocity:5
        - wait 2t
        - modifyblock <[loc]> water
        - wait 1s
        - modifyblock <[loc]> air
# ISM
      - case AGooseWithAPhone:
        - define loc <player.location>
        - playsound <player.location> sound:entity_chicken_death pitch:1 volume:3
        - playeffect effect:cloud at:<[loc].add[0,1,0]> offset:0.5,0.5,0.5 quantity:120 velocity:5
        - playeffect effect:item_crack at:<player.location.add[0,1,0]> offset:0.8,0.8,0.8 special_data:feather quantity:60 velocity:5
# SPEEDER
      - case Speeder323:
        - define loc <player.location>
        - repeat 20:
          - strike <[loc]> no_damage
          - wait 1t
# HECKER
      - case rika55:
        - cast <player> invisibility duration:1s amplifier:1 hide_particles no_ambient no_icon
        - define loc <player.location>
        - playsound <player.location> sound:entity_ghast_shoot pitch:0 volume:3
        - playeffect effect:smoke_large at:<[loc].add[0,1,0]> offset:0.8,0.8,0.8 quantity:120 velocity:5
        - repeat 6:
          - spawn bat <player.location>
# HEAPONS
      - case Heapons: 
        - if !<player.has_flag[heaponsdeath]>:
          - determine cancelled passively
          - define loc <player.location>
          - playsound <player.location> sound:block_portal_trigger pitch:1 volume:3
          - repeat 70:
            - playeffect effect:ash at:<player.location.add[0,1,0]> offset:0.2,0.4,0.2 quantity:120 velocity:5
            - wait 1t
          - cast <player> invisibility duration:2s amplifier:1 hide_particles no_ambient no_icon
          - wait 1t
          - playsound <player.location> sound:entity_ghast_shoot pitch:0 volume:3
          - flag <player> heaponsdeath expire:1
          - kill <player>
# FAILSAFE?
      - default:
          - playsound <player.location> sound:custom.oof pitch:1 volume:1 custom