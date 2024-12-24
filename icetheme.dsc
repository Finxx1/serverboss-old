icetheme:
  type: task
  script:
  - define icey <server.match_player[IceTudor]>
  - flag <[icey]> listeningtomusic
  - flag <[icey]> song:<list[1|2|3|4|5|6|7|8|9|10|11|12|13].random>
  - while <[icey].has_flag[listeningtomusic]>:
    - announce "<[icey].flag[song]>"
    - choose <[icey].flag[song]>:
      - case 1:
        - playsound <[icey].location> sound:custom.ice1 volume:16 pitch:1 custom
      - case 2:
        - playsound <[icey].location> sound:custom.ice2 volume:16 pitch:1 custom
      - case 3:
        - playsound <[icey].location> sound:custom.ice3 volume:16 pitch:1 custom
      - case 4:
        - playsound <[icey].location> sound:custom.ice4 volume:16 pitch:1 custom
      - case 5:
        - playsound <[icey].location> sound:custom.ice5 volume:16 pitch:1 custom
      - case 6:
        - playsound <[icey].location> sound:custom.ice6 volume:16 pitch:1 custom
      - case 7:
        - playsound <[icey].location> sound:custom.ice7 volume:16 pitch:1 custom
      - case 8:
        - playsound <[icey].location> sound:custom.ice8 volume:16 pitch:1 custom
      - case 9:
        - playsound <[icey].location> sound:custom.ice9 volume:16 pitch:1 custom
      - case 10:
        - playsound <[icey].location> sound:custom.ice10 volume:16 pitch:1 custom
      - case 11:
        - playsound <[icey].location> sound:custom.ice11 volume:16 pitch:1 custom
      - case 12:
        - playsound <[icey].location> sound:custom.ice12 volume:16 pitch:1 custom
      - case 13:
        - playsound <[icey].location> sound:custom.ice13 volume:16 pitch:1 custom
    - wait 321t
    - adjust <[icey]> stopsound
    - define chosens <[icey].flag[song]>
    - while <[icey].flag[song]> == <[chosens]>:
      - flag <[icey]> song:<list[1|2|3|4|5|6|7|8|9|10|11|12|13].random>

         