achievementgive:
  type: task
  debug: false
  definitions: playa|ach
  script:
  - if <[playa].flag[achievements].contains_any[<[ach]>]>:
    - stop
  - define achname <element[Placeholder!]>
  - define colsel #FFFFFF
  - define dscmsg <element[Placeholders are fucking awful!]>
  - choose <[ach]>:
    - case gray:
      - define achname <element[Finally, a gray one!]>
      - define colsel #808080
      - define dscmsg <element[Find a gray ball]>
    - case marketgarden:
      - define achname <element[Market Garden]>
      - define colsel #FF40FF
      - define dscmsg <element[Land a shovel attack after falling 25+ meters]>
    - case homer:
      - define achname <element[Do it for her]>
      - define colsel #FF40FF
      - define dscmsg <element[Reflect a nuclear explosive]>
    - case bigshot:
      - define achname <element[Watch me fly, mama!]>
      - define colsel #FF2020
      - define dscmsg <element[Get pulled back to reality after flying too high]>
    - case freebird:
      - define achname <element[Rocket Rider]>
      - define colsel #20FFFF
      - define dscmsg <element[Won't you fly high, free bird]>
    - case finishthat:
      - define achname <element[Are you gonna finish that?]>
      - define colsel #40FF40
      - define dscmsg <element[Try to consume meatballs without being hungry]>
    - case iwbtg:
      - define achname <element[I wanna be The Guy!]>
      - define colsel #FF2020
      - define dscmsg <element[Die impaled on a set of spikes]>
    - case skelenohit:
      - define achname <element[Disbelief]>
      - define colsel #FF8020
      - define dscmsg <element[Beat Skeleton King without taking any damage]>
  - announce <element[<[playa].display_name>]><&r><element[ has just earned the achievement ]><element[&lb<[achname]>&rb].unescaped.color[<[colsel]>].on_hover[<element[&lb<[achname]>&rb].unescaped.color[<[colsel]>]><&nl><[dscmsg]>].type[SHOW_TEXT]>
  - flag <[playa]> achievements:->:<[ach]>
  - playsound at:<[playa].eye_location> sound:custom.tadahh pitch:1 volume:3 custom