meatballs:
  type: item
  material: pumpkin_pie
  enchantments:
  - infinity:1
  mechanisms:
    hides: all
    custom_model_data: 13375201
  display name: <element[「「「].color[#E0D0A0]><element[Spaghetti].color_gradient[from=#E0D0A0;to=#706850]><element[ & ].color[#C02000]><element[Meatballs].color_gradient[from=#804020;to=#402010]><element[」」」].color[#402010]>
  lore:
  - <element[-=-= ].color[#706850]><element[Made with].color_gradient[from=#706850;to=#382C28]><element[ ]><element[love & hate].color_gradient[from=#402010;to=#201008]><element[ =-=-].color[#201008]>
  - <&7>
  - <element[CRACKED].color[#600048].bold>

meatballscript:
  type: world
  debug: false
  events:
    on player right clicks block with:meatballs:
    - if <player.food_level> == 20:
      - run achievementgive def:<player>|finishthat
    on player consumes meatballs:
    - determine cancelled passively
    - heal <player> amount:<player.health_max>
    - feed <player> amount:20 saturation:20
    - adjust <player> potion_effects:<list[<map[type=SPEED;amplifier=1;duration=1200t;ambient=false;particles=false;icon=false]>|<map[type=DAMAGE_RESISTANCE;amplifier=1;duration=1200t;ambient=false;particles=false;icon=false]>|<map[type=INCREASE_DAMAGE;amplifier=1;duration=1200t;ambient=false;particles=false;icon=false]>|<map[type=FAST_DIGGING;amplifier=1;duration=1200t;ambient=false;particles=false;icon=false]>|<map[type=REGENERATION;amplifier=1;duration=1200t;ambient=false;particles=false;icon=false]>]>