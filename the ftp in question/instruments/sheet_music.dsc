sheet_music_handler:
  type: world
  debug: false
  events:
    on player left clicks block with:stick:
    - if !<player.has_flag[playingSheetMusic]> && <player.item_in_offhand.is_book>:
      - flag player playingSheetMusic:<queue>
      - foreach <player.item_in_offhand.book_pages.unseparated.strip_color.split[;]> as:note:
        - if <player.item_in_offhand.is_book>:
          - define data <[note].split[,]>
          - if <[data].size> == 4:
            - define pause <[data].get[1]>
            - define pitch <[data].get[2]>
            - define instrument <[data].get[3]>
            - define volume <[data].get[4]>
            - ~run play_note_task def:<[pitch]>|<[volume]>|<player.inventory.slot[<[instrument]>].flag[sound]>|<player.inventory.slot[<[instrument]>].flag[custom]||false>|<player.location.above[2]>|0.5
            - wait <[pause]>t
        - else:
          - flag player playingSheetMusic:!
          - stop
    - else:
      - queue <player.flag[playingSheetMusic]> clear
    - flag player playingSheetMusic:!

sheet_music:
  debug: false
  type: book
  title: <&translate[item.sheet_music]>
  author: Author
  signed: true
  text:
    - e

center_text:
  debug: false
  type: procedure
  definitions: text|max_length
  script:
    - define parts <list>
    - define part <list>
    - foreach <[text].split>:
      - if <[part].include[<[part]>].space_separated.length> < 16:
        - define part:->:<[value]>
      - else:
        - define parts:->:<[part].space_separated>
        - define part <list[<[value]>]>
    - define parts:->:<[part].space_separated>
    - determine <[parts].parse[proc[text_padding].context[<[max_length]>]].separated_by[<&nl>]>

text_padding:
  debug: false
  type: procedure
  definitions: word|max_length
  script:
    - define size <[max_length].sub[<[word].length>].div[2]>
    - determine "<element[ ].repeat[<[size].round_down>]><[word]><element[ ].repeat[<[size].round_up>]>"

sheet_music_getter:
  debug: false
  type: command
  name: sheet
  aliases:
    - sm
  usage: /sheet <&lb>URL<&rb>
  description: Get sheet music from a URL.
  script:
    - ~webget <context.args.get[1]> save:raw_data
    - define data <util.parse_yaml[<entry[raw_data].result>]>
    - define item <item[sheet_music]>
    - define title "<[data].get[name]||Sheet Music>"
    - debug log <[title]>
    - define author <[data].get[author]||Unknown>
    - define title_page <[title].proc[center_text].context[20].bold><element[by<&sp><[author]>].proc[center_text].context[26]><&nl>
    - define instruments <list>
    - foreach <[data].get[instruments]>:
      - define instruments:->:<item[<[value]>].proc[item_display]||<[value]>>
    - define title_page <[title_page]><element[Instruments:].bold><&nl><[instruments].separated_by[<&nl>]><&translate[icon.minecraft.cookie].color[white]>
    - define pages <list[<[title_page]>].include[<[data].get[pages]>]>

    - define item <[item].with_single[book_pages=<[pages]>].with[book_author=<[author]>;book_title=<[title]>]>
    - give <[item]>