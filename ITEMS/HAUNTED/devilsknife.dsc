devilsknife:
  type: item
  material: golden_hoe
  display name: <element[Devil's].color_gradient[from=#6868C0;to=#B8E820]><element[ ]><element[Knife].color_gradient[from=#202020;to=#FFC000]>
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13374368
  recipes:
    1:
      type: shapeless
      output_quantity: 1
      input: vampscythe|jokercard
  lore:
  - <element[CUT AWAY T].color_gradient[from=#343460;to=#5CE810]><element[HE AFTERGLOW].color_gradient[from=#101010;to=#806000]>
  - <&7>
  - <element[HAUNTED].color[#38F0A8].bold>

devilskniferotating:
  type: item
  material: golden_hoe
  display name: <element[Devil's].color_gradient[from=#6868C0;to=#B8E820]><element[ ]><element[Knife].color_gradient[from=#202020;to=#FFC000]><element[ (rotating)].color[#FFFFFF]>
  mechanisms:
    unbreakable: true
    #hides: all
    custom_model_data: 13374369
  lore: 
  - <element[THE BEST PLACE T].color_gradient[from=#343460;to=#5CE810]><element[ ]><element[O HIDE IS INSANITY].color_gradient[from=#101010;to=#806000]>
  - <&7>
  - <element[HAUNTED].color[#38F0A8].bold>

devilsknifetriggers:
  type: world
  debug: false
  events:
    on player left clicks block with:devilsknife:
    - determine cancelled passively
    - if <player.attack_cooldown_percent> < 100:
      - stop
    - playsound at:<player.location> volume:2 sound:item_trident_throw pitch:0
    - foreach <player.location.add[0,1,0].points_around_y[radius=2;points=8]>:
      - playeffect effect:sweep_attack quantity:1 offset:0.1 at:<[value]> visibility:100
      - foreach <[value].find.living_entities.within[2].exclude[<player>]> as:hurtguys:
        - hurt <[hurtguys]> 3 source:<player> cause:ENTITY_SWEEP_ATTACK
      - wait 1t
    - foreach <player.location.add[0,1,0].points_around_y[radius=3;points=6]>:
      - playeffect effect:sweep_attack quantity:1 offset:0.1 at:<[value]> visibility:100
      - foreach <[value].find.living_entities.within[2].exclude[<player>]> as:hurtguys:
        - hurt <[hurtguys]> 3 source:<player> cause:ENTITY_SWEEP_ATTACK
      - wait 1t
    on player damages entity with:devilsknife:
    - if ( <player.attack_cooldown_percent> < 100 || <context.cause> == ENTITY_SWEEP_ATTACK ) && <player.item_in_hand.script.name> == devilsknife:
      - stop
    - playsound at:<player.location> volume:2 sound:item_trident_throw pitch:0
    - foreach <player.location.add[0,1,0].points_around_y[radius=2;points=8]>>:
      - playeffect effect:sweep_attack quantity:1 offset:0.1 at:<[value]> visibility:100
      - foreach <[value].find.living_entities.within[2].exclude[<player>]> as:hurtguys:
        - hurt <[hurtguys]> 3 source:<player> cause:ENTITY_SWEEP_ATTACK
      - wait 1t
    - foreach <player.location.add[0,1,0].points_around_y[radius=3;points=6]>>:
      - playeffect effect:sweep_attack quantity:1 offset:0.1 at:<[value]> visibility:100
      - foreach <[value].find.living_entities.within[2].exclude[<player>]> as:hurtguys:
        - hurt <[hurtguys]> 3 source:<player> cause:ENTITY_SWEEP_ATTACK
      - wait 1t
    on player holds item item:devilsknife:
    - playsound at:<player.eye_location> sound:custom.jlaugh<list[1|2|3].random> pitch:1 volume:2 custom
    on heartbullet spawns:
    - define velvec <location[0,0,0].random_offset[1].normalize.mul[0.5].random_offset[0.15]>
    - adjust <context.entity> velocity:<[velvec]>
    - wait 3s
    - if <context.entity.is_spawned>:
      - playeffect at:<context.entity.location> offset:0.25 effect:item_crack special_data:hearts quantity:16 velocity:<location[0,0,0].random_offset[0.05]>
      - playsound at:<context.entity.location> sound:entity_generic_hurt pitch:2 volume:1
    - remove <context.entity>
    on spadebullet spawns:
    - wait 1t
    - define velvec <context.entity.location.sub[<context.entity.location.find.living_entities.within[16].exclude[<context.entity.shooter>].get[1].eye_location>].normalize.mul[-0.75]||0>
#    - announce <[velvec]>
    - if <[velvec]> == 0:
      - define velvec <location[0,0,0].random_offset[1].normalize.mul[0.75].random_offset[0.15]>
    - adjust <context.entity> velocity:<[velvec]>
    - wait 3s
    - if <context.entity.is_spawned>:
      - playeffect at:<context.entity.location> offset:0.25 effect:item_crack special_data:spades quantity:16 velocity:<location[0,0,0].random_offset[0.05]>
      - playsound at:<context.entity.location> sound:entity_generic_hurt pitch:2 volume:1
    - remove <context.entity>
    on diamondbullet spawns:
    - define velvec <location[0,0,0].random_offset[1].normalize.mul[0.65].random_offset[0.15].add[0,0.05,0]>
    - adjust <context.entity> velocity:<[velvec]>
    - wait 3s
    - if <context.entity.is_spawned>:
      - playeffect at:<context.entity.location> offset:0.25 effect:item_crack special_data:diamonds quantity:16 velocity:<location[0,0,0].random_offset[0.05]>
      - playsound at:<context.entity.location> sound:entity_generic_hurt pitch:2 volume:1
    - remove <context.entity>
    on clubsbullet spawns:
    - wait 1t
    - define velvec <context.entity.location.sub[<context.entity.location.find.living_entities.within[16].exclude[<context.entity.shooter>].get[1].eye_location>].normalize.mul[-0.75].random_offset[0.15]||0>
#    - announce <[velvec]>
    - if <[velvec]> == 0:
      - define velvec <location[0,0,0].random_offset[1].normalize.mul[0.75].random_offset[0.15]>
    - adjust <context.entity> velocity:<[velvec]>
    - wait 9s
    - if <context.entity.is_spawned>:
      - playeffect at:<context.entity.location> offset:0.25 effect:item_crack special_data:clubs quantity:16 velocity:<location[0,0,0].random_offset[0.05]>
      - playsound at:<context.entity.location> sound:entity_generic_hurt pitch:2 volume:1
    - remove <context.entity>
    on horseybullet spawns:
    - wait 3s
    - if <context.entity.is_spawned>:
      - playeffect at:<context.entity.location> offset:0.5 effect:item_crack special_data:horsey quantity:36 velocity:<location[0,0,0].random_offset[0.05]>
      - playsound at:<context.entity.location> sound:entity_generic_hurt pitch:1 volume:2
      - playsound at:<context.entity.location> sound:entity_horse_angry pitch:1 volume:2
    - remove <context.entity>
    on entity damaged by heartbullet:
    - hurt <context.entity> 4
    - heal <context.projectile.shooter> 4
    on entity damaged by clubsbullet:
    - hurt <context.entity> 6
    on entity damaged by diamondbullet:
    - hurt <context.entity> 4 
    - adjust <context.entity> velocity:<context.entity.velocity.random_offset[1]>
    - adjust <context.entity> armor_bonus:<context.entity.armor_bonus.sub[1]>
    on entity damaged by spadebullet:
    - hurt <context.entity> 8
    on spadebullet hits block:
    - playsound at:<context.projectile.location> sound:entity_generic_hurt pitch:2 volume:1
    on heartbullet hits block:
    - playsound at:<context.projectile.location> sound:entity_generic_hurt pitch:2 volume:1
    on clubsbullet hits block:
    - playsound at:<context.projectile.location> sound:entity_generic_hurt pitch:2 volume:1
    on diamondbullet hits block:
    - playsound at:<context.projectile.location> sound:entity_generic_hurt pitch:2 volume:1
    on horseybullet hits block:
    - playsound at:<context.projectile.location> sound:entity_generic_hurt pitch:1 volume:1
    - playsound at:<context.projectile.location> sound:entity_horse_death pitch:1 volume:3
    - strike at:<context.projectile.location>
    - explode at:<context.projectile.location> power:1
    on horseybullet hits entity:
    - playsound at:<context.projectile.location> sound:entity_generic_hurt pitch:1 volume:1
    - playsound at:<context.projectile.location> sound:entity_horse_death pitch:1 volume:3
    - strike at:<context.projectile.location>
    - explode at:<context.projectile.location> power:1
    on player right clicks block with:devilsknife:
    - determine cancelled passively
    - if <player.attack_cooldown_percent> == 100:
      - take iteminhand quantity:1 from:<player>
      - shoot throwndevil origin:<player.eye_location> speed:1.25 shooter:<player> save:jevilthrow
      - playsound <player.eye_location> sound:custom.jlaugh<list[1|2|3].random> pitch:1 volume:2 custom
      - define sillyclown <entry[jevilthrow].shot_entities.get[1]>
      - flag <[sillyclown]> bounces:24
    on throwndevil spawns:
    - wait 3s
    - if <context.entity.is_spawned>:
      - give devilsknife to:<context.entity.shooter.inventory> quantity:1
      - playsound <context.entity.shooter.location> sound:custom.jlaugh<list[1|2|3].random> pitch:1 volume:2 custom
      - announce <element[Devil's].color_gradient[from=#6868C0;to=#B8E820]><element[ ]><element[Knife].color_gradient[from=#202020;to=#FFC000]><element[ &gt&gt ].unescaped.color[#FFFFFF]><element[<list[CAREFUL, CAREFUL! YOU NEARLY LOST ME, LOST ME!|I HAVE RETURNED FROM THE ABYSS, ABYSS!|THE CLOWN IS BACK IN TOWN, TOWN!].random>].color[#FFFFFF]>
      - define surfloc <context.entity.location.with_pitch[90].ray_trace[range=256;return=precise;default=air;ignore=*;nonsolids=false]>
      - strike <[surfloc]>
      - explode <[surfloc]> power:3
      - remove <context.entity>
    on throwndevil hits block:
    - define projvel <context.projectile.velocity>
    - define projbnc <context.projectile.flag[bounces]>
    - define shootercont <context.projectile.shooter>
    - define hitface <context.hit_face>
    - if <[projbnc]> < 1:
      - give devilsknife to:<[shootercont]> quantity:1
      - playsound <[shootercont].eye_location> sound:custom.jlaugh<list[1|2|3].random> pitch:1 volume:2 custom
      - stop
    - define pvel2 <location[<[projvel].x.mul[<[hitface].x.abs.mul[-2].add[1]>]>,<[projvel].y.mul[<[hitface].y.abs.mul[-2].add[1]>]>,<[projvel].z.mul[<[hitface].z.abs.mul[-2].add[1]>]>].mul[1.15]>
    - define bounceloc <context.location.add[0.5,0.5,0.5].add[<context.hit_face>]>
    - playsound <[bounceloc]> sound:entity_zombie_attack_iron_door pitch:<[projbnc].div[10]> volume:1
    - playsound <[bounceloc]> sound:entity_wither_ambient pitch:0 volume:1
    - playsound <[bounceloc]> sound:custom.jlaugh<list[1|2|3].random> pitch:1 volume:2 custom
    - playeffect at:<[bounceloc]> effect:flash offset:0 visibility:100
    - spawn throwndevil[velocity=<[pvel2]>;shooter=<[shootercont]>] <[bounceloc]> save:projbouncing
    - flag <entry[projbouncing].spawned_entity> bounces:<[projbnc].sub[1]>
    - random:
      - repeat 16:
        - spawn heartbullet <[bounceloc]> save:heartbulsave
        - define bult <entry[heartbulsave].spawned_entities[1]>
        - adjust <[bult]> shooter:<[shootercont]>
      - repeat 16:
        - spawn diamondbullet <[bounceloc]> save:diamondbulsave
        - define bult <entry[heartbulsave].spawned_entities[1]>
        - adjust <[bult]> shooter:<[shootercont]>
      - repeat 3:
        - repeat 3:
          - spawn clubsbullet <[bounceloc]> save:clubsbulsave
          - define bult <entry[heartbulsave].spawned_entities[1]>
          - adjust <[bult]> shooter:<[shootercont]>
        - wait 3t
      - repeat 5:
        - spawn spadebullet <[bounceloc]> save:spadebulsave
        - define bult <entry[heartbulsave].spawned_entities[1]>
        - adjust <[bult]> shooter:<[shootercont]>
        - wait 1t
    on throwndevil hits entity:
    - determine cancelled passively
    - define bounceloc <context.entity.eye_location>
    - hurt <context.entity> 10 source:<context.shooter>
    - playsound <[bounceloc]> sound:entity_wither_ambient pitch:0 volume:1
    - playsound <[bounceloc]> sound:custom.jlaugh<list[1|2|3].random> pitch:1 volume:2 custom
    - random:
      - repeat 16:
        - spawn heartbullet <[bounceloc]> save:heartbulsave
        - define bult <entry[heartbulsave].spawned_entities[1]>
        - adjust <[bult]> shooter:<[shootercont]>
      - repeat 16:
        - spawn diamondbullet <[bounceloc]> save:diamondbulsave
        - define bult <entry[heartbulsave].spawned_entities[1]>
        - adjust <[bult]> shooter:<[shootercont]>
      - repeat 3:
        - spawn clubsbullet <[bounceloc]> save:clubsbulsave
        - define bult <entry[heartbulsave].spawned_entities[1]>
        - adjust <[bult]> shooter:<[shootercont]>
      - repeat 5:
        - spawn spadebullet <[bounceloc]> save:spadebulsave
        - define bult <entry[heartbulsave].spawned_entities[1]>
        - adjust <[bult]> shooter:<[shootercont]>
        - wait 1t

throwndevil:
  type: entity
  entity_type: snowball
  mechanisms:
    gravity: false
    item: devilskniferotating

heartbullet:
  type: entity
  entity_type: snowball
  mechanisms:
    gravity: false
    item: hearts

diamondbullet:
  type: entity
  entity_type: snowball
  mechanisms:
    gravity: true
    item: diamonds

thrownwcw:
  type: entity
  entity_type: snowball
  mechanisms:
    gravity: true
    item: worldcontrolwandspinny

thrownsabre:
  type: entity
  entity_type: snowball
  mechanisms:
    gravity: true
    item: lovexcaliburfall

spadebullet:
  type: entity
  entity_type: snowball
  mechanisms:
    gravity: false
    item: spades

clubsbullet:
  type: entity
  entity_type: snowball
  mechanisms:
    gravity: false
    item: clubs

horseybullet:
  type: entity
  entity_type: snowball
  mechanisms:
    gravity: true
    item: horsey

hearts:
  type: item
  material: diamond
  display name: <element[♥♥♥ Hearts ♥♥♥].color[#FF0000]>
  mechanisms:
    unbreakable: true
    #hides: all
    custom_model_data: 13375200
  lore:
  - <element[WE'RE CREATED JUST TO DIE].color[#800000]>
  - <&7>
  - <element[HAUNTED].color[#38F0A8].bold>

diamonds:
  type: item
  material: diamond
  display name: <element[♦♦♦ Diamonds ♦♦♦].color[#FF0000]>
  mechanisms:
    unbreakable: true
    #hides: all
    custom_model_data: 13375201
  lore:
  - <element[MORTAL SIN'S THE REASON WHY].color[#800000]>
  - <&7>
  - <element[HAUNTED].color[#38F0A8].bold>

spades:
  type: item
  material: diamond
  display name: <element[♠♠♠ Spades ♠♠♠].color[#404040]>
  mechanisms:
    unbreakable: true
    #hides: all
    custom_model_data: 13375202
  lore:
  - <element[YOU CAN'T STOP WHAT HAS BEGUN].color[#202020]>
  - <&7>
  - <element[HAUNTED].color[#38F0A8].bold>

clubs:
  type: item
  material: diamond
  display name: <element[♣♣♣ Clubs ♣♣♣].color[#808080]>
  mechanisms:
    unbreakable: true
    #hides: all
    custom_model_data: 13375203
  lore:
  - <element[MIGHT ASWELL HAVE SO MUCH FUN].color[#202020]>
  - <&7>
  - <element[HAUNTED].color[#38F0A8].bold>

horsey:
  type: item
  material: diamond
  display name: <element[♘ ...Horse? ♘].color[#C0C0C0]>
  mechanisms:
    unbreakable: true
    #hides: all
    custom_model_data: 13375220
  lore:
  - <element[CHAOS, CHAOS!].color[#606060]>
  - <&7>
  - <element[HAUNTED].color[#38F0A8].bold>

heartscard:
  type: item
  material: paper
  display name: <element[♥♥♥ Hearts ♥♥♥].color[#FF0000]>
  mechanisms:
    #hides: all
    custom_model_data: 13375200
  recipes:
    1:
      type: shapeless
      output_quantity: 2
      input: heartscard|blankcard
  lore:
  - <element[Revitalizing!].color[#800000]>
  - <&7>
  - <element[GENUINE].color[#206030].bold>

diamondscard:
  type: item
  material: paper
  display name: <element[♦♦♦ Diamonds ♦♦♦].color[#FF0000]>
  mechanisms:
    #hides: all
    custom_model_data: 13375201
  recipes:
    1:
      type: shapeless
      output_quantity: 2
      input: diamondscard|blankcard
  lore:
  - <element[Possessions have no value].color[#800000]>
  - <&7>
  - <element[GENUINE].color[#206030].bold>

spadescard:
  type: item
  material: paper
  display name: <element[♠♠♠ Spades ♠♠♠].color[#404040]>
  mechanisms:
    #hides: all
    custom_model_data: 13375202
  recipes:
    1:
      type: shapeless
      output_quantity: 2
      input: spadescard|blankcard
  lore:
  - <element[Die!].color[#202020]>
  - <&7>
  - <element[GENUINE].color[#206030].bold>

clubscard:
  type: item
  material: paper
  display name: <element[♣♣♣ Clubs ♣♣♣].color[#404040]>
  mechanisms:
    #hides: all
    custom_model_data: 13375203
  recipes:
    1:
      type: shapeless
      output_quantity: 2
      input: clubscard|blankcard
  lore:
  - <element[Isn't it more fun in threes?].color[#202020]>
  - <&7>
  - <element[GENUINE].color[#206030].bold>

jokercard:
  type: item
  material: paper
  display name: <element[☆ Joker ☆].color_gradient[from=#6868C0;to=#B8E820]>
  mechanisms:
    #hides: all
    custom_model_data: 13375280
  recipes:
    1:
      type: shapeless
      output_quantity: 1
      input: heartscard|diamondscard|spadescard|clubscard|jackcard|kingcard|queencard
  lore:
  - <element[I can do anything!!!].color_gradient[from=#343460;to=#5CE810]>
  - <&7>
  - <element[COLLECTOR'S].color[#800000].bold>

jackcard:
  type: item
  material: paper
  display name: <element[♘ Jack ♘].color_gradient[from=#FF0000;to=#404040]>
  mechanisms:
    #hides: all
    custom_model_data: 13375296
  lore:
  - <element[If God had wanted you to live he would not have created me!].color_gradient[from=#800000;to=#202020]>
  - <&7>
  - <element[GENUINE].color[#206030].bold>

queencard:
  type: item
  material: paper
  display name: <element[♔ Queen ♔].color_gradient[from=#FF0000;to=#FF00FF;style=HSB]>
  mechanisms:
    #hides: all
    custom_model_data: 13375298
  lore:
  - <element[Queen of All Time].color_gradient[from=#800000;to=#800080;style=HSB]>
  - <&7>
  - <element[GENUINE].color[#206030].bold>

kingcard:
  type: item
  material: paper
  display name: <element[♕ King ♕].color_gradient[from=#FFC040;to=#FFFFFF]>
  mechanisms:
    #hides: all
    custom_model_data: 13375297
  lore:
  - <element[Ruler of Everything].color_gradient[from=#806020;to=#808080]>
  - <&7>
  - <element[GENUINE].color[#206030].bold>

blankcard:
  type: item
  material: paper
  display name: <element[Blank Card].color_gradient[from=#C0C0C0;to=#FFFFFF]>
  mechanisms:
    #hides: all
    custom_model_data: 13375399
  lore:
  - <element[Devoid].color_gradient[from=#606060;to=#808080]>
  - <&7>
  - <element[GENUINE].color[#206030].bold>

rouxlscard:
  type: item
  material: paper
  display name: <element[Reversed Card].color_gradient[from=#000080;to=#FFFFFF]>
  mechanisms:
    #hides: all
    custom_model_data: 13375400
  lore:
  - <element[Go fisheth!].color_gradient[from=#000040;to=#808080]>
  - <&7>
  - <element[GENUINE].color[#206030].bold>

torncard:
  type: item
  material: paper
  display name: <element[Torn Card].color_gradient[from=#20C030;to=#FFFFFF]>
  mechanisms:
    #hides: all
    custom_model_data: 13375397
  lore:
  - <element[Tragedy: unfold].color_gradient[from=#10601C;to=#808080]>
  - <&7>
  - <element[GENUINE].color[#206030].bold>

scribbledcard:
  type: item
  material: paper
  display name: <element[Scribbled Card].color_gradient[from=#E00808;to=#FFFFFF]>
  mechanisms:
    #hides: all
    custom_model_data: 13375398
  lore:
  - <element[funny marker  haha].color_gradient[from=#780404;to=#808080]>
  - <&7>
  - <element[GENUINE].color[#206030].bold>

voidcard:
  type: item
  material: paper
  display name: <element[Void Card].color_gradient[from=#200040;to=#FFFFFF]>
  mechanisms:
    #hides: all
    custom_model_data: 13375402
  lore:
  - <element[Don't keep the devil waiting].color_gradient[from=#100020;to=#808080]>
  - <&7>
  - <element[GENUINE].color[#206030].bold>

cardstriggers:
  type: world
  debug: false
  events:
    on player right clicks block with:jokercard:
    - determine cancelled passively
    - if <player.has_flag[jokercooldown]>:
      - stop
    - playsound sound:custom.jlaugh<list[1|2|3].random> pitch:1 at:<player.eye_location> volume:2 custom
    - playsound sound:block_enchantment_table_use pitch:1 at:<player.eye_location> volume:2
    - flag <player> jokercooldown expire:1.5s
    - itemcooldown paper duration:1.5s
    - if <util.random_chance[95]>:
      - random:
        - repeat 16:
          - spawn heartbullet[shooter=<player>] <player.eye_location>
        - repeat 16:
          - spawn diamondbullet[shooter=<player>] <player.eye_location>
        - repeat 3:
          - repeat 3:
            - spawn clubsbullet[shooter=<player>] <player.eye_location>
          - wait 3t
        - repeat 5:
          - spawn spadebullet[shooter=<player>] <player.eye_location>
          - wait 1t
    - else:
      - foreach <location[0,0,0].points_around_y[radius=1;points=4]>:
        - spawn horseybullet[velocity=<[value].mul[0.4].add[0,0.2,0]>] at:<player.location.add[0,1,0].add[<[value]>]>
    on player right clicks block with:heartscard:
    - take iteminhand from:<player> quantity:1
    - playsound sound:block_enchantment_table_use pitch:1 at:<player.eye_location> volume:2
    - repeat 16:
      - spawn heartbullet[shooter=<player>] <player.eye_location>
    on player right clicks block with:diamondscard:
    - take iteminhand from:<player> quantity:1
    - playsound sound:block_enchantment_table_use pitch:1 at:<player.eye_location> volume:2
    - repeat 16:
      - spawn diamondbullet[shooter=<player>] <player.eye_location>
    on player right clicks block with:spadescard:
    - take iteminhand from:<player> quantity:1
    - playsound sound:block_enchantment_table_use pitch:1 at:<player.eye_location> volume:2
    - repeat 5:
      - spawn spadebullet[shooter=<player>] <player.eye_location>
      - wait 1t
    on player right clicks block with:clubscard:
    - take iteminhand from:<player> quantity:1
    - playsound sound:block_enchantment_table_use pitch:1 at:<player.eye_location> volume:2
    - repeat 3:
      - repeat 3:
        - spawn clubsbullet[shooter=<player>] <player.eye_location>
      - wait 3t
    on player right clicks block with:jackcard:
    - take iteminhand from:<player> quantity:1
    - playsound sound:block_enchantment_table_use pitch:1 at:<player.eye_location> volume:2
    - foreach <location[0,0,0].points_around_y[radius=1;points=4]>:
      - spawn horseybullet[velocity=<[value].mul[0.4].add[0,0.2,0]>] at:<player.location.add[0,1,0].add[<[value]>]>
    on player right clicks block with:rouxlscard:
    - take iteminhand from:<player> quantity:1
    - playsound sound:block_enchantment_table_use pitch:1 at:<player.eye_location> volume:2
    - define clubsL <player.inventory.find_all_items[clubscard]>
    - define heartsL <player.inventory.find_all_items[heartscard]>
    - define diamondsL <player.inventory.find_all_items[diamondscard]>
    - define spadesL <player.inventory.find_all_items[spadescard]>
    - define kingsL <player.inventory.find_all_items[queencard]>
    - define queensL <player.inventory.find_all_items[kingcard]>
    - foreach <[clubsL]>:
      - define QTT <player.inventory.slot[<[value]>].quantity>
      - inventory set origin:<list[heartscard|diamondscard|spadescard].random>[quantity=<[QTT]>] destination:<player.inventory> slot:<[value]>
    - foreach <[heartsL]>:
      - define QTT <player.inventory.slot[<[value]>].quantity>
      - inventory set origin:<list[clubscard|diamondscard|spadescard].random>[quantity=<[QTT]>] destination:<player.inventory> slot:<[value]>
    - foreach <[diamondsL]>:
      - define QTT <player.inventory.slot[<[value]>].quantity>
      - inventory set origin:<list[clubscard|heartscard|spadescard].random>[quantity=<[QTT]>] destination:<player.inventory> slot:<[value]>
    - foreach <[spadesL]>:
      - define QTT <player.inventory.slot[<[value]>].quantity>
      - inventory set origin:<list[clubscard|heartscard|diamondscard].random>[quantity=<[QTT]>] destination:<player.inventory> slot:<[value]>
    on player right clicks block with:kingcard:
    - take iteminhand from:<player> quantity:1
    - playsound sound:block_enchantment_table_use pitch:1 at:<player.eye_location> volume:2
    - foreach <player.eye_location.find.living_entities.within[10].exclude[<player>]||0>:
      - spawn thrownsabre[velocity=<location[0,-0.15,0]>] at:<[value].eye_location.add[0,3.5,0]>
    on player right clicks block with:queencard:
    - take iteminhand from:<player> quantity:1
    - playsound sound:block_enchantment_table_use pitch:1 at:<player.eye_location> volume:2
    - foreach <player.eye_location.find.living_entities.within[10].exclude[<player>]||0>:
      - spawn thrownwcw[velocity=<location[0,-0.15,0]>] at:<[value].eye_location.add[0,3.5,0]>
    on thrownwcw hits block:
    - explode <context.projectile.location> power:1
    on entity damaged by thrownsabre:
    - determine cancelled passively
    - hurt <context.entity> <context.entity.health_max.sub[<context.entity.health>].mul[0.25].add[10]>
    - playsound <context.entity.location> sound:entity_ender_dragon_ambient pitch:0 volume:2
    - explode <context.projectile.location> power:1
    on thrownsabre hits block:
    - explode <context.projectile.location> power:1
    on entity damaged by thrownwcw:
    - determine cancelled passively
    - hurt <context.entity> <context.entity.health.mul[0.5]>
    - playsound <context.entity.location> sound:entity_wither_death pitch:0 volume:2
    - explode <context.projectile.location> power:1
    on player right clicks block with:blankcard:
    - determine cancelled passively
    - if <player.has_flag[blankused]>:
      - stop
    - if !<player.has_flag[blanklastloc]>:
      - playsound sound:block_enchantment_table_use pitch:1 at:<player.eye_location> volume:2
      - flag <player> blanklastloc:<player.location>
      - teleport <player> <location[0,67,0,deathplane]>
      - itemcooldown paper duration:6s
      - flag <player> blankused expire:6s
      - playsound sound:ENTITY_ENDER_DRAGON_GROWL pitch:0 volume:2 at:<player.eye_location>
      - cast <player> blindness duration:9999s amplifier:0 no_icon hide_particles no_ambient
      - wait 5s
      - title targets:<player> "title:<element[THE VOID].bold.color[#FFFFFF]>" fade_in:20t fade:out:20t stay:20t
      - playsound sound:entity_wither_spawn pitch:0 at:<player.eye_location> volume:2
    - else:
      - teleport <player> <player.flag[blanklastloc]>
      - take iteminhand from:<player> quantity:1
      - flag <player> blanklastloc:!
      - cast <player> blindness duration:2s amplifier:1 no_icon hide_particles no_ambient
      - playsound sound:ENTITY_ENDER_DRAGON_HURT pitch:0 volume:2 at:<player.eye_location>
    on player right clicks block with:voidcard:
    - determine cancelled passively
    - if <player.has_flag[blankused]>:
      - stop
    - if !<player.has_flag[blanklastloc]>:
      - take iteminhand from:<player> quantity:1
      - playsound sound:block_enchantment_table_use pitch:1 at:<player.eye_location> volume:2
      - flag <player> blanklastloc:<player.location>
      - teleport <player> <location[0,67,0,deathplane].with_yaw[<player.eye_location.yaw>].with_pitch[<player.eye_location.pitch>]>
      - itemcooldown paper duration:6s
      - flag <player> blankused expire:6s
      - playsound sound:ENTITY_ENDER_DRAGON_GROWL pitch:0 volume:2 at:<player.eye_location>
      - cast <player> blindness duration:9999s amplifier:0 no_icon hide_particles no_ambient
      - wait 1t
      - title targets:<player> "title:<element[THE VOID].bold.color[#FFFFFF]>" fade_in:20t fade:out:20t stay:20t
      - playsound sound:entity_wither_spawn pitch:0 at:<player.eye_location> volume:2
      - define movedoffset <player.location.sub[0,66,0]>
      - repeat 100:
        - define movedoffset <player.location.sub[0,66,0]>
        - playeffect at:<player.flag[blanklastloc].add[<[movedoffset]>]> effect:large_smoke offset:0.5 visibility:100 quantity:1
        - if <[value].mod[20]> == 0:
          - playsound sound:ui_button_click pitch:1 volume:2 at:<player.eye_location>
        - if <[value].mod[20]> == 10:
          - playsound sound:ui_button_click pitch:0 volume:2 at:<player.eye_location>
        - wait 1t
      - define movedoffset <player.location.sub[0,66,0]>
      - teleport <player> <player.flag[blanklastloc].add[<[movedoffset]>]>
      - flag <player> blanklastloc:!
      - cast <player> blindness duration:2s amplifier:1 no_icon hide_particles no_ambient
      - playsound sound:ENTITY_ENDER_DRAGON_HURT pitch:0 volume:2 at:<player.eye_location>
    on player right clicks block with:torncard:
    - determine cancelled passively
    - playsound sound:block_enchantment_table_use pitch:1 at:<player.eye_location> volume:2
    - playsound sound:entity_wither_break_block pitch:1 at:<player.eye_location> volume:2
    - flag <player> tornup
    - flag <player> tornu2
    - take from:<player> iteminhand quantity:1
    on entity damaged by player:
    - if <context.damager.has_flag[tornup]>:
      - determine <context.damage.mul[2]> passively
      - playsound sound:block_enchantment_table_use pitch:2 at:<context.damager.eye_location> volume:2
      - playsound sound:entity_wither_break_block pitch:2 at:<context.damager.eye_location> volume:2
      - flag <player> tornup:!
    on player damaged:
    - if <context.entity.has_flag[tornu2]>:
      - if <util.random_chance[1]>:
        - kill <context.entity>
      - flag <context.entity> tornu2:!