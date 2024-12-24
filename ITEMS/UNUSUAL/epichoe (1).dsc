epichoetriggers:
  type: world
  events:
    on player left clicks block with:epichoe:
    # 1:
    # Play swing sound, depending on if the attack cd is full
    - if <player.attack_cooldown_percent> == 100:
      - playsound sound:entity_player_attack_sweep at:<player.location> pitch:1.2
    on player damages entity with:epichoe:
    #- narrate "hit registered"
    # 1:
    # Play task
    - run epichoehit def:<context.entity>|<context.damager>

epichoehit:
  type: task
  definitions: target|damager
  script:
  # 1:
  # Play sound and particles, depending on the attack cd. stop otherwise
  - if <player.attack_cooldown_percent> == 100:
    - playsound sound:entity_player_attack_sweep at:<player.location> pitch:1 volume:1
    - playsound sound:block_enchantment_table_use at:<player.location> pitch:1.6 volume:0.6
    - playsound sound:block_grass_break at:<[target].location> volume:1.2
    - playsound sound:block_grass_break at:<[target].location> volume:1.2 pitch:1.5
    - playeffect effect:block_crack at:<[target].eye_location> special_data:grass quantity:40 offset:0.35
    - playeffect effect:block_crack at:<[target].eye_location> special_data:oak_leaves quantity:60 offset:0.55
    - playeffect effect:sweep_attack at:<[target].eye_location.below[0.5]> quantity:2 offset:0.3
  - else:
    - playsound sound:entity_player_attack_sweep at:<player.location> pitch:1.7 volume:0.5
    - playeffect effect:block_crack at:<[target].eye_location> special_data:dirt quantity:10 offset:0.2
    - stop
  # 2:
  # full cd, continue the script after checking the entity is alive
  # random attack
  - wait 1t
  - if <[target].is_spawned.not>:
    - stop
  - random:
    - run epichoepoison def:<[target]>|<[damager]>
    - run epichoewind def:<[target]>|<[damager]>
    - run epichoeearthhit def:<[target]>|<[damager]>