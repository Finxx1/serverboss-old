playerafkroom:
  debug: false
  type: world
  events:
    on player goes afk:
    - flag <player> preafkpos:<player.location>
    - cast <player> blindness duration:20t no_ambient hide_particles no_icon
    - wait 3t
    - teleport <player> <location[15,100,280,deathplane]>
    #- wait 5t
    - if <player.has_flag[afkmusic]>:
      - playsound <player.location> <player> sound:music_disc_wait pitch:0 volume:1
    on player returns from afk:
    - teleport <player> <player.flag[preafkpos]>
    - cast <player> blindness duration:20t no_ambient hide_particles no_icon
    - adjust <player> stop_sound
    on player joins:
    - if <server.has_flag[safetymode]>:
      - repeat 10:
        - execute as_server "/sudo * c:/minecraft:kill @e[type=item,distance=..25]" silent
        - wait 1t

afksfx:
    debug: false
    type: command
    name: afksfx
    description: "Toggles afk room music"
    aliases:
    - afx
    usage: /afksfx
    script:
    - if <player.has_flag[afkmusic]>:
      - flag player afkmusic:!
    - else:
      - flag player afkmusic