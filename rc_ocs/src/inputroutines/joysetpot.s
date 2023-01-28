SETPOT:
    move.w #$C000,$dff034
    rts
    MOVE.L  #$DFF000,A5
  MOVE.W  #%1100000000000000,$34(A5) ;POTGO Set standard OS value

  MOVEQ   #5-1,D2            ;Wait 5 rasterlines (~320 µs)
  MOVE.L  #$0001FF00,D3      ;Mask for vertical beam position V0-V8
wait_loop1
  MOVE.W  6(A5),D0           ;Get VHPOSR content
  SWAP    D0                 ;Move content to the upper word
  MOVE.W  4(A5),D0           ;Get VPOSR content
  AND.L   D3,D0              ;Only bits V0-V8
wait_loop2
  MOVE.W  6(A5),D1           ;Get VHPOSR content
  SWAP    D1                 ;Move content to the upper word
  MOVE.W  4(A5),D1           ;Get VPOSR content
  AND.L   D3,D1              ;Only bits V0-V8
  CMP.L   D1,D0              ;Still the same vertical position?
  BEQ.S   wait_loop2         ;Yes -> loop
  dbf     d2,wait_loop1

  
    rts