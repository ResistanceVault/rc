BIGFONTS:
    dcb.b 2*16*3,$00 ; space
    dcb.b 2*16*3,$00 ; !
    dcb.b 2*16*3,$00 ; "
    dcb.b 2*16*3,$00 ; #
    dcb.b 2*16*3,$00 ; $
    dcb.b 2*16*3,$00 ; %
    dcb.b 2*16*3,$00 ; &
    dcb.b 2*16*3,$00 ; '
    dcb.b 2*16*3,$00 ; (
    dcb.b 2*16*3,$00 ; )
    dcb.b 2*16*3,$00 ; *
    dcb.b 2*16*3,$00 ; +
    dcb.b 2*16*3,$00 ; ,
    dcb.b 2*16*3,$00 ; -
    dcb.b 2*16*3,$00 ; .
    dcb.b 2*16*3,$00 ; /
    incbin "assets/fonts/big/0.raw"
    incbin "assets/fonts/big/1.raw"
    incbin "assets/fonts/big/2.raw"
    incbin "assets/fonts/big/3.raw"
    incbin "assets/fonts/big/4.raw"
    incbin "assets/fonts/big/5.raw"
    incbin "assets/fonts/big/6.raw"
    incbin "assets/fonts/big/7.raw"
    incbin "assets/fonts/big/8.raw"
    incbin "assets/fonts/big/9.raw"
    dcb.b 2*16*3,$00 ; :
    dcb.b 2*16*3,$00 ; ;
    incbin "assets/cursors/cursor_left.raw" ; <
    dcb.b 2*16*3,$00 ; =
    incbin "assets/cursors/cursor_right.raw" ; >
    dcb.b 2*16*3,$00 ; ?
    dcb.b 2*16*3,$00 ; @
    incbin "assets/fonts/big/a.raw"
    incbin "assets/fonts/big/b.raw"
    incbin "assets/fonts/big/c.raw"
    incbin "assets/fonts/big/d.raw"
    incbin "assets/fonts/big/e.raw"
    incbin "assets/fonts/big/f.raw"
    incbin "assets/fonts/big/g.raw"
    incbin "assets/fonts/big/h.raw"
    incbin "assets/fonts/big/i.raw"
    incbin "assets/fonts/big/j.raw"
    incbin "assets/fonts/big/k.raw"
    incbin "assets/fonts/big/l.raw"
    incbin "assets/fonts/big/m.raw"
    incbin "assets/fonts/big/n.raw"
    incbin "assets/fonts/big/o.raw"
    incbin "assets/fonts/big/p.raw"
    incbin "assets/fonts/big/q.raw"
    incbin "assets/fonts/big/r.raw"
    incbin "assets/fonts/big/s.raw"
    incbin "assets/fonts/big/t.raw"
    incbin "assets/fonts/big/u.raw"
    incbin "assets/fonts/big/v.raw"
    incbin "assets/fonts/big/w.raw"
    incbin "assets/fonts/big/x.raw"
    incbin "assets/fonts/big/y.raw"
    incbin "assets/fonts/big/z.raw"
    even

BIGFONTS_REVERSE_MASK:
    dcb.b 2*16*1,$FF ; space
    dcb.b 2*16*1,$00 ; !
    dcb.b 2*16*1,$00 ; "
    dcb.b 2*16*1,$00 ; #
    dcb.b 2*16*1,$00 ; $
    dcb.b 2*16*1,$00 ; %
    dcb.b 2*16*1,$00 ; &
    dcb.b 2*16*1,$00 ; '
    dcb.b 2*16*1,$00 ; (
    dcb.b 2*16*1,$00 ; )
    dcb.b 2*16*1,$00 ; *
    dcb.b 2*16*1,$00 ; +
    dcb.b 2*16*1,$00 ; ,
    dcb.b 2*16*1,$00 ; -
    dcb.b 2*16*1,$00 ; .
    dcb.b 2*16*1,$00 ; /
    incbin "assets/fonts/big/0_mask_reversed.raw"
    incbin "assets/fonts/big/1_mask_reversed.raw"
    incbin "assets/fonts/big/2_mask_reversed.raw"
    incbin "assets/fonts/big/3_mask_reversed.raw"
    incbin "assets/fonts/big/4_mask_reversed.raw"
    incbin "assets/fonts/big/5_mask_reversed.raw"
    incbin "assets/fonts/big/6_mask_reversed.raw"
    incbin "assets/fonts/big/7_mask_reversed.raw"
    incbin "assets/fonts/big/8_mask_reversed.raw"
    incbin "assets/fonts/big/9_mask_reversed.raw"
    dcb.b 2*16*1,$00 ; :
    dcb.b 2*16*1,$00 ; ;
    incbin "assets/cursors/cursor_left_mask_reversed.raw" ; <
    dcb.b 2*16*1,$00 ; =
    incbin "assets/cursors/cursor_right_mask_reversed.raw" ; >
    dcb.b 2*16*1,$00 ; ?
    dcb.b 2*16*1,$00 ; @
    incbin "assets/fonts/big/a_mask_reversed.raw"
    incbin "assets/fonts/big/b_mask_reversed.raw"
    incbin "assets/fonts/big/c_mask_reversed.raw"
    incbin "assets/fonts/big/d_mask_reversed.raw"
    incbin "assets/fonts/big/e_mask_reversed.raw"
    incbin "assets/fonts/big/f_mask_reversed.raw"
    incbin "assets/fonts/big/g_mask_reversed.raw"
    incbin "assets/fonts/big/h_mask_reversed.raw"
    incbin "assets/fonts/big/i_mask_reversed.raw"
    incbin "assets/fonts/big/j_mask_reversed.raw"
    incbin "assets/fonts/big/k_mask_reversed.raw"
    incbin "assets/fonts/big/l_mask_reversed.raw"
    incbin "assets/fonts/big/m_mask_reversed.raw"
    incbin "assets/fonts/big/n_mask_reversed.raw"
    incbin "assets/fonts/big/o_mask_reversed.raw"
    incbin "assets/fonts/big/p_mask_reversed.raw"
    incbin "assets/fonts/big/q_mask_reversed.raw"
    incbin "assets/fonts/big/r_mask_reversed.raw"
    incbin "assets/fonts/big/s_mask_reversed.raw"
    incbin "assets/fonts/big/t_mask_reversed.raw"
    incbin "assets/fonts/big/u_mask_reversed.raw"
    incbin "assets/fonts/big/v_mask_reversed.raw"
    incbin "assets/fonts/big/w_mask_reversed.raw"
    incbin "assets/fonts/big/x_mask_reversed.raw"
    incbin "assets/fonts/big/y_mask_reversed.raw"
    incbin "assets/fonts/big/z_mask_reversed.raw"
    even


SMALLFONTS:
    dcb.b 1*7*3,$00 ; space
    dcb.b 1*7*3,$00 ; !
    dcb.b 1*7*3,$00 ; "
    dcb.b 1*7*3,$00 ; #
    dcb.b 1*7*3,$00 ; $
    dcb.b 1*7*3,$00 ; %
    dcb.b 1*7*3,$00 ; &
    dcb.b 1*7*3,$00 ; '
    dcb.b 1*7*3,$00 ; (
    dcb.b 1*7*3,$00 ; )
    dcb.b 1*7*3,$00 ; *
    dcb.b 1*7*3,$00 ; +
    dcb.b 1*7*3,$00 ; ,
    dcb.b 1*7*3,$00 ; -
    dcb.b 1*7*3,$00 ; .
    dcb.b 1*7*3,$00 ; /
    incbin "assets/fonts/small/0.raw"
    incbin "assets/fonts/small/1.raw"
    incbin "assets/fonts/small/2.raw"
    incbin "assets/fonts/small/3.raw"
    incbin "assets/fonts/small/4.raw"
    incbin "assets/fonts/small/5.raw"
    incbin "assets/fonts/small/6.raw"
    incbin "assets/fonts/small/7.raw"
    incbin "assets/fonts/small/8.raw"
    incbin "assets/fonts/small/9.raw"
    dcb.b 1*7*3,$00 ; :
    dcb.b 1*7*3,$00 ; ;
    incbin "assets/cursors/cursor_left_small.raw" ; <
    dcb.b 1*7*3,$00 ; =
    incbin "assets/cursors/cursor_right_small.raw" ; >
    dcb.b 1*7*3,$00 ; ?
    dcb.b 1*7*3,$00 ; @
    incbin "assets/fonts/small/a.raw"
    incbin "assets/fonts/small/b.raw"
    incbin "assets/fonts/small/c.raw"
    incbin "assets/fonts/small/d.raw"
    incbin "assets/fonts/small/e.raw"
    incbin "assets/fonts/small/f.raw"
    incbin "assets/fonts/small/g.raw"
    incbin "assets/fonts/small/h.raw"
    incbin "assets/fonts/small/i.raw"
    incbin "assets/fonts/small/j.raw"
    incbin "assets/fonts/small/k.raw"
    incbin "assets/fonts/small/l.raw"
    incbin "assets/fonts/small/m.raw"
    incbin "assets/fonts/small/n.raw"
    incbin "assets/fonts/small/o.raw"
    incbin "assets/fonts/small/p.raw"
    incbin "assets/fonts/small/q.raw"
    incbin "assets/fonts/small/r.raw"
    incbin "assets/fonts/small/s.raw"
    incbin "assets/fonts/small/t.raw"
    incbin "assets/fonts/small/u.raw"
    incbin "assets/fonts/small/v.raw"
    incbin "assets/fonts/small/w.raw"
    incbin "assets/fonts/small/x.raw"
    incbin "assets/fonts/small/y.raw"
    incbin "assets/fonts/small/z.raw"
    even


SMALLFONTS_REVERSE_MASK:
    dcb.b 1*7*1,$FF ; space
    dcb.b 1*7*1,$00 ; !
    dcb.b 1*7*1,$00 ; "
    dcb.b 1*7*1,$00 ; #
    dcb.b 1*7*1,$00 ; $
    dcb.b 1*7*1,$00 ; %
    dcb.b 1*7*1,$00 ; &
    dcb.b 1*7*1,$00 ; '
    dcb.b 1*7*1,$00 ; (
    dcb.b 1*7*1,$00 ; )
    dcb.b 1*7*1,$00 ; *
    dcb.b 1*7*1,$00 ; +
    dcb.b 1*7*1,$00 ; ,
    dcb.b 1*7*1,$00 ; -
    dcb.b 1*7*1,$00 ; .
    dcb.b 1*7*1,$00 ; /
    incbin "assets/fonts/small/0_mask_reversed.raw"
    incbin "assets/fonts/small/1_mask_reversed.raw"
    incbin "assets/fonts/small/2_mask_reversed.raw"
    incbin "assets/fonts/small/3_mask_reversed.raw"
    incbin "assets/fonts/small/4_mask_reversed.raw"
    incbin "assets/fonts/small/5_mask_reversed.raw"
    incbin "assets/fonts/small/6_mask_reversed.raw"
    incbin "assets/fonts/small/7_mask_reversed.raw"
    incbin "assets/fonts/small/8_mask_reversed.raw"
    incbin "assets/fonts/small/9_mask_reversed.raw"
    dcb.b 1*7*1,$00 ; :
    dcb.b 1*7*1,$00 ; ;
    incbin "assets/cursors/cursor_left_small_mask_reversed.raw" ; <
    dcb.b 1*7*1,$00 ; =
    incbin "assets/cursors/cursor_right_small_mask_reversed.raw" ; >
    dcb.b 1*7*1,$00 ; ?
    dcb.b 1*7*1,$00 ; @
    incbin "assets/fonts/small/a_mask_reversed.raw"
    incbin "assets/fonts/small/b_mask_reversed.raw"
    incbin "assets/fonts/small/c_mask_reversed.raw"
    incbin "assets/fonts/small/d_mask_reversed.raw"
    incbin "assets/fonts/small/e_mask_reversed.raw"
    incbin "assets/fonts/small/f_mask_reversed.raw"
    incbin "assets/fonts/small/g_mask_reversed.raw"
    incbin "assets/fonts/small/h_mask_reversed.raw"
    incbin "assets/fonts/small/i_mask_reversed.raw"
    incbin "assets/fonts/small/j_mask_reversed.raw"
    incbin "assets/fonts/small/k_mask_reversed.raw"
    incbin "assets/fonts/small/l_mask_reversed.raw"
    incbin "assets/fonts/small/m_mask_reversed.raw"
    incbin "assets/fonts/small/n_mask_reversed.raw"
    incbin "assets/fonts/small/o_mask_reversed.raw"
    incbin "assets/fonts/small/p_mask_reversed.raw"
    incbin "assets/fonts/small/q_mask_reversed.raw"
    incbin "assets/fonts/small/r_mask_reversed.raw"
    incbin "assets/fonts/small/s_mask_reversed.raw"
    incbin "assets/fonts/small/t_mask_reversed.raw"
    incbin "assets/fonts/small/u_mask_reversed.raw"
    incbin "assets/fonts/small/v_mask_reversed.raw"
    incbin "assets/fonts/small/w_mask_reversed.raw"
    incbin "assets/fonts/small/x_mask_reversed.raw"
    incbin "assets/fonts/small/y_mask_reversed.raw"
    incbin "assets/fonts/small/z_mask_reversed.raw"
    even