timestopvisuals2:
  debug: false
  type: task
  definitions: players
  script:
  - define standnpc <player.flag[standnpc].as_npc>
  - define players <[players]>
  # title
  - run twtimestoptitle def:<[players]>
  # run ticking
  - run theworldticking def:<[players]>
  - playsound at:<player.location> sound:block_portal_travel volume:9 pitch:0
  - wait 25t
  # sound
  - run twtimestopsound
  # crazy hamburger sky
  - run timestopsky2
  # flash
  - repeat 2:
    - run timestopflashtw def:<[standnpc]>
  # blindness
  #- cast <[players]> blindness duration:20t no_icon

  - waituntil <player.has_flag[timestop]>
  # wait to end
  - waituntil <player.flag_expiration[timestop].duration_since[<util.time_now>].in_seconds> <= 3
  # forward float
  - flag <player> standfloattype:front duration:2.5s
  # repeat

  # flash
  - repeat 2:
    - run timestopflashtw def:<[standnpc]>
  # blindness
  #- cast <[players]> blindness duration:20t no_icon

theworldticking:
  debug: false
  type: task
  definitions: players
  script:
  - wait 1.25s
  - repeat 12:
    - playsound <player.location> sound:block_note_block_snare pitch:2 volume:1
    - wait 5t
    - playsound <player.location> sound:block_note_block_snare pitch:2 volume:0.3
    - wait 5t
    - playsound <player.location> sound:block_note_block_snare pitch:2 volume:1
    - wait 5t
    - playsound <player.location> sound:block_note_block_snare pitch:2 volume:0.3
    - wait 5t

timestopsky2:
  debug: false
  type: task
  script:
  - if <player.location.find.living_entities.within[100].filter[has_flag[timestop]].exclude[<player>].is_empty>:
    - define time <player.world.time>
  - repeat 30:
    - time global <player.time.add[800]>t
    - wait 1t
  # wait
  - waituntil <player.flag_expiration[timestop].duration_since[<util.time_now>].in_ticks> <= 40
  - repeat 30:
    - time global <player.time.sub[800]>t
    - wait 1t
  - if <[time]||null> != null:
    - time global <[time]>t

timestopflashtw:
  debug: false
  type: task
  definitions: standnpc
  script:
  - repeat 15:
    - if <[standnpc].is_spawned||false>:
      - playeffect flash at:<[standnpc].location.above.add[<util.random.decimal[1].to[-1]>,<util.random.decimal[1].to[-1]>,<util.random.decimal[1].to[-1]>]> quantity:2 offset:0
    - wait 2t

twtimestoptitle:
  debug: false
  type: task
  definitions: players
  script:
  - title targets:<[players]> title:<&f><&l>ZA fade_in:0t stay:5s
  - wait 5t
  - title targets:<[players]> title:<&e><&l>ZA fade_in:0t stay:5s
  - wait 15t
  - title targets:<[players]> "title:<&f><&l>ZA WARUDO" fade_in:0t fade_out:5t stay:0.6s
  - wait 5t
  - title targets:<[players]> "title:<&e><&l>ZA WARUDO" fade_in:0t fade_out:5t stay:0.6s
  - wait 10t
  - title targets:<[players]> "title:<&e><&l>ZA WARUDO" "subtitle:<&e><&o>TOKI WO TOMARE!" fade_in:0t fade_out:2t stay:1.5s


twtimestopsound:
  debug: false
  type: task
  script:
  - playsound <player.location> sound:entity_wither_spawn volume:9 pitch:0
  - playsound <player.location> sound:entity_wither_break_block volume:9 pitch:0
  - playsound <player.location> sound:block_note_block_bass volume:9 pitch:0
  - playsound <player.location> sound:block_note_block_basedrum volume:9 pitch:0
  - playsound <player.location> sound:block_note_block_didgeridoo volume:9 pitch:0
  #- playsound <player.location> sound:custom.tobi volume:1 pitch:0
  - playeffect flash at:<player.location> quantity:10 offset:0
  #- repeat 10:
  #  - playeffect flash at:<player.location> quantity:<element[2].mul[<[value]>].mul[<[value]>]> offset:<[value]>
  #  - wait 2t
  - strike <player.eye_location.forward[-50]>
  - wait 5s
  - playsound <player.location> sound:block_portal_trigger volume:9 pitch:0
  - wait 7.5s
  - adjust <player.location.find.players.within[200]> stop_sound
  - playsound <player.location> sound:block_note_block_bass volume:9 pitch:0
  - playsound <player.location> sound:block_note_block_basedrum volume:9 pitch:0
  - playsound <player.location> sound:block_note_block_didgeridoo volume:9 pitch:0
  - wait 1s
  - adjust <player.location.find.players.within[200]> stop_sound
  - playsound <player.location> sound:entity_enderman_stare volume:9 pitch:0
  - wait 12.5s
  - playsound <player.location> sound:block_portal_trigger volume:9 pitch:0
  - wait 7s
  - adjust <player.location.find.players.within[200]> stop_sound
  - playsound <player.location> sound:block_note_block_pling volume:1 pitch:2