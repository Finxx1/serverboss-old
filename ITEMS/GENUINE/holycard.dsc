holycard:
  type: item
  material: paper
  display name: <element[Holy Card].color_gradient[from=#FFFFFF;to=#C0C0C0]>
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13374277
  lore:
  - <element[To protect and to serve].color_gradient[from=#808080;to=#606060]>
  - <&7> 
  - <element[GENUINE].color[#206030].bold>

holycardtriggers:
  type: world
  debug: false
  events:
    on player damaged:
    - if <context.entity.flag[mantles]||0> > 0:
      - determine cancelled passively
      - ratelimit <context.entity> <context.entity.last_damage.max_duration>
      - flag <context.entity> mantles:<context.entity.flag[mantles].sub[1]>
      - playeffect effect:flash quantity:1 at:<context.entity.location> offset:0
      - if <context.entity.flag[mantles]> > 0:
        - playsound <context.entity.location> sound:item_totem_use pitch:2 volume:1 
      - else:
        - playsound <context.entity.location> sound:item_totem_use pitch:1 volume:1
    on player right clicks block with:holycard:
    - if <player.attack_cooldown_percent> == 100:
      - playeffect effect:item_crack at:<player.location.add[0,1,0]> offset:0.3,0.3,0.3 special_data:holycard quantity:10 velocity:1
      - playsound sound:entity_player_burp at:<player.location> pitch:1
      - take iteminhand quantity:1 from:<player>
      - flag <player> mantles:<player.flag[mantles].add[1]||1>