define strip_odd_bytes
    > $2
	for number in 0 2 4 6 8 10 12 14 16 18 20 22 24 26 28 30 32 34 36 38 40; do \
		dd if=$1 skip=$$number count=1 bs=1 status=none oflag=append conv=notrunc of=$2; \
    done
endef

define strip_odd_bytes_mask
    > $2
	for number in 0 2 4 6 8 10 12; do \
		dd if=$1 skip=$$number count=1 bs=1 status=none oflag=append conv=notrunc of=$2; \
    done
endef

define copy
	cp $1 $2
endef

all:
	ilbm2raw -f -r ./small/0_mask_reversed.raw ./small/0.iff ./small/0.raw -p ../../src/assets/fonts/small/colors.plt
	$(call strip_odd_bytes,./small/0.raw,../../src/assets/fonts/small/0.raw)
	$(call strip_odd_bytes_mask,./small/0_mask_reversed.raw,../../src/assets/fonts/small/0_mask_reversed.raw)

	ilbm2raw -f -r ./small/1_mask_reversed.raw ./small/1.iff ./small/1.raw
	$(call strip_odd_bytes,./small/1.raw,../../src/assets/fonts/small/1.raw)
	$(call strip_odd_bytes_mask,./small/1_mask_reversed.raw,../../src/assets/fonts/small/1_mask_reversed.raw)

	ilbm2raw -f -r ./small/2_mask_reversed.raw ./small/2.iff ./small/2.raw
	$(call strip_odd_bytes,./small/2.raw,../../src/assets/fonts/small/2.raw)
	$(call strip_odd_bytes_mask,./small/2_mask_reversed.raw,../../src/assets/fonts/small/2_mask_reversed.raw)

	ilbm2raw -f -r ./small/3_mask_reversed.raw ./small/3.iff ./small/3.raw
	$(call strip_odd_bytes,./small/3.raw,../../src/assets/fonts/small/3.raw)
	$(call strip_odd_bytes_mask,./small/3_mask_reversed.raw,../../src/assets/fonts/small/3_mask_reversed.raw)

	ilbm2raw  -f -r ./small/4_mask_reversed.raw ./small/4.iff ./small/4.raw
	$(call strip_odd_bytes,./small/4.raw,../../src/assets/fonts/small/4.raw)
	$(call strip_odd_bytes_mask,./small/4_mask_reversed.raw,../../src/assets/fonts/small/4_mask_reversed.raw)

	ilbm2raw  -f -r ./small/5_mask_reversed.raw ./small/5.iff ./small/5.raw
	$(call strip_odd_bytes,./small/5.raw,../../src/assets/fonts/small/5.raw)
	$(call strip_odd_bytes_mask,./small/5_mask_reversed.raw,../../src/assets/fonts/small/5_mask_reversed.raw)

	ilbm2raw -f -r ./small/6_mask_reversed.raw ./small/6.iff ./small/6.raw
	$(call strip_odd_bytes,./small/6.raw,../../src/assets/fonts/small/6.raw)
	$(call strip_odd_bytes_mask,./small/6_mask_reversed.raw,../../src/assets/fonts/small/6_mask_reversed.raw)

	ilbm2raw -f -r ./small/7_mask_reversed.raw ./small/7.iff ./small/7.raw
	$(call strip_odd_bytes,./small/7.raw,../../src/assets/fonts/small/7.raw)
	$(call strip_odd_bytes_mask,./small/7_mask_reversed.raw,../../src/assets/fonts/small/7_mask_reversed.raw)

	ilbm2raw -f -r ./small/8_mask_reversed.raw ./small/8.iff ./small/8.raw
	$(call strip_odd_bytes,./small/8.raw,../../src/assets/fonts/small/8.raw)
	$(call strip_odd_bytes_mask,./small/8_mask_reversed.raw,../../src/assets/fonts/small/8_mask_reversed.raw)

	ilbm2raw -f -r ./small/9_mask_reversed.raw ./small/9.iff ./small/9.raw
	$(call strip_odd_bytes,./small/9.raw,../../src/assets/fonts/small/9.raw)
	$(call strip_odd_bytes_mask,./small/9_mask_reversed.raw,../../src/assets/fonts/small/9_mask_reversed.raw)

	ilbm2raw -f -r ./small/a_mask_reversed.raw ./small/a.iff ./small/a.raw
	$(call strip_odd_bytes,./small/a.raw,../../src/assets/fonts/small/a.raw)
	$(call strip_odd_bytes_mask,./small/a_mask_reversed.raw,../../src/assets/fonts/small/a_mask_reversed.raw)

	ilbm2raw -f -r ./small/b_mask_reversed.raw ./small/b.iff ./small/b.raw
	$(call strip_odd_bytes,./small/b.raw,../../src/assets/fonts/small/b.raw)
	$(call strip_odd_bytes_mask,./small/b_mask_reversed.raw,../../src/assets/fonts/small/b_mask_reversed.raw)

	ilbm2raw -f -r ./small/c_mask_reversed.raw ./small/c.iff ./small/c.raw
	$(call strip_odd_bytes,./small/c.raw,../../src/assets/fonts/small/c.raw)
	$(call strip_odd_bytes_mask,./small/c_mask_reversed.raw,../../src/assets/fonts/small/c_mask_reversed.raw)

	ilbm2raw -f -r ./small/d_mask_reversed.raw ./small/d.iff ./small/d.raw
	$(call strip_odd_bytes,./small/d.raw,../../src/assets/fonts/small/d.raw)
	$(call strip_odd_bytes_mask,./small/d_mask_reversed.raw,../../src/assets/fonts/small/d_mask_reversed.raw)

	ilbm2raw -f -r ./small/e_mask_reversed.raw ./small/e.iff ./small/e.raw
	$(call strip_odd_bytes,./small/e.raw,../../src/assets/fonts/small/e.raw)
	$(call strip_odd_bytes_mask,./small/e_mask_reversed.raw,../../src/assets/fonts/small/e_mask_reversed.raw)

	ilbm2raw -f -r ./small/f_mask_reversed.raw ./small/f.iff ./small/f.raw
	$(call strip_odd_bytes,./small/f.raw,../../src/assets/fonts/small/f.raw)
	$(call strip_odd_bytes_mask,./small/f_mask_reversed.raw,../../src/assets/fonts/small/f_mask_reversed.raw)

	ilbm2raw -f -r ./small/g_mask_reversed.raw ./small/g.iff ./small/g.raw
	$(call strip_odd_bytes,./small/g.raw,../../src/assets/fonts/small/g.raw)
	$(call strip_odd_bytes_mask,./small/g_mask_reversed.raw,../../src/assets/fonts/small/g_mask_reversed.raw)

	ilbm2raw -f -r ./small/h_mask_reversed.raw ./small/h.iff ./small/h.raw
	$(call strip_odd_bytes,./small/h.raw,../../src/assets/fonts/small/h.raw)
	$(call strip_odd_bytes_mask,./small/h_mask_reversed.raw,../../src/assets/fonts/small/h_mask_reversed.raw)

	ilbm2raw -f -r ./small/i_mask_reversed.raw ./small/i.iff ./small/i.raw
	$(call strip_odd_bytes,./small/i.raw,../../src/assets/fonts/small/i.raw)
	$(call strip_odd_bytes_mask,./small/i_mask_reversed.raw,../../src/assets/fonts/small/i_mask_reversed.raw)

	ilbm2raw -f -r ./small/j_mask_reversed.raw ./small/j.iff ./small/j.raw
	$(call strip_odd_bytes,./small/j.raw,../../src/assets/fonts/small/j.raw)
	$(call strip_odd_bytes_mask,./small/j_mask_reversed.raw,../../src/assets/fonts/small/j_mask_reversed.raw)

	ilbm2raw -f -r ./small/k_mask_reversed.raw ./small/k.iff ./small/k.raw
	$(call strip_odd_bytes,./small/k.raw,../../src/assets/fonts/small/k.raw)
	$(call strip_odd_bytes_mask,./small/k_mask_reversed.raw,../../src/assets/fonts/small/k_mask_reversed.raw)

	ilbm2raw -f -r ./small/l_mask_reversed.raw ./small/l.iff ./small/l.raw
	$(call strip_odd_bytes,./small/l.raw,../../src/assets/fonts/small/l.raw)
	$(call strip_odd_bytes_mask,./small/l_mask_reversed.raw,../../src/assets/fonts/small/l_mask_reversed.raw)

	ilbm2raw -f -r ./small/m_mask_reversed.raw ./small/m.iff ./small/m.raw
	$(call strip_odd_bytes,./small/m.raw,../../src/assets/fonts/small/m.raw)
	$(call strip_odd_bytes_mask,./small/m_mask_reversed.raw,../../src/assets/fonts/small/m_mask_reversed.raw)

	ilbm2raw -f -r ./small/n_mask_reversed.raw ./small/n.iff ./small/n.raw
	$(call strip_odd_bytes,./small/n.raw,../../src/assets/fonts/small/n.raw)
	$(call strip_odd_bytes_mask,./small/n_mask_reversed.raw,../../src/assets/fonts/small/n_mask_reversed.raw)

	ilbm2raw -f -r ./small/o_mask_reversed.raw ./small/o.iff ./small/o.raw
	$(call strip_odd_bytes,./small/o.raw,../../src/assets/fonts/small/o.raw)
	$(call strip_odd_bytes_mask,./small/o_mask_reversed.raw,../../src/assets/fonts/small/o_mask_reversed.raw)

	ilbm2raw -f -r ./small/p_mask_reversed.raw ./small/p.iff ./small/p.raw
	$(call strip_odd_bytes,./small/p.raw,../../src/assets/fonts/small/p.raw)
	$(call strip_odd_bytes_mask,./small/p_mask_reversed.raw,../../src/assets/fonts/small/p_mask_reversed.raw)

	ilbm2raw -f -r ./small/q_mask_reversed.raw ./small/q.iff ./small/q.raw
	$(call strip_odd_bytes,./small/q.raw,../../src/assets/fonts/small/q.raw)
	$(call strip_odd_bytes_mask,./small/q_mask_reversed.raw,../../src/assets/fonts/small/q_mask_reversed.raw)

	ilbm2raw -f -r ./small/r_mask_reversed.raw ./small/r.iff ./small/r.raw
	$(call strip_odd_bytes,./small/r.raw,../../src/assets/fonts/small/r.raw)
	$(call strip_odd_bytes_mask,./small/r_mask_reversed.raw,../../src/assets/fonts/small/r_mask_reversed.raw)

	ilbm2raw -f -r ./small/s_mask_reversed.raw ./small/s.iff ./small/s.raw
	$(call strip_odd_bytes,./small/s.raw,../../src/assets/fonts/small/s.raw)
	$(call strip_odd_bytes_mask,./small/s_mask_reversed.raw,../../src/assets/fonts/small/s_mask_reversed.raw)

	ilbm2raw -f -r ./small/t_mask_reversed.raw ./small/t.iff ./small/t.raw
	$(call strip_odd_bytes,./small/t.raw,../../src/assets/fonts/small/t.raw)
	$(call strip_odd_bytes_mask,./small/t_mask_reversed.raw,../../src/assets/fonts/small/t_mask_reversed.raw)

	ilbm2raw -f -r ./small/u_mask_reversed.raw ./small/u.iff ./small/u.raw
	$(call strip_odd_bytes,./small/u.raw,../../src/assets/fonts/small/u.raw)
	$(call strip_odd_bytes_mask,./small/u_mask_reversed.raw,../../src/assets/fonts/small/u_mask_reversed.raw)

	ilbm2raw -f -r ./small/v_mask_reversed.raw ./small/v.iff ./small/v.raw
	$(call strip_odd_bytes,./small/v.raw,../../src/assets/fonts/small/v.raw)
	$(call strip_odd_bytes_mask,./small/v_mask_reversed.raw,../../src/assets/fonts/small/v_mask_reversed.raw)

	ilbm2raw -f -r ./small/w_mask_reversed.raw ./small/w.iff ./small/w.raw
	$(call strip_odd_bytes,./small/w.raw,../../src/assets/fonts/small/w.raw)
	$(call strip_odd_bytes_mask,./small/w_mask_reversed.raw,../../src/assets/fonts/small/w_mask_reversed.raw)

	ilbm2raw -f -r ./small/x_mask_reversed.raw ./small/x.iff ./small/x.raw
	$(call strip_odd_bytes,./small/x.raw,../../src/assets/fonts/small/x.raw)
	$(call strip_odd_bytes_mask,./small/x_mask_reversed.raw,../../src/assets/fonts/small/x_mask_reversed.raw)

	ilbm2raw -f -r ./small/y_mask_reversed.raw ./small/y.iff ./small/y.raw
	$(call strip_odd_bytes,./small/y.raw,../../src/assets/fonts/small/y.raw)
	$(call strip_odd_bytes_mask,./small/y_mask_reversed.raw,../../src/assets/fonts/small/y_mask_reversed.raw)

	ilbm2raw -f -r ./small/z_mask_reversed.raw ./small/z.iff ./small/z.raw
	$(call strip_odd_bytes,./small/z.raw,../../src/assets/fonts/small/z.raw)
	$(call strip_odd_bytes_mask,./small/z_mask_reversed.raw,../../src/assets/fonts/small/z_mask_reversed.raw)

	rm -f ./big/0.raw ../../src/assets/fonts/big/colors.plt ./big/0_mask_reversed.raw
	ilbm2raw  ./big/0.iff ./big/0.raw -p ../../src/assets/fonts/big/colors.plt -r ./big/0_mask_reversed.raw
	$(call copy,./big/0.raw,../../src/assets/fonts/big/0.raw)
	$(call copy,./big/0_mask_reversed.raw,../../src/assets/fonts/big/0_mask_reversed.raw)

	rm -f ./big/1.raw -r ./big/1_mask_reversed.raw
	ilbm2raw  ./big/1.iff ./big/1.raw -r ./big/1_mask_reversed.raw
	$(call copy,./big/1.raw,../../src/assets/fonts/big/1.raw)
	$(call copy,./big/1_mask_reversed.raw,../../src/assets/fonts/big/1_mask_reversed.raw)

	rm -f ./big/2.raw -r ./big/2_mask_reversed.raw
	ilbm2raw  ./big/2.iff ./big/2.raw -r ./big/2_mask_reversed.raw
	$(call copy,./big/2.raw,../../src/assets/fonts/big/2.raw)
	$(call copy,./big/2_mask_reversed.raw,../../src/assets/fonts/big/2_mask_reversed.raw)

	rm -f ./big/3.raw -r ./big/3_mask_reversed.raw
	ilbm2raw  ./big/3.iff ./big/3.raw -r ./big/3_mask_reversed.raw
	$(call copy,./big/3.raw,../../src/assets/fonts/big/3.raw)
	$(call copy,./big/3_mask_reversed.raw,../../src/assets/fonts/big/3_mask_reversed.raw)

	rm -f ./big/4.raw -r ./big/4_mask_reversed.raw
	ilbm2raw  ./big/4.iff ./big/4.raw -r ./big/4_mask_reversed.raw
	$(call copy,./big/4.raw,../../src/assets/fonts/big/4.raw)
	$(call copy,./big/4_mask_reversed.raw,../../src/assets/fonts/big/4_mask_reversed.raw)

	rm -f ./big/5.raw -r ./big/5_mask_reversed.raw
	ilbm2raw  ./big/5.iff ./big/5.raw -r ./big/5_mask_reversed.raw
	$(call copy,./big/5.raw,../../src/assets/fonts/big/5.raw)
	$(call copy,./big/5_mask_reversed.raw,../../src/assets/fonts/big/5_mask_reversed.raw)

	rm -f ./big/6.raw -r ./big/6_mask_reversed.raw
	ilbm2raw  ./big/6.iff ./big/6.raw -r ./big/6_mask_reversed.raw
	$(call copy,./big/6.raw,../../src/assets/fonts/big/6.raw)
	$(call copy,./big/6_mask_reversed.raw,../../src/assets/fonts/big/6_mask_reversed.raw)

	rm -f ./big/7.raw -r ./big/7_mask_reversed.raw
	ilbm2raw  ./big/7.iff ./big/7.raw -r ./big/7_mask_reversed.raw
	$(call copy,./big/7.raw,../../src/assets/fonts/big/7.raw)
	$(call copy,./big/7_mask_reversed.raw,../../src/assets/fonts/big/7_mask_reversed.raw)

	rm -f ./big/8.raw -r ./big/8_mask_reversed.raw
	ilbm2raw  ./big/8.iff ./big/8.raw -r ./big/8_mask_reversed.raw
	$(call copy,./big/8.raw,../../src/assets/fonts/big/8.raw)
	$(call copy,./big/8_mask_reversed.raw,../../src/assets/fonts/big/8_mask_reversed.raw)

	rm -f ./big/9.raw -r ./big/9_mask_reversed.raw
	ilbm2raw  ./big/9.iff ./big/9.raw -r ./big/9_mask_reversed.raw
	$(call copy,./big/9.raw,../../src/assets/fonts/big/9.raw)
	$(call copy,./big/9_mask_reversed.raw,../../src/assets/fonts/big/9_mask_reversed.raw)

	rm -f ./big/a.raw ./big/a_mask_reversed.raw
	ilbm2raw  ./big/a.iff ./big/a.raw -r ./big/a_mask_reversed.raw
	$(call copy,./big/a.raw,../../src/assets/fonts/big/a.raw)
	$(call copy,./big/a_mask_reversed.raw,../../src/assets/fonts/big/a_mask_reversed.raw)

	rm -f ./big/b.raw ./big/b_mask_reversed.raw
	ilbm2raw  ./big/b.iff ./big/b.raw -r ./big/b_mask_reversed.raw
	$(call copy,./big/b.raw,../../src/assets/fonts/big/b.raw)
	$(call copy,./big/b_mask_reversed.raw,../../src/assets/fonts/big/b_mask_reversed.raw)

	rm -f ./big/c.raw ./big/c_mask_reversed.raw
	ilbm2raw  ./big/c.iff ./big/c.raw -r ./big/c_mask_reversed.raw
	$(call copy,./big/c.raw,../../src/assets/fonts/big/c.raw)
	$(call copy,./big/c_mask_reversed.raw,../../src/assets/fonts/big/c_mask_reversed.raw)

	rm -f ./big/d.raw ./big/d_mask_reversed.raw
	ilbm2raw  ./big/d.iff ./big/d.raw -r ./big/d_mask_reversed.raw
	$(call copy,./big/d.raw,../../src/assets/fonts/big/d.raw)
	$(call copy,./big/d_mask_reversed.raw,../../src/assets/fonts/big/d_mask_reversed.raw)

	rm -f ./big/e.raw ./big/e_mask_reversed.raw
	ilbm2raw  ./big/e.iff ./big/e.raw -r ./big/e_mask_reversed.raw
	$(call copy,./big/e.raw,../../src/assets/fonts/big/e.raw)
	$(call copy,./big/e_mask_reversed.raw,../../src/assets/fonts/big/e_mask_reversed.raw)

	rm -f ./big/f.raw ./big/f_mask_reversed.raw
	ilbm2raw  ./big/f.iff ./big/f.raw -r ./big/f_mask_reversed.raw
	$(call copy,./big/f.raw,../../src/assets/fonts/big/f.raw)
	$(call copy,./big/f_mask_reversed.raw,../../src/assets/fonts/big/f_mask_reversed.raw)

	rm -f ./big/g.raw ./big/g_mask_reversed.raw
	ilbm2raw  ./big/g.iff ./big/g.raw -r ./big/g_mask_reversed.raw
	$(call copy,./big/g.raw,../../src/assets/fonts/big/g.raw)
	$(call copy,./big/g_mask_reversed.raw,../../src/assets/fonts/big/g_mask_reversed.raw)

	rm -f ./big/h.raw ./big/h_mask_reversed.raw
	ilbm2raw  ./big/h.iff ./big/h.raw -r ./big/h_mask_reversed.raw
	$(call copy,./big/h.raw,../../src/assets/fonts/big/h.raw)
	$(call copy,./big/h_mask_reversed.raw,../../src/assets/fonts/big/h_mask_reversed.raw)

	rm -f ./big/i.raw ./big/i_mask_reversed.raw
	ilbm2raw  ./big/i.iff ./big/i.raw -r ./big/i_mask_reversed.raw
	$(call copy,./big/i.raw,../../src/assets/fonts/big/i.raw)
	$(call copy,./big/i_mask_reversed.raw,../../src/assets/fonts/big/i_mask_reversed.raw)

	rm -f ./big/j.raw ./big/j_mask_reversed.raw
	ilbm2raw  ./big/j.iff ./big/j.raw -r ./big/j_mask_reversed.raw
	$(call copy,./big/j.raw,../../src/assets/fonts/big/j.raw)
	$(call copy,./big/j_mask_reversed.raw,../../src/assets/fonts/big/j_mask_reversed.raw)

	rm -f ./big/k.raw ./big/k_mask_reversed.raw
	ilbm2raw  ./big/k.iff ./big/k.raw -r ./big/k_mask_reversed.raw
	$(call copy,./big/k.raw,../../src/assets/fonts/big/k.raw)
	$(call copy,./big/k_mask_reversed.raw,../../src/assets/fonts/big/k_mask_reversed.raw)

	rm -f ./big/l.raw ./big/l_mask_reversed.raw
	ilbm2raw  ./big/l.iff ./big/l.raw -r ./big/l_mask_reversed.raw
	$(call copy,./big/l.raw,../../src/assets/fonts/big/l.raw)
	$(call copy,./big/l_mask_reversed.raw,../../src/assets/fonts/big/l_mask_reversed.raw)

	rm -f ./big/m.raw ./big/m_mask_reversed.raw
	ilbm2raw  ./big/m.iff ./big/m.raw -r ./big/m_mask_reversed.raw
	$(call copy,./big/m.raw,../../src/assets/fonts/big/m.raw)
	$(call copy,./big/m_mask_reversed.raw,../../src/assets/fonts/big/m_mask_reversed.raw)

	rm -f ./big/n.raw ./big/n_mask_reversed.raw
	ilbm2raw  ./big/n.iff ./big/n.raw -r ./big/n_mask_reversed.raw
	$(call copy,./big/n.raw,../../src/assets/fonts/big/n.raw)
	$(call copy,./big/n_mask_reversed.raw,../../src/assets/fonts/big/n_mask_reversed.raw)

	rm -f ./big/o.raw ./big/o_mask_reversed.raw
	ilbm2raw  ./big/o.iff ./big/o.raw -r ./big/o_mask_reversed.raw
	$(call copy,./big/o.raw,../../src/assets/fonts/big/o.raw)
	$(call copy,./big/o_mask_reversed.raw,../../src/assets/fonts/big/o_mask_reversed.raw)

	rm -f ./big/p.raw ./big/p_mask_reversed.raw
	ilbm2raw  ./big/p.iff ./big/p.raw -r ./big/p_mask_reversed.raw
	$(call copy,./big/p.raw,../../src/assets/fonts/big/p.raw)
	$(call copy,./big/p_mask_reversed.raw,../../src/assets/fonts/big/p_mask_reversed.raw)

	rm -f ./big/q.raw ./big/q_mask_reversed.raw
	ilbm2raw  ./big/q.iff ./big/q.raw -r ./big/q_mask_reversed.raw
	$(call copy,./big/q.raw,../../src/assets/fonts/big/q.raw)
	$(call copy,./big/q_mask_reversed.raw,../../src/assets/fonts/big/q_mask_reversed.raw)

	rm -f ./big/r.raw ./big/r_mask_reversed.raw
	ilbm2raw  ./big/r.iff ./big/r.raw -r ./big/r_mask_reversed.raw
	$(call copy,./big/r.raw,../../src/assets/fonts/big/r.raw)
	$(call copy,./big/r_mask_reversed.raw,../../src/assets/fonts/big/r_mask_reversed.raw)

	rm -f ./big/s.raw ./big/s_mask_reversed.raw
	ilbm2raw  ./big/s.iff ./big/s.raw -r ./big/s_mask_reversed.raw
	$(call copy,./big/s.raw,../../src/assets/fonts/big/s.raw)
	$(call copy,./big/s_mask_reversed.raw,../../src/assets/fonts/big/s_mask_reversed.raw)

	rm -f ./big/t.raw ./big/t_mask_reversed.raw
	ilbm2raw  ./big/t.iff ./big/t.raw -r ./big/t_mask_reversed.raw
	$(call copy,./big/t.raw,../../src/assets/fonts/big/t.raw)
	$(call copy,./big/t_mask_reversed.raw,../../src/assets/fonts/big/t_mask_reversed.raw)

	rm -f ./big/u.raw ./big/u_mask_reversed.raw
	ilbm2raw  ./big/u.iff ./big/u.raw -r ./big/u_mask_reversed.raw
	$(call copy,./big/u.raw,../../src/assets/fonts/big/u.raw)
	$(call copy,./big/u_mask_reversed.raw,../../src/assets/fonts/big/u_mask_reversed.raw)

	rm -f ./big/v.raw ./big/v_mask_reversed.raw
	ilbm2raw  ./big/v.iff ./big/v.raw -r ./big/v_mask_reversed.raw
	$(call copy,./big/v.raw,../../src/assets/fonts/big/v.raw)
	$(call copy,./big/v_mask_reversed.raw,../../src/assets/fonts/big/v_mask_reversed.raw)

	rm -f ./big/w.raw ./big/w_mask_reversed.raw
	ilbm2raw  ./big/w.iff ./big/w.raw -r ./big/w_mask_reversed.raw
	$(call copy,./big/w.raw,../../src/assets/fonts/big/w.raw)
	$(call copy,./big/w_mask_reversed.raw,../../src/assets/fonts/big/w_mask_reversed.raw)

	rm -f ./big/x.raw ./big/x_mask_reversed.raw
	ilbm2raw  ./big/x.iff ./big/x.raw -r ./big/x_mask_reversed.raw
	$(call copy,./big/x.raw,../../src/assets/fonts/big/x.raw)
	$(call copy,./big/x_mask_reversed.raw,../../src/assets/fonts/big/x_mask_reversed.raw)

	rm -f ./big/y.raw ./big/y_mask_reversed.raw
	ilbm2raw  ./big/y.iff ./big/y.raw -r ./big/y_mask_reversed.raw
	$(call copy,./big/y.raw,../../src/assets/fonts/big/y.raw)
	$(call copy,./big/y_mask_reversed.raw,../../src/assets/fonts/big/y_mask_reversed.raw)

	rm -f ./big/z.raw ./big/z_mask_reversed.raw
	ilbm2raw  ./big/z.iff ./big/z.raw -r ./big/z_mask_reversed.raw
	$(call copy,./big/z.raw,../../src/assets/fonts/big/z.raw)
	$(call copy,./big/z_mask_reversed.raw,../../src/assets/fonts/big/z_mask_reversed.raw)