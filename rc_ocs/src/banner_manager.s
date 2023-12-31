; set banner pointed by d0
SET_BANNER:
    IFD COLOR
    lea                 BPLPTR_HUD,a0

    move.l              #$00e00000,(a0)+
    move.l              #$00e20000,(a0)+
    move.l              #$00e40000,(a0)+
    move.l              #$00e60000,(a0)+
    move.l              #$00e80000,(a0)+
    move.l              #$00ea0000,(a0)+

    move.l              d0,d1
  	lea                 BPLPTR1_HUD,A1
  	bsr.w               POINTINCOPPERLIST_FUNCT
    move.l              d1,d0

    add.l               #40*16,d0
  	move.l              d0,d1
    lea                 BPLPTR2_HUD,A1
  	bsr.w               POINTINCOPPERLIST_FUNCT
    move.l              d1,d0

    add.l               #40*16,d0
  	lea                 BPLPTR3_HUD,A1
  	bsr.w               POINTINCOPPERLIST_FUNCT
    ENDC
    rts

RESTORE_TIMERS_BANNER:
  IFD COLOR
    lea                 BPLPTR_HUD,a0

    move.l              #$01800000,(a0)+
    move.l              #$01800000,(a0)+
    move.l              #$01800000,(a0)+
    move.l              #$01800000,(a0)+
    move.l              #$01800000,(a0)+
    move.l              #$01800000,(a0)+
    ENDC
  rts

CLEAN_DASHBOARD:
  lea                   DASHBOARD_DATA_1,a0
  lea                   DASHBOARD_DATA_2,a1
  lea                   DASHBOARD_DATA_3,a2
  move.w                #(40*16/4)-1,d7
startcleandashboard:
  clr.l                 (a0)+
  clr.l                 (a1)+
  clr.l                 (a2)+
  dbra                  d7,startcleandashboard

  ; car 1
  lea                   MOVERS,a2
  lea                   CAR_90+4,a0
  movea.l                #0,a4
  movea.l                #0,a5
  bsr.w                 PRINT_HUD_ICONS

  ; car 2
  lea                   MOVERS2,a2
  lea                   CAR1_90+4,a0
  movea                 #0,a4
  lea                   DASHBOARD_DATA_1,a5
  bsr.w                 PRINT_HUD_ICONS

  ; car 3
  lea                   MOVERS3,a2
  lea                   CAR2_90+4,a0
  lea                   DASHBOARD_DATA_3,a4
  movea.l               #0,a5
  bsr.w                 PRINT_HUD_ICONS

  ; car 4
  lea                   MOVERS4,a2
  lea                   CAR3_90+4,a0
  lea                   DASHBOARD_DATA_3,a4
  lea                   DASHBOARD_DATA_1,a5
  bsr.w                 PRINT_HUD_ICONS

  ; car 5
  lea                   MOVERS5,a2
  lea                   CAR_90+4,a0
  movea.l                #0,a4
  movea.l                #0,a5
  bsr.w                 PRINT_HUD_ICONS

  ; car 6
  lea                   MOVERS6,a2
  lea                   CAR1_90+4,a0
  movea                 #0,a4
  lea                   DASHBOARD_DATA_1,a5
  bsr.w                 PRINT_HUD_ICONS

  ; car 7
  lea                   MOVERS7,a2
  lea                   CAR2_90+4,a0
  lea                   DASHBOARD_DATA_3,a4
  movea.l               #0,a5
  bsr.w                 PRINT_HUD_ICONS

  ; car 8
  lea                   MOVERS8,a2
  lea                   CAR3_90+4,a0
  lea                   DASHBOARD_DATA_3,a4
  lea                   DASHBOARD_DATA_1,a5
  bsr.w                 PRINT_HUD_ICONS

; print horizontal lines
  lea                   DASHBOARD_DATA_1,a0
  lea                   DASHBOARD_DATA_1+40*15,a1
  lea                   DASHBOARD_DATA_3+40,a2
  moveq                 #10-1,d7
loophudfirstline:
  move.l                #$FFFFFFFF,(a0)+
  move.l                #$FFFFFFFF,-40(a1)
  move.l                #$FFFFFFFF,(a1)+

  move.l                #$7FFFFFFF,(a2)+ ; second horizontal line
  dbra                  d7,loophudfirstline

  IFD COLOR
  move.w #0,COPHUDCOLOR1+2
  move.w #$921,COPHUDCOLOR2+2
  move.w #$25b,COPHUDCOLOR3+2
  move.w #$aaa,COPHUDCOLOR4+2 ; border light 1
  move.w #$333,COPHUDCOLOR5+2 ; border dark 1
  move.w #$dd4,COPHUDCOLOR6+2 ; color 26
  move.w #$4a4,COPHUDCOLOR7+2

  ; Print vertical bar for lap indicator
  moveq                 #13-1,d7
  lea                   DASHBOARD_DATA_1+40*2-1,a0
rightborderlaphudloop:
  bset                  #0,(a0)
  bset                  #0,40*256*2(a0)
  add.w                 #40,a0
  dbra                  d7,rightborderlaphudloop

  ;move.w #bbb,COPHUDCOLOR4+2 ; border light 2
  ;move.w #$555,COPHUDCOLOR5_BIS+2 ; border dark 2
  ENDC
  rts

PRINT_HUD_ICONS:
  STORECARPROPERTY      HUD_POSITION_X,d7
  lea                   DASHBOARD_DATA_1,a3
  lea                   DASHBOARD_DATA_3,a6
  adda.w                d7,a3
  adda.w                d7,a6
  moveq                 #16-2-1,d7
hudprintleftborder:
  adda.w                #40,a3
  adda.w                #40,a6

  ; left border
  bset                  #7,(a3)
  bset                  #6,(a6)

  ; right border
  bset                  #0,3(a6)
  bset                  #0,3(a3)
  dbra                  d7,hudprintleftborder

  tst.l                 INPUT_ROUTINE_OFFSET(a2)
  bne.s                 print_hud_active
  rts
print_hud_active:
  move.l                a2,a6
  STORECARPROPERTY      HUD_POSITION_X,d7
  lea                   INDICATOR,a1
  lea                   DASHBOARD_DATA_1,a2
  adda.w                d7,a2
  lea                   DASHBOARD_DATA_2,a3
  adda.w                d7,a3

  cmp.l                 #0,a4
  beq.s                 print_hud_icons_no_a4
  adda.w                d7,a4
print_hud_icons_no_a4:

  cmp.l                 #0,a5
  beq.s                 print_hud_icons_no_a5
  adda.w                d7,a5
print_hud_icons_no_a5:

  moveq                 #16-2-1,d7 ; dont copy last 2 rows
printgamebannerloop:
  move.w                (a0)+,d6
  or.w                  d6,(a2) ; car frame

  move.w                (a0)+,d6
  or.w                  d6,(a3) ; car inner data

  move.w                32(a1),d6
  or.w                  d6,2+40*256*2(a2) ; write indicator inner

  move.w                (a1)+,d6
  or.w                  d6,2(a2) ; write indicator

  add.l                 #40,a2
  add.l                 #40,a3
  cmp.l                 #0,a4
  beq.s                 print_hud_icons_no_a4_2
  move                  -2(a0),d6
  or.w                  d6,(a4) ; car inner data
  add.l                 #40,a4
print_hud_icons_no_a4_2:
  cmp.l                 #0,a5
  beq.s                 print_hud_icons_no_a5_2
  move                  -2(a0),d6
  or.w                  d6,(a5) ; car inner data
  add.l                 #40,a5
print_hud_icons_no_a5_2:

  dbra                  d7,printgamebannerloop

  ;lea                   DASHBOARD_DATA_3,a0
  ;move.l                a6,a2
  ;STORECARPROPERTY      HUD_POSITION_X,d7
  ;adda.w                d7,a0
  ;ori.w                 #HUD_BEST_TIME_ROW_1,2+(40*6)(a0)
  ;ori.w                 #HUD_BEST_TIME_ROW_2,2+(40*7)(a0)
  ;ori.w                 #HUD_BEST_TIME_ROW_3,2+(40*8)(a0)
  ;ori.w                 #HUD_BEST_TIME_ROW_4,2+(40*9)(a0)
  ;ori.w                 #HUD_BEST_TIME_ROW_5,2+(40*10)(a0)
  rts