dinnerblaster:
  type: item
  material: iron_horse_armor
  display name: <element[Dinner Blaster].color[#B08030]>
  mechanisms:
    unbreakable: true
    custom_model_data: 13374340
    hides: all
  lore:
  - <element[Snooping as usual I see!].color[#584018]>
  - 
  - <element[VINTAGE].color[#404878].bold>

dinner:
  type: item
  material: golden_carrot
  display name: <element[Hamburger].color_gradient[from=#FFC040;to=#B08030]>
  mechanisms:
    unbreakable: true
    custom_model_data: 13374200
    hides: all
  lore:
  - <element[I wonder what's for DINNER].color_gradient[from=#806020;to=#584018]>
  - 
  - <element[GENUINE].color[#206030].bold>

dinnerproj:
  type: entity
  entity_type: snowball
  mechanisms:
    item: dinner

dinnerblastertrigger:
  type: world
  events:
    on player right clicks block with:dinnerblaster:
    - ratelimit <player> 1t
    - if !<player.has_flag[riflecooldown]>:
      - playsound <player.location> sound:entity_iron_golem_hurt pitch:0 volume:2
      - playsound <player.location> sound:entity_generic_extinguish_fire pitch:0 volume:2
      - playsound <player.location> sound:entity_skeleton_hurt pitch:0 volume:2
      - playsound <player.location> sound:entity_zombie_attack_iron_door pitch:0 volume:2
      - playsound <player.location> sound:custom.classic_explode pitch:1 volume:2 custom
      - playsound <player.location> sound:custom.classic_bow_shoot pitch:0 volume:2 custom
      - flag <player> riflecooldown expire:2t
      - itemcooldown iron_horse_armor duration:2t
      - shoot dinnerproj origin:<player.eye_location.right[0.4].below[0.4]> speed:2 shooter:<player> spread:1
      - wait 2t
    on dinnerproj hits entity:
    - hurt <context.hit_entity> amount:4
    - adjust <context.hit_entity> velocity:<context.projectile.velocity.mul[0.2].add[0,0.1,0]>
    - playsound sound:entity_player_burp pitch:0 volume:2 at:<context.hit_entity.eye_locaiton>
    - feed <context.shooter> amount:2 saturation:2
    - drop dinner <context.projectile.location> quantity:1 speed:1
    on player consumes dinner:
    - feed <player> amount:20 saturation:20