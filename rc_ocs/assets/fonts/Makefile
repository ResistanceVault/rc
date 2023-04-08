define strip_odd_bytes
    > $2
	for number in 0 2 4 6 8 10 12 14 16 18 20 22 24 26 28 30 32 34 36 38 40; do \
		dd if=$1 skip=$$number count=1 bs=1 status=none oflag=append conv=notrunc of=$2; \
    done
endef

define copy
	cp $1 $2
endef

all:
	rm -f ./small/0.raw ../../src/assets/fonts/small/colors.plt
	ilbm2raw  ./small/0.iff ./small/0.raw -p ../../src/assets/fonts/small/colors.plt
	$(call strip_odd_bytes,./small/0.raw,../../src/assets/fonts/small/0.raw)

	rm -f ./small/1.raw
	ilbm2raw  ./small/1.iff ./small/1.raw
	$(call strip_odd_bytes,./small/1.raw,../../src/assets/fonts/small/1.raw)

	rm -f ./small/2.raw
	ilbm2raw  ./small/2.iff ./small/2.raw
	$(call strip_odd_bytes,./small/2.raw,../../src/assets/fonts/small/2.raw)

	rm -f ./small/3.raw
	ilbm2raw  ./small/3.iff ./small/3.raw
	$(call strip_odd_bytes,./small/3.raw,../../src/assets/fonts/small/3.raw)

	rm -f ./small/4.raw
	ilbm2raw  ./small/4.iff ./small/4.raw
	$(call strip_odd_bytes,./small/4.raw,../../src/assets/fonts/small/4.raw)

	rm -f ./small/5.raw
	ilbm2raw  ./small/5.iff ./small/5.raw
	$(call strip_odd_bytes,./small/5.raw,../../src/assets/fonts/small/5.raw)

	rm -f ./small/6.raw
	ilbm2raw  ./small/6.iff ./small/6.raw
	$(call strip_odd_bytes,./small/6.raw,../../src/assets/fonts/small/6.raw)

	rm -f ./small/7.raw
	ilbm2raw  ./small/7.iff ./small/7.raw
	$(call strip_odd_bytes,./small/7.raw,../../src/assets/fonts/small/7.raw)

	rm -f ./small/8.raw
	ilbm2raw  ./small/8.iff ./small/8.raw
	$(call strip_odd_bytes,./small/8.raw,../../src/assets/fonts/small/8.raw)

	rm -f ./small/9.raw
	ilbm2raw  ./small/9.iff ./small/9.raw
	$(call strip_odd_bytes,./small/9.raw,../../src/assets/fonts/small/9.raw)




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

	rm -f ./big/b.raw ./big/b_mask_reversed.raw
	ilbm2raw  ./big/b.iff ./big/b.raw -r ./big/b_mask_reversed.raw
	$(call copy,./big/b.raw,../../src/assets/fonts/big/b.raw)

	rm -f ./big/c.raw ./big/c_mask_reversed.raw
	ilbm2raw  ./big/c.iff ./big/c.raw -r ./big/c_mask_reversed.raw
	$(call copy,./big/c.raw,../../src/assets/fonts/big/c.raw)

	rm -f ./big/d.raw ./big/d_mask_reversed.raw
	ilbm2raw  ./big/d.iff ./big/d.raw -r ./big/d_mask_reversed.raw
	$(call copy,./big/d.raw,../../src/assets/fonts/big/d.raw)

	rm -f ./big/e.raw ./big/e_mask_reversed.raw
	ilbm2raw  ./big/e.iff ./big/e.raw -r ./big/e_mask_reversed.raw
	$(call copy,./big/e.raw,../../src/assets/fonts/big/e.raw)

	rm -f ./big/f.raw ./big/f_mask_reversed.raw
	ilbm2raw  ./big/f.iff ./big/f.raw -r ./big/f_mask_reversed.raw
	$(call copy,./big/f.raw,../../src/assets/fonts/big/f.raw)

	rm -f ./big/g.raw ./big/g_mask_reversed.raw
	ilbm2raw  ./big/g.iff ./big/g.raw -r ./big/g_mask_reversed.raw
	$(call copy,./big/g.raw,../../src/assets/fonts/big/g.raw)

	rm -f ./big/h.raw ./big/h_mask_reversed.raw
	ilbm2raw  ./big/h.iff ./big/h.raw -r ./big/h_mask_reversed.raw
	$(call copy,./big/h.raw,../../src/assets/fonts/big/h.raw)

	rm -f ./big/i.raw ./big/i_mask_reversed.raw
	ilbm2raw  ./big/i.iff ./big/i.raw -r ./big/i_mask_reversed.raw
	$(call copy,./big/i.raw,../../src/assets/fonts/big/i.raw)

	rm -f ./big/j.raw ./big/j_mask_reversed.raw
	ilbm2raw  ./big/j.iff ./big/j.raw -r ./big/j_mask_reversed.raw
	$(call copy,./big/j.raw,../../src/assets/fonts/big/j.raw)

	rm -f ./big/k.raw ./big/k_mask_reversed.raw
	ilbm2raw  ./big/k.iff ./big/k.raw -r ./big/k_mask_reversed.raw
	$(call copy,./big/k.raw,../../src/assets/fonts/big/k.raw)

	rm -f ./big/l.raw ./big/l_mask_reversed.raw
	ilbm2raw  ./big/l.iff ./big/l.raw -r ./big/l_mask_reversed.raw
	$(call copy,./big/l.raw,../../src/assets/fonts/big/l.raw)

	rm -f ./big/m.raw ./big/m_mask_reversed.raw
	ilbm2raw  ./big/m.iff ./big/m.raw -r ./big/m_mask_reversed.raw
	$(call copy,./big/m.raw,../../src/assets/fonts/big/m.raw)

	rm -f ./big/n.raw ./big/n_mask_reversed.raw
	ilbm2raw  ./big/n.iff ./big/n.raw -r ./big/n_mask_reversed.raw
	$(call copy,./big/n.raw,../../src/assets/fonts/big/n.raw)

	rm -f ./big/o.raw ./big/o_mask_reversed.raw
	ilbm2raw  ./big/o.iff ./big/o.raw -r ./big/o_mask_reversed.raw
	$(call copy,./big/o.raw,../../src/assets/fonts/big/o.raw)

	rm -f ./big/p.raw ./big/p_mask_reversed.raw
	ilbm2raw  ./big/p.iff ./big/p.raw -r ./big/p_mask_reversed.raw
	$(call copy,./big/p.raw,../../src/assets/fonts/big/p.raw)

	rm -f ./big/q.raw ./big/q_mask_reversed.raw
	ilbm2raw  ./big/q.iff ./big/q.raw -r ./big/q_mask_reversed.raw
	$(call copy,./big/q.raw,../../src/assets/fonts/big/q.raw)

	rm -f ./big/r.raw ./big/r_mask_reversed.raw
	ilbm2raw  ./big/r.iff ./big/r.raw -r ./big/r_mask_reversed.raw
	$(call copy,./big/r.raw,../../src/assets/fonts/big/r.raw)

	rm -f ./big/s.raw ./big/s_mask_reversed.raw
	ilbm2raw  ./big/s.iff ./big/s.raw -r ./big/s_mask_reversed.raw
	$(call copy,./big/s.raw,../../src/assets/fonts/big/s.raw)

	rm -f ./big/t.raw ./big/t_mask_reversed.raw
	ilbm2raw  ./big/t.iff ./big/t.raw -r ./big/t_mask_reversed.raw
	$(call copy,./big/t.raw,../../src/assets/fonts/big/t.raw)

	rm -f ./big/u.raw ./big/u_mask_reversed.raw
	ilbm2raw  ./big/u.iff ./big/u.raw -r ./big/u_mask_reversed.raw
	$(call copy,./big/u.raw,../../src/assets/fonts/big/u.raw)

	rm -f ./big/v.raw ./big/v_mask_reversed.raw
	ilbm2raw  ./big/v.iff ./big/v.raw -r ./big/v_mask_reversed.raw
	$(call copy,./big/v.raw,../../src/assets/fonts/big/v.raw)

	rm -f ./big/w.raw ./big/w_mask_reversed.raw
	ilbm2raw  ./big/w.iff ./big/w.raw -r ./big/w_mask_reversed.raw
	$(call copy,./big/w.raw,../../src/assets/fonts/big/w.raw)

	rm -f ./big/x.raw ./big/x_mask_reversed.raw
	ilbm2raw  ./big/x.iff ./big/x.raw -r ./big/x_mask_reversed.raw
	$(call copy,./big/x.raw,../../src/assets/fonts/big/x.raw)

	rm -f ./big/y.raw ./big/y_mask_reversed.raw
	ilbm2raw  ./big/y.iff ./big/y.raw -r ./big/y_mask_reversed.raw
	$(call copy,./big/y.raw,../../src/assets/fonts/big/y.raw)

	rm -f ./big/z.raw ./big/z_mask_reversed.raw
	ilbm2raw  ./big/z.iff ./big/z.raw -r ./big/z_mask_reversed.raw
	$(call copy,./big/z.raw,../../src/assets/fonts/big/z.raw)