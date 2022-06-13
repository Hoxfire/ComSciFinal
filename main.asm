;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.1.0 #12072 (MINGW32)
;--------------------------------------------------------
	.module main
	.optsdcc -mgbz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _printNum
	.globl _pow
	.globl _randw
	.globl _printf
	.globl _set_sprite_data
	.globl _joypad
	.globl _delay
	.globl _Numbers
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area _DABS (ABS)
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area _HOME
	.area _GSINIT
	.area _GSFINAL
	.area _GSINIT
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area _HOME
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
;Tools/print.h:5: int pow(int x, int y){
;	---------------------------------
; Function pow
; ---------------------------------
_pow::
	add	sp, #-2
;Tools/print.h:6: int s=1;
	ldhl	sp,	#0
	ld	(hl), #0x01
	xor	a, a
	inc	hl
	ld	(hl), a
;Tools/print.h:7: if (y==0)
	ldhl	sp,	#7
	ld	a, (hl-)
	or	a, (hl)
	jr	NZ, 00102$
;Tools/print.h:9: return 1;
	ld	de, #0x0001
	jr	00109$
00102$:
;Tools/print.h:11: if (y<0)
	ldhl	sp,	#6
	ld	a, (hl)
	sub	a, #0x00
	inc	hl
	ld	a, (hl)
	sbc	a, #0x00
	ld	d, (hl)
	ld	a, #0x00
	bit	7,a
	jr	Z, 00132$
	bit	7, d
	jr	NZ, 00133$
	cp	a, a
	jr	00133$
00132$:
	bit	7, d
	jr	Z, 00133$
	scf
00133$:
	jr	NC, 00114$
;Tools/print.h:13: return 0;
	ld	de, #0x0000
	jr	00109$
;Tools/print.h:16: for (size_t i = 0; i < y; i++)
00114$:
	ld	bc, #0x0000
00107$:
	ldhl	sp,	#6
	ld	a, c
	sub	a, (hl)
	inc	hl
	ld	a, b
	sbc	a, (hl)
	ld	a, b
	ld	d, a
	bit	7, (hl)
	jr	Z, 00134$
	bit	7, d
	jr	NZ, 00135$
	cp	a, a
	jr	00135$
00134$:
	bit	7, d
	jr	Z, 00135$
	scf
00135$:
	jr	NC, 00105$
;Tools/print.h:18: s*=x;
	push	bc
	ldhl	sp,	#6
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	ldhl	sp,	#4
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	__mulint
	add	sp, #4
	pop	bc
	inc	sp
	inc	sp
	push	de
;Tools/print.h:16: for (size_t i = 0; i < y; i++)
	inc	bc
	jr	00107$
00105$:
;Tools/print.h:20: return s;
	ldhl	sp,	#0
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
00109$:
;Tools/print.h:21: }
	add	sp, #2
	ret
;Tools/print.h:23: void printNum(UINT32 n, UINT8 nb,UINT8 x, UINT8 y, const unsigned char *data){
;	---------------------------------
; Function printNum
; ---------------------------------
_printNum::
	add	sp, #-20
;Tools/print.h:54: set_sprite_data(nb,nb+10,data);
	ldhl	sp,	#26
	ld	a, (hl)
	ldhl	sp,	#8
	ld	(hl), a
	ld	a, (hl)
	add	a, #0x0a
	ld	b, a
	ldhl	sp,	#29
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	push	bc
	inc	sp
	ldhl	sp,	#29
	ld	a, (hl)
	push	af
	inc	sp
	call	_set_sprite_data
	add	sp, #4
;Tools/print.h:56: UINT32 n2=0;
	xor	a, a
	ldhl	sp,	#4
	ld	(hl+), a
	ld	(hl+), a
	ld	(hl+), a
	ld	(hl), a
;Tools/print.h:57: for (int i = 3; i > 0; i--)
	ld	bc, #0x0003
	ldhl	sp,	#28
	ld	a, (hl)
	ldhl	sp,	#9
	ld	(hl), a
	ldhl	sp,	#18
	ld	(hl), #0x01
	xor	a, a
	inc	hl
	ld	(hl), a
00105$:
	ld	e, b
	ld	d, #0x00
	xor	a, a
	cp	a, c
	sbc	a, b
	bit	7, e
	jr	Z, 00120$
	bit	7, d
	jr	NZ, 00121$
	cp	a, a
	jr	00121$
00120$:
	bit	7, d
	jr	Z, 00121$
	scf
00121$:
	jp	NC, 00107$
;Tools/print.h:59: n1 = n/(pow(10,i-1));
	ld	de, #0x0001
	ld	a, c
	sub	a, e
	ld	e, a
	ld	a, b
	sbc	a, d
	ldhl	sp,	#11
	ld	(hl-), a
	ld	(hl), e
	push	bc
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	ld	hl, #0x000a
	push	hl
	call	_pow
	add	sp, #4
	pop	bc
	ld	a, d
	rla
	sbc	a, a
	ld	l, a
	ld	h, a
	push	bc
	push	hl
	push	de
	ldhl	sp,	#30
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	ldhl	sp,	#30
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	__divulong
	add	sp, #8
	push	hl
	ldhl	sp,	#4
	ld	(hl), e
	ldhl	sp,	#5
	ld	(hl), d
	pop	hl
	push	hl
	ld	a, l
	ldhl	sp,	#6
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#5
	ld	(hl), a
	pop	bc
	ldhl	sp,	#0
	ld	d, h
	ld	e, l
	ldhl	sp,	#12
	ld	a, (de)
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
;Tools/print.h:60: set_sprite_tile(nb+c, n1-(n2*10));
	ldhl	sp,	#12
	ld	a, (hl)
	ldhl	sp,	#16
	ld	(hl), a
	ldhl	sp,	#4
	ld	a, (hl)
	ld	e, a
	add	a, a
	add	a, a
	add	a, e
	add	a, a
	ldhl	sp,	#17
	ld	(hl-), a
	ld	a, (hl+)
	sub	a, (hl)
	ld	e, a
	inc	hl
	ld	a, (hl)
	ldhl	sp,	#8
	add	a, (hl)
	ldhl	sp,	#17
	ld	(hl), a
	ld	d, (hl)
;c:/gbdk/include/gb/gb.h:1145: shadow_OAM[nb].tile=tile;
	ld	h, #0x00
	ld	l, d
	add	hl, hl
	add	hl, hl
	push	de
	ld	de, #_shadow_OAM
	add	hl, de
	pop	de
	inc	hl
	inc	hl
	ld	(hl), e
;Tools/print.h:61: move_sprite(nb+c, x+(8*(3-i)), y);
	ld	a, #0x03
	sub	a, c
	add	a, a
	add	a, a
	add	a, a
	ldhl	sp,	#27
	ld	c, (hl)
	add	a, c
	ld	c, a
	ldhl	sp,	#17
	ld	e, (hl)
;c:/gbdk/include/gb/gb.h:1218: OAM_item_t * itm = &shadow_OAM[nb];
	ld	h, #0x00
	ld	l, e
	add	hl, hl
	add	hl, hl
	ld	de, #_shadow_OAM
	add	hl, de
	ld	e, l
	ld	d, h
;c:/gbdk/include/gb/gb.h:1219: itm->y=y, itm->x=x;
	ldhl	sp,	#9
	ld	a, (hl)
	ld	(de), a
	inc	de
	ld	a, c
	ld	(de), a
;Tools/print.h:62: c++;
	ldhl	sp,	#18
	inc	(hl)
	jr	NZ, 00122$
	inc	hl
	inc	(hl)
00122$:
;Tools/print.h:63: n2=n1;
	ldhl	sp,	#12
	ld	d, h
	ld	e, l
	ldhl	sp,	#4
	ld	a, (de)
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
;Tools/print.h:57: for (int i = 3; i > 0; i--)
	ldhl	sp,#10
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	jp	00105$
00107$:
;Tools/print.h:66: }
	add	sp, #20
	ret
;main.c:10: void main()
;	---------------------------------
; Function main
; ---------------------------------
_main::
	add	sp, #-12
;main.c:16: UINT32 PM =100;
	ldhl	sp,	#4
	ld	(hl), #0x64
	xor	a, a
	inc	hl
	ld	(hl+), a
	ld	(hl+), a
	ld	(hl), a
;main.c:17: UINT32 W =0;
	xor	a, a
	inc	hl
	ld	(hl+), a
	ld	(hl+), a
	ld	(hl+), a
	ld	(hl), a
;main.c:18: UINT8 S1 =2;
	ldhl	sp,	#0
;main.c:19: UINT8 S2 =2;
;main.c:20: UINT8 S3 =2;
	ld	a,#0x02
	ld	(hl+),a
	ld	(hl+), a
	ld	(hl), #0x02
;main.c:30: printf("You Have: \nYou Bet: ");
	ld	hl, #___str_0
	push	hl
	call	_printf
	add	sp, #2
;main.c:33: while (1)
00121$:
;main.c:38: if (W>PM) W=PM;
	ldhl	sp,	#4
	ld	e, l
	ld	d, h
	ldhl	sp,	#8
	ld	a, (de)
	sub	a, (hl)
	inc	hl
	inc	de
	ld	a, (de)
	sbc	a, (hl)
	inc	hl
	inc	de
	ld	a, (de)
	sbc	a, (hl)
	inc	hl
	inc	de
	ld	a, (de)
	sbc	a, (hl)
	jr	NC, 00102$
	ldhl	sp,	#4
	ld	d, h
	ld	e, l
	ldhl	sp,	#8
	ld	a, (de)
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
00102$:
;main.c:41: switch (joypad())
	call	_joypad
	ld	a, e
	cp	a, #0x01
	jp	Z,00119$
	cp	a, #0x02
	jp	Z,00119$
	cp	a, #0x04
	jp	Z,00115$
	cp	a, #0x08
	jp	Z,00116$
	sub	a, #0x10
	jp	NZ,00119$
;main.c:44: S1=(int)(randw()/9362);
	call	_randw
	ld	hl, #0x2492
	push	hl
	push	de
	call	__divuint
	add	sp, #4
	ldhl	sp,	#0
	ld	(hl), e
;main.c:45: S2=(int)(randw()/9362);
	call	_randw
	ld	hl, #0x2492
	push	hl
	push	de
	call	__divuint
	add	sp, #4
	ldhl	sp,	#1
	ld	(hl), e
;main.c:46: S3=(int)(randw()/9362);
	call	_randw
	ld	hl, #0x2492
	push	hl
	push	de
	call	__divuint
	add	sp, #4
	ldhl	sp,	#2
;main.c:47: if (S1==S2 || S2==S3 || S1==S3)
	ld	a, e
	ld	(hl-), a
	dec	hl
	ld	a, (hl+)
	sub	a, (hl)
	ld	a, #0x01
	jr	Z, 00198$
	xor	a, a
00198$:
	ld	c, a
	or	a, a
	jr	NZ, 00108$
	ldhl	sp,	#1
	ld	a, (hl+)
	sub	a, (hl)
	ld	a, #0x01
	jr	Z, 00200$
	xor	a, a
00200$:
	ld	e, a
	or	a, a
	jr	NZ, 00108$
	ldhl	sp,	#0
	ld	a, (hl+)
	inc	hl
	sub	a, (hl)
	jr	NZ, 00109$
00108$:
;main.c:49: W*=2;
	ldhl	sp,	#8
	sla	(hl)
	inc	hl
	rl	(hl)
	inc	hl
	rl	(hl)
	inc	hl
	rl	(hl)
;main.c:50: PM+=W;
	ldhl	sp,#4
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, e
	ldhl	sp,	#8
	add	a, (hl)
	ld	e, a
	ld	a, d
	inc	hl
	adc	a, (hl)
	push	af
	ldhl	sp,	#7
	ld	(hl-), a
	ld	(hl), e
	ldhl	sp,#8
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#12
	pop	af
	ld	a, e
	adc	a, (hl)
	ld	e, a
	ld	a, d
	inc	hl
	adc	a, (hl)
	ldhl	sp,	#7
	ld	(hl-), a
;main.c:51: W=1;
	ld	a, e
	ld	(hl+), a
	inc	hl
	ld	(hl), #0x01
	xor	a, a
	inc	hl
	ld	(hl+), a
	ld	(hl+), a
	ld	(hl), a
	jp	00119$
00109$:
;main.c:52: }else if (S1==S2 && S2==S3)
	ld	a, c
	or	a, a
	jr	Z, 00105$
	ld	a, e
	or	a, a
	jr	Z, 00105$
;main.c:54: W*=3;
	ldhl	sp,	#10
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	ldhl	sp,	#10
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	ld	hl, #0x0000
	push	hl
	ld	hl, #0x0003
	push	hl
	call	__mullong
	add	sp, #8
	ld	c, l
	ld	b, h
	ldhl	sp,	#8
	ld	a, e
	ld	(hl+), a
	ld	a, d
	ld	(hl+), a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;main.c:55: PM+=W;
	ldhl	sp,#4
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, e
	ldhl	sp,	#8
	add	a, (hl)
	ld	e, a
	ld	a, d
	inc	hl
	adc	a, (hl)
	push	af
	ldhl	sp,	#7
	ld	(hl-), a
	ld	(hl), e
	ldhl	sp,#8
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#12
	pop	af
	ld	a, e
	adc	a, (hl)
	ld	e, a
	ld	a, d
	inc	hl
	adc	a, (hl)
	ldhl	sp,	#7
	ld	(hl-), a
;main.c:56: W=1;
	ld	a, e
	ld	(hl+), a
	inc	hl
	ld	(hl), #0x01
	xor	a, a
	inc	hl
	ld	(hl+), a
	ld	(hl+), a
	ld	(hl), a
	jr	00119$
00105$:
;main.c:58: PM-=W;
	ldhl	sp,#4
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, e
	ldhl	sp,	#8
	sub	a, (hl)
	ld	e, a
	ld	a, d
	inc	hl
	sbc	a, (hl)
	push	af
	ldhl	sp,	#7
	ld	(hl-), a
	ld	(hl), e
	ldhl	sp,#8
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#12
	pop	af
	ld	a, e
	sbc	a, (hl)
	ld	e, a
	ld	a, d
	inc	hl
	sbc	a, (hl)
	ldhl	sp,	#7
	ld	(hl-), a
;main.c:59: W=1;
	ld	a, e
	ld	(hl+), a
	inc	hl
	ld	(hl), #0x01
	xor	a, a
	inc	hl
	ld	(hl+), a
	ld	(hl+), a
	ld	(hl), a
;main.c:63: break;
	jr	00119$
;main.c:75: case J_UP:
00115$:
;main.c:77: W+=1;
	ldhl	sp,	#8
	inc	(hl)
	jr	NZ, 00119$
	inc	hl
	inc	(hl)
	jr	NZ, 00119$
	inc	hl
	inc	(hl)
	jr	NZ, 00119$
	inc	hl
	inc	(hl)
;main.c:79: break;
	jr	00119$
;main.c:81: case J_DOWN:
00116$:
;main.c:82: if (W>1) W-=1;
	ldhl	sp,	#8
	ld	a, #0x01
	sub	a, (hl)
	inc	hl
	ld	a, #0x00
	sbc	a, (hl)
	inc	hl
	ld	a, #0x00
	sbc	a, (hl)
	inc	hl
	ld	a, #0x00
	sbc	a, (hl)
	jr	NC, 00119$
	ldhl	sp,#8
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, e
	sub	a, #0x01
	ld	e, a
	ld	a, d
	sbc	a, #0x00
	push	af
	ld	(hl-), a
	ld	(hl), e
	ldhl	sp,#12
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	pop	af
	ld	a, e
	sbc	a, #0x00
	ld	e, a
	ld	a, d
	sbc	a, #0x00
	ld	(hl-), a
	ld	(hl), e
;main.c:87: }
00119$:
;main.c:89: printNum(PM,0,88,16,Numbers);
	ld	hl, #_Numbers
	push	hl
	ld	de, #0x1058
	push	de
	xor	a, a
	push	af
	inc	sp
	ldhl	sp,	#11
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	ldhl	sp,	#11
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	_printNum
	add	sp, #9
;main.c:90: printNum(W,10,80,25,Numbers);
	ld	hl, #_Numbers
	push	hl
	ld	de, #0x1950
	push	de
	ld	a, #0x0a
	push	af
	inc	sp
	ldhl	sp,	#15
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	ldhl	sp,	#15
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	_printNum
	add	sp, #9
;main.c:91: set_sprite_data(20,27,Numbers);
	ld	hl, #_Numbers
	push	hl
	ld	de, #0x1b14
	push	de
	call	_set_sprite_data
	add	sp, #4
;main.c:92: set_sprite_tile(20,S1+40);
	ldhl	sp,	#0
	ld	a, (hl)
	add	a, #0x28
	ld	c, a
;c:/gbdk/include/gb/gb.h:1145: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 0x0052)
	ld	(hl), c
;c:/gbdk/include/gb/gb.h:1218: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 0x0050)
;c:/gbdk/include/gb/gb.h:1219: itm->y=y, itm->x=x;
	ld	a, #0x3f
	ld	(hl+), a
	ld	(hl), #0x50
;main.c:94: set_sprite_tile(21,S2+40);
	ldhl	sp,	#1
	ld	a, (hl)
	add	a, #0x28
	ld	c, a
;c:/gbdk/include/gb/gb.h:1145: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 0x0056)
	ld	(hl), c
;c:/gbdk/include/gb/gb.h:1218: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 0x0054)
;c:/gbdk/include/gb/gb.h:1219: itm->y=y, itm->x=x;
	ld	a, #0x3f
	ld	(hl+), a
	ld	(hl), #0x59
;main.c:96: set_sprite_tile(22,S3+40);
	ldhl	sp,	#2
	ld	a, (hl)
	add	a, #0x28
	inc	hl
	ld	(hl), a
;c:/gbdk/include/gb/gb.h:1145: shadow_OAM[nb].tile=tile;
	ld	de, #(_shadow_OAM + 0x005a)
	ld	a, (hl)
	ld	(de), a
;c:/gbdk/include/gb/gb.h:1218: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 0x0058)
;c:/gbdk/include/gb/gb.h:1219: itm->y=y, itm->x=x;
	ld	a, #0x3f
	ld	(hl+), a
	ld	(hl), #0x62
;main.c:98: SHOW_SPRITES;
	ldh	a, (_LCDC_REG+0)
	or	a, #0x02
	ldh	(_LCDC_REG+0),a
;main.c:99: delay(80);
	ld	hl, #0x0050
	push	hl
	call	_delay
	add	sp, #2
	jp	00121$
;main.c:102: }
	add	sp, #12
	ret
_Numbers:
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x42	; 66	'B'
	.db #0x42	; 66	'B'
	.db #0x42	; 66	'B'
	.db #0x42	; 66	'B'
	.db #0x42	; 66	'B'
	.db #0x42	; 66	'B'
	.db #0x42	; 66	'B'
	.db #0x42	; 66	'B'
	.db #0x42	; 66	'B'
	.db #0x42	; 66	'B'
	.db #0x42	; 66	'B'
	.db #0x42	; 66	'B'
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x38	; 56	'8'
	.db #0x38	; 56	'8'
	.db #0x78	; 120	'x'
	.db #0x78	; 120	'x'
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x66	; 102	'f'
	.db #0x66	; 102	'f'
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x1c	; 28
	.db #0x1c	; 28
	.db #0x38	; 56	'8'
	.db #0x38	; 56	'8'
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7c	; 124
	.db #0x7c	; 124
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7c	; 124
	.db #0x7c	; 124
	.db #0x44	; 68	'D'
	.db #0x44	; 68	'D'
	.db #0x44	; 68	'D'
	.db #0x44	; 68	'D'
	.db #0x44	; 68	'D'
	.db #0x44	; 68	'D'
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x7c	; 124
	.db #0x7c	; 124
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x7c	; 124
	.db #0x7c	; 124
	.db #0x7c	; 124
	.db #0x7c	; 124
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x42	; 66	'B'
	.db #0x42	; 66	'B'
	.db #0x42	; 66	'B'
	.db #0x42	; 66	'B'
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x42	; 66	'B'
	.db #0x42	; 66	'B'
	.db #0x42	; 66	'B'
	.db #0x42	; 66	'B'
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x42	; 66	'B'
	.db #0x42	; 66	'B'
	.db #0x42	; 66	'B'
	.db #0x42	; 66	'B'
	.db #0x42	; 66	'B'
	.db #0x42	; 66	'B'
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x42	; 66	'B'
	.db #0x42	; 66	'B'
	.db #0x42	; 66	'B'
	.db #0x42	; 66	'B'
	.db #0x42	; 66	'B'
	.db #0x42	; 66	'B'
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x42	; 66	'B'
	.db #0x42	; 66	'B'
	.db #0x42	; 66	'B'
	.db #0x42	; 66	'B'
	.db #0x42	; 66	'B'
	.db #0x42	; 66	'B'
	.db #0x42	; 66	'B'
	.db #0x42	; 66	'B'
	.db #0x42	; 66	'B'
	.db #0x42	; 66	'B'
	.db #0x42	; 66	'B'
	.db #0x42	; 66	'B'
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x38	; 56	'8'
	.db #0x38	; 56	'8'
	.db #0x78	; 120	'x'
	.db #0x78	; 120	'x'
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x66	; 102	'f'
	.db #0x66	; 102	'f'
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x1c	; 28
	.db #0x1c	; 28
	.db #0x38	; 56	'8'
	.db #0x38	; 56	'8'
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7c	; 124
	.db #0x7c	; 124
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7c	; 124
	.db #0x7c	; 124
	.db #0x44	; 68	'D'
	.db #0x44	; 68	'D'
	.db #0x44	; 68	'D'
	.db #0x44	; 68	'D'
	.db #0x44	; 68	'D'
	.db #0x44	; 68	'D'
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x7c	; 124
	.db #0x7c	; 124
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x7c	; 124
	.db #0x7c	; 124
	.db #0x7c	; 124
	.db #0x7c	; 124
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x42	; 66	'B'
	.db #0x42	; 66	'B'
	.db #0x42	; 66	'B'
	.db #0x42	; 66	'B'
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x42	; 66	'B'
	.db #0x42	; 66	'B'
	.db #0x42	; 66	'B'
	.db #0x42	; 66	'B'
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x42	; 66	'B'
	.db #0x42	; 66	'B'
	.db #0x42	; 66	'B'
	.db #0x42	; 66	'B'
	.db #0x42	; 66	'B'
	.db #0x42	; 66	'B'
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x42	; 66	'B'
	.db #0x42	; 66	'B'
	.db #0x42	; 66	'B'
	.db #0x42	; 66	'B'
	.db #0x42	; 66	'B'
	.db #0x42	; 66	'B'
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x40	; 64
	.db #0x2c	; 44
	.db #0x80	; 128
	.db #0x7e	; 126
	.db #0x02	; 2
	.db #0xfe	; 254
	.db #0x04	; 4
	.db #0x7c	; 124
	.db #0x08	; 8
	.db #0x38	; 56	'8'
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x7e	; 126
	.db #0x00	; 0
	.db #0x40	; 64
	.db #0x3e	; 62
	.db #0x00	; 0
	.db #0x0e	; 14
	.db #0x04	; 4
	.db #0x1c	; 28
	.db #0x08	; 8
	.db #0x38	; 56	'8'
	.db #0x38	; 56	'8'
	.db #0x38	; 56	'8'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x30	; 48	'0'
	.db #0x0c	; 12
	.db #0x40	; 64
	.db #0x3e	; 62
	.db #0x02	; 2
	.db #0x7e	; 126
	.db #0x02	; 2
	.db #0x7e	; 126
	.db #0x04	; 4
	.db #0x3c	; 60
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x60	; 96
	.db #0x1c	; 28
	.db #0x80	; 128
	.db #0x7e	; 126
	.db #0x00	; 0
	.db #0xfe	; 254
	.db #0x02	; 2
	.db #0xfe	; 254
	.db #0x1c	; 28
	.db #0x7c	; 124
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x00	; 0
	.db #0x7e	; 126
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x00	; 0
	.db #0x7e	; 126
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x00	; 0
	.db #0x7e	; 126
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x00	; 0
	.db #0x7e	; 126
___str_0:
	.ascii "You Have: "
	.db 0x0a
	.ascii "You Bet: "
	.db 0x00
	.area _CODE
	.area _CABS (ABS)
