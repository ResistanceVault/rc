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
  ;movem.l                 d7/a0/a1/a2/a3,-(sp)
  lea                   DASHBOARD_DATA_1,a0
  lea                   DASHBOARD_DATA_2,a1
  lea                   DASHBOARD_DATA_3,a2
  move.w                #(40*16/4)-1,d7
startcleandashboard:
  clr.l                 (a0)+
  clr.l                 (a1)+
  clr.l                 (a2)+
  dbra                  d7,startcleandashboard
  ;movem.l               (sp)+,d7/a0/a1/a2/a3
  rts