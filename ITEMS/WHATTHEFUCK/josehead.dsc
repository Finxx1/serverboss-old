josehead:
  type: item
  material: player_head
  display name: <&f><element[soup__can's head]>
  mechanisms:
    unbreakable: true
    hides: all
    skull_skin: keepinventoryoff
  enchantments:
  - infinity:1
  lore:
  - <&8><element[It's still alive?]>
  - <&8><element[Looks like he isn't quite fond of that maniac either...]>
  - <&8><element[Maybe you two can help eachother]>
  - <&8>
  - <element[JOSE].color[#701020].bold.obfuscate>

josetriggers:
  type: world
  debug: false
  events:
    on player kills entity:
    - ratelimit <player> 35t 
    - if <player.inventory.contains_item[josehead]> && <util.random_chance[10]>:
      - wait <util.random.decimal[1].to[3]>s
      - random:
        - narrate "aluminum__can <element[&gt&gt].unescaped> goof jo" targets:<player>
        - narrate "aluminum__can <element[&gt&gt].unescaped> dead i think" targets:<player>
        - narrate "aluminum__can <element[&gt&gt].unescaped> epic win" targets:<player>
    on player drops josehead:
    - determine cancelled passively
    - ratelimit <player> 10t
    - if <util.random_chance[10]>:
      - wait <util.random.decimal[0.5].to[1]>s
      - random:
        - narrate "aluminum__can <element[&gt&gt].unescaped> retad" targets:<player>
        - narrate "aluminum__can <element[&gt&gt].unescaped> sorry your fat an sticky" targets:<player>
        - narrate "aluminum__can <element[&gt&gt].unescaped> dumba s" targets:<player>