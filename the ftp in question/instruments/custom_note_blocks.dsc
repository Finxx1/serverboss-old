## Configuration ##

note_block_config:
  type: data
  sounds:
    entity_llama_spit: rail
#   sound: block1|block2|block3
#   custom_sound|true: block1|block2|block3

# When adding custom note block sounds, the first value of the line needs to be the spigot name of the sound.
# The second value needs to be a block, or a list of blocks, that will play the sound if beneath a Note Block.
#   sound: block
#   sound: block1|block2|block3
#   block_chest_open: chest|trapped_chest
# A list of all sounds can be found here: https://hub.spigotmc.org/javadocs/spigot/org/bukkit/Sound.html
# When adding a #custom sound#, make sure to add "|true" after the sound, so that the script can recognize it correctly.
#   custom_sound|true: block1|block2|block3
#   block_crystal_activate|true: diamond_block|emerald_block

## Configuration End ##

note_block_handler:
  type: world
  debug: false
  events:
    on noteblock plays note:
    - define mat_below <context.location.below.material.name>
    - foreach <script[note_block_config].data_key[sounds]> as:match:
      - if <[mat_below].advanced_matches[<[match]>]>:
        - determine passively cancelled
        - if <[key].as_list.size> > 1:
          - define sound <[key].as_list.get[1]>
          - define custom <[key].as_list.get[2]>
        - else:
          - define sound <[key]>
          - define custom false
        - run play_note_task def:<context.location.material.note>|3|<[sound]>|<[custom]>|<context.location.add[0.5,1.1,0.5]>|0
        - foreach stop

#note_block_play_task:
#  type: task
#  debug: false
#  definitions: pitch|volume|sound|custom|location
#  script:
#    - if <[custom]||false>:
#      - playsound <[location]> sound:<[sound]> pitch:<[pitch]> volume:3 sound_category:records custom
#    - else:
#      - playsound <[location]> sound:<[sound]> pitch:<[pitch]> volume:3 sound_category:records
#    - playeffect effect:NOTE at:<[location].add[0.5,1.1,0.5]> offset:<[pitch]>,0,0 quantity:0 data:1