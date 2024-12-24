bstrdhead:
  type: item
  material: yellow_stained_glass
  display name: <element[BSTRD].color[#FFFF00]>
  mechanisms:
    hides: all
  lore:
  - <element[BADASS!!!].color[#FFFFFF]>
  - <&8>
  - <element[BSTRD].color[#FF0000].bold>

bstrdtriggers:
  type: world
  debug: false
  events:
    on entity drops bstrdhead:
    - determine cancelled passively