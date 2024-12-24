ikeaticket:
  type: item
  material: paper
  display name: <element[「「「].color[#303090]><element[IKEA].color_gradient[from=#FFDD20;to=#303090]><element[ TICKET].color_gradient[from=#303090;to=#FFDD20]><element[ 」」」].color[#303090]>
  enchantments:
  - infinity:1
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13374276
  lore:
  - <element[-=-=].color[#151545]><element[ Thy will].color_gradient[from=#887710;to=#151545]><element[ be done ].color_gradient[from=#151545;to=#887710]><element[=-=-].color[#151545]>
  - 
  - <element[CRACKED].color[#600048].bold>


ikeatickettriggers:
  type: world
  events:
    on player right clicks block with:ikeaticket:
    # 1:
    # Play swing sound, depending on if the attack cd is full
    - if <player.attack_cooldown_percent> == 100:
      - if !<player.has_flag[inikea]>:
        - playeffect effect:item_crack at:<player.location.add[0,1,0]> offset:0.3,0.3,0.3 special_data:paper quantity:10 velocity:1
        - playsound sound:entity_player_burp at:<player.location> pitch:1
        - take iteminhand quantity:1 from:<player>
        - wait 30t
        - flag <player> ikeasave:<player.location>
        - flag <player> inikea
        - cast <player> blindness duration:25t amplifier:2 no_ambient hide_particles no_icon
        - teleport <player> <location[-26,89,182,serverboss]>
        - strike <player.location> no_damage
        - playsound sound:entity_enderman_teleport at:<player.eye_location> pitch:0
        - playsound sound:entity_generic_explode at:<player.eye_location> pitch:0
        - playeffect effect:explosion_huge at:<player.eye_location> offset:0 visibility:100 quantity:1
        - title "title:<element[-- IKEA -- ].color_gradient[from=#303090;to=#FFDD20]>" "subtitle:<element[-- STAGE : ??? --].color_gradient[from=#151545;to=#887710]>" stay:3s targets:<player>
      - else:
        - if !<player.has_flag[stopdoingthat]>:
          - playsound sound:block_portal_travel at:<player.location> pitch:2 volume:2
          - title "title:<element[-- PARADOX! --].color_gradient[from=#481818;to=#101010]>" "subtitle:<element[-- ACTION CANCELLED! --].color_gradient[from=#481818;to=#101010]>" stay:3s targets:<player>
          - flag <player> stopdoingthat expire:5s
        - playsound sound:block_note_block_didgeridoo at:<player.location> pitch:0 volume:2
#    on player clicks in inventory:
#    - if <player.has_flag[inikea]> && <context.clicked_inventory> != <player.inventory> && <context.item.material.name> != air:
    on player right clicks item_frame:
    - if <player.has_flag[inikea]>:
      - determine cancelled passively
      - cast <player> blindness duration:25t amplifier:2 no_ambient hide_particles no_icon
      - teleport <player> <player.flag[ikeasave]>
      - wait 1t
      - strike <player.location> no_damage
      - give <player> <context.entity.framed_item>
      - playsound sound:entity_enderman_teleport at:<player.location> pitch:0
      - explode power:2 <player.location> source:<player>
      - explode power:2 <player.location> source:<player>
      - explode power:2 <player.location> source:<player>
      - explode power:2 <player.location> source:<player>
      - explode power:2 <player.location> source:<player>
      - title "title:<element[-- RETURN --].color_gradient[from=#903030;to=#cf6f6f]>" "subtitle:<element[-- TO SENDER! --].color_gradient[from=#903030;to=#cf6f6f]>" stay:3s targets:<player>
      - flag <player> inikea:!
