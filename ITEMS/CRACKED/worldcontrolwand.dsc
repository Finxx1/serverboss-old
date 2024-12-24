worldcontrolwand:
  type: item
  material: wooden_axe
  display name: <element[「「「].color_gradient[from=#C000C0;to=#0000C0]><element[WORLD CON].color_gradient[from=#0000C0;to=#00C000]><element[T].color[#00C000]><element[ROL WAND].color_gradient[from=#00C000;to=#C00000]><element[」」」].color_gradient[from=#C00000;to=#C000C0]>
  enchantments:
  - infinity:1
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13374209
  lore:
  - <element[-=-=].color_gradient[from=#600060;to=#000060]><element[ Sel].color_gradient[from=#000060;to=#006000]><element[ect].color_gradient[from=#006000;to=#600000]><element[ =-=-].color_gradient[from=#600000;to=#600060]>
  - 
  - <element[CRACKED].color[#600048].bold>

worldcontrolwandspinny:
  type: item
  material: wooden_axe
  display name: <element[「「「].color_gradient[from=#C000C0;to=#0000C0]><element[WORLD CON].color_gradient[from=#0000C0;to=#00C000]><element[T].color[#00C000]><element[ROL WAND].color_gradient[from=#00C000;to=#C00000]><element[」」」].color_gradient[from=#C00000;to=#C000C0]><element[ (Spinning)].color[#FFFFFF]>
  enchantments:
  - infinity:1
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13374210
  lore:
  - <element[-=-=].color_gradient[from=#600060;to=#000060]><element[ Sel].color_gradient[from=#000060;to=#006000]><element[ect].color_gradient[from=#006000;to=#600000]><element[ =-=-].color_gradient[from=#600000;to=#600060]>
  - 
  - <element[CRACKED].color[#600048].bold>

worldcontrolwandtriggers:
  type: world
  events:
    on player damages entity with:worldcontrolwand:
    # 1:
    # Play swing sound, depending on if the attack cd is full
    - if <player.attack_cooldown_percent> == 100:
      - playeffect effect:item_crack at:<player.location.add[0,1,0]> offset:0.1,0.1,0.1 special_data:worldcontrolwand quantity:10 velocity:1
      - playsound sound:entity_wither_spawn at:<player.location> pitch:1
      - playsound sound:entity_wither_break_block at:<player.location> pitch:1
      - take iteminhand quantity:1 from:<context.damager>
      - hurt <context.entity> 2147483647
      - explode power:3 <context.damager.location> source:<context.damager>
    on player right clicks block with:worldcontrolwand:
    - determine cancelled
    on player left clicks block with:worldcontrolwand:
    - playeffect effect:item_crack at:<player.location.add[0,1,0]> offset:0.3,0.3,0.3 special_data:worldcontrolwand quantity:20 velocity:1
    - playsound sound:item_shield_break at:<player.location> pitch:0
    - playsound sound:item_shield_break at:<player.location> pitch:1
    - playsound sound:item_shield_break at:<player.location> pitch:2
    - take iteminhand quantity:1 from:<player>
    - hurt <player> 1
    #- explode power:1 <player.location> source:<player>