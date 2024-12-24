loudcream:
  type: item
  material: stick
  display name: <element[Very Loud Icecream].color[#FFFFFF]>
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13374304
  lore:
  - <element[10,000 DB].color[#808080]>
  - <&7>
  - <element[COLLECTOR'S].color[#800000].bold>


loudcreamtrigger:
  type: world
  debug: false
  events:
    on player right clicks block with:loudcream:
    - if <player.has_flag[icecreamcooldown]>:
      - stop
    - flag <player> icecreamcooldown expire:5s
    - itemcooldown stick duration:5s
    - foreach <player.eye_location.find_entities.within[5].exclude[<player>]>:
      - adjust <[value]> velocity:<[value].eye_location.sub[<player.location>].normalize.mul[2]>
    - repeat 64:
      - define setOff <location[0,0,0].random_offset[2]>
      - playeffect effect:EXPLODE quantity:1 at:<player.eye_location.add[<[setOff]>]> offset:0 visibility:100 velocity:<[setOff].mul[0.15]>
    - repeat 128:
      - define setOff <location[0,0,0].random_offset[2]>
      - playeffect effect:smoke quantity:1 at:<player.eye_location.sub[<[setOff].mul[2]>]> offset:0 visibility:100 velocity:<[setOff].mul[-0.3]>
    - repeat 8 as:extraoff:
      - repeat 32:
        - define setOff <location[0,0,0].random_offset[1]>
        - playeffect effect:note quantity:1 at:<player.eye_location> offset:<element[2].add[<[extraoff]>]> visibility:100 velocity:<[setOff]>
      - wait 1t