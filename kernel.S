
target/riscv64gc-unknown-none-elf/debug/os:	file format elf64-littleriscv

Disassembly of section .text:

0000000080200000 <stext>:
80200000: 17 01 03 00  	auipc	sp, 48
80200004: 13 01 01 00  	mv	sp, sp
80200008: 97 00 00 00  	auipc	ra, 0
8020000c: e7 80 20 50  	jalr	1282(ra)

0000000080200010 <_ZN5riscv8register5stvec5write17h72f0b9c1ac648398E>:
80200010: 79 71        	addi	sp, sp, -48
80200012: 06 f4        	sd	ra, 40(sp)
80200014: 2e e4        	sd	a1, 8(sp)
80200016: aa 85        	mv	a1, a0
80200018: 22 65        	ld	a0, 8(sp)
8020001a: 2e ec        	sd	a1, 24(sp)
8020001c: a3 03 a1 02  	sb	a0, 39(sp)
80200020: 2e 95        	add	a0, a0, a1
80200022: 2a e8        	sd	a0, 16(sp)
80200024: 63 69 b5 00  	bltu	a0, a1, 0x80200036 <.LBB0_4>
80200028: 09 a0        	j	0x8020002a <_ZN5riscv8register5stvec5write17h72f0b9c1ac648398E+0x1a>
8020002a: 42 65        	ld	a0, 16(sp)
8020002c: 97 00 00 00  	auipc	ra, 0
80200030: e7 80 c0 02  	jalr	44(ra)
80200034: 39 a8        	j	0x80200052 <.LBB0_5+0x14>

0000000080200036 <.LBB0_4>:
80200036: 17 75 00 00  	auipc	a0, 7
8020003a: 13 05 a5 03  	addi	a0, a0, 58

000000008020003e <.LBB0_5>:
8020003e: 17 76 00 00  	auipc	a2, 7
80200042: 13 06 a6 01  	addi	a2, a2, 26
80200046: f1 45        	addi	a1, zero, 28
80200048: 97 50 00 00  	auipc	ra, 5
8020004c: e7 80 40 b6  	jalr	-1180(ra)
80200050: 00 00        	unimp	
80200052: a2 70        	ld	ra, 40(sp)
80200054: 45 61        	addi	sp, sp, 48
80200056: 82 80        	ret

0000000080200058 <_ZN5riscv8register5stvec6_write17h180d73048156e539E>:
80200058: 41 11        	addi	sp, sp, -16
8020005a: 2a e4        	sd	a0, 8(sp)
8020005c: 73 10 55 10  	csrw	stvec, a0
80200060: 09 a0        	j	0x80200062 <_ZN5riscv8register5stvec6_write17h180d73048156e539E+0xa>
80200062: 41 01        	addi	sp, sp, 16
80200064: 82 80        	ret

0000000080200066 <_ZN2os4sync2up19UPSafeCell$LT$T$GT$3new17hb8237306081ebc07E>:
80200066: 13 01 01 c1  	addi	sp, sp, -1008
8020006a: 23 34 11 3e  	sd	ra, 1000(sp)
8020006e: 2a e0        	sd	a0, 0(sp)
80200070: 08 04        	addi	a0, sp, 512
80200072: 2a e4        	sd	a0, 8(sp)
80200074: 13 06 80 1e  	addi	a2, zero, 488
80200078: 97 70 00 00  	auipc	ra, 7
8020007c: e7 80 20 a3  	jalr	-1486(ra)
80200080: a2 65        	ld	a1, 8(sp)
80200082: 08 08        	addi	a0, sp, 16
80200084: 97 00 00 00  	auipc	ra, 0
80200088: e7 80 20 0c  	jalr	194(ra)
8020008c: 09 a0        	j	0x8020008e <_ZN2os4sync2up19UPSafeCell$LT$T$GT$3new17hb8237306081ebc07E+0x28>
8020008e: 02 65        	ld	a0, 0(sp)
80200090: 0c 08        	addi	a1, sp, 16
80200092: 13 06 00 1f  	addi	a2, zero, 496
80200096: 97 70 00 00  	auipc	ra, 7
8020009a: e7 80 40 a1  	jalr	-1516(ra)
8020009e: 83 30 81 3e  	ld	ra, 1000(sp)
802000a2: 13 01 01 3f  	addi	sp, sp, 1008
802000a6: 82 80        	ret

00000000802000a8 <_ZN2os4sync2up19UPSafeCell$LT$T$GT$16exclusive_access17hd19d36d906d3e08fE>:
802000a8: 01 11        	addi	sp, sp, -32
802000aa: 06 ec        	sd	ra, 24(sp)
802000ac: 2a e8        	sd	a0, 16(sp)

00000000802000ae <.LBB1_2>:
802000ae: 97 75 00 00  	auipc	a1, 7
802000b2: 93 85 25 ff  	addi	a1, a1, -14
802000b6: 97 00 00 00  	auipc	ra, 0
802000ba: e7 80 c0 0f  	jalr	252(ra)
802000be: 2a e0        	sd	a0, 0(sp)
802000c0: 2e e4        	sd	a1, 8(sp)
802000c2: 09 a0        	j	0x802000c4 <.LBB1_2+0x16>
802000c4: a2 65        	ld	a1, 8(sp)
802000c6: 02 65        	ld	a0, 0(sp)
802000c8: e2 60        	ld	ra, 24(sp)
802000ca: 05 61        	addi	sp, sp, 32
802000cc: 82 80        	ret

00000000802000ce <_ZN4core4cell13Cell$LT$T$GT$3new17h1ed8e8f487e94f39E>:
802000ce: 79 71        	addi	sp, sp, -48
802000d0: 2a ec        	sd	a0, 24(sp)
802000d2: 2a f4        	sd	a0, 40(sp)
802000d4: 2a f0        	sd	a0, 32(sp)
802000d6: 2a e4        	sd	a0, 8(sp)
802000d8: 09 a0        	j	0x802000da <_ZN4core4cell13Cell$LT$T$GT$3new17h1ed8e8f487e94f39E+0xc>
802000da: 22 65        	ld	a0, 8(sp)
802000dc: 2a e8        	sd	a0, 16(sp)
802000de: 45 61        	addi	sp, sp, 48
802000e0: 82 80        	ret

00000000802000e2 <_ZN4core4cell13Cell$LT$T$GT$3set17hf6d2f96d99d4a2adE>:
802000e2: 79 71        	addi	sp, sp, -48
802000e4: 06 f4        	sd	ra, 40(sp)
802000e6: 2a e8        	sd	a0, 16(sp)
802000e8: 2e ec        	sd	a1, 24(sp)
802000ea: 97 00 00 00  	auipc	ra, 0
802000ee: e7 80 20 02  	jalr	34(ra)
802000f2: aa 85        	mv	a1, a0
802000f4: 2e e4        	sd	a1, 8(sp)
802000f6: 2a f0        	sd	a0, 32(sp)
802000f8: 09 a0        	j	0x802000fa <_ZN4core4cell13Cell$LT$T$GT$3set17hf6d2f96d99d4a2adE+0x18>
802000fa: 22 65        	ld	a0, 8(sp)
802000fc: 97 30 00 00  	auipc	ra, 3
80200100: e7 80 00 62  	jalr	1568(ra)
80200104: 09 a0        	j	0x80200106 <_ZN4core4cell13Cell$LT$T$GT$3set17hf6d2f96d99d4a2adE+0x24>
80200106: a2 70        	ld	ra, 40(sp)
80200108: 45 61        	addi	sp, sp, 48
8020010a: 82 80        	ret

000000008020010c <_ZN4core4cell13Cell$LT$T$GT$7replace17h8ba28b6fa514dbf0E>:
8020010c: 39 71        	addi	sp, sp, -64
8020010e: 06 fc        	sd	ra, 56(sp)
80200110: 2e e8        	sd	a1, 16(sp)
80200112: 2a ec        	sd	a0, 24(sp)
80200114: 2a f0        	sd	a0, 32(sp)
80200116: 2e f4        	sd	a1, 40(sp)
80200118: 2a f8        	sd	a0, 48(sp)
8020011a: 09 a0        	j	0x8020011c <_ZN4core4cell13Cell$LT$T$GT$7replace17h8ba28b6fa514dbf0E+0x10>
8020011c: c2 65        	ld	a1, 16(sp)
8020011e: 62 65        	ld	a0, 24(sp)
80200120: 97 30 00 00  	auipc	ra, 3
80200124: e7 80 00 5b  	jalr	1456(ra)
80200128: 2a e4        	sd	a0, 8(sp)
8020012a: 09 a0        	j	0x8020012c <_ZN4core4cell13Cell$LT$T$GT$7replace17h8ba28b6fa514dbf0E+0x20>
8020012c: 22 65        	ld	a0, 8(sp)
8020012e: e2 70        	ld	ra, 56(sp)
80200130: 21 61        	addi	sp, sp, 64
80200132: 82 80        	ret

0000000080200134 <_ZN4core4cell13Cell$LT$T$GT$3get17ha25d11d1770cd5a4E>:
80200134: 01 11        	addi	sp, sp, -32
80200136: 2a e4        	sd	a0, 8(sp)
80200138: 2a e8        	sd	a0, 16(sp)
8020013a: 2a ec        	sd	a0, 24(sp)
8020013c: 09 a0        	j	0x8020013e <_ZN4core4cell13Cell$LT$T$GT$3get17ha25d11d1770cd5a4E+0xa>
8020013e: 22 65        	ld	a0, 8(sp)
80200140: 08 61        	ld	a0, 0(a0)
80200142: 05 61        	addi	sp, sp, 32
80200144: 82 80        	ret

0000000080200146 <_ZN4core4cell16RefCell$LT$T$GT$3new17h4231cc17242942a5E>:
80200146: 13 01 01 a1  	addi	sp, sp, -1520
8020014a: 23 34 11 5e  	sd	ra, 1512(sp)
8020014e: 2a e8        	sd	a0, 16(sp)
80200150: 28 0c        	addi	a0, sp, 536
80200152: 2a ec        	sd	a0, 24(sp)
80200154: 13 06 80 1e  	addi	a2, zero, 488
80200158: 32 f4        	sd	a2, 40(sp)
8020015a: 97 70 00 00  	auipc	ra, 7
8020015e: e7 80 00 95  	jalr	-1712(ra)
80200162: e2 65        	ld	a1, 24(sp)
80200164: 22 76        	ld	a2, 40(sp)
80200166: 13 05 01 40  	addi	a0, sp, 1024
8020016a: 2a f0        	sd	a0, 32(sp)
8020016c: 97 70 00 00  	auipc	ra, 7
80200170: e7 80 e0 93  	jalr	-1730(ra)
80200174: 82 75        	ld	a1, 32(sp)
80200176: 22 76        	ld	a2, 40(sp)
80200178: 08 18        	addi	a0, sp, 48
8020017a: 97 70 00 00  	auipc	ra, 7
8020017e: e7 80 00 93  	jalr	-1744(ra)
80200182: 09 a0        	j	0x80200184 <_ZN4core4cell16RefCell$LT$T$GT$3new17h4231cc17242942a5E+0x3e>
80200184: 01 45        	mv	a0, zero
80200186: 97 00 00 00  	auipc	ra, 0
8020018a: e7 80 80 f4  	jalr	-184(ra)
8020018e: 2a e4        	sd	a0, 8(sp)
80200190: 09 a0        	j	0x80200192 <_ZN4core4cell16RefCell$LT$T$GT$3new17h4231cc17242942a5E+0x4c>
80200192: 42 65        	ld	a0, 16(sp)
80200194: a2 65        	ld	a1, 8(sp)
80200196: 0c e1        	sd	a1, 0(a0)
80200198: 21 05        	addi	a0, a0, 8
8020019a: 0c 18        	addi	a1, sp, 48
8020019c: 13 06 80 1e  	addi	a2, zero, 488
802001a0: 97 70 00 00  	auipc	ra, 7
802001a4: e7 80 a0 90  	jalr	-1782(ra)
802001a8: 83 30 81 5e  	ld	ra, 1512(sp)
802001ac: 13 01 01 5f  	addi	sp, sp, 1520
802001b0: 82 80        	ret

00000000802001b2 <_ZN4core4cell16RefCell$LT$T$GT$10borrow_mut17h29d99aa21314fa4fE>:
802001b2: 39 71        	addi	sp, sp, -64
802001b4: 06 fc        	sd	ra, 56(sp)
802001b6: 2e ec        	sd	a1, 24(sp)
802001b8: 2a f8        	sd	a0, 48(sp)
802001ba: 97 00 00 00  	auipc	ra, 0
802001be: e7 80 60 03  	jalr	54(ra)
802001c2: 2a f0        	sd	a0, 32(sp)
802001c4: 2e f4        	sd	a1, 40(sp)
802001c6: 09 a0        	j	0x802001c8 <_ZN4core4cell16RefCell$LT$T$GT$10borrow_mut17h29d99aa21314fa4fE+0x16>
802001c8: 62 67        	ld	a4, 24(sp)
802001ca: a2 75        	ld	a1, 40(sp)
802001cc: 02 75        	ld	a0, 32(sp)

00000000802001ce <.LBB5_3>:
802001ce: 17 76 00 00  	auipc	a2, 7
802001d2: 13 06 a6 f0  	addi	a2, a2, -246
802001d6: c1 46        	addi	a3, zero, 16
802001d8: 97 10 00 00  	auipc	ra, 1
802001dc: e7 80 60 59  	jalr	1430(ra)
802001e0: 2a e4        	sd	a0, 8(sp)
802001e2: 2e e8        	sd	a1, 16(sp)
802001e4: 09 a0        	j	0x802001e6 <.LBB5_3+0x18>
802001e6: c2 65        	ld	a1, 16(sp)
802001e8: 22 65        	ld	a0, 8(sp)
802001ea: e2 70        	ld	ra, 56(sp)
802001ec: 21 61        	addi	sp, sp, 64
802001ee: 82 80        	ret

00000000802001f0 <_ZN4core4cell16RefCell$LT$T$GT$14try_borrow_mut17hf1fa6be23fdf422eE>:
802001f0: 1d 71        	addi	sp, sp, -96
802001f2: 86 ec        	sd	ra, 88(sp)
802001f4: 2a e8        	sd	a0, 16(sp)
802001f6: aa e0        	sd	a0, 64(sp)
802001f8: 97 00 00 00  	auipc	ra, 0
802001fc: e7 80 e0 0d  	jalr	222(ra)
80200200: 2a f4        	sd	a0, 40(sp)
80200202: 09 a0        	j	0x80200204 <_ZN4core4cell16RefCell$LT$T$GT$14try_borrow_mut17hf1fa6be23fdf422eE+0x14>
80200204: 22 75        	ld	a0, 40(sp)
80200206: b3 35 a0 00  	snez	a1, a0
8020020a: 81 45        	mv	a1, zero
8020020c: 63 05 b5 00  	beq	a0, a1, 0x80200216 <_ZN4core4cell16RefCell$LT$T$GT$14try_borrow_mut17hf1fa6be23fdf422eE+0x26>
80200210: 09 a0        	j	0x80200212 <_ZN4core4cell16RefCell$LT$T$GT$14try_borrow_mut17hf1fa6be23fdf422eE+0x22>
80200212: 29 a0        	j	0x8020021c <_ZN4core4cell16RefCell$LT$T$GT$14try_borrow_mut17hf1fa6be23fdf422eE+0x2c>
80200214: 00 00        	unimp	
80200216: 01 45        	mv	a0, zero
80200218: 2a ec        	sd	a0, 24(sp)
8020021a: 05 a0        	j	0x8020023a <_ZN4core4cell16RefCell$LT$T$GT$14try_borrow_mut17hf1fa6be23fdf422eE+0x4a>
8020021c: 42 65        	ld	a0, 16(sp)
8020021e: a2 75        	ld	a1, 40(sp)
80200220: 2e e0        	sd	a1, 0(sp)
80200222: ae e4        	sd	a1, 72(sp)
80200224: 21 05        	addi	a0, a0, 8
80200226: 2a e4        	sd	a0, 8(sp)
80200228: aa e8        	sd	a0, 80(sp)
8020022a: 09 a0        	j	0x8020022c <_ZN4core4cell16RefCell$LT$T$GT$14try_borrow_mut17hf1fa6be23fdf422eE+0x3c>
8020022c: 02 65        	ld	a0, 0(sp)
8020022e: a2 65        	ld	a1, 8(sp)
80200230: 2e f8        	sd	a1, 48(sp)
80200232: 2a fc        	sd	a0, 56(sp)
80200234: 2e ec        	sd	a1, 24(sp)
80200236: 2a f0        	sd	a0, 32(sp)
80200238: 09 a0        	j	0x8020023a <_ZN4core4cell16RefCell$LT$T$GT$14try_borrow_mut17hf1fa6be23fdf422eE+0x4a>
8020023a: 62 65        	ld	a0, 24(sp)
8020023c: 82 75        	ld	a1, 32(sp)
8020023e: e6 60        	ld	ra, 88(sp)
80200240: 25 61        	addi	sp, sp, 96
80200242: 82 80        	ret

0000000080200244 <_ZN71_$LT$core..cell..RefMut$LT$T$GT$$u20$as$u20$core..ops..deref..Deref$GT$5deref17hcef6530b007c50d8E>:
80200244: 41 11        	addi	sp, sp, -16
80200246: 2a e4        	sd	a0, 8(sp)
80200248: 08 61        	ld	a0, 0(a0)
8020024a: 41 01        	addi	sp, sp, 16
8020024c: 82 80        	ret

000000008020024e <_ZN74_$LT$core..cell..RefMut$LT$T$GT$$u20$as$u20$core..ops..deref..DerefMut$GT$9deref_mut17h0dc8b46515e14135E>:
8020024e: 41 11        	addi	sp, sp, -16
80200250: 2a e4        	sd	a0, 8(sp)
80200252: 08 61        	ld	a0, 0(a0)
80200254: 41 01        	addi	sp, sp, 16
80200256: 82 80        	ret

0000000080200258 <_ZN5riscv8register4sepc4read17h9535691e7d3bb573E>:
80200258: 41 11        	addi	sp, sp, -16
8020025a: 06 e4        	sd	ra, 8(sp)
8020025c: 97 00 00 00  	auipc	ra, 0
80200260: e7 80 40 01  	jalr	20(ra)
80200264: 2a e0        	sd	a0, 0(sp)
80200266: 09 a0        	j	0x80200268 <_ZN5riscv8register4sepc4read17h9535691e7d3bb573E+0x10>
80200268: 02 65        	ld	a0, 0(sp)
8020026a: a2 60        	ld	ra, 8(sp)
8020026c: 41 01        	addi	sp, sp, 16
8020026e: 82 80        	ret

0000000080200270 <_ZN5riscv8register4sepc5_read17h350cffd348628bafE>:
80200270: 41 11        	addi	sp, sp, -16
80200272: 73 25 10 14  	csrr	a0, sepc
80200276: 2a e4        	sd	a0, 8(sp)
80200278: 09 a0        	j	0x8020027a <_ZN5riscv8register4sepc5_read17h350cffd348628bafE+0xa>
8020027a: 22 65        	ld	a0, 8(sp)
8020027c: 41 01        	addi	sp, sp, 16
8020027e: 82 80        	ret

0000000080200280 <_ZN81_$LT$core..str..iter..Chars$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4next17hba953f1b5d4ce7cbE>:
80200280: 79 71        	addi	sp, sp, -48
80200282: 06 f4        	sd	ra, 40(sp)
80200284: 2a f0        	sd	a0, 32(sp)
80200286: 97 10 00 00  	auipc	ra, 1
8020028a: e7 80 60 5b  	jalr	1462(ra)
8020028e: 2a e8        	sd	a0, 16(sp)
80200290: 2e ec        	sd	a1, 24(sp)
80200292: 09 a0        	j	0x80200294 <_ZN81_$LT$core..str..iter..Chars$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4next17hba953f1b5d4ce7cbE+0x14>
80200294: e2 65        	ld	a1, 24(sp)
80200296: 42 65        	ld	a0, 16(sp)
80200298: 97 30 00 00  	auipc	ra, 3
8020029c: e7 80 00 a4  	jalr	-1472(ra)
802002a0: 02 15        	slli	a0, a0, 32
802002a2: 01 91        	srli	a0, a0, 32
802002a4: 2a e4        	sd	a0, 8(sp)
802002a6: 09 a0        	j	0x802002a8 <_ZN81_$LT$core..str..iter..Chars$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4next17hba953f1b5d4ce7cbE+0x28>
802002a8: 22 65        	ld	a0, 8(sp)
802002aa: a2 70        	ld	ra, 40(sp)
802002ac: 45 61        	addi	sp, sp, 48
802002ae: 82 80        	ret

00000000802002b0 <_ZN2os6loader9load_apps28_$u7b$$u7b$closure$u7d$$u7d$17h2285ccdc817b09cbE>:
802002b0: 79 71        	addi	sp, sp, -48
802002b2: 06 f4        	sd	ra, 40(sp)
802002b4: 2e e0        	sd	a1, 0(sp)
802002b6: aa 85        	mv	a1, a0
802002b8: 02 65        	ld	a0, 0(sp)
802002ba: 2e e4        	sd	a1, 8(sp)
802002bc: 2a e8        	sd	a0, 16(sp)
802002be: 2a ec        	sd	a0, 24(sp)
802002c0: 81 45        	mv	a1, zero
802002c2: a3 03 b1 02  	sb	a1, 39(sp)
802002c6: 97 30 00 00  	auipc	ra, 3
802002ca: e7 80 00 2d  	jalr	720(ra)
802002ce: 09 a0        	j	0x802002d0 <_ZN2os6loader9load_apps28_$u7b$$u7b$closure$u7d$$u7d$17h2285ccdc817b09cbE+0x20>
802002d0: a2 70        	ld	ra, 40(sp)
802002d2: 45 61        	addi	sp, sp, 48
802002d4: 82 80        	ret

00000000802002d6 <_ZN4core4cell12BorrowRefMut3new17had31ce8d9c8fc057E>:
802002d6: 79 71        	addi	sp, sp, -48
802002d8: 06 f4        	sd	ra, 40(sp)
802002da: 2a e0        	sd	a0, 0(sp)
802002dc: 2a f0        	sd	a0, 32(sp)
802002de: 97 00 00 00  	auipc	ra, 0
802002e2: e7 80 60 e5  	jalr	-426(ra)
802002e6: 2a e4        	sd	a0, 8(sp)
802002e8: 09 a0        	j	0x802002ea <_ZN4core4cell12BorrowRefMut3new17had31ce8d9c8fc057E+0x14>
802002ea: 22 65        	ld	a0, 8(sp)
802002ec: 81 45        	mv	a1, zero
802002ee: 63 1a b5 00  	bne	a0, a1, 0x80200302 <_ZN4core4cell12BorrowRefMut3new17had31ce8d9c8fc057E+0x2c>
802002f2: 09 a0        	j	0x802002f4 <_ZN4core4cell12BorrowRefMut3new17had31ce8d9c8fc057E+0x1e>
802002f4: 02 65        	ld	a0, 0(sp)
802002f6: fd 55        	addi	a1, zero, -1
802002f8: 97 00 00 00  	auipc	ra, 0
802002fc: e7 80 a0 de  	jalr	-534(ra)
80200300: 01 a8        	j	0x80200310 <_ZN4core4cell12BorrowRefMut3new17had31ce8d9c8fc057E+0x3a>
80200302: 01 45        	mv	a0, zero
80200304: 2a e8        	sd	a0, 16(sp)
80200306: 09 a0        	j	0x80200308 <_ZN4core4cell12BorrowRefMut3new17had31ce8d9c8fc057E+0x32>
80200308: 42 65        	ld	a0, 16(sp)
8020030a: a2 70        	ld	ra, 40(sp)
8020030c: 45 61        	addi	sp, sp, 48
8020030e: 82 80        	ret
80200310: 02 65        	ld	a0, 0(sp)
80200312: 2a ec        	sd	a0, 24(sp)
80200314: 2a e8        	sd	a0, 16(sp)
80200316: cd bf        	j	0x80200308 <_ZN4core4cell12BorrowRefMut3new17had31ce8d9c8fc057E+0x32>

0000000080200318 <_ZN2os7syscall7process8sys_exit17hf92397d8489ff051E>:
80200318: 75 71        	addi	sp, sp, -144
8020031a: 06 e5        	sd	ra, 136(sp)
8020031c: 2a ca        	sw	a0, 20(sp)

000000008020031e <.LBB0_6>:
8020031e: 97 65 00 00  	auipc	a1, 6
80200322: 93 85 a5 45  	addi	a1, a1, 1114
80200326: 48 08        	addi	a0, sp, 20
80200328: 97 10 00 00  	auipc	ra, 1
8020032c: e7 80 40 ce  	jalr	-796(ra)
80200330: 2a e0        	sd	a0, 0(sp)
80200332: 2e e4        	sd	a1, 8(sp)
80200334: 09 a0        	j	0x80200336 <.LBB0_6+0x18>
80200336: 22 65        	ld	a0, 8(sp)
80200338: 82 65        	ld	a1, 0(sp)
8020033a: ae e4        	sd	a1, 72(sp)
8020033c: aa e8        	sd	a0, 80(sp)

000000008020033e <.LBB0_7>:
8020033e: 97 75 00 00  	auipc	a1, 7
80200342: 93 85 25 df  	addi	a1, a1, -526
80200346: 28 08        	addi	a0, sp, 24
80200348: 09 46        	addi	a2, zero, 2
8020034a: b4 00        	addi	a3, sp, 72
8020034c: 05 47        	addi	a4, zero, 1
8020034e: 97 20 00 00  	auipc	ra, 2
80200352: e7 80 a0 0d  	jalr	218(ra)
80200356: 09 a0        	j	0x80200358 <.LBB0_7+0x1a>
80200358: 28 08        	addi	a0, sp, 24
8020035a: 97 10 00 00  	auipc	ra, 1
8020035e: e7 80 a0 76  	jalr	1898(ra)
80200362: 09 a0        	j	0x80200364 <.LBB0_7+0x26>
80200364: 97 10 00 00  	auipc	ra, 1
80200368: e7 80 20 c2  	jalr	-990(ra)
8020036c: 09 a0        	j	0x8020036e <.LBB0_8>

000000008020036e <.LBB0_8>:
8020036e: 97 75 00 00  	auipc	a1, 7
80200372: 93 85 a5 df  	addi	a1, a1, -518

0000000080200376 <.LBB0_9>:
80200376: 97 76 00 00  	auipc	a3, 7
8020037a: 93 86 26 e0  	addi	a3, a3, -510
8020037e: a8 08        	addi	a0, sp, 88
80200380: 05 46        	addi	a2, zero, 1
80200382: 01 47        	mv	a4, zero
80200384: 97 20 00 00  	auipc	ra, 2
80200388: e7 80 40 0a  	jalr	164(ra)
8020038c: 09 a0        	j	0x8020038e <.LBB0_10>

000000008020038e <.LBB0_10>:
8020038e: 97 75 00 00  	auipc	a1, 7
80200392: 93 85 25 e0  	addi	a1, a1, -510
80200396: a8 08        	addi	a0, sp, 88
80200398: 97 50 00 00  	auipc	ra, 5
8020039c: e7 80 00 88  	jalr	-1920(ra)
802003a0: 00 00        	unimp	

00000000802003a2 <_ZN2os7syscall7process9sys_yield17h4696c43b2dfddeb1E>:
802003a2: 41 11        	addi	sp, sp, -16
802003a4: 06 e4        	sd	ra, 8(sp)
802003a6: 97 10 00 00  	auipc	ra, 1
802003aa: e7 80 20 bc  	jalr	-1086(ra)
802003ae: 09 a0        	j	0x802003b0 <_ZN2os7syscall7process9sys_yield17h4696c43b2dfddeb1E+0xe>
802003b0: 01 45        	mv	a0, zero
802003b2: a2 60        	ld	ra, 8(sp)
802003b4: 41 01        	addi	sp, sp, 16
802003b6: 82 80        	ret

00000000802003b8 <_ZN2os7syscall7process12sys_get_time17h1eb25a3e42f2a3cbE>:
802003b8: 41 11        	addi	sp, sp, -16
802003ba: 06 e4        	sd	ra, 8(sp)
802003bc: 97 40 00 00  	auipc	ra, 4
802003c0: e7 80 60 88  	jalr	-1914(ra)
802003c4: 2a e0        	sd	a0, 0(sp)
802003c6: 09 a0        	j	0x802003c8 <_ZN2os7syscall7process12sys_get_time17h1eb25a3e42f2a3cbE+0x10>
802003c8: 02 65        	ld	a0, 0(sp)
802003ca: a2 60        	ld	ra, 8(sp)
802003cc: 41 01        	addi	sp, sp, 16
802003ce: 82 80        	ret

00000000802003d0 <_ZN4core9core_arch12riscv_shared5pause17h87f9566817141f9dE>:
802003d0: 0f 00 00 01  	fence	w, unknown
802003d4: 09 a0        	j	0x802003d6 <_ZN4core9core_arch12riscv_shared5pause17h87f9566817141f9dE+0x6>
802003d6: 82 80        	ret

00000000802003d8 <_ZN4core4char7convert18from_u32_unchecked17h2189fa58e6323ae8E>:
802003d8: 41 11        	addi	sp, sp, -16
802003da: 2a c4        	sw	a0, 8(sp)
802003dc: 2a c6        	sw	a0, 12(sp)
802003de: 02 15        	slli	a0, a0, 32
802003e0: 01 91        	srli	a0, a0, 32
802003e2: 2a e0        	sd	a0, 0(sp)
802003e4: 09 a0        	j	0x802003e6 <_ZN4core4char7convert18from_u32_unchecked17h2189fa58e6323ae8E+0xe>
802003e6: 02 65        	ld	a0, 0(sp)
802003e8: 41 01        	addi	sp, sp, 16
802003ea: 82 80        	ret

00000000802003ec <_ZN4core10intrinsics19copy_nonoverlapping17h415934424caf68c6E>:
802003ec: 79 71        	addi	sp, sp, -48
802003ee: 06 f4        	sd	ra, 40(sp)
802003f0: 2e e4        	sd	a1, 8(sp)
802003f2: aa 85        	mv	a1, a0
802003f4: 22 65        	ld	a0, 8(sp)
802003f6: 2e e8        	sd	a1, 16(sp)
802003f8: 2a ec        	sd	a0, 24(sp)
802003fa: 32 f0        	sd	a2, 32(sp)
802003fc: 97 60 00 00  	auipc	ra, 6
80200400: e7 80 e0 6a  	jalr	1710(ra)
80200404: a2 70        	ld	ra, 40(sp)
80200406: 45 61        	addi	sp, sp, 48
80200408: 82 80        	ret

000000008020040a <_ZN5riscv8register7sstatus7Sstatus7set_spp17hbb2d5ee612731392E>:
8020040a: 79 71        	addi	sp, sp, -48
8020040c: 06 f4        	sd	ra, 40(sp)
8020040e: 2a e4        	sd	a0, 8(sp)
80200410: a3 0f b1 00  	sb	a1, 31(sp)
80200414: 2a f0        	sd	a0, 32(sp)

0000000080200416 <.LBB0_3>:
80200416: 97 75 00 00  	auipc	a1, 7
8020041a: 93 85 25 d9  	addi	a1, a1, -622
8020041e: 13 05 f1 01  	addi	a0, sp, 31
80200422: 97 00 00 00  	auipc	ra, 0
80200426: e7 80 20 02  	jalr	34(ra)
8020042a: 2a e8        	sd	a0, 16(sp)
8020042c: 09 a0        	j	0x8020042e <.LBB0_3+0x18>
8020042e: 42 66        	ld	a2, 16(sp)
80200430: 22 65        	ld	a0, 8(sp)
80200432: a1 45        	addi	a1, zero, 8
80200434: 97 30 00 00  	auipc	ra, 3
80200438: e7 80 60 9e  	jalr	-1562(ra)
8020043c: 09 a0        	j	0x8020043e <.LBB0_3+0x28>
8020043e: a2 70        	ld	ra, 40(sp)
80200440: 45 61        	addi	sp, sp, 48
80200442: 82 80        	ret

0000000080200444 <_ZN70_$LT$riscv..register..sstatus..SPP$u20$as$u20$core..cmp..PartialEq$GT$2eq17h6fcb88faa1ae36c6E>:
80200444: 79 71        	addi	sp, sp, -48
80200446: 2a e8        	sd	a0, 16(sp)
80200448: 2e ec        	sd	a1, 24(sp)
8020044a: 03 45 05 00  	lbu	a0, 0(a0)
8020044e: 2a f0        	sd	a0, 32(sp)
80200450: 83 c5 05 00  	lbu	a1, 0(a1)
80200454: 2e f4        	sd	a1, 40(sp)
80200456: 63 07 b5 00  	beq	a0, a1, 0x80200464 <_ZN70_$LT$riscv..register..sstatus..SPP$u20$as$u20$core..cmp..PartialEq$GT$2eq17h6fcb88faa1ae36c6E+0x20>
8020045a: 09 a0        	j	0x8020045c <_ZN70_$LT$riscv..register..sstatus..SPP$u20$as$u20$core..cmp..PartialEq$GT$2eq17h6fcb88faa1ae36c6E+0x18>
8020045c: 01 45        	mv	a0, zero
8020045e: a3 07 a1 00  	sb	a0, 15(sp)
80200462: 29 a0        	j	0x8020046c <_ZN70_$LT$riscv..register..sstatus..SPP$u20$as$u20$core..cmp..PartialEq$GT$2eq17h6fcb88faa1ae36c6E+0x28>
80200464: 05 45        	addi	a0, zero, 1
80200466: a3 07 a1 00  	sb	a0, 15(sp)
8020046a: 09 a0        	j	0x8020046c <_ZN70_$LT$riscv..register..sstatus..SPP$u20$as$u20$core..cmp..PartialEq$GT$2eq17h6fcb88faa1ae36c6E+0x28>
8020046c: 03 45 f1 00  	lbu	a0, 15(sp)
80200470: 45 61        	addi	sp, sp, 48
80200472: 82 80        	ret

0000000080200474 <_ZN5riscv8register7sstatus4read17h2e4da2a818200420E>:
80200474: 01 11        	addi	sp, sp, -32
80200476: 06 ec        	sd	ra, 24(sp)
80200478: 97 00 00 00  	auipc	ra, 0
8020047c: e7 80 60 01  	jalr	22(ra)
80200480: 2a e4        	sd	a0, 8(sp)
80200482: 09 a0        	j	0x80200484 <_ZN5riscv8register7sstatus4read17h2e4da2a818200420E+0x10>
80200484: 22 65        	ld	a0, 8(sp)
80200486: 2a e8        	sd	a0, 16(sp)
80200488: e2 60        	ld	ra, 24(sp)
8020048a: 05 61        	addi	sp, sp, 32
8020048c: 82 80        	ret

000000008020048e <_ZN5riscv8register7sstatus5_read17h1c863958dfbc4a5dE>:
8020048e: 41 11        	addi	sp, sp, -16
80200490: 73 25 00 10  	csrr	a0, sstatus
80200494: 2a e4        	sd	a0, 8(sp)
80200496: 09 a0        	j	0x80200498 <_ZN5riscv8register7sstatus5_read17h1c863958dfbc4a5dE+0xa>
80200498: 22 65        	ld	a0, 8(sp)
8020049a: 41 01        	addi	sp, sp, 16
8020049c: 82 80        	ret

000000008020049e <_ZN2os9clear_bss17h908e360a314be55eE>:
8020049e: 01 11        	addi	sp, sp, -32
802004a0: 06 ec        	sd	ra, 24(sp)

00000000802004a2 <.LBB0_5>:
802004a2: 97 05 03 00  	auipc	a1, 48
802004a6: 93 85 e5 b5  	addi	a1, a1, -1186

00000000802004aa <.LBB0_6>:
802004aa: 17 15 03 00  	auipc	a0, 49
802004ae: 13 05 65 b5  	addi	a0, a0, -1194
802004b2: b3 05 b5 40  	sub	a1, a0, a1
802004b6: 2e e8        	sd	a1, 16(sp)
802004b8: 63 6f b5 00  	bltu	a0, a1, 0x802004d6 <.LBB0_8>
802004bc: 09 a0        	j	0x802004be <.LBB0_6+0x14>
802004be: c2 65        	ld	a1, 16(sp)

00000000802004c0 <.LBB0_7>:
802004c0: 17 05 03 00  	auipc	a0, 48
802004c4: 13 05 05 b4  	addi	a0, a0, -1216
802004c8: 97 20 00 00  	auipc	ra, 2
802004cc: e7 80 60 b3  	jalr	-1226(ra)
802004d0: 2a e0        	sd	a0, 0(sp)
802004d2: 2e e4        	sd	a1, 8(sp)
802004d4: 05 a0        	j	0x802004f4 <.LBB0_9+0x16>

00000000802004d6 <.LBB0_8>:
802004d6: 17 75 00 00  	auipc	a0, 7
802004da: 13 05 a5 cf  	addi	a0, a0, -774

00000000802004de <.LBB0_9>:
802004de: 17 76 00 00  	auipc	a2, 7
802004e2: 13 06 a6 cd  	addi	a2, a2, -806
802004e6: 93 05 10 02  	addi	a1, zero, 33
802004ea: 97 40 00 00  	auipc	ra, 4
802004ee: e7 80 20 6c  	jalr	1730(ra)
802004f2: 00 00        	unimp	
802004f4: a2 65        	ld	a1, 8(sp)
802004f6: 02 65        	ld	a0, 0(sp)
802004f8: 01 46        	mv	a2, zero
802004fa: 97 20 00 00  	auipc	ra, 2
802004fe: e7 80 80 6c  	jalr	1736(ra)
80200502: 09 a0        	j	0x80200504 <.LBB0_9+0x26>
80200504: e2 60        	ld	ra, 24(sp)
80200506: 05 61        	addi	sp, sp, 32
80200508: 82 80        	ret

000000008020050a <rust_main>:
8020050a: 0d 71        	addi	sp, sp, -352
8020050c: 86 ee        	sd	ra, 344(sp)
8020050e: 97 00 00 00  	auipc	ra, 0
80200512: e7 80 00 f9  	jalr	-112(ra)
80200516: 09 a0        	j	0x80200518 <.LBB1_23>

0000000080200518 <.LBB1_23>:
80200518: 97 75 00 00  	auipc	a1, 7
8020051c: 93 85 05 cf  	addi	a1, a1, -784

0000000080200520 <.LBB1_24>:
80200520: 97 76 00 00  	auipc	a3, 7
80200524: 93 86 86 cf  	addi	a3, a3, -776
80200528: 28 00        	addi	a0, sp, 8
8020052a: 05 46        	addi	a2, zero, 1
8020052c: 01 47        	mv	a4, zero
8020052e: 97 20 00 00  	auipc	ra, 2
80200532: e7 80 a0 ef  	jalr	-262(ra)
80200536: 09 a0        	j	0x80200538 <.LBB1_24+0x18>
80200538: 28 00        	addi	a0, sp, 8
8020053a: 97 10 00 00  	auipc	ra, 1
8020053e: e7 80 a0 58  	jalr	1418(ra)
80200542: 09 a0        	j	0x80200544 <.LBB1_24+0x24>
80200544: 97 00 00 00  	auipc	ra, 0
80200548: e7 80 a0 f5  	jalr	-166(ra)
8020054c: 09 a0        	j	0x8020054e <.LBB1_25>

000000008020054e <.LBB1_25>:
8020054e: 97 75 00 00  	auipc	a1, 7
80200552: 93 85 25 ce  	addi	a1, a1, -798

0000000080200556 <.LBB1_26>:
80200556: 97 76 00 00  	auipc	a3, 7
8020055a: 93 86 26 cc  	addi	a3, a3, -830
8020055e: 28 18        	addi	a0, sp, 56
80200560: 05 46        	addi	a2, zero, 1
80200562: 01 47        	mv	a4, zero
80200564: 97 20 00 00  	auipc	ra, 2
80200568: e7 80 40 ec  	jalr	-316(ra)
8020056c: 09 a0        	j	0x8020056e <.LBB1_26+0x18>
8020056e: 28 18        	addi	a0, sp, 56
80200570: 97 10 00 00  	auipc	ra, 1
80200574: e7 80 40 55  	jalr	1364(ra)
80200578: 09 a0        	j	0x8020057a <.LBB1_26+0x24>
8020057a: 97 30 00 00  	auipc	ra, 3
8020057e: e7 80 00 26  	jalr	608(ra)
80200582: 09 a0        	j	0x80200584 <.LBB1_27>

0000000080200584 <.LBB1_27>:
80200584: 97 75 00 00  	auipc	a1, 7
80200588: 93 85 45 ce  	addi	a1, a1, -796

000000008020058c <.LBB1_28>:
8020058c: 97 76 00 00  	auipc	a3, 7
80200590: 93 86 c6 c8  	addi	a3, a3, -884
80200594: a8 10        	addi	a0, sp, 104
80200596: 05 46        	addi	a2, zero, 1
80200598: 01 47        	mv	a4, zero
8020059a: 97 20 00 00  	auipc	ra, 2
8020059e: e7 80 e0 e8  	jalr	-370(ra)
802005a2: 09 a0        	j	0x802005a4 <.LBB1_28+0x18>
802005a4: a8 10        	addi	a0, sp, 104
802005a6: 97 10 00 00  	auipc	ra, 1
802005aa: e7 80 e0 51  	jalr	1310(ra)
802005ae: 09 a0        	j	0x802005b0 <.LBB1_28+0x24>
802005b0: 97 20 00 00  	auipc	ra, 2
802005b4: e7 80 60 1f  	jalr	502(ra)
802005b8: 09 a0        	j	0x802005ba <.LBB1_29>

00000000802005ba <.LBB1_29>:
802005ba: 97 75 00 00  	auipc	a1, 7
802005be: 93 85 e5 cd  	addi	a1, a1, -802

00000000802005c2 <.LBB1_30>:
802005c2: 97 76 00 00  	auipc	a3, 7
802005c6: 93 86 66 c5  	addi	a3, a3, -938
802005ca: 28 09        	addi	a0, sp, 152
802005cc: 05 46        	addi	a2, zero, 1
802005ce: 01 47        	mv	a4, zero
802005d0: 97 20 00 00  	auipc	ra, 2
802005d4: e7 80 80 e5  	jalr	-424(ra)
802005d8: 09 a0        	j	0x802005da <.LBB1_30+0x18>
802005da: 28 09        	addi	a0, sp, 152
802005dc: 97 10 00 00  	auipc	ra, 1
802005e0: e7 80 80 4e  	jalr	1256(ra)
802005e4: 09 a0        	j	0x802005e6 <.LBB1_30+0x24>
802005e6: 97 30 00 00  	auipc	ra, 3
802005ea: e7 80 60 21  	jalr	534(ra)
802005ee: 09 a0        	j	0x802005f0 <.LBB1_31>

00000000802005f0 <.LBB1_31>:
802005f0: 97 75 00 00  	auipc	a1, 7
802005f4: 93 85 05 ce  	addi	a1, a1, -800

00000000802005f8 <.LBB1_32>:
802005f8: 97 76 00 00  	auipc	a3, 7
802005fc: 93 86 06 c2  	addi	a3, a3, -992
80200600: a8 01        	addi	a0, sp, 200
80200602: 05 46        	addi	a2, zero, 1
80200604: 01 47        	mv	a4, zero
80200606: 97 20 00 00  	auipc	ra, 2
8020060a: e7 80 20 e2  	jalr	-478(ra)
8020060e: 09 a0        	j	0x80200610 <.LBB1_32+0x18>
80200610: a8 01        	addi	a0, sp, 200
80200612: 97 10 00 00  	auipc	ra, 1
80200616: e7 80 20 4b  	jalr	1202(ra)
8020061a: 09 a0        	j	0x8020061c <.LBB1_32+0x24>
8020061c: 97 30 00 00  	auipc	ra, 3
80200620: e7 80 00 66  	jalr	1632(ra)
80200624: 09 a0        	j	0x80200626 <.LBB1_33>

0000000080200626 <.LBB1_33>:
80200626: 97 75 00 00  	auipc	a1, 7
8020062a: 93 85 a5 ce  	addi	a1, a1, -790

000000008020062e <.LBB1_34>:
8020062e: 97 76 00 00  	auipc	a3, 7
80200632: 93 86 a6 be  	addi	a3, a3, -1046
80200636: a8 19        	addi	a0, sp, 248
80200638: 05 46        	addi	a2, zero, 1
8020063a: 01 47        	mv	a4, zero
8020063c: 97 20 00 00  	auipc	ra, 2
80200640: e7 80 c0 de  	jalr	-532(ra)
80200644: 09 a0        	j	0x80200646 <.LBB1_34+0x18>
80200646: a8 19        	addi	a0, sp, 248
80200648: 97 10 00 00  	auipc	ra, 1
8020064c: e7 80 c0 47  	jalr	1148(ra)
80200650: 09 a0        	j	0x80200652 <.LBB1_34+0x24>
80200652: 02 90        	ebreak	
80200654: 09 a0        	j	0x80200656 <.LBB1_35>

0000000080200656 <.LBB1_35>:
80200656: 97 75 00 00  	auipc	a1, 7
8020065a: 93 85 25 cf  	addi	a1, a1, -782

000000008020065e <.LBB1_36>:
8020065e: 97 76 00 00  	auipc	a3, 7
80200662: 93 86 a6 bb  	addi	a3, a3, -1094
80200666: 28 12        	addi	a0, sp, 296
80200668: 05 46        	addi	a2, zero, 1
8020066a: 01 47        	mv	a4, zero
8020066c: 97 20 00 00  	auipc	ra, 2
80200670: e7 80 c0 db  	jalr	-580(ra)
80200674: 09 a0        	j	0x80200676 <.LBB1_36+0x18>
80200676: 28 12        	addi	a0, sp, 296
80200678: 97 10 00 00  	auipc	ra, 1
8020067c: e7 80 c0 44  	jalr	1100(ra)
80200680: 09 a0        	j	0x80200682 <.LBB1_36+0x24>
80200682: 97 10 00 00  	auipc	ra, 1
80200686: e7 80 40 84  	jalr	-1980(ra)
8020068a: 09 a0        	j	0x8020068c <.LBB1_36+0x2e>
8020068c: 01 a0        	j	0x8020068c <.LBB1_36+0x2e>

000000008020068e <rust_begin_unwind>:
8020068e: 59 71        	addi	sp, sp, -112
80200690: 86 f4        	sd	ra, 104(sp)
80200692: aa f0        	sd	a0, 96(sp)
80200694: 97 40 00 00  	auipc	ra, 4
80200698: e7 80 40 51  	jalr	1300(ra)
8020069c: 2a e8        	sd	a0, 16(sp)
8020069e: 09 a0        	j	0x802006a0 <rust_begin_unwind+0x12>
802006a0: 42 65        	ld	a0, 16(sp)

00000000802006a2 <.LBB0_6>:
802006a2: 97 75 00 00  	auipc	a1, 7
802006a6: 93 85 e5 cf  	addi	a1, a1, -770
802006aa: 97 20 00 00  	auipc	ra, 2
802006ae: e7 80 20 5d  	jalr	1490(ra)
802006b2: aa ec        	sd	a0, 88(sp)
802006b4: 09 a0        	j	0x802006b6 <.LBB0_7>

00000000802006b6 <.LBB0_7>:
802006b6: 97 15 00 00  	auipc	a1, 1
802006ba: 93 85 c5 9b  	addi	a1, a1, -1604
802006be: a8 08        	addi	a0, sp, 88
802006c0: 97 10 00 00  	auipc	ra, 1
802006c4: e7 80 a0 92  	jalr	-1750(ra)
802006c8: 2a e0        	sd	a0, 0(sp)
802006ca: 2e e4        	sd	a1, 8(sp)
802006cc: 09 a0        	j	0x802006ce <.LBB0_7+0x18>
802006ce: 22 65        	ld	a0, 8(sp)
802006d0: 82 65        	ld	a1, 0(sp)
802006d2: ae e4        	sd	a1, 72(sp)
802006d4: aa e8        	sd	a0, 80(sp)

00000000802006d6 <.LBB0_8>:
802006d6: 97 75 00 00  	auipc	a1, 7
802006da: 93 85 a5 c9  	addi	a1, a1, -870
802006de: 28 08        	addi	a0, sp, 24
802006e0: 09 46        	addi	a2, zero, 2
802006e2: b4 00        	addi	a3, sp, 72
802006e4: 05 47        	addi	a4, zero, 1
802006e6: 97 20 00 00  	auipc	ra, 2
802006ea: e7 80 20 d4  	jalr	-702(ra)
802006ee: 09 a0        	j	0x802006f0 <.LBB0_8+0x1a>
802006f0: 28 08        	addi	a0, sp, 24
802006f2: 97 10 00 00  	auipc	ra, 1
802006f6: e7 80 20 3d  	jalr	978(ra)
802006fa: 09 a0        	j	0x802006fc <.LBB0_8+0x26>
802006fc: 97 10 00 00  	auipc	ra, 1
80200700: e7 80 e0 f2  	jalr	-210(ra)
80200704: 00 00        	unimp	

0000000080200706 <_ZN2os7syscall7syscall17h620217634e38aad3E>:
80200706: 19 71        	addi	sp, sp, -128
80200708: 86 fc        	sd	ra, 120(sp)
8020070a: 2e ec        	sd	a1, 24(sp)
8020070c: 2a f4        	sd	a0, 40(sp)
8020070e: aa 85        	mv	a1, a0
80200710: 2e f0        	sd	a1, 32(sp)
80200712: 93 05 00 04  	addi	a1, zero, 64
80200716: 63 01 b5 04  	beq	a0, a1, 0x80200758 <.LBB0_12+0x18>
8020071a: 09 a0        	j	0x8020071c <_ZN2os7syscall7syscall17h620217634e38aad3E+0x16>
8020071c: 02 75        	ld	a0, 32(sp)
8020071e: 93 05 d0 05  	addi	a1, zero, 93
80200722: 63 05 b5 04  	beq	a0, a1, 0x8020076c <.LBB0_12+0x2c>
80200726: 09 a0        	j	0x80200728 <_ZN2os7syscall7syscall17h620217634e38aad3E+0x22>
80200728: 02 75        	ld	a0, 32(sp)
8020072a: 93 05 c0 07  	addi	a1, zero, 124
8020072e: 63 06 b5 04  	beq	a0, a1, 0x8020077a <.LBB0_12+0x3a>
80200732: 09 a0        	j	0x80200734 <_ZN2os7syscall7syscall17h620217634e38aad3E+0x2e>
80200734: 02 75        	ld	a0, 32(sp)
80200736: 93 05 90 0a  	addi	a1, zero, 169
8020073a: 63 06 b5 04  	beq	a0, a1, 0x80200786 <.LBB0_12+0x46>
8020073e: 09 a0        	j	0x80200740 <.LBB0_12>

0000000080200740 <.LBB0_12>:
80200740: 97 65 00 00  	auipc	a1, 6
80200744: 93 85 c5 05  	addi	a1, a1, 92
80200748: 28 10        	addi	a0, sp, 40
8020074a: 97 10 00 00  	auipc	ra, 1
8020074e: e7 80 60 90  	jalr	-1786(ra)
80200752: 2a e4        	sd	a0, 8(sp)
80200754: 2e e8        	sd	a1, 16(sp)
80200756: 35 a8        	j	0x80200792 <.LBB0_12+0x52>
80200758: 62 66        	ld	a2, 24(sp)
8020075a: 08 62        	ld	a0, 0(a2)
8020075c: 0c 66        	ld	a1, 8(a2)
8020075e: 10 6a        	ld	a2, 16(a2)
80200760: 97 20 00 00  	auipc	ra, 2
80200764: e7 80 80 78  	jalr	1928(ra)
80200768: 2a f8        	sd	a0, 48(sp)
8020076a: b9 a8        	j	0x802007c8 <.LBB0_14+0x14>
8020076c: 62 65        	ld	a0, 24(sp)
8020076e: 08 61        	ld	a0, 0(a0)
80200770: 97 00 00 00  	auipc	ra, 0
80200774: e7 80 80 ba  	jalr	-1112(ra)
80200778: 00 00        	unimp	
8020077a: 97 00 00 00  	auipc	ra, 0
8020077e: e7 80 80 c2  	jalr	-984(ra)
80200782: 2a f8        	sd	a0, 48(sp)
80200784: 91 a0        	j	0x802007c8 <.LBB0_14+0x14>
80200786: 97 00 00 00  	auipc	ra, 0
8020078a: e7 80 20 c3  	jalr	-974(ra)
8020078e: 2a f8        	sd	a0, 48(sp)
80200790: 25 a8        	j	0x802007c8 <.LBB0_14+0x14>
80200792: 42 65        	ld	a0, 16(sp)
80200794: a2 65        	ld	a1, 8(sp)
80200796: ae f4        	sd	a1, 104(sp)
80200798: aa f8        	sd	a0, 112(sp)

000000008020079a <.LBB0_13>:
8020079a: 97 75 00 00  	auipc	a1, 7
8020079e: 93 85 65 c3  	addi	a1, a1, -970
802007a2: 28 18        	addi	a0, sp, 56
802007a4: b4 10        	addi	a3, sp, 104
802007a6: 05 47        	addi	a4, zero, 1
802007a8: 3a 86        	mv	a2, a4
802007aa: 97 20 00 00  	auipc	ra, 2
802007ae: e7 80 e0 c7  	jalr	-898(ra)
802007b2: 09 a0        	j	0x802007b4 <.LBB0_14>

00000000802007b4 <.LBB0_14>:
802007b4: 97 75 00 00  	auipc	a1, 7
802007b8: 93 85 45 c4  	addi	a1, a1, -956
802007bc: 28 18        	addi	a0, sp, 56
802007be: 97 40 00 00  	auipc	ra, 4
802007c2: e7 80 a0 45  	jalr	1114(ra)
802007c6: 00 00        	unimp	
802007c8: 42 75        	ld	a0, 48(sp)
802007ca: e6 70        	ld	ra, 120(sp)
802007cc: 09 61        	addi	sp, sp, 128
802007ce: 82 80        	ret

00000000802007d0 <_ZN4core4sync6atomic23atomic_compare_exchange17h5123d9bdd9563db9E>:
802007d0: 29 71        	addi	sp, sp, -320
802007d2: 06 fe        	sd	ra, 312(sp)
802007d4: 32 f8        	sd	a2, 48(sp)
802007d6: 2e fc        	sd	a1, 56(sp)
802007d8: aa e0        	sd	a0, 64(sp)
802007da: 2a e6        	sd	a0, 264(sp)
802007dc: 2e ea        	sd	a1, 272(sp)
802007de: 32 ee        	sd	a2, 280(sp)
802007e0: 23 03 d1 12  	sb	a3, 294(sp)
802007e4: a3 03 e1 12  	sb	a4, 295(sp)
802007e8: 23 08 d1 06  	sb	a3, 112(sp)
802007ec: a3 08 e1 06  	sb	a4, 113(sp)
802007f0: 93 f5 f6 0f  	andi	a1, a3, 255
802007f4: ae e4        	sd	a1, 72(sp)
802007f6: 11 45        	addi	a0, zero, 4
802007f8: 63 6b b5 00  	bltu	a0, a1, 0x8020080e <.LBB0_41+0xe>
802007fc: 26 65        	ld	a0, 72(sp)
802007fe: 0e 05        	slli	a0, a0, 3

0000000080200800 <.LBB0_41>:
80200800: 97 75 00 00  	auipc	a1, 7
80200804: 93 85 05 c1  	addi	a1, a1, -1008
80200808: 2e 95        	add	a0, a0, a1
8020080a: 08 61        	ld	a0, 0(a0)
8020080c: 02 85        	jr	a0
8020080e: 03 45 11 07  	lbu	a0, 113(sp)
80200812: 2a f4        	sd	a0, 40(sp)
80200814: 85 45        	addi	a1, zero, 1
80200816: 63 0b b5 1e  	beq	a0, a1, 0x80200a0c <.LBB0_44>
8020081a: 09 a0        	j	0x8020081c <.LBB0_41+0x1c>
8020081c: 22 75        	ld	a0, 40(sp)
8020081e: 8d 45        	addi	a1, zero, 3
80200820: 63 06 b5 20  	beq	a0, a1, 0x80200a2c <.LBB0_46>
80200824: e1 a2        	j	0x802009ec <.LBB0_42>

0000000080200826 <.LBB0_4>:
80200826: 03 45 11 07  	lbu	a0, 113(sp)
8020082a: 81 45        	mv	a1, zero
8020082c: 63 0f b5 18  	beq	a0, a1, 0x802009ca <.LBB0_10+0x15c>
80200830: f9 bf        	j	0x8020080e <.LBB0_41+0xe>

0000000080200832 <.LBB0_5>:
80200832: 03 45 11 07  	lbu	a0, 113(sp)
80200836: 81 45        	mv	a1, zero
80200838: 63 07 b5 16  	beq	a0, a1, 0x802009a6 <.LBB0_10+0x138>
8020083c: c9 bf        	j	0x8020080e <.LBB0_41+0xe>

000000008020083e <.LBB0_6>:
8020083e: 03 45 11 07  	lbu	a0, 113(sp)
80200842: 2a f0        	sd	a0, 32(sp)
80200844: 81 45        	mv	a1, zero
80200846: 63 0c b5 10  	beq	a0, a1, 0x8020095e <.LBB0_10+0xf0>
8020084a: 09 a0        	j	0x8020084c <.LBB0_6+0xe>
8020084c: 02 75        	ld	a0, 32(sp)
8020084e: 89 45        	addi	a1, zero, 2
80200850: 63 08 b5 12  	beq	a0, a1, 0x80200980 <.LBB0_10+0x112>
80200854: 6d bf        	j	0x8020080e <.LBB0_41+0xe>

0000000080200856 <.LBB0_8>:
80200856: 03 45 11 07  	lbu	a0, 113(sp)
8020085a: 2a ec        	sd	a0, 24(sp)
8020085c: 81 45        	mv	a1, zero
8020085e: 63 0c b5 0a  	beq	a0, a1, 0x80200916 <.LBB0_10+0xa8>
80200862: 09 a0        	j	0x80200864 <.LBB0_8+0xe>
80200864: 62 65        	ld	a0, 24(sp)
80200866: 89 45        	addi	a1, zero, 2
80200868: 63 08 b5 0c  	beq	a0, a1, 0x80200938 <.LBB0_10+0xca>
8020086c: 4d b7        	j	0x8020080e <.LBB0_41+0xe>

000000008020086e <.LBB0_10>:
8020086e: 03 45 11 07  	lbu	a0, 113(sp)
80200872: 2a e8        	sd	a0, 16(sp)
80200874: 81 45        	mv	a1, zero
80200876: 63 0d b5 00  	beq	a0, a1, 0x80200890 <.LBB0_10+0x22>
8020087a: 09 a0        	j	0x8020087c <.LBB0_10+0xe>
8020087c: 42 65        	ld	a0, 16(sp)
8020087e: 89 45        	addi	a1, zero, 2
80200880: 63 09 b5 02  	beq	a0, a1, 0x802008b2 <.LBB0_10+0x44>
80200884: 09 a0        	j	0x80200886 <.LBB0_10+0x18>
80200886: 42 65        	ld	a0, 16(sp)
80200888: 91 45        	addi	a1, zero, 4
8020088a: 63 05 b5 04  	beq	a0, a1, 0x802008d4 <.LBB0_10+0x66>
8020088e: 41 b7        	j	0x8020080e <.LBB0_41+0xe>
80200890: 62 75        	ld	a0, 56(sp)
80200892: 86 66        	ld	a3, 64(sp)
80200894: 42 77        	ld	a4, 48(sp)
80200896: af b5 06 16  	lr.d.aqrl	a1, (a3)
8020089a: 63 95 a5 00  	bne	a1, a0, 0x802008a4 <.LBB0_10+0x36>
8020089e: 2f b6 e6 1e  	sc.d.aqrl	a2, a4, (a3)
802008a2: 75 fa        	bnez	a2, 0x80200896 <.LBB0_10+0x28>
802008a4: 2d 8d        	xor	a0, a0, a1
802008a6: 13 35 15 00  	seqz	a0, a0
802008aa: ae f0        	sd	a1, 96(sp)
802008ac: 23 04 a1 06  	sb	a0, 104(sp)
802008b0: 95 a0        	j	0x80200914 <.LBB0_10+0xa6>
802008b2: 62 75        	ld	a0, 56(sp)
802008b4: 86 66        	ld	a3, 64(sp)
802008b6: 42 77        	ld	a4, 48(sp)
802008b8: af b5 06 16  	lr.d.aqrl	a1, (a3)
802008bc: 63 95 a5 00  	bne	a1, a0, 0x802008c6 <.LBB0_10+0x58>
802008c0: 2f b6 e6 1e  	sc.d.aqrl	a2, a4, (a3)
802008c4: 75 fa        	bnez	a2, 0x802008b8 <.LBB0_10+0x4a>
802008c6: 2d 8d        	xor	a0, a0, a1
802008c8: 13 35 15 00  	seqz	a0, a0
802008cc: ae f0        	sd	a1, 96(sp)
802008ce: 23 04 a1 06  	sb	a0, 104(sp)
802008d2: 81 a0        	j	0x80200912 <.LBB0_10+0xa4>
802008d4: 62 75        	ld	a0, 56(sp)
802008d6: 86 66        	ld	a3, 64(sp)
802008d8: 42 77        	ld	a4, 48(sp)
802008da: af b5 06 16  	lr.d.aqrl	a1, (a3)
802008de: 63 95 a5 00  	bne	a1, a0, 0x802008e8 <.LBB0_10+0x7a>
802008e2: 2f b6 e6 1e  	sc.d.aqrl	a2, a4, (a3)
802008e6: 75 fa        	bnez	a2, 0x802008da <.LBB0_10+0x6c>
802008e8: 2d 8d        	xor	a0, a0, a1
802008ea: 13 35 15 00  	seqz	a0, a0
802008ee: ae f0        	sd	a1, 96(sp)
802008f0: 23 04 a1 06  	sb	a0, 104(sp)
802008f4: 09 a0        	j	0x802008f6 <.LBB0_10+0x88>
802008f6: 09 a0        	j	0x802008f8 <.LBB0_10+0x8a>
802008f8: 06 75        	ld	a0, 96(sp)
802008fa: 2a e4        	sd	a0, 8(sp)
802008fc: 2a f6        	sd	a0, 296(sp)
802008fe: 83 45 81 06  	lbu	a1, 104(sp)
80200902: 13 f5 15 00  	andi	a0, a1, 1
80200906: a3 0b b1 12  	sb	a1, 311(sp)
8020090a: 81 45        	mv	a1, zero
8020090c: 63 14 b5 18  	bne	a0, a1, 0x80200a94 <.LBB0_50+0x20>
80200910: ad aa        	j	0x80200a8a <.LBB0_50+0x16>
80200912: dd b7        	j	0x802008f8 <.LBB0_10+0x8a>
80200914: d5 b7        	j	0x802008f8 <.LBB0_10+0x8a>
80200916: 62 75        	ld	a0, 56(sp)
80200918: 86 66        	ld	a3, 64(sp)
8020091a: 42 77        	ld	a4, 48(sp)
8020091c: af b5 06 14  	lr.d.aq	a1, (a3)
80200920: 63 95 a5 00  	bne	a1, a0, 0x8020092a <.LBB0_10+0xbc>
80200924: 2f b6 e6 1a  	sc.d.rl	a2, a4, (a3)
80200928: 75 fa        	bnez	a2, 0x8020091c <.LBB0_10+0xae>
8020092a: 2d 8d        	xor	a0, a0, a1
8020092c: 13 35 15 00  	seqz	a0, a0
80200930: ae f0        	sd	a1, 96(sp)
80200932: 23 04 a1 06  	sb	a0, 104(sp)
80200936: 1d a0        	j	0x8020095c <.LBB0_10+0xee>
80200938: 62 75        	ld	a0, 56(sp)
8020093a: 86 66        	ld	a3, 64(sp)
8020093c: 42 77        	ld	a4, 48(sp)
8020093e: af b5 06 14  	lr.d.aq	a1, (a3)
80200942: 63 95 a5 00  	bne	a1, a0, 0x8020094c <.LBB0_10+0xde>
80200946: 2f b6 e6 1a  	sc.d.rl	a2, a4, (a3)
8020094a: 75 fa        	bnez	a2, 0x8020093e <.LBB0_10+0xd0>
8020094c: 2d 8d        	xor	a0, a0, a1
8020094e: 13 35 15 00  	seqz	a0, a0
80200952: ae f0        	sd	a1, 96(sp)
80200954: 23 04 a1 06  	sb	a0, 104(sp)
80200958: 09 a0        	j	0x8020095a <.LBB0_10+0xec>
8020095a: 79 bf        	j	0x802008f8 <.LBB0_10+0x8a>
8020095c: 71 bf        	j	0x802008f8 <.LBB0_10+0x8a>
8020095e: 62 75        	ld	a0, 56(sp)
80200960: 86 66        	ld	a3, 64(sp)
80200962: 42 77        	ld	a4, 48(sp)
80200964: af b5 06 14  	lr.d.aq	a1, (a3)
80200968: 63 95 a5 00  	bne	a1, a0, 0x80200972 <.LBB0_10+0x104>
8020096c: 2f b6 e6 18  	sc.d	a2, a4, (a3)
80200970: 75 fa        	bnez	a2, 0x80200964 <.LBB0_10+0xf6>
80200972: 2d 8d        	xor	a0, a0, a1
80200974: 13 35 15 00  	seqz	a0, a0
80200978: ae f0        	sd	a1, 96(sp)
8020097a: 23 04 a1 06  	sb	a0, 104(sp)
8020097e: 1d a0        	j	0x802009a4 <.LBB0_10+0x136>
80200980: 62 75        	ld	a0, 56(sp)
80200982: 86 66        	ld	a3, 64(sp)
80200984: 42 77        	ld	a4, 48(sp)
80200986: af b5 06 14  	lr.d.aq	a1, (a3)
8020098a: 63 95 a5 00  	bne	a1, a0, 0x80200994 <.LBB0_10+0x126>
8020098e: 2f b6 e6 18  	sc.d	a2, a4, (a3)
80200992: 75 fa        	bnez	a2, 0x80200986 <.LBB0_10+0x118>
80200994: 2d 8d        	xor	a0, a0, a1
80200996: 13 35 15 00  	seqz	a0, a0
8020099a: ae f0        	sd	a1, 96(sp)
8020099c: 23 04 a1 06  	sb	a0, 104(sp)
802009a0: 09 a0        	j	0x802009a2 <.LBB0_10+0x134>
802009a2: 99 bf        	j	0x802008f8 <.LBB0_10+0x8a>
802009a4: 91 bf        	j	0x802008f8 <.LBB0_10+0x8a>
802009a6: 62 75        	ld	a0, 56(sp)
802009a8: 86 66        	ld	a3, 64(sp)
802009aa: 42 77        	ld	a4, 48(sp)
802009ac: af b5 06 10  	lr.d	a1, (a3)
802009b0: 63 95 a5 00  	bne	a1, a0, 0x802009ba <.LBB0_10+0x14c>
802009b4: 2f b6 e6 1a  	sc.d.rl	a2, a4, (a3)
802009b8: 75 fa        	bnez	a2, 0x802009ac <.LBB0_10+0x13e>
802009ba: 2d 8d        	xor	a0, a0, a1
802009bc: 13 35 15 00  	seqz	a0, a0
802009c0: ae f0        	sd	a1, 96(sp)
802009c2: 23 04 a1 06  	sb	a0, 104(sp)
802009c6: 09 a0        	j	0x802009c8 <.LBB0_10+0x15a>
802009c8: 05 bf        	j	0x802008f8 <.LBB0_10+0x8a>
802009ca: 62 75        	ld	a0, 56(sp)
802009cc: 86 66        	ld	a3, 64(sp)
802009ce: 42 77        	ld	a4, 48(sp)
802009d0: af b5 06 10  	lr.d	a1, (a3)
802009d4: 63 95 a5 00  	bne	a1, a0, 0x802009de <.LBB0_10+0x170>
802009d8: 2f b6 e6 18  	sc.d	a2, a4, (a3)
802009dc: 75 fa        	bnez	a2, 0x802009d0 <.LBB0_10+0x162>
802009de: 2d 8d        	xor	a0, a0, a1
802009e0: 13 35 15 00  	seqz	a0, a0
802009e4: ae f0        	sd	a1, 96(sp)
802009e6: 23 04 a1 06  	sb	a0, 104(sp)
802009ea: 79 a8        	j	0x80200a88 <.LBB0_50+0x14>

00000000802009ec <.LBB0_42>:
802009ec: 97 75 00 00  	auipc	a1, 7
802009f0: 93 85 c5 a8  	addi	a1, a1, -1396

00000000802009f4 <.LBB0_43>:
802009f4: 97 76 00 00  	auipc	a3, 7
802009f8: 93 86 46 a9  	addi	a3, a3, -1388
802009fc: a8 09        	addi	a0, sp, 216
802009fe: 05 46        	addi	a2, zero, 1
80200a00: 01 47        	mv	a4, zero
80200a02: 97 20 00 00  	auipc	ra, 2
80200a06: e7 80 60 a2  	jalr	-1498(ra)
80200a0a: 89 a0        	j	0x80200a4c <.LBB0_48>

0000000080200a0c <.LBB0_44>:
80200a0c: 97 75 00 00  	auipc	a1, 7
80200a10: 93 85 45 b8  	addi	a1, a1, -1148

0000000080200a14 <.LBB0_45>:
80200a14: 97 76 00 00  	auipc	a3, 7
80200a18: 93 86 46 a7  	addi	a3, a3, -1420
80200a1c: 28 11        	addi	a0, sp, 168
80200a1e: 05 46        	addi	a2, zero, 1
80200a20: 01 47        	mv	a4, zero
80200a22: 97 20 00 00  	auipc	ra, 2
80200a26: e7 80 60 a0  	jalr	-1530(ra)
80200a2a: a9 a0        	j	0x80200a74 <.LBB0_50>

0000000080200a2c <.LBB0_46>:
80200a2c: 97 75 00 00  	auipc	a1, 7
80200a30: 93 85 45 b0  	addi	a1, a1, -1276

0000000080200a34 <.LBB0_47>:
80200a34: 97 76 00 00  	auipc	a3, 7
80200a38: 93 86 46 a5  	addi	a3, a3, -1452
80200a3c: a8 18        	addi	a0, sp, 120
80200a3e: 05 46        	addi	a2, zero, 1
80200a40: 01 47        	mv	a4, zero
80200a42: 97 20 00 00  	auipc	ra, 2
80200a46: e7 80 60 9e  	jalr	-1562(ra)
80200a4a: 19 a8        	j	0x80200a60 <.LBB0_49>

0000000080200a4c <.LBB0_48>:
80200a4c: 97 75 00 00  	auipc	a1, 7
80200a50: 93 85 c5 a8  	addi	a1, a1, -1396
80200a54: a8 09        	addi	a0, sp, 216
80200a56: 97 40 00 00  	auipc	ra, 4
80200a5a: e7 80 20 1c  	jalr	450(ra)
80200a5e: 00 00        	unimp	

0000000080200a60 <.LBB0_49>:
80200a60: 97 75 00 00  	auipc	a1, 7
80200a64: 93 85 05 ae  	addi	a1, a1, -1312
80200a68: a8 18        	addi	a0, sp, 120
80200a6a: 97 40 00 00  	auipc	ra, 4
80200a6e: e7 80 e0 1a  	jalr	430(ra)
80200a72: 00 00        	unimp	

0000000080200a74 <.LBB0_50>:
80200a74: 97 75 00 00  	auipc	a1, 7
80200a78: 93 85 c5 b2  	addi	a1, a1, -1236
80200a7c: 28 11        	addi	a0, sp, 168
80200a7e: 97 40 00 00  	auipc	ra, 4
80200a82: e7 80 a0 19  	jalr	410(ra)
80200a86: 00 00        	unimp	
80200a88: 85 bd        	j	0x802008f8 <.LBB0_10+0x8a>
80200a8a: 22 65        	ld	a0, 8(sp)
80200a8c: aa ec        	sd	a0, 88(sp)
80200a8e: 05 45        	addi	a0, zero, 1
80200a90: aa e8        	sd	a0, 80(sp)
80200a92: 31 a0        	j	0x80200a9e <.LBB0_50+0x2a>
80200a94: 22 65        	ld	a0, 8(sp)
80200a96: aa ec        	sd	a0, 88(sp)
80200a98: 01 45        	mv	a0, zero
80200a9a: aa e8        	sd	a0, 80(sp)
80200a9c: 09 a0        	j	0x80200a9e <.LBB0_50+0x2a>
80200a9e: 46 65        	ld	a0, 80(sp)
80200aa0: e6 65        	ld	a1, 88(sp)
80200aa2: f2 70        	ld	ra, 312(sp)
80200aa4: 31 61        	addi	sp, sp, 320
80200aa6: 82 80        	ret

0000000080200aa8 <_ZN2os4task11TaskManager14run_first_task17hf4507acfbb85338cE>:
80200aa8: 51 71        	addi	sp, sp, -240
80200aaa: 86 f5        	sd	ra, 232(sp)
80200aac: aa e9        	sd	a0, 208(sp)
80200aae: 21 05        	addi	a0, a0, 8
80200ab0: 97 f0 ff ff  	auipc	ra, 1048575
80200ab4: e7 80 80 5f  	jalr	1528(ra)
80200ab8: 2a ec        	sd	a0, 24(sp)
80200aba: 2e f0        	sd	a1, 32(sp)
80200abc: 09 a0        	j	0x80200abe <_ZN2os4task11TaskManager14run_first_task17hf4507acfbb85338cE+0x16>
80200abe: 28 08        	addi	a0, sp, 24
80200ac0: 97 f0 ff ff  	auipc	ra, 1048575
80200ac4: e7 80 e0 78  	jalr	1934(ra)
80200ac8: 2a e8        	sd	a0, 16(sp)
80200aca: 09 a0        	j	0x80200acc <_ZN2os4task11TaskManager14run_first_task17hf4507acfbb85338cE+0x24>
80200acc: 42 65        	ld	a0, 16(sp)
80200ace: aa ed        	sd	a0, 216(sp)
80200ad0: 89 45        	addi	a1, zero, 2
80200ad2: a3 07 b1 02  	sb	a1, 47(sp)
80200ad6: 23 08 b5 06  	sb	a1, 112(a0)
80200ada: aa 85        	mv	a1, a0
80200adc: 2e e4        	sd	a1, 8(sp)
80200ade: aa f1        	sd	a0, 224(sp)
80200ae0: 62 65        	ld	a0, 24(sp)
80200ae2: 82 75        	ld	a1, 32(sp)
80200ae4: 97 30 00 00  	auipc	ra, 3
80200ae8: e7 80 e0 c1  	jalr	-994(ra)
80200aec: 09 a0        	j	0x80200aee <_ZN2os4task11TaskManager14run_first_task17hf4507acfbb85338cE+0x46>
80200aee: 08 18        	addi	a0, sp, 48
80200af0: 97 10 00 00  	auipc	ra, 1
80200af4: e7 80 a0 92  	jalr	-1750(ra)
80200af8: 09 a0        	j	0x80200afa <_ZN2os4task11TaskManager14run_first_task17hf4507acfbb85338cE+0x52>
80200afa: a2 65        	ld	a1, 8(sp)
80200afc: 08 18        	addi	a0, sp, 48
80200afe: 97 30 00 00  	auipc	ra, 3
80200b02: e7 80 20 84  	jalr	-1982(ra)
80200b06: 09 a0        	j	0x80200b08 <.LBB0_7>

0000000080200b08 <.LBB0_7>:
80200b08: 97 75 00 00  	auipc	a1, 7
80200b0c: 93 85 05 ad  	addi	a1, a1, -1328

0000000080200b10 <.LBB0_8>:
80200b10: 97 76 00 00  	auipc	a3, 7
80200b14: 93 86 86 ad  	addi	a3, a3, -1320
80200b18: 08 11        	addi	a0, sp, 160
80200b1a: 05 46        	addi	a2, zero, 1
80200b1c: 01 47        	mv	a4, zero
80200b1e: 97 20 00 00  	auipc	ra, 2
80200b22: e7 80 a0 90  	jalr	-1782(ra)
80200b26: 09 a0        	j	0x80200b28 <.LBB0_9>

0000000080200b28 <.LBB0_9>:
80200b28: 97 75 00 00  	auipc	a1, 7
80200b2c: 93 85 05 ad  	addi	a1, a1, -1328
80200b30: 08 11        	addi	a0, sp, 160
80200b32: 97 40 00 00  	auipc	ra, 4
80200b36: e7 80 60 0e  	jalr	230(ra)
80200b3a: 00 00        	unimp	

0000000080200b3c <_ZN2os4task11TaskManager22mark_current_suspended17hf7e3115161f82710E>:
80200b3c: 5d 71        	addi	sp, sp, -80
80200b3e: 86 e4        	sd	ra, 72(sp)
80200b40: 2a fc        	sd	a0, 56(sp)
80200b42: 21 05        	addi	a0, a0, 8
80200b44: 97 f0 ff ff  	auipc	ra, 1048575
80200b48: e7 80 40 56  	jalr	1380(ra)
80200b4c: 2a f0        	sd	a0, 32(sp)
80200b4e: 2e f4        	sd	a1, 40(sp)
80200b50: 09 a0        	j	0x80200b52 <_ZN2os4task11TaskManager22mark_current_suspended17hf7e3115161f82710E+0x16>
80200b52: 08 10        	addi	a0, sp, 32
80200b54: 97 f0 ff ff  	auipc	ra, 1048575
80200b58: e7 80 00 6f  	jalr	1776(ra)
80200b5c: 2a ec        	sd	a0, 24(sp)
80200b5e: 09 a0        	j	0x80200b60 <_ZN2os4task11TaskManager22mark_current_suspended17hf7e3115161f82710E+0x24>
80200b60: 62 65        	ld	a0, 24(sp)
80200b62: 03 35 05 1e  	ld	a0, 480(a0)
80200b66: 2a e4        	sd	a0, 8(sp)
80200b68: aa e0        	sd	a0, 64(sp)
80200b6a: 05 45        	addi	a0, zero, 1
80200b6c: a3 0b a1 02  	sb	a0, 55(sp)
80200b70: 08 10        	addi	a0, sp, 32
80200b72: 97 f0 ff ff  	auipc	ra, 1048575
80200b76: e7 80 c0 6d  	jalr	1756(ra)
80200b7a: 2a e8        	sd	a0, 16(sp)
80200b7c: 09 a0        	j	0x80200b7e <_ZN2os4task11TaskManager22mark_current_suspended17hf7e3115161f82710E+0x42>
80200b7e: a2 65        	ld	a1, 8(sp)
80200b80: 0d 45        	addi	a0, zero, 3
80200b82: 63 64 b5 02  	bltu	a0, a1, 0x80200baa <_ZN2os4task11TaskManager22mark_current_suspended17hf7e3115161f82710E+0x6e>
80200b86: 09 a0        	j	0x80200b88 <_ZN2os4task11TaskManager22mark_current_suspended17hf7e3115161f82710E+0x4c>
80200b88: 42 65        	ld	a0, 16(sp)
80200b8a: a2 65        	ld	a1, 8(sp)
80200b8c: 13 06 80 07  	addi	a2, zero, 120
80200b90: b3 85 c5 02  	mul	a1, a1, a2
80200b94: aa 95        	add	a1, a1, a0
80200b96: 03 05 71 03  	lb	a0, 55(sp)
80200b9a: 23 88 a5 06  	sb	a0, 112(a1)
80200b9e: 08 10        	addi	a0, sp, 32
80200ba0: 97 10 00 00  	auipc	ra, 1
80200ba4: e7 80 00 83  	jalr	-2000(ra)
80200ba8: 21 a8        	j	0x80200bc0 <.LBB1_7+0x14>
80200baa: 22 65        	ld	a0, 8(sp)

0000000080200bac <.LBB1_7>:
80200bac: 17 76 00 00  	auipc	a2, 7
80200bb0: 13 06 46 a6  	addi	a2, a2, -1436
80200bb4: 91 45        	addi	a1, zero, 4
80200bb6: 97 40 00 00  	auipc	ra, 4
80200bba: e7 80 20 02  	jalr	34(ra)
80200bbe: 00 00        	unimp	
80200bc0: a6 60        	ld	ra, 72(sp)
80200bc2: 61 61        	addi	sp, sp, 80
80200bc4: 82 80        	ret

0000000080200bc6 <_ZN2os4task11TaskManager19mark_current_exited17hc31ba74eb5f164ecE>:
80200bc6: 5d 71        	addi	sp, sp, -80
80200bc8: 86 e4        	sd	ra, 72(sp)
80200bca: 2a fc        	sd	a0, 56(sp)
80200bcc: 21 05        	addi	a0, a0, 8
80200bce: 97 f0 ff ff  	auipc	ra, 1048575
80200bd2: e7 80 a0 4d  	jalr	1242(ra)
80200bd6: 2a f0        	sd	a0, 32(sp)
80200bd8: 2e f4        	sd	a1, 40(sp)
80200bda: 09 a0        	j	0x80200bdc <_ZN2os4task11TaskManager19mark_current_exited17hc31ba74eb5f164ecE+0x16>
80200bdc: 08 10        	addi	a0, sp, 32
80200bde: 97 f0 ff ff  	auipc	ra, 1048575
80200be2: e7 80 60 66  	jalr	1638(ra)
80200be6: 2a ec        	sd	a0, 24(sp)
80200be8: 09 a0        	j	0x80200bea <_ZN2os4task11TaskManager19mark_current_exited17hc31ba74eb5f164ecE+0x24>
80200bea: 62 65        	ld	a0, 24(sp)
80200bec: 03 35 05 1e  	ld	a0, 480(a0)
80200bf0: 2a e4        	sd	a0, 8(sp)
80200bf2: aa e0        	sd	a0, 64(sp)
80200bf4: 0d 45        	addi	a0, zero, 3
80200bf6: a3 0b a1 02  	sb	a0, 55(sp)
80200bfa: 08 10        	addi	a0, sp, 32
80200bfc: 97 f0 ff ff  	auipc	ra, 1048575
80200c00: e7 80 20 65  	jalr	1618(ra)
80200c04: 2a e8        	sd	a0, 16(sp)
80200c06: 09 a0        	j	0x80200c08 <_ZN2os4task11TaskManager19mark_current_exited17hc31ba74eb5f164ecE+0x42>
80200c08: a2 65        	ld	a1, 8(sp)
80200c0a: 0d 45        	addi	a0, zero, 3
80200c0c: 63 64 b5 02  	bltu	a0, a1, 0x80200c34 <_ZN2os4task11TaskManager19mark_current_exited17hc31ba74eb5f164ecE+0x6e>
80200c10: 09 a0        	j	0x80200c12 <_ZN2os4task11TaskManager19mark_current_exited17hc31ba74eb5f164ecE+0x4c>
80200c12: 42 65        	ld	a0, 16(sp)
80200c14: a2 65        	ld	a1, 8(sp)
80200c16: 13 06 80 07  	addi	a2, zero, 120
80200c1a: b3 85 c5 02  	mul	a1, a1, a2
80200c1e: aa 95        	add	a1, a1, a0
80200c20: 03 05 71 03  	lb	a0, 55(sp)
80200c24: 23 88 a5 06  	sb	a0, 112(a1)
80200c28: 08 10        	addi	a0, sp, 32
80200c2a: 97 00 00 00  	auipc	ra, 0
80200c2e: e7 80 60 7a  	jalr	1958(ra)
80200c32: 21 a8        	j	0x80200c4a <.LBB2_7+0x14>
80200c34: 22 65        	ld	a0, 8(sp)

0000000080200c36 <.LBB2_7>:
80200c36: 17 76 00 00  	auipc	a2, 7
80200c3a: 13 06 26 9f  	addi	a2, a2, -1550
80200c3e: 91 45        	addi	a1, zero, 4
80200c40: 97 40 00 00  	auipc	ra, 4
80200c44: e7 80 80 f9  	jalr	-104(ra)
80200c48: 00 00        	unimp	
80200c4a: a6 60        	ld	ra, 72(sp)
80200c4c: 61 61        	addi	sp, sp, 80
80200c4e: 82 80        	ret

0000000080200c50 <_ZN2os4task11TaskManager14find_next_task17h9aaffd61ec2582ecE>:
80200c50: 35 71        	addi	sp, sp, -160
80200c52: 06 ed        	sd	ra, 152(sp)
80200c54: 2a fc        	sd	a0, 56(sp)
80200c56: 2a e5        	sd	a0, 136(sp)
80200c58: 21 05        	addi	a0, a0, 8
80200c5a: 97 f0 ff ff  	auipc	ra, 1048575
80200c5e: e7 80 e0 44  	jalr	1102(ra)
80200c62: aa e0        	sd	a0, 64(sp)
80200c64: ae e4        	sd	a1, 72(sp)
80200c66: 09 a0        	j	0x80200c68 <_ZN2os4task11TaskManager14find_next_task17h9aaffd61ec2582ecE+0x18>
80200c68: 88 00        	addi	a0, sp, 64
80200c6a: 97 f0 ff ff  	auipc	ra, 1048575
80200c6e: e7 80 a0 5d  	jalr	1498(ra)
80200c72: 2a f8        	sd	a0, 48(sp)
80200c74: 09 a0        	j	0x80200c76 <_ZN2os4task11TaskManager14find_next_task17h9aaffd61ec2582ecE+0x26>
80200c76: 42 75        	ld	a0, 48(sp)
80200c78: 83 35 05 1e  	ld	a1, 480(a0)
80200c7c: 2e f0        	sd	a1, 32(sp)
80200c7e: 2e e9        	sd	a1, 144(sp)
80200c80: 13 85 15 00  	addi	a0, a1, 1
80200c84: 2a f4        	sd	a0, 40(sp)
80200c86: 63 6b b5 00  	bltu	a0, a1, 0x80200c9c <.LBB3_12>
80200c8a: 09 a0        	j	0x80200c8c <_ZN2os4task11TaskManager14find_next_task17h9aaffd61ec2582ecE+0x3c>
80200c8c: 82 75        	ld	a1, 32(sp)
80200c8e: 62 75        	ld	a0, 56(sp)
80200c90: 08 61        	ld	a0, 0(a0)
80200c92: 2e 95        	add	a0, a0, a1
80200c94: 2a ec        	sd	a0, 24(sp)
80200c96: 63 68 b5 02  	bltu	a0, a1, 0x80200cc6 <.LBB3_14>
80200c9a: 39 a8        	j	0x80200cb8 <.LBB3_13+0x14>

0000000080200c9c <.LBB3_12>:
80200c9c: 17 75 00 00  	auipc	a0, 7
80200ca0: 13 05 45 9c  	addi	a0, a0, -1596

0000000080200ca4 <.LBB3_13>:
80200ca4: 17 76 00 00  	auipc	a2, 7
80200ca8: 13 06 c6 99  	addi	a2, a2, -1636
80200cac: f1 45        	addi	a1, zero, 28
80200cae: 97 40 00 00  	auipc	ra, 4
80200cb2: e7 80 e0 ef  	jalr	-258(ra)
80200cb6: 00 00        	unimp	
80200cb8: e2 65        	ld	a1, 24(sp)
80200cba: 13 85 15 00  	addi	a0, a1, 1
80200cbe: 2a e8        	sd	a0, 16(sp)
80200cc0: 63 6d b5 02  	bltu	a0, a1, 0x80200cfa <.LBB3_16>
80200cc4: 39 a8        	j	0x80200ce2 <.LBB3_15+0x14>

0000000080200cc6 <.LBB3_14>:
80200cc6: 17 75 00 00  	auipc	a0, 7
80200cca: 13 05 a5 99  	addi	a0, a0, -1638

0000000080200cce <.LBB3_15>:
80200cce: 17 76 00 00  	auipc	a2, 7
80200cd2: 13 06 26 9b  	addi	a2, a2, -1614
80200cd6: f1 45        	addi	a1, zero, 28
80200cd8: 97 40 00 00  	auipc	ra, 4
80200cdc: e7 80 40 ed  	jalr	-300(ra)
80200ce0: 00 00        	unimp	
80200ce2: e2 76        	ld	a3, 56(sp)
80200ce4: 42 66        	ld	a2, 16(sp)
80200ce6: a2 75        	ld	a1, 40(sp)
80200ce8: ae f4        	sd	a1, 104(sp)
80200cea: b2 f8        	sd	a2, 112(sp)
80200cec: b6 fc        	sd	a3, 120(sp)
80200cee: 88 08        	addi	a0, sp, 80
80200cf0: 97 10 00 00  	auipc	ra, 1
80200cf4: e7 80 a0 e1  	jalr	-486(ra)
80200cf8: 39 a8        	j	0x80200d16 <.LBB3_17+0x14>

0000000080200cfa <.LBB3_16>:
80200cfa: 17 75 00 00  	auipc	a0, 7
80200cfe: 13 05 65 96  	addi	a0, a0, -1690

0000000080200d02 <.LBB3_17>:
80200d02: 17 76 00 00  	auipc	a2, 7
80200d06: 13 06 e6 97  	addi	a2, a2, -1666
80200d0a: f1 45        	addi	a1, zero, 28
80200d0c: 97 40 00 00  	auipc	ra, 4
80200d10: e7 80 00 ea  	jalr	-352(ra)
80200d14: 00 00        	unimp	
80200d16: 8c 00        	addi	a1, sp, 64
80200d18: 2e e1        	sd	a1, 128(sp)
80200d1a: 88 08        	addi	a0, sp, 80
80200d1c: 97 20 00 00  	auipc	ra, 2
80200d20: e7 80 80 e0  	jalr	-504(ra)
80200d24: 2a e0        	sd	a0, 0(sp)
80200d26: 2e e4        	sd	a1, 8(sp)
80200d28: 09 a0        	j	0x80200d2a <.LBB3_17+0x28>
80200d2a: 88 00        	addi	a0, sp, 64
80200d2c: 97 00 00 00  	auipc	ra, 0
80200d30: e7 80 40 6a  	jalr	1700(ra)
80200d34: 09 a0        	j	0x80200d36 <.LBB3_17+0x34>
80200d36: a2 65        	ld	a1, 8(sp)
80200d38: 02 65        	ld	a0, 0(sp)
80200d3a: ea 60        	ld	ra, 152(sp)
80200d3c: 0d 61        	addi	sp, sp, 160
80200d3e: 82 80        	ret

0000000080200d40 <_ZN2os4task11TaskManager13run_next_task17hfb79d07d72b37e5eE>:
80200d40: 15 71        	addi	sp, sp, -224
80200d42: 86 ed        	sd	ra, 216(sp)
80200d44: aa e8        	sd	a0, 80(sp)
80200d46: 2a f9        	sd	a0, 176(sp)
80200d48: 97 00 00 00  	auipc	ra, 0
80200d4c: e7 80 80 f0  	jalr	-248(ra)
80200d50: aa ec        	sd	a0, 88(sp)
80200d52: ae f0        	sd	a1, 96(sp)
80200d54: 09 a0        	j	0x80200d56 <_ZN2os4task11TaskManager13run_next_task17hfb79d07d72b37e5eE+0x16>
80200d56: 66 65        	ld	a0, 88(sp)
80200d58: 81 45        	mv	a1, zero
80200d5a: 63 0f b5 00  	beq	a0, a1, 0x80200d78 <.LBB4_19>
80200d5e: 09 a0        	j	0x80200d60 <_ZN2os4task11TaskManager13run_next_task17hfb79d07d72b37e5eE+0x20>
80200d60: 46 65        	ld	a0, 80(sp)
80200d62: 86 75        	ld	a1, 96(sp)
80200d64: ae e4        	sd	a1, 72(sp)
80200d66: 2e fd        	sd	a1, 184(sp)
80200d68: 21 05        	addi	a0, a0, 8
80200d6a: 97 f0 ff ff  	auipc	ra, 1048575
80200d6e: e7 80 e0 33  	jalr	830(ra)
80200d72: aa f4        	sd	a0, 104(sp)
80200d74: ae f8        	sd	a1, 112(sp)
80200d76: 1d a8        	j	0x80200dac <.LBB4_21+0x14>

0000000080200d78 <.LBB4_19>:
80200d78: 97 75 00 00  	auipc	a1, 7
80200d7c: 93 85 05 94  	addi	a1, a1, -1728

0000000080200d80 <.LBB4_20>:
80200d80: 97 76 00 00  	auipc	a3, 7
80200d84: 93 86 86 86  	addi	a3, a3, -1944
80200d88: 08 01        	addi	a0, sp, 128
80200d8a: 05 46        	addi	a2, zero, 1
80200d8c: 01 47        	mv	a4, zero
80200d8e: 97 10 00 00  	auipc	ra, 1
80200d92: e7 80 a0 69  	jalr	1690(ra)
80200d96: 09 a0        	j	0x80200d98 <.LBB4_21>

0000000080200d98 <.LBB4_21>:
80200d98: 97 75 00 00  	auipc	a1, 7
80200d9c: 93 85 05 93  	addi	a1, a1, -1744
80200da0: 08 01        	addi	a0, sp, 128
80200da2: 97 40 00 00  	auipc	ra, 4
80200da6: e7 80 60 e7  	jalr	-394(ra)
80200daa: 00 00        	unimp	
80200dac: a8 10        	addi	a0, sp, 104
80200dae: 97 f0 ff ff  	auipc	ra, 1048575
80200db2: e7 80 60 49  	jalr	1174(ra)
80200db6: aa e0        	sd	a0, 64(sp)
80200db8: 09 a0        	j	0x80200dba <.LBB4_21+0x22>
80200dba: 06 65        	ld	a0, 64(sp)
80200dbc: 03 35 05 1e  	ld	a0, 480(a0)
80200dc0: 2a f8        	sd	a0, 48(sp)
80200dc2: aa e1        	sd	a0, 192(sp)
80200dc4: 09 45        	addi	a0, zero, 2
80200dc6: a3 0f a1 06  	sb	a0, 127(sp)
80200dca: a8 10        	addi	a0, sp, 104
80200dcc: 97 f0 ff ff  	auipc	ra, 1048575
80200dd0: e7 80 20 48  	jalr	1154(ra)
80200dd4: 2a fc        	sd	a0, 56(sp)
80200dd6: 09 a0        	j	0x80200dd8 <.LBB4_21+0x40>
80200dd8: a6 65        	ld	a1, 72(sp)
80200dda: 0d 45        	addi	a0, zero, 3
80200ddc: 63 65 b5 02  	bltu	a0, a1, 0x80200e06 <.LBB4_21+0x6e>
80200de0: 09 a0        	j	0x80200de2 <.LBB4_21+0x4a>
80200de2: 62 75        	ld	a0, 56(sp)
80200de4: a6 65        	ld	a1, 72(sp)
80200de6: 13 06 80 07  	addi	a2, zero, 120
80200dea: b3 85 c5 02  	mul	a1, a1, a2
80200dee: aa 95        	add	a1, a1, a0
80200df0: 03 05 f1 07  	lb	a0, 127(sp)
80200df4: 23 88 a5 06  	sb	a0, 112(a1)
80200df8: a8 10        	addi	a0, sp, 104
80200dfa: 97 f0 ff ff  	auipc	ra, 1048575
80200dfe: e7 80 40 45  	jalr	1108(ra)
80200e02: 2a f4        	sd	a0, 40(sp)
80200e04: 21 a8        	j	0x80200e1c <.LBB4_22+0x14>
80200e06: 26 65        	ld	a0, 72(sp)

0000000080200e08 <.LBB4_22>:
80200e08: 17 76 00 00  	auipc	a2, 7
80200e0c: 13 06 86 8d  	addi	a2, a2, -1832
80200e10: 91 45        	addi	a1, zero, 4
80200e12: 97 40 00 00  	auipc	ra, 4
80200e16: e7 80 60 dc  	jalr	-570(ra)
80200e1a: 00 00        	unimp	
80200e1c: 26 65        	ld	a0, 72(sp)
80200e1e: a2 75        	ld	a1, 40(sp)
80200e20: 23 b0 a5 1e  	sd	a0, 480(a1)
80200e24: a8 10        	addi	a0, sp, 104
80200e26: 97 f0 ff ff  	auipc	ra, 1048575
80200e2a: e7 80 80 42  	jalr	1064(ra)
80200e2e: 2a f0        	sd	a0, 32(sp)
80200e30: 09 a0        	j	0x80200e32 <.LBB4_22+0x2a>
80200e32: c2 75        	ld	a1, 48(sp)
80200e34: 0d 45        	addi	a0, zero, 3
80200e36: 63 63 b5 02  	bltu	a0, a1, 0x80200e5c <.LBB4_22+0x54>
80200e3a: 09 a0        	j	0x80200e3c <.LBB4_22+0x34>
80200e3c: 02 75        	ld	a0, 32(sp)
80200e3e: c2 75        	ld	a1, 48(sp)
80200e40: 13 06 80 07  	addi	a2, zero, 120
80200e44: b3 85 c5 02  	mul	a1, a1, a2
80200e48: 2e 95        	add	a0, a0, a1
80200e4a: 2a e8        	sd	a0, 16(sp)
80200e4c: aa e5        	sd	a0, 200(sp)
80200e4e: a8 10        	addi	a0, sp, 104
80200e50: 97 f0 ff ff  	auipc	ra, 1048575
80200e54: e7 80 40 3f  	jalr	1012(ra)
80200e58: 2a ec        	sd	a0, 24(sp)
80200e5a: 21 a8        	j	0x80200e72 <.LBB4_23+0x14>
80200e5c: 42 75        	ld	a0, 48(sp)

0000000080200e5e <.LBB4_23>:
80200e5e: 17 76 00 00  	auipc	a2, 7
80200e62: 13 06 a6 89  	addi	a2, a2, -1894
80200e66: 91 45        	addi	a1, zero, 4
80200e68: 97 40 00 00  	auipc	ra, 4
80200e6c: e7 80 00 d7  	jalr	-656(ra)
80200e70: 00 00        	unimp	
80200e72: a6 65        	ld	a1, 72(sp)
80200e74: 0d 45        	addi	a0, zero, 3
80200e76: 63 63 b5 02  	bltu	a0, a1, 0x80200e9c <.LBB4_23+0x3e>
80200e7a: 09 a0        	j	0x80200e7c <.LBB4_23+0x1e>
80200e7c: 62 65        	ld	a0, 24(sp)
80200e7e: a6 65        	ld	a1, 72(sp)
80200e80: 13 06 80 07  	addi	a2, zero, 120
80200e84: b3 85 c5 02  	mul	a1, a1, a2
80200e88: 2e 95        	add	a0, a0, a1
80200e8a: 2a e4        	sd	a0, 8(sp)
80200e8c: aa e9        	sd	a0, 208(sp)
80200e8e: 26 75        	ld	a0, 104(sp)
80200e90: c6 75        	ld	a1, 112(sp)
80200e92: 97 30 00 00  	auipc	ra, 3
80200e96: e7 80 00 87  	jalr	-1936(ra)
80200e9a: 21 a8        	j	0x80200eb2 <.LBB4_24+0x14>
80200e9c: 26 65        	ld	a0, 72(sp)

0000000080200e9e <.LBB4_24>:
80200e9e: 17 76 00 00  	auipc	a2, 7
80200ea2: 13 06 26 87  	addi	a2, a2, -1934
80200ea6: 91 45        	addi	a1, zero, 4
80200ea8: 97 40 00 00  	auipc	ra, 4
80200eac: e7 80 00 d3  	jalr	-720(ra)
80200eb0: 00 00        	unimp	
80200eb2: a2 65        	ld	a1, 8(sp)
80200eb4: 42 65        	ld	a0, 16(sp)
80200eb6: 97 20 00 00  	auipc	ra, 2
80200eba: e7 80 a0 48  	jalr	1162(ra)
80200ebe: 09 a0        	j	0x80200ec0 <.LBB4_24+0x22>
80200ec0: ee 60        	ld	ra, 216(sp)
80200ec2: 2d 61        	addi	sp, sp, 224
80200ec4: 82 80        	ret

0000000080200ec6 <_ZN2os4task14run_first_task17h08a9c3cef0cab99eE>:
80200ec6: 41 11        	addi	sp, sp, -16
80200ec8: 06 e4        	sd	ra, 8(sp)

0000000080200eca <.LBB5_2>:
80200eca: 17 75 00 00  	auipc	a0, 7
80200ece: 13 05 e5 85  	addi	a0, a0, -1954
80200ed2: 97 00 00 00  	auipc	ra, 0
80200ed6: e7 80 20 0d  	jalr	210(ra)
80200eda: 2a e0        	sd	a0, 0(sp)
80200edc: 09 a0        	j	0x80200ede <.LBB5_2+0x14>
80200ede: 02 65        	ld	a0, 0(sp)
80200ee0: 97 00 00 00  	auipc	ra, 0
80200ee4: e7 80 80 bc  	jalr	-1080(ra)
80200ee8: 00 00        	unimp	

0000000080200eea <_ZN2os4task13run_next_task17h95cd7f8dce6ead2fE>:
80200eea: 41 11        	addi	sp, sp, -16
80200eec: 06 e4        	sd	ra, 8(sp)

0000000080200eee <.LBB6_3>:
80200eee: 17 75 00 00  	auipc	a0, 7
80200ef2: 13 05 a5 83  	addi	a0, a0, -1990
80200ef6: 97 00 00 00  	auipc	ra, 0
80200efa: e7 80 e0 0a  	jalr	174(ra)
80200efe: 2a e0        	sd	a0, 0(sp)
80200f00: 09 a0        	j	0x80200f02 <.LBB6_3+0x14>
80200f02: 02 65        	ld	a0, 0(sp)
80200f04: 97 00 00 00  	auipc	ra, 0
80200f08: e7 80 c0 e3  	jalr	-452(ra)
80200f0c: 09 a0        	j	0x80200f0e <.LBB6_3+0x20>
80200f0e: a2 60        	ld	ra, 8(sp)
80200f10: 41 01        	addi	sp, sp, 16
80200f12: 82 80        	ret

0000000080200f14 <_ZN2os4task22mark_current_suspended17hfc88d56f8a91e5baE>:
80200f14: 41 11        	addi	sp, sp, -16
80200f16: 06 e4        	sd	ra, 8(sp)

0000000080200f18 <.LBB7_3>:
80200f18: 17 75 00 00  	auipc	a0, 7
80200f1c: 13 05 05 81  	addi	a0, a0, -2032
80200f20: 97 00 00 00  	auipc	ra, 0
80200f24: e7 80 40 08  	jalr	132(ra)
80200f28: 2a e0        	sd	a0, 0(sp)
80200f2a: 09 a0        	j	0x80200f2c <.LBB7_3+0x14>
80200f2c: 02 65        	ld	a0, 0(sp)
80200f2e: 97 00 00 00  	auipc	ra, 0
80200f32: e7 80 e0 c0  	jalr	-1010(ra)
80200f36: 09 a0        	j	0x80200f38 <.LBB7_3+0x20>
80200f38: a2 60        	ld	ra, 8(sp)
80200f3a: 41 01        	addi	sp, sp, 16
80200f3c: 82 80        	ret

0000000080200f3e <_ZN2os4task19mark_current_exited17h39b9fa12f3cd8b5cE>:
80200f3e: 41 11        	addi	sp, sp, -16
80200f40: 06 e4        	sd	ra, 8(sp)

0000000080200f42 <.LBB8_3>:
80200f42: 17 65 00 00  	auipc	a0, 6
80200f46: 13 05 65 7e  	addi	a0, a0, 2022
80200f4a: 97 00 00 00  	auipc	ra, 0
80200f4e: e7 80 a0 05  	jalr	90(ra)
80200f52: 2a e0        	sd	a0, 0(sp)
80200f54: 09 a0        	j	0x80200f56 <.LBB8_3+0x14>
80200f56: 02 65        	ld	a0, 0(sp)
80200f58: 97 00 00 00  	auipc	ra, 0
80200f5c: e7 80 e0 c6  	jalr	-914(ra)
80200f60: 09 a0        	j	0x80200f62 <.LBB8_3+0x20>
80200f62: a2 60        	ld	ra, 8(sp)
80200f64: 41 01        	addi	sp, sp, 16
80200f66: 82 80        	ret

0000000080200f68 <_ZN2os4task28suspend_current_and_run_next17hb22acfcc7b586d95E>:
80200f68: 41 11        	addi	sp, sp, -16
80200f6a: 06 e4        	sd	ra, 8(sp)
80200f6c: 97 00 00 00  	auipc	ra, 0
80200f70: e7 80 80 fa  	jalr	-88(ra)
80200f74: 09 a0        	j	0x80200f76 <_ZN2os4task28suspend_current_and_run_next17hb22acfcc7b586d95E+0xe>
80200f76: 97 00 00 00  	auipc	ra, 0
80200f7a: e7 80 40 f7  	jalr	-140(ra)
80200f7e: 09 a0        	j	0x80200f80 <_ZN2os4task28suspend_current_and_run_next17hb22acfcc7b586d95E+0x18>
80200f80: a2 60        	ld	ra, 8(sp)
80200f82: 41 01        	addi	sp, sp, 16
80200f84: 82 80        	ret

0000000080200f86 <_ZN2os4task25exit_current_and_run_next17h25f3fa11e179f10cE>:
80200f86: 41 11        	addi	sp, sp, -16
80200f88: 06 e4        	sd	ra, 8(sp)
80200f8a: 97 00 00 00  	auipc	ra, 0
80200f8e: e7 80 40 fb  	jalr	-76(ra)
80200f92: 09 a0        	j	0x80200f94 <_ZN2os4task25exit_current_and_run_next17h25f3fa11e179f10cE+0xe>
80200f94: 97 00 00 00  	auipc	ra, 0
80200f98: e7 80 60 f5  	jalr	-170(ra)
80200f9c: 09 a0        	j	0x80200f9e <_ZN2os4task25exit_current_and_run_next17h25f3fa11e179f10cE+0x18>
80200f9e: a2 60        	ld	ra, 8(sp)
80200fa0: 41 01        	addi	sp, sp, 16
80200fa2: 82 80        	ret

0000000080200fa4 <_ZN66_$LT$os..task..TASK_MANAGER$u20$as$u20$core..ops..deref..Deref$GT$5deref17h31c9d2c9a88f94abE>:
80200fa4: 01 11        	addi	sp, sp, -32
80200fa6: 06 ec        	sd	ra, 24(sp)
80200fa8: 2a e4        	sd	a0, 8(sp)

0000000080200faa <.LBB11_2>:
80200faa: 17 f5 02 00  	auipc	a0, 47
80200fae: 13 05 65 05  	addi	a0, a0, 86
80200fb2: 2a e8        	sd	a0, 16(sp)
80200fb4: 97 10 00 00  	auipc	ra, 1
80200fb8: e7 80 80 e4  	jalr	-440(ra)
80200fbc: 2a e0        	sd	a0, 0(sp)
80200fbe: 09 a0        	j	0x80200fc0 <.LBB11_2+0x16>
80200fc0: 02 65        	ld	a0, 0(sp)
80200fc2: e2 60        	ld	ra, 24(sp)
80200fc4: 05 61        	addi	sp, sp, 32
80200fc6: 82 80        	ret

0000000080200fc8 <_ZN4core3fmt10ArgumentV13new17h05e6eebfa2195526E>:
80200fc8: 5d 71        	addi	sp, sp, -80
80200fca: 2a e8        	sd	a0, 16(sp)
80200fcc: 2a f8        	sd	a0, 48(sp)
80200fce: 2e fc        	sd	a1, 56(sp)
80200fd0: ae e0        	sd	a1, 64(sp)
80200fd2: 2e ec        	sd	a1, 24(sp)
80200fd4: 09 a0        	j	0x80200fd6 <_ZN4core3fmt10ArgumentV13new17h05e6eebfa2195526E+0xe>
80200fd6: 42 65        	ld	a0, 16(sp)
80200fd8: aa e4        	sd	a0, 72(sp)
80200fda: 2a e4        	sd	a0, 8(sp)
80200fdc: 09 a0        	j	0x80200fde <_ZN4core3fmt10ArgumentV13new17h05e6eebfa2195526E+0x16>
80200fde: e2 65        	ld	a1, 24(sp)
80200fe0: 22 65        	ld	a0, 8(sp)
80200fe2: 2a f0        	sd	a0, 32(sp)
80200fe4: 2e f4        	sd	a1, 40(sp)
80200fe6: 61 61        	addi	sp, sp, 80
80200fe8: 82 80        	ret

0000000080200fea <_ZN4core3fmt10ArgumentV13new17h0c5a50ec46d0d85aE>:
80200fea: 5d 71        	addi	sp, sp, -80
80200fec: 2a e8        	sd	a0, 16(sp)
80200fee: 2a f8        	sd	a0, 48(sp)
80200ff0: 2e fc        	sd	a1, 56(sp)
80200ff2: ae e0        	sd	a1, 64(sp)
80200ff4: 2e ec        	sd	a1, 24(sp)
80200ff6: 09 a0        	j	0x80200ff8 <_ZN4core3fmt10ArgumentV13new17h0c5a50ec46d0d85aE+0xe>
80200ff8: 42 65        	ld	a0, 16(sp)
80200ffa: aa e4        	sd	a0, 72(sp)
80200ffc: 2a e4        	sd	a0, 8(sp)
80200ffe: 09 a0        	j	0x80201000 <_ZN4core3fmt10ArgumentV13new17h0c5a50ec46d0d85aE+0x16>
80201000: e2 65        	ld	a1, 24(sp)
80201002: 22 65        	ld	a0, 8(sp)
80201004: 2a f0        	sd	a0, 32(sp)
80201006: 2e f4        	sd	a1, 40(sp)
80201008: 61 61        	addi	sp, sp, 80
8020100a: 82 80        	ret

000000008020100c <_ZN4core3fmt10ArgumentV13new17h5a4dcec4ec0f01bbE>:
8020100c: 5d 71        	addi	sp, sp, -80
8020100e: 2a e8        	sd	a0, 16(sp)
80201010: 2a f8        	sd	a0, 48(sp)
80201012: 2e fc        	sd	a1, 56(sp)
80201014: ae e0        	sd	a1, 64(sp)
80201016: 2e ec        	sd	a1, 24(sp)
80201018: 09 a0        	j	0x8020101a <_ZN4core3fmt10ArgumentV13new17h5a4dcec4ec0f01bbE+0xe>
8020101a: 42 65        	ld	a0, 16(sp)
8020101c: aa e4        	sd	a0, 72(sp)
8020101e: 2a e4        	sd	a0, 8(sp)
80201020: 09 a0        	j	0x80201022 <_ZN4core3fmt10ArgumentV13new17h5a4dcec4ec0f01bbE+0x16>
80201022: e2 65        	ld	a1, 24(sp)
80201024: 22 65        	ld	a0, 8(sp)
80201026: 2a f0        	sd	a0, 32(sp)
80201028: 2e f4        	sd	a1, 40(sp)
8020102a: 61 61        	addi	sp, sp, 80
8020102c: 82 80        	ret

000000008020102e <_ZN4core3fmt10ArgumentV13new17ha2f67dd6539ac1d3E>:
8020102e: 5d 71        	addi	sp, sp, -80
80201030: 2a e8        	sd	a0, 16(sp)
80201032: 2a f8        	sd	a0, 48(sp)
80201034: 2e fc        	sd	a1, 56(sp)
80201036: ae e0        	sd	a1, 64(sp)
80201038: 2e ec        	sd	a1, 24(sp)
8020103a: 09 a0        	j	0x8020103c <_ZN4core3fmt10ArgumentV13new17ha2f67dd6539ac1d3E+0xe>
8020103c: 42 65        	ld	a0, 16(sp)
8020103e: aa e4        	sd	a0, 72(sp)
80201040: 2a e4        	sd	a0, 8(sp)
80201042: 09 a0        	j	0x80201044 <_ZN4core3fmt10ArgumentV13new17ha2f67dd6539ac1d3E+0x16>
80201044: e2 65        	ld	a1, 24(sp)
80201046: 22 65        	ld	a0, 8(sp)
80201048: 2a f0        	sd	a0, 32(sp)
8020104a: 2e f4        	sd	a1, 40(sp)
8020104c: 61 61        	addi	sp, sp, 80
8020104e: 82 80        	ret

0000000080201050 <_ZN4core3fmt10ArgumentV13new17hbc2d1957743bdf9eE>:
80201050: 5d 71        	addi	sp, sp, -80
80201052: 2a e8        	sd	a0, 16(sp)
80201054: 2a f8        	sd	a0, 48(sp)
80201056: 2e fc        	sd	a1, 56(sp)
80201058: ae e0        	sd	a1, 64(sp)
8020105a: 2e ec        	sd	a1, 24(sp)
8020105c: 09 a0        	j	0x8020105e <_ZN4core3fmt10ArgumentV13new17hbc2d1957743bdf9eE+0xe>
8020105e: 42 65        	ld	a0, 16(sp)
80201060: aa e4        	sd	a0, 72(sp)
80201062: 2a e4        	sd	a0, 8(sp)
80201064: 09 a0        	j	0x80201066 <_ZN4core3fmt10ArgumentV13new17hbc2d1957743bdf9eE+0x16>
80201066: e2 65        	ld	a1, 24(sp)
80201068: 22 65        	ld	a0, 8(sp)
8020106a: 2a f0        	sd	a0, 32(sp)
8020106c: 2e f4        	sd	a1, 40(sp)
8020106e: 61 61        	addi	sp, sp, 80
80201070: 82 80        	ret

0000000080201072 <_ZN44_$LT$$RF$T$u20$as$u20$core..fmt..Display$GT$3fmt17h9adf3f8b31bf006dE>:
80201072: 01 11        	addi	sp, sp, -32
80201074: 06 ec        	sd	ra, 24(sp)
80201076: 2a e4        	sd	a0, 8(sp)
80201078: 2e e8        	sd	a1, 16(sp)
8020107a: 08 61        	ld	a0, 0(a0)
8020107c: 97 40 00 00  	auipc	ra, 4
80201080: e7 80 20 33  	jalr	818(ra)
80201084: 2a e0        	sd	a0, 0(sp)
80201086: 09 a0        	j	0x80201088 <_ZN44_$LT$$RF$T$u20$as$u20$core..fmt..Display$GT$3fmt17h9adf3f8b31bf006dE+0x16>
80201088: 02 65        	ld	a0, 0(sp)
8020108a: e2 60        	ld	ra, 24(sp)
8020108c: 05 61        	addi	sp, sp, 32
8020108e: 82 80        	ret

0000000080201090 <_ZN74_$LT$$u5b$T$u5d$$u20$as$u20$core..slice..specialize..SpecFill$LT$T$GT$$GT$9spec_fill17h2be07a052633f0e5E>:
80201090: 59 71        	addi	sp, sp, -112
80201092: 86 f4        	sd	ra, 104(sp)
80201094: b2 86        	mv	a3, a2
80201096: 36 ec        	sd	a3, 24(sp)
80201098: aa e4        	sd	a0, 72(sp)
8020109a: ae e8        	sd	a1, 80(sp)
8020109c: a3 0f c1 04  	sb	a2, 95(sp)
802010a0: 97 20 00 00  	auipc	ra, 2
802010a4: e7 80 20 b0  	jalr	-1278(ra)
802010a8: 2a f0        	sd	a0, 32(sp)
802010aa: 2e f4        	sd	a1, 40(sp)
802010ac: 09 a0        	j	0x802010ae <_ZN74_$LT$$u5b$T$u5d$$u20$as$u20$core..slice..specialize..SpecFill$LT$T$GT$$GT$9spec_fill17h2be07a052633f0e5E+0x1e>
802010ae: a2 75        	ld	a1, 40(sp)
802010b0: 02 75        	ld	a0, 32(sp)
802010b2: 97 10 00 00  	auipc	ra, 1
802010b6: e7 80 20 f9  	jalr	-110(ra)
802010ba: 2a e4        	sd	a0, 8(sp)
802010bc: 2e e8        	sd	a1, 16(sp)
802010be: 09 a0        	j	0x802010c0 <_ZN74_$LT$$u5b$T$u5d$$u20$as$u20$core..slice..specialize..SpecFill$LT$T$GT$$GT$9spec_fill17h2be07a052633f0e5E+0x30>
802010c0: 42 65        	ld	a0, 16(sp)
802010c2: a2 65        	ld	a1, 8(sp)
802010c4: 2e f8        	sd	a1, 48(sp)
802010c6: 2a fc        	sd	a0, 56(sp)
802010c8: 09 a0        	j	0x802010ca <_ZN74_$LT$$u5b$T$u5d$$u20$as$u20$core..slice..specialize..SpecFill$LT$T$GT$$GT$9spec_fill17h2be07a052633f0e5E+0x3a>
802010ca: 08 18        	addi	a0, sp, 48
802010cc: 97 10 00 00  	auipc	ra, 1
802010d0: e7 80 60 1e  	jalr	486(ra)
802010d4: aa e0        	sd	a0, 64(sp)
802010d6: 09 a0        	j	0x802010d8 <_ZN74_$LT$$u5b$T$u5d$$u20$as$u20$core..slice..specialize..SpecFill$LT$T$GT$$GT$9spec_fill17h2be07a052633f0e5E+0x48>
802010d8: 06 65        	ld	a0, 64(sp)
802010da: b3 35 a0 00  	snez	a1, a0
802010de: 81 45        	mv	a1, zero
802010e0: 63 05 b5 00  	beq	a0, a1, 0x802010ea <_ZN74_$LT$$u5b$T$u5d$$u20$as$u20$core..slice..specialize..SpecFill$LT$T$GT$$GT$9spec_fill17h2be07a052633f0e5E+0x5a>
802010e4: 09 a0        	j	0x802010e6 <_ZN74_$LT$$u5b$T$u5d$$u20$as$u20$core..slice..specialize..SpecFill$LT$T$GT$$GT$9spec_fill17h2be07a052633f0e5E+0x56>
802010e6: 29 a0        	j	0x802010f0 <_ZN74_$LT$$u5b$T$u5d$$u20$as$u20$core..slice..specialize..SpecFill$LT$T$GT$$GT$9spec_fill17h2be07a052633f0e5E+0x60>
802010e8: 00 00        	unimp	
802010ea: a6 70        	ld	ra, 104(sp)
802010ec: 65 61        	addi	sp, sp, 112
802010ee: 82 80        	ret
802010f0: 62 65        	ld	a0, 24(sp)
802010f2: 86 65        	ld	a1, 64(sp)
802010f4: ae f0        	sd	a1, 96(sp)
802010f6: 23 80 a5 00  	sb	a0, 0(a1)
802010fa: c1 bf        	j	0x802010ca <_ZN74_$LT$$u5b$T$u5d$$u20$as$u20$core..slice..specialize..SpecFill$LT$T$GT$$GT$9spec_fill17h2be07a052633f0e5E+0x3a>

00000000802010fc <_ZN67_$LT$os..task..task..TaskStatus$u20$as$u20$core..cmp..PartialEq$GT$2eq17h81a1f1df81eff3a1E>:
802010fc: 79 71        	addi	sp, sp, -48
802010fe: 2a e8        	sd	a0, 16(sp)
80201100: 2e ec        	sd	a1, 24(sp)
80201102: 03 45 05 00  	lbu	a0, 0(a0)
80201106: 2a f0        	sd	a0, 32(sp)
80201108: 83 c5 05 00  	lbu	a1, 0(a1)
8020110c: 2e f4        	sd	a1, 40(sp)
8020110e: 63 07 b5 00  	beq	a0, a1, 0x8020111c <_ZN67_$LT$os..task..task..TaskStatus$u20$as$u20$core..cmp..PartialEq$GT$2eq17h81a1f1df81eff3a1E+0x20>
80201112: 09 a0        	j	0x80201114 <_ZN67_$LT$os..task..task..TaskStatus$u20$as$u20$core..cmp..PartialEq$GT$2eq17h81a1f1df81eff3a1E+0x18>
80201114: 01 45        	mv	a0, zero
80201116: a3 07 a1 00  	sb	a0, 15(sp)
8020111a: 29 a0        	j	0x80201124 <_ZN67_$LT$os..task..task..TaskStatus$u20$as$u20$core..cmp..PartialEq$GT$2eq17h81a1f1df81eff3a1E+0x28>
8020111c: 05 45        	addi	a0, zero, 1
8020111e: a3 07 a1 00  	sb	a0, 15(sp)
80201122: 09 a0        	j	0x80201124 <_ZN67_$LT$os..task..task..TaskStatus$u20$as$u20$core..cmp..PartialEq$GT$2eq17h81a1f1df81eff3a1E+0x28>
80201124: 03 45 f1 00  	lbu	a0, 15(sp)
80201128: 45 61        	addi	sp, sp, 48
8020112a: 82 80        	ret

000000008020112c <_ZN95_$LT$core..ops..control_flow..ControlFlow$LT$B$C$C$GT$$u20$as$u20$core..ops..try_trait..Try$GT$11from_output17hfef7d59769b2305cE>:
8020112c: 01 11        	addi	sp, sp, -32
8020112e: 01 45        	mv	a0, zero
80201130: 2a e4        	sd	a0, 8(sp)
80201132: c2 65        	ld	a1, 16(sp)
80201134: 05 61        	addi	sp, sp, 32
80201136: 82 80        	ret

0000000080201138 <_ZN95_$LT$core..ops..control_flow..ControlFlow$LT$B$C$C$GT$$u20$as$u20$core..ops..try_trait..Try$GT$6branch17h3ca84efa4feed16bE>:
80201138: 39 71        	addi	sp, sp, -64
8020113a: 2a e4        	sd	a0, 8(sp)
8020113c: 2e e8        	sd	a1, 16(sp)
8020113e: 81 45        	mv	a1, zero
80201140: 63 05 b5 00  	beq	a0, a1, 0x8020114a <_ZN95_$LT$core..ops..control_flow..ControlFlow$LT$B$C$C$GT$$u20$as$u20$core..ops..try_trait..Try$GT$6branch17h3ca84efa4feed16bE+0x12>
80201144: 09 a0        	j	0x80201146 <_ZN95_$LT$core..ops..control_flow..ControlFlow$LT$B$C$C$GT$$u20$as$u20$core..ops..try_trait..Try$GT$6branch17h3ca84efa4feed16bE+0xe>
80201146: 29 a0        	j	0x80201150 <_ZN95_$LT$core..ops..control_flow..ControlFlow$LT$B$C$C$GT$$u20$as$u20$core..ops..try_trait..Try$GT$6branch17h3ca84efa4feed16bE+0x18>
80201148: 00 00        	unimp	
8020114a: 01 45        	mv	a0, zero
8020114c: 2a ec        	sd	a0, 24(sp)
8020114e: 01 a8        	j	0x8020115e <_ZN95_$LT$core..ops..control_flow..ControlFlow$LT$B$C$C$GT$$u20$as$u20$core..ops..try_trait..Try$GT$6branch17h3ca84efa4feed16bE+0x26>
80201150: 42 65        	ld	a0, 16(sp)
80201152: 2a fc        	sd	a0, 56(sp)
80201154: 2a f4        	sd	a0, 40(sp)
80201156: 2a f0        	sd	a0, 32(sp)
80201158: 05 45        	addi	a0, zero, 1
8020115a: 2a ec        	sd	a0, 24(sp)
8020115c: 09 a0        	j	0x8020115e <_ZN95_$LT$core..ops..control_flow..ControlFlow$LT$B$C$C$GT$$u20$as$u20$core..ops..try_trait..Try$GT$6branch17h3ca84efa4feed16bE+0x26>
8020115e: 62 65        	ld	a0, 24(sp)
80201160: 82 75        	ld	a1, 32(sp)
80201162: 21 61        	addi	sp, sp, 64
80201164: 82 80        	ret

0000000080201166 <_ZN104_$LT$core..ops..control_flow..ControlFlow$LT$B$C$C$GT$$u20$as$u20$core..ops..try_trait..FromResidual$GT$13from_residual17h04c92765944418bbE>:
80201166: 01 11        	addi	sp, sp, -32
80201168: aa 85        	mv	a1, a0
8020116a: 2e e0        	sd	a1, 0(sp)
8020116c: 2e ec        	sd	a1, 24(sp)
8020116e: 2e e8        	sd	a1, 16(sp)
80201170: 05 45        	addi	a0, zero, 1
80201172: 2a e4        	sd	a0, 8(sp)
80201174: 05 61        	addi	sp, sp, 32
80201176: 82 80        	ret

0000000080201178 <_ZN4core3ops12control_flow24ControlFlow$LT$B$C$C$GT$11break_value17hf46e707ba73caa52E>:
80201178: 79 71        	addi	sp, sp, -48
8020117a: 2a e4        	sd	a0, 8(sp)
8020117c: 2e e8        	sd	a1, 16(sp)
8020117e: 81 45        	mv	a1, zero
80201180: 63 05 b5 00  	beq	a0, a1, 0x8020118a <_ZN4core3ops12control_flow24ControlFlow$LT$B$C$C$GT$11break_value17hf46e707ba73caa52E+0x12>
80201184: 09 a0        	j	0x80201186 <_ZN4core3ops12control_flow24ControlFlow$LT$B$C$C$GT$11break_value17hf46e707ba73caa52E+0xe>
80201186: 29 a0        	j	0x80201190 <_ZN4core3ops12control_flow24ControlFlow$LT$B$C$C$GT$11break_value17hf46e707ba73caa52E+0x18>
80201188: 00 00        	unimp	
8020118a: 01 45        	mv	a0, zero
8020118c: 2a ec        	sd	a0, 24(sp)
8020118e: 39 a0        	j	0x8020119c <_ZN4core3ops12control_flow24ControlFlow$LT$B$C$C$GT$11break_value17hf46e707ba73caa52E+0x24>
80201190: 42 65        	ld	a0, 16(sp)
80201192: 2a f4        	sd	a0, 40(sp)
80201194: 2a f0        	sd	a0, 32(sp)
80201196: 05 45        	addi	a0, zero, 1
80201198: 2a ec        	sd	a0, 24(sp)
8020119a: 09 a0        	j	0x8020119c <_ZN4core3ops12control_flow24ControlFlow$LT$B$C$C$GT$11break_value17hf46e707ba73caa52E+0x24>
8020119c: 22 65        	ld	a0, 8(sp)
8020119e: 81 45        	mv	a1, zero
802011a0: 63 07 b5 00  	beq	a0, a1, 0x802011ae <_ZN4core3ops12control_flow24ControlFlow$LT$B$C$C$GT$11break_value17hf46e707ba73caa52E+0x36>
802011a4: 09 a0        	j	0x802011a6 <_ZN4core3ops12control_flow24ControlFlow$LT$B$C$C$GT$11break_value17hf46e707ba73caa52E+0x2e>
802011a6: 62 65        	ld	a0, 24(sp)
802011a8: 82 75        	ld	a1, 32(sp)
802011aa: 45 61        	addi	sp, sp, 48
802011ac: 82 80        	ret
802011ae: e5 bf        	j	0x802011a6 <_ZN4core3ops12control_flow24ControlFlow$LT$B$C$C$GT$11break_value17hf46e707ba73caa52E+0x2e>

00000000802011b0 <_ZN5riscv8register4time4read17h0f6ed79352cfe56bE>:
802011b0: 41 11        	addi	sp, sp, -16
802011b2: 06 e4        	sd	ra, 8(sp)
802011b4: 97 00 00 00  	auipc	ra, 0
802011b8: e7 80 40 01  	jalr	20(ra)
802011bc: 2a e0        	sd	a0, 0(sp)
802011be: 09 a0        	j	0x802011c0 <_ZN5riscv8register4time4read17h0f6ed79352cfe56bE+0x10>
802011c0: 02 65        	ld	a0, 0(sp)
802011c2: a2 60        	ld	ra, 8(sp)
802011c4: 41 01        	addi	sp, sp, 16
802011c6: 82 80        	ret

00000000802011c8 <_ZN5riscv8register4time5_read17h7c7a1db8e0bceb61E>:
802011c8: 41 11        	addi	sp, sp, -16
802011ca: 73 25 10 c0  	rdtime	a0
802011ce: 2a e4        	sd	a0, 8(sp)
802011d0: 09 a0        	j	0x802011d2 <_ZN5riscv8register4time5_read17h7c7a1db8e0bceb61E+0xa>
802011d2: 22 65        	ld	a0, 8(sp)
802011d4: 41 01        	addi	sp, sp, 16
802011d6: 82 80        	ret

00000000802011d8 <_ZN4core4hint21unreachable_unchecked17h28bebc84128474f9E>:
802011d8: 00 00        	unimp	

00000000802011da <_ZN4core4hint9spin_loop17h8fbd309cce1c149fE>:
802011da: 41 11        	addi	sp, sp, -16
802011dc: 06 e4        	sd	ra, 8(sp)
802011de: 97 f0 ff ff  	auipc	ra, 1048575
802011e2: e7 80 20 1f  	jalr	498(ra)
802011e6: 09 a0        	j	0x802011e8 <_ZN4core4hint9spin_loop17h8fbd309cce1c149fE+0xe>
802011e8: a2 60        	ld	ra, 8(sp)
802011ea: 41 01        	addi	sp, sp, 16
802011ec: 82 80        	ret

00000000802011ee <_ZN4core3ops8function6FnOnce9call_once17h708073da5fdf95dcE>:
802011ee: 13 01 01 81  	addi	sp, sp, -2032
802011f2: 23 34 11 7e  	sd	ra, 2024(sp)
802011f6: 13 01 01 df  	addi	sp, sp, -528
802011fa: aa ec        	sd	a0, 88(sp)
802011fc: 97 10 00 00  	auipc	ra, 1
80201200: e7 80 a0 58  	jalr	1418(ra)
80201204: aa 85        	mv	a1, a0
80201206: ae f0        	sd	a1, 96(sp)
80201208: 85 65        	lui	a1, 1
8020120a: 9b 85 05 9e  	addiw	a1, a1, -1568
8020120e: 8a 95        	add	a1, a1, sp
80201210: 88 e1        	sd	a0, 0(a1)
80201212: a8 15        	addi	a0, sp, 744
80201214: aa f4        	sd	a0, 104(sp)
80201216: 97 00 00 00  	auipc	ra, 0
8020121a: e7 80 40 20  	jalr	516(ra)
8020121e: a6 75        	ld	a1, 104(sp)
80201220: 01 45        	mv	a0, zero
80201222: 23 00 a1 2e  	sb	a0, 736(sp)
80201226: 88 1c        	addi	a0, sp, 624
80201228: 13 06 00 07  	addi	a2, zero, 112
8020122c: 97 60 00 00  	auipc	ra, 6
80201230: e7 80 e0 87  	jalr	-1922(ra)
80201234: 08 09        	addi	a0, sp, 144
80201236: 8c 1c        	addi	a1, sp, 624
80201238: ae f8        	sd	a1, 112(sp)
8020123a: aa fc        	sd	a0, 120(sp)
8020123c: 09 a0        	j	0x8020123e <_ZN4core3ops8function6FnOnce9call_once17h708073da5fdf95dcE+0x50>
8020123e: c6 75        	ld	a1, 112(sp)
80201240: 66 75        	ld	a0, 120(sp)
80201242: aa e8        	sd	a0, 80(sp)
80201244: 63 00 b5 02  	beq	a0, a1, 0x80201264 <_ZN4core3ops8function6FnOnce9call_once17h708073da5fdf95dcE+0x76>
80201248: 09 a0        	j	0x8020124a <_ZN4core3ops8function6FnOnce9call_once17h708073da5fdf95dcE+0x5c>
8020124a: 46 65        	ld	a0, 80(sp)
8020124c: 8c 1c        	addi	a1, sp, 624
8020124e: 13 06 80 07  	addi	a2, zero, 120
80201252: 97 60 00 00  	auipc	ra, 6
80201256: e7 80 80 85  	jalr	-1960(ra)
8020125a: 46 65        	ld	a0, 80(sp)
8020125c: 13 05 85 07  	addi	a0, a0, 120
80201260: aa fc        	sd	a0, 120(sp)
80201262: f1 bf        	j	0x8020123e <_ZN4core3ops8function6FnOnce9call_once17h708073da5fdf95dcE+0x50>
80201264: 08 09        	addi	a0, sp, 144
80201266: 91 45        	addi	a1, zero, 4
80201268: 97 20 00 00  	auipc	ra, 2
8020126c: e7 80 00 09  	jalr	144(ra)
80201270: aa e0        	sd	a0, 64(sp)
80201272: 2e 86        	mv	a2, a1
80201274: 86 65        	ld	a1, 64(sp)
80201276: 88 1e        	addi	a0, sp, 880
80201278: aa e4        	sd	a0, 72(sp)
8020127a: 97 10 00 00  	auipc	ra, 1
8020127e: e7 80 e0 dd  	jalr	-546(ra)
80201282: a6 65        	ld	a1, 72(sp)
80201284: a8 0e        	addi	a0, sp, 856
80201286: 97 00 00 00  	auipc	ra, 0
8020128a: e7 80 c0 48  	jalr	1164(ra)
8020128e: 03 35 81 36  	ld	a0, 872(sp)
80201292: 23 3c a1 38  	sd	a0, 920(sp)
80201296: 03 35 01 36  	ld	a0, 864(sp)
8020129a: 23 38 a1 38  	sd	a0, 912(sp)
8020129e: 03 35 81 35  	ld	a0, 856(sp)
802012a2: 23 34 a1 38  	sd	a0, 904(sp)
802012a6: 09 a0        	j	0x802012a8 <_ZN4core3ops8function6FnOnce9call_once17h708073da5fdf95dcE+0xba>
802012a8: 28 07        	addi	a0, sp, 904
802012aa: 97 00 00 00  	auipc	ra, 0
802012ae: e7 80 c0 3c  	jalr	972(ra)
802012b2: 23 34 b1 3a  	sd	a1, 936(sp)
802012b6: 23 30 a1 3a  	sd	a0, 928(sp)
802012ba: 33 35 b0 00  	snez	a0, a1
802012be: 01 45        	mv	a0, zero
802012c0: 63 8e a5 04  	beq	a1, a0, 0x8020131c <_ZN4core3ops8function6FnOnce9call_once17h708073da5fdf95dcE+0x12e>
802012c4: 09 a0        	j	0x802012c6 <_ZN4core3ops8function6FnOnce9call_once17h708073da5fdf95dcE+0xd8>
802012c6: 11 a0        	j	0x802012ca <_ZN4core3ops8function6FnOnce9call_once17h708073da5fdf95dcE+0xdc>
802012c8: 00 00        	unimp	
802012ca: 03 35 01 3a  	ld	a0, 928(sp)
802012ce: 85 65        	lui	a1, 1
802012d0: 9b 85 85 9e  	addiw	a1, a1, -1560
802012d4: 8a 95        	add	a1, a1, sp
802012d6: 88 e1        	sd	a0, 0(a1)
802012d8: 83 35 81 3a  	ld	a1, 936(sp)
802012dc: 2e fc        	sd	a1, 56(sp)
802012de: 05 66        	lui	a2, 1
802012e0: 1b 06 06 9f  	addiw	a2, a2, -1552
802012e4: 0a 96        	add	a2, a2, sp
802012e6: 0c e2        	sd	a1, 0(a2)
802012e8: 97 10 00 00  	auipc	ra, 1
802012ec: e7 80 a0 6f  	jalr	1786(ra)
802012f0: aa 85        	mv	a1, a0
802012f2: 08 1f        	addi	a0, sp, 944
802012f4: 2a f8        	sd	a0, 48(sp)
802012f6: 97 00 00 00  	auipc	ra, 0
802012fa: e7 80 c0 15  	jalr	348(ra)
802012fe: c2 75        	ld	a1, 48(sp)
80201300: 62 75        	ld	a0, 56(sp)
80201302: 13 06 00 07  	addi	a2, zero, 112
80201306: 97 50 00 00  	auipc	ra, 5
8020130a: e7 80 40 7a  	jalr	1956(ra)
8020130e: e2 75        	ld	a1, 56(sp)
80201310: 05 45        	addi	a0, zero, 1
80201312: a3 03 a1 42  	sb	a0, 1063(sp)
80201316: 23 88 a5 06  	sb	a0, 112(a1)
8020131a: 79 b7        	j	0x802012a8 <_ZN4core3ops8function6FnOnce9call_once17h708073da5fdf95dcE+0xba>
8020131c: 05 65        	lui	a0, 1
8020131e: 1b 05 05 80  	addiw	a0, a0, -2048
80201322: 0a 95        	add	a0, a0, sp
80201324: 2a e8        	sd	a0, 16(sp)
80201326: 0c 09        	addi	a1, sp, 144
80201328: 13 06 00 1e  	addi	a2, zero, 480
8020132c: 32 ec        	sd	a2, 24(sp)
8020132e: 97 50 00 00  	auipc	ra, 5
80201332: e7 80 c0 77  	jalr	1916(ra)
80201336: c2 65        	ld	a1, 16(sp)
80201338: 62 66        	ld	a2, 24(sp)
8020133a: 13 05 81 61  	addi	a0, sp, 1560
8020133e: 2a f0        	sd	a0, 32(sp)
80201340: 97 50 00 00  	auipc	ra, 5
80201344: e7 80 a0 76  	jalr	1898(ra)
80201348: 82 75        	ld	a1, 32(sp)
8020134a: 01 45        	mv	a0, zero
8020134c: 23 3c a1 7e  	sd	a0, 2040(sp)
80201350: 13 05 81 42  	addi	a0, sp, 1064
80201354: 2a f4        	sd	a0, 40(sp)
80201356: 97 f0 ff ff  	auipc	ra, 1048575
8020135a: e7 80 00 d1  	jalr	-752(ra)
8020135e: 06 76        	ld	a2, 96(sp)
80201360: 66 65        	ld	a0, 88(sp)
80201362: a2 75        	ld	a1, 40(sp)
80201364: 10 e1        	sd	a2, 0(a0)
80201366: 21 05        	addi	a0, a0, 8
80201368: 13 06 00 1f  	addi	a2, zero, 496
8020136c: 97 50 00 00  	auipc	ra, 5
80201370: e7 80 e0 73  	jalr	1854(ra)
80201374: 09 a0        	j	0x80201376 <_ZN4core3ops8function6FnOnce9call_once17h708073da5fdf95dcE+0x188>
80201376: 13 01 01 21  	addi	sp, sp, 528
8020137a: 83 30 81 7e  	ld	ra, 2024(sp)
8020137e: 13 01 01 7f  	addi	sp, sp, 2032
80201382: 82 80        	ret

0000000080201384 <_ZN4core3ptr37drop_in_place$LT$core..fmt..Error$GT$17h215d28e7aa4875fcE>:
80201384: 41 11        	addi	sp, sp, -16
80201386: 2a e4        	sd	a0, 8(sp)
80201388: 41 01        	addi	sp, sp, 16
8020138a: 82 80        	ret

000000008020138c <_ZN4core3ptr39drop_in_place$LT$spin..once..Finish$GT$17hf58ad8e15c167360E>:
8020138c: 41 11        	addi	sp, sp, -16
8020138e: 06 e4        	sd	ra, 8(sp)
80201390: 2a e0        	sd	a0, 0(sp)
80201392: 97 30 00 00  	auipc	ra, 3
80201396: e7 80 a0 34  	jalr	842(ra)
8020139a: 09 a0        	j	0x8020139c <_ZN4core3ptr39drop_in_place$LT$spin..once..Finish$GT$17hf58ad8e15c167360E+0x10>
8020139c: a2 60        	ld	ra, 8(sp)
8020139e: 41 01        	addi	sp, sp, 16
802013a0: 82 80        	ret

00000000802013a2 <_ZN4core3ptr45drop_in_place$LT$core..cell..BorrowRefMut$GT$17h0213cdce8c1ac421E>:
802013a2: 41 11        	addi	sp, sp, -16
802013a4: 06 e4        	sd	ra, 8(sp)
802013a6: 2a e0        	sd	a0, 0(sp)
802013a8: 97 00 00 00  	auipc	ra, 0
802013ac: e7 80 00 04  	jalr	64(ra)
802013b0: 09 a0        	j	0x802013b2 <_ZN4core3ptr45drop_in_place$LT$core..cell..BorrowRefMut$GT$17h0213cdce8c1ac421E+0x10>
802013b2: a2 60        	ld	ra, 8(sp)
802013b4: 41 01        	addi	sp, sp, 16
802013b6: 82 80        	ret

00000000802013b8 <_ZN4core3ptr47drop_in_place$LT$core..cell..BorrowMutError$GT$17hdbd55520593f6cb7E>:
802013b8: 41 11        	addi	sp, sp, -16
802013ba: 2a e4        	sd	a0, 8(sp)
802013bc: 41 01        	addi	sp, sp, 16
802013be: 82 80        	ret

00000000802013c0 <_ZN4core3ptr48drop_in_place$LT$core..str..error..Utf8Error$GT$17h9eccffe97c52af1bE>:
802013c0: 41 11        	addi	sp, sp, -16
802013c2: 2a e4        	sd	a0, 8(sp)
802013c4: 41 01        	addi	sp, sp, 16
802013c6: 82 80        	ret

00000000802013c8 <_ZN4core3ptr52drop_in_place$LT$$RF$mut$u20$os..console..Stdout$GT$17haa76ddfe7fd478e4E>:
802013c8: 41 11        	addi	sp, sp, -16
802013ca: 2a e4        	sd	a0, 8(sp)
802013cc: 41 01        	addi	sp, sp, 16
802013ce: 82 80        	ret

00000000802013d0 <_ZN4core3ptr73drop_in_place$LT$core..cell..RefMut$LT$os..task..TaskManagerInner$GT$$GT$17hfc4294927470dc09E>:
802013d0: 41 11        	addi	sp, sp, -16
802013d2: 06 e4        	sd	ra, 8(sp)
802013d4: 2a e0        	sd	a0, 0(sp)
802013d6: 21 05        	addi	a0, a0, 8
802013d8: 97 00 00 00  	auipc	ra, 0
802013dc: e7 80 a0 fc  	jalr	-54(ra)
802013e0: 09 a0        	j	0x802013e2 <_ZN4core3ptr73drop_in_place$LT$core..cell..RefMut$LT$os..task..TaskManagerInner$GT$$GT$17hfc4294927470dc09E+0x12>
802013e2: a2 60        	ld	ra, 8(sp)
802013e4: 41 01        	addi	sp, sp, 16
802013e6: 82 80        	ret

00000000802013e8 <_ZN66_$LT$core..cell..BorrowRefMut$u20$as$u20$core..ops..drop..Drop$GT$4drop17h9c92210e3b48cbffE>:
802013e8: 79 71        	addi	sp, sp, -48
802013ea: 06 f4        	sd	ra, 40(sp)
802013ec: 2a e4        	sd	a0, 8(sp)
802013ee: 2a ec        	sd	a0, 24(sp)
802013f0: 08 61        	ld	a0, 0(a0)
802013f2: 97 f0 ff ff  	auipc	ra, 1048575
802013f6: e7 80 20 d4  	jalr	-702(ra)
802013fa: aa 85        	mv	a1, a0
802013fc: 2e e8        	sd	a1, 16(sp)
802013fe: 2a f0        	sd	a0, 32(sp)
80201400: 09 a0        	j	0x80201402 <_ZN66_$LT$core..cell..BorrowRefMut$u20$as$u20$core..ops..drop..Drop$GT$4drop17h9c92210e3b48cbffE+0x1a>
80201402: c2 65        	ld	a1, 16(sp)
80201404: 22 65        	ld	a0, 8(sp)
80201406: 08 61        	ld	a0, 0(a0)
80201408: 85 05        	addi	a1, a1, 1
8020140a: 97 f0 ff ff  	auipc	ra, 1048575
8020140e: e7 80 80 cd  	jalr	-808(ra)
80201412: 09 a0        	j	0x80201414 <_ZN66_$LT$core..cell..BorrowRefMut$u20$as$u20$core..ops..drop..Drop$GT$4drop17h9c92210e3b48cbffE+0x2c>
80201414: a2 70        	ld	ra, 40(sp)
80201416: 45 61        	addi	sp, sp, 48
80201418: 82 80        	ret

000000008020141a <_ZN2os4task7context11TaskContext9zero_init17h6fcc8d98fec90166E>:
8020141a: 75 71        	addi	sp, sp, -144
8020141c: 06 e5        	sd	ra, 136(sp)
8020141e: 2a f0        	sd	a0, 32(sp)
80201420: 28 10        	addi	a0, sp, 40
80201422: 2a e8        	sd	a0, 16(sp)
80201424: 81 45        	mv	a1, zero
80201426: 2e e4        	sd	a1, 8(sp)
80201428: 13 06 00 06  	addi	a2, zero, 96
8020142c: 32 ec        	sd	a2, 24(sp)
8020142e: 97 50 00 00  	auipc	ra, 5
80201432: e7 80 20 73  	jalr	1842(ra)
80201436: a2 66        	ld	a3, 8(sp)
80201438: c2 65        	ld	a1, 16(sp)
8020143a: 62 66        	ld	a2, 24(sp)
8020143c: 02 75        	ld	a0, 32(sp)
8020143e: 14 e1        	sd	a3, 0(a0)
80201440: 14 e5        	sd	a3, 8(a0)
80201442: 41 05        	addi	a0, a0, 16
80201444: 97 50 00 00  	auipc	ra, 5
80201448: e7 80 60 66  	jalr	1638(ra)
8020144c: aa 60        	ld	ra, 136(sp)
8020144e: 49 61        	addi	sp, sp, 144
80201450: 82 80        	ret

0000000080201452 <_ZN2os4task7context11TaskContext12goto_restore17h42d36e7fd0f56794E>:
80201452: 75 71        	addi	sp, sp, -144
80201454: 06 e5        	sd	ra, 136(sp)
80201456: 2e e0        	sd	a1, 0(sp)
80201458: 2a ec        	sd	a0, 24(sp)
8020145a: 2e e1        	sd	a1, 128(sp)
8020145c: 08 10        	addi	a0, sp, 32
8020145e: 2a e4        	sd	a0, 8(sp)
80201460: 81 45        	mv	a1, zero
80201462: 13 06 00 06  	addi	a2, zero, 96
80201466: 32 e8        	sd	a2, 16(sp)
80201468: 97 50 00 00  	auipc	ra, 5
8020146c: e7 80 80 6f  	jalr	1784(ra)
80201470: 82 66        	ld	a3, 0(sp)
80201472: a2 65        	ld	a1, 8(sp)
80201474: 42 66        	ld	a2, 16(sp)
80201476: 62 65        	ld	a0, 24(sp)

0000000080201478 <.LBB1_1>:
80201478: 17 27 00 00  	auipc	a4, 2
8020147c: 13 07 c7 30  	addi	a4, a4, 780
80201480: 18 e1        	sd	a4, 0(a0)
80201482: 14 e5        	sd	a3, 8(a0)
80201484: 41 05        	addi	a0, a0, 16
80201486: 97 50 00 00  	auipc	ra, 5
8020148a: e7 80 40 62  	jalr	1572(ra)
8020148e: aa 60        	ld	ra, 136(sp)
80201490: 49 61        	addi	sp, sp, 144
80201492: 82 80        	ret

0000000080201494 <_ZN5riscv8register6scause6Scause5cause17haf2558d390133d8dE>:
80201494: 5d 71        	addi	sp, sp, -80
80201496: 86 e4        	sd	ra, 72(sp)
80201498: 2a f4        	sd	a0, 40(sp)
8020149a: aa e0        	sd	a0, 64(sp)
8020149c: 97 00 00 00  	auipc	ra, 0
802014a0: e7 80 00 08  	jalr	128(ra)
802014a4: 2a f8        	sd	a0, 48(sp)
802014a6: 09 a0        	j	0x802014a8 <_ZN5riscv8register6scause6Scause5cause17haf2558d390133d8dE+0x14>
802014a8: 42 75        	ld	a0, 48(sp)
802014aa: 81 45        	mv	a1, zero
802014ac: 63 1a b5 00  	bne	a0, a1, 0x802014c0 <_ZN5riscv8register6scause6Scause5cause17haf2558d390133d8dE+0x2c>
802014b0: 09 a0        	j	0x802014b2 <_ZN5riscv8register6scause6Scause5cause17haf2558d390133d8dE+0x1e>
802014b2: 22 75        	ld	a0, 40(sp)
802014b4: 97 30 00 00  	auipc	ra, 3
802014b8: e7 80 80 99  	jalr	-1640(ra)
802014bc: 2a f0        	sd	a0, 32(sp)
802014be: 3d a8        	j	0x802014fc <_ZN5riscv8register6scause6Scause5cause17haf2558d390133d8dE+0x68>
802014c0: 22 75        	ld	a0, 40(sp)
802014c2: 97 30 00 00  	auipc	ra, 3
802014c6: e7 80 a0 98  	jalr	-1654(ra)
802014ca: 2a ec        	sd	a0, 24(sp)
802014cc: 09 a0        	j	0x802014ce <_ZN5riscv8register6scause6Scause5cause17haf2558d390133d8dE+0x3a>
802014ce: 62 65        	ld	a0, 24(sp)
802014d0: 97 30 00 00  	auipc	ra, 3
802014d4: e7 80 00 85  	jalr	-1968(ra)
802014d8: 13 75 f5 0f  	andi	a0, a0, 255
802014dc: 2a e8        	sd	a0, 16(sp)
802014de: 09 a0        	j	0x802014e0 <_ZN5riscv8register6scause6Scause5cause17haf2558d390133d8dE+0x4c>
802014e0: 42 65        	ld	a0, 16(sp)
802014e2: a3 0c a1 02  	sb	a0, 57(sp)
802014e6: 01 45        	mv	a0, zero
802014e8: 23 0c a1 02  	sb	a0, 56(sp)
802014ec: 09 a0        	j	0x802014ee <_ZN5riscv8register6scause6Scause5cause17haf2558d390133d8dE+0x5a>
802014ee: 03 45 81 03  	lbu	a0, 56(sp)
802014f2: 83 05 91 03  	lb	a1, 57(sp)
802014f6: a6 60        	ld	ra, 72(sp)
802014f8: 61 61        	addi	sp, sp, 80
802014fa: 82 80        	ret
802014fc: 02 75        	ld	a0, 32(sp)
802014fe: 97 30 00 00  	auipc	ra, 3
80201502: e7 80 c0 89  	jalr	-1892(ra)
80201506: 13 75 f5 0f  	andi	a0, a0, 255
8020150a: 2a e4        	sd	a0, 8(sp)
8020150c: 09 a0        	j	0x8020150e <_ZN5riscv8register6scause6Scause5cause17haf2558d390133d8dE+0x7a>
8020150e: 22 65        	ld	a0, 8(sp)
80201510: a3 0c a1 02  	sb	a0, 57(sp)
80201514: 05 45        	addi	a0, zero, 1
80201516: 23 0c a1 02  	sb	a0, 56(sp)
8020151a: d1 bf        	j	0x802014ee <_ZN5riscv8register6scause6Scause5cause17haf2558d390133d8dE+0x5a>

000000008020151c <_ZN5riscv8register6scause6Scause12is_interrupt17h68897610cdd8dc0aE>:
8020151c: 79 71        	addi	sp, sp, -48
8020151e: 06 f4        	sd	ra, 40(sp)
80201520: 2a ec        	sd	a0, 24(sp)
80201522: 2a f0        	sd	a0, 32(sp)
80201524: 09 a0        	j	0x80201526 <_ZN5riscv8register6scause6Scause12is_interrupt17h68897610cdd8dc0aE+0xa>
80201526: 13 05 00 04  	addi	a0, zero, 64
8020152a: 2a e8        	sd	a0, 16(sp)
8020152c: 01 45        	mv	a0, zero
8020152e: 63 1a a5 00  	bne	a0, a0, 0x80201542 <.LBB1_7>
80201532: 09 a0        	j	0x80201534 <_ZN5riscv8register6scause6Scause12is_interrupt17h68897610cdd8dc0aE+0x18>
80201534: 42 65        	ld	a0, 16(sp)
80201536: 93 05 f5 ff  	addi	a1, a0, -1
8020153a: 2e e4        	sd	a1, 8(sp)
8020153c: 63 6a b5 02  	bltu	a0, a1, 0x80201570 <.LBB1_9>
80201540: 05 a0        	j	0x80201560 <.LBB1_8+0x16>

0000000080201542 <.LBB1_7>:
80201542: 17 65 00 00  	auipc	a0, 6
80201546: 13 05 e5 25  	addi	a0, a0, 606

000000008020154a <.LBB1_8>:
8020154a: 17 66 00 00  	auipc	a2, 6
8020154e: 13 06 66 23  	addi	a2, a2, 566
80201552: 93 05 10 02  	addi	a1, zero, 33
80201556: 97 30 00 00  	auipc	ra, 3
8020155a: e7 80 60 65  	jalr	1622(ra)
8020155e: 00 00        	unimp	
80201560: a2 65        	ld	a1, 8(sp)
80201562: 62 65        	ld	a0, 24(sp)
80201564: 97 20 00 00  	auipc	ra, 2
80201568: e7 80 c0 83  	jalr	-1988(ra)
8020156c: 2a e0        	sd	a0, 0(sp)
8020156e: 05 a0        	j	0x8020158e <.LBB1_10+0x16>

0000000080201570 <.LBB1_9>:
80201570: 17 65 00 00  	auipc	a0, 6
80201574: 13 05 05 26  	addi	a0, a0, 608

0000000080201578 <.LBB1_10>:
80201578: 17 66 00 00  	auipc	a2, 6
8020157c: 13 06 86 20  	addi	a2, a2, 520
80201580: 93 05 10 02  	addi	a1, zero, 33
80201584: 97 30 00 00  	auipc	ra, 3
80201588: e7 80 80 62  	jalr	1576(ra)
8020158c: 00 00        	unimp	
8020158e: 02 65        	ld	a0, 0(sp)
80201590: a2 70        	ld	ra, 40(sp)
80201592: 45 61        	addi	sp, sp, 48
80201594: 82 80        	ret

0000000080201596 <_ZN5riscv8register6scause4read17hd2bbb7fcc7f6a3d6E>:
80201596: 01 11        	addi	sp, sp, -32
80201598: 06 ec        	sd	ra, 24(sp)
8020159a: 97 00 00 00  	auipc	ra, 0
8020159e: e7 80 60 01  	jalr	22(ra)
802015a2: 2a e4        	sd	a0, 8(sp)
802015a4: 09 a0        	j	0x802015a6 <_ZN5riscv8register6scause4read17hd2bbb7fcc7f6a3d6E+0x10>
802015a6: 22 65        	ld	a0, 8(sp)
802015a8: 2a e8        	sd	a0, 16(sp)
802015aa: e2 60        	ld	ra, 24(sp)
802015ac: 05 61        	addi	sp, sp, 32
802015ae: 82 80        	ret

00000000802015b0 <_ZN5riscv8register6scause5_read17h17cd7e9dbc1fbee1E>:
802015b0: 41 11        	addi	sp, sp, -16
802015b2: 73 25 20 14  	csrr	a0, scause
802015b6: 2a e4        	sd	a0, 8(sp)
802015b8: 09 a0        	j	0x802015ba <_ZN5riscv8register6scause5_read17h17cd7e9dbc1fbee1E+0xa>
802015ba: 22 65        	ld	a0, 8(sp)
802015bc: 41 01        	addi	sp, sp, 16
802015be: 82 80        	ret

00000000802015c0 <_ZN2os3sbi8sbi_call17h261e8ebfd1834741E>:
802015c0: 39 71        	addi	sp, sp, -64
802015c2: 36 e0        	sd	a3, 0(sp)
802015c4: b2 86        	mv	a3, a2
802015c6: 02 66        	ld	a2, 0(sp)
802015c8: 36 e4        	sd	a3, 8(sp)
802015ca: ae 86        	mv	a3, a1
802015cc: a2 65        	ld	a1, 8(sp)
802015ce: 36 e8        	sd	a3, 16(sp)
802015d0: aa 88        	mv	a7, a0
802015d2: 42 65        	ld	a0, 16(sp)
802015d4: 46 f0        	sd	a7, 32(sp)
802015d6: 2a f4        	sd	a0, 40(sp)
802015d8: 2e f8        	sd	a1, 48(sp)
802015da: 32 fc        	sd	a2, 56(sp)
802015dc: 73 00 00 00  	ecall	
802015e0: 2a ce        	sw	a0, 28(sp)
802015e2: 09 a0        	j	0x802015e4 <_ZN2os3sbi8sbi_call17h261e8ebfd1834741E+0x24>
802015e4: 72 45        	lw	a0, 28(sp)
802015e6: 21 61        	addi	sp, sp, 64
802015e8: 82 80        	ret

00000000802015ea <_ZN2os3sbi9set_timer17h61f0a4f97366f7a8E>:
802015ea: 41 11        	addi	sp, sp, -16
802015ec: 06 e4        	sd	ra, 8(sp)
802015ee: aa 85        	mv	a1, a0
802015f0: 2e e0        	sd	a1, 0(sp)
802015f2: 81 46        	mv	a3, zero
802015f4: 36 85        	mv	a0, a3
802015f6: 36 86        	mv	a2, a3
802015f8: 97 00 00 00  	auipc	ra, 0
802015fc: e7 80 80 fc  	jalr	-56(ra)
80201600: 09 a0        	j	0x80201602 <_ZN2os3sbi9set_timer17h61f0a4f97366f7a8E+0x18>
80201602: a2 60        	ld	ra, 8(sp)
80201604: 41 01        	addi	sp, sp, 16
80201606: 82 80        	ret

0000000080201608 <_ZN2os3sbi15console_putchar17h206b36cf89d52ecfE>:
80201608: 41 11        	addi	sp, sp, -16
8020160a: 06 e4        	sd	ra, 8(sp)
8020160c: a3 03 a1 00  	sb	a0, 7(sp)
80201610: 93 75 f5 0f  	andi	a1, a0, 255
80201614: 05 45        	addi	a0, zero, 1
80201616: 81 46        	mv	a3, zero
80201618: 36 86        	mv	a2, a3
8020161a: 97 00 00 00  	auipc	ra, 0
8020161e: e7 80 60 fa  	jalr	-90(ra)
80201622: 09 a0        	j	0x80201624 <_ZN2os3sbi15console_putchar17h206b36cf89d52ecfE+0x1c>
80201624: a2 60        	ld	ra, 8(sp)
80201626: 41 01        	addi	sp, sp, 16
80201628: 82 80        	ret

000000008020162a <_ZN2os3sbi8shutdown17h94397c9fa2b2ca81E>:
8020162a: 41 11        	addi	sp, sp, -16
8020162c: 06 e4        	sd	ra, 8(sp)
8020162e: 21 45        	addi	a0, zero, 8
80201630: 81 46        	mv	a3, zero
80201632: b6 85        	mv	a1, a3
80201634: 36 86        	mv	a2, a3
80201636: 97 00 00 00  	auipc	ra, 0
8020163a: e7 80 a0 f8  	jalr	-118(ra)
8020163e: 09 a0        	j	0x80201640 <.LBB3_2>

0000000080201640 <.LBB3_2>:
80201640: 17 65 00 00  	auipc	a0, 6
80201644: 13 05 15 1b  	addi	a0, a0, 433

0000000080201648 <.LBB3_3>:
80201648: 17 66 00 00  	auipc	a2, 6
8020164c: 13 06 06 1e  	addi	a2, a2, 480
80201650: 93 05 80 02  	addi	a1, zero, 40
80201654: 97 30 00 00  	auipc	ra, 3
80201658: e7 80 80 55  	jalr	1368(ra)
8020165c: 00 00        	unimp	

000000008020165e <_ZN4core4iter8adapters9enumerate18Enumerate$LT$I$GT$3new17hfdcb6ea4abad0627E>:
8020165e: 01 11        	addi	sp, sp, -32
80201660: 2e e4        	sd	a1, 8(sp)
80201662: aa 85        	mv	a1, a0
80201664: 22 65        	ld	a0, 8(sp)
80201666: 2a e8        	sd	a0, 16(sp)
80201668: 32 ec        	sd	a2, 24(sp)
8020166a: 88 e1        	sd	a0, 0(a1)
8020166c: 90 e5        	sd	a2, 8(a1)
8020166e: 01 45        	mv	a0, zero
80201670: 88 e9        	sd	a0, 16(a1)
80201672: 05 61        	addi	sp, sp, 32
80201674: 82 80        	ret

0000000080201676 <_ZN110_$LT$core..iter..adapters..enumerate..Enumerate$LT$I$GT$$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4next17h31fc193dbd034fb9E>:
80201676: 19 71        	addi	sp, sp, -128
80201678: 86 fc        	sd	ra, 120(sp)
8020167a: 2a ec        	sd	a0, 24(sp)
8020167c: aa e8        	sd	a0, 80(sp)
8020167e: 97 10 00 00  	auipc	ra, 1
80201682: e7 80 e0 ce  	jalr	-786(ra)
80201686: 2a f0        	sd	a0, 32(sp)
80201688: 09 a0        	j	0x8020168a <_ZN110_$LT$core..iter..adapters..enumerate..Enumerate$LT$I$GT$$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4next17h31fc193dbd034fb9E+0x14>
8020168a: 02 75        	ld	a0, 32(sp)
8020168c: 97 10 00 00  	auipc	ra, 1
80201690: e7 80 40 6d  	jalr	1748(ra)
80201694: 2a fc        	sd	a0, 56(sp)
80201696: 09 a0        	j	0x80201698 <_ZN110_$LT$core..iter..adapters..enumerate..Enumerate$LT$I$GT$$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4next17h31fc193dbd034fb9E+0x22>
80201698: 62 75        	ld	a0, 56(sp)
8020169a: 93 35 15 00  	seqz	a1, a0
8020169e: 81 45        	mv	a1, zero
802016a0: 63 15 b5 00  	bne	a0, a1, 0x802016aa <_ZN110_$LT$core..iter..adapters..enumerate..Enumerate$LT$I$GT$$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4next17h31fc193dbd034fb9E+0x34>
802016a4: 09 a0        	j	0x802016a6 <_ZN110_$LT$core..iter..adapters..enumerate..Enumerate$LT$I$GT$$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4next17h31fc193dbd034fb9E+0x30>
802016a6: 0d a0        	j	0x802016c8 <_ZN110_$LT$core..iter..adapters..enumerate..Enumerate$LT$I$GT$$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4next17h31fc193dbd034fb9E+0x52>
802016a8: 00 00        	unimp	
802016aa: 62 65        	ld	a0, 24(sp)
802016ac: e2 75        	ld	a1, 56(sp)
802016ae: 2e e0        	sd	a1, 0(sp)
802016b0: ae f0        	sd	a1, 96(sp)
802016b2: ae f4        	sd	a1, 104(sp)
802016b4: 0c 69        	ld	a1, 16(a0)
802016b6: 2e e4        	sd	a1, 8(sp)
802016b8: ae f8        	sd	a1, 112(sp)
802016ba: 0c 69        	ld	a1, 16(a0)
802016bc: 13 85 15 00  	addi	a0, a1, 1
802016c0: 2a e8        	sd	a0, 16(sp)
802016c2: 63 6a b5 02  	bltu	a0, a1, 0x802016f6 <.LBB1_11>
802016c6: 31 a8        	j	0x802016e2 <_ZN110_$LT$core..iter..adapters..enumerate..Enumerate$LT$I$GT$$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4next17h31fc193dbd034fb9E+0x6c>
802016c8: 97 10 00 00  	auipc	ra, 1
802016cc: e7 80 00 6c  	jalr	1728(ra)
802016d0: 2a f4        	sd	a0, 40(sp)
802016d2: 2e f8        	sd	a1, 48(sp)
802016d4: 09 a0        	j	0x802016d6 <_ZN110_$LT$core..iter..adapters..enumerate..Enumerate$LT$I$GT$$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4next17h31fc193dbd034fb9E+0x60>
802016d6: 09 a0        	j	0x802016d8 <_ZN110_$LT$core..iter..adapters..enumerate..Enumerate$LT$I$GT$$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4next17h31fc193dbd034fb9E+0x62>
802016d8: 22 75        	ld	a0, 40(sp)
802016da: c2 75        	ld	a1, 48(sp)
802016dc: e6 70        	ld	ra, 120(sp)
802016de: 09 61        	addi	sp, sp, 128
802016e0: 82 80        	ret
802016e2: 02 65        	ld	a0, 0(sp)
802016e4: a2 65        	ld	a1, 8(sp)
802016e6: 42 66        	ld	a2, 16(sp)
802016e8: e2 66        	ld	a3, 24(sp)
802016ea: 90 ea        	sd	a2, 16(a3)
802016ec: ae e0        	sd	a1, 64(sp)
802016ee: aa e4        	sd	a0, 72(sp)
802016f0: 2e f4        	sd	a1, 40(sp)
802016f2: 2a f8        	sd	a0, 48(sp)
802016f4: d5 b7        	j	0x802016d8 <_ZN110_$LT$core..iter..adapters..enumerate..Enumerate$LT$I$GT$$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4next17h31fc193dbd034fb9E+0x62>

00000000802016f6 <.LBB1_11>:
802016f6: 17 65 00 00  	auipc	a0, 6
802016fa: 13 05 a5 1c  	addi	a0, a0, 458

00000000802016fe <.LBB1_12>:
802016fe: 17 66 00 00  	auipc	a2, 6
80201702: 13 06 26 1a  	addi	a2, a2, 418
80201706: f1 45        	addi	a1, zero, 28
80201708: 97 30 00 00  	auipc	ra, 3
8020170c: e7 80 40 4a  	jalr	1188(ra)
80201710: 00 00        	unimp	

0000000080201712 <_ZN63_$LT$I$u20$as$u20$core..iter..traits..collect..IntoIterator$GT$9into_iter17h496dada55bd01099E>:
80201712: 41 11        	addi	sp, sp, -16
80201714: 2e e4        	sd	a1, 8(sp)
80201716: aa 85        	mv	a1, a0
80201718: 22 65        	ld	a0, 8(sp)
8020171a: 10 69        	ld	a2, 16(a0)
8020171c: 90 e9        	sd	a2, 16(a1)
8020171e: 10 65        	ld	a2, 8(a0)
80201720: 90 e5        	sd	a2, 8(a1)
80201722: 08 61        	ld	a0, 0(a0)
80201724: 88 e1        	sd	a0, 0(a1)
80201726: 41 01        	addi	sp, sp, 16
80201728: 82 80        	ret

000000008020172a <_ZN4core3ptr9const_ptr33_$LT$impl$u20$$BP$const$u20$T$GT$7is_null17h8cf664e80f990733E>:
8020172a: 01 11        	addi	sp, sp, -32
8020172c: 06 ec        	sd	ra, 24(sp)
8020172e: 2a e4        	sd	a0, 8(sp)
80201730: 2a e8        	sd	a0, 16(sp)
80201732: 09 a0        	j	0x80201734 <_ZN4core3ptr9const_ptr33_$LT$impl$u20$$BP$const$u20$T$GT$7is_null17h8cf664e80f990733E+0xa>
80201734: 22 65        	ld	a0, 8(sp)
80201736: 81 45        	mv	a1, zero
80201738: 97 30 00 00  	auipc	ra, 3
8020173c: e7 80 20 d5  	jalr	-686(ra)
80201740: 2a e0        	sd	a0, 0(sp)
80201742: 09 a0        	j	0x80201744 <_ZN4core3ptr9const_ptr33_$LT$impl$u20$$BP$const$u20$T$GT$7is_null17h8cf664e80f990733E+0x1a>
80201744: 02 65        	ld	a0, 0(sp)
80201746: e2 60        	ld	ra, 24(sp)
80201748: 05 61        	addi	sp, sp, 32
8020174a: 82 80        	ret

000000008020174c <_ZN4core3ptr9const_ptr33_$LT$impl$u20$$BP$const$u20$T$GT$4cast17hf0c830466e30b00bE>:
8020174c: 41 11        	addi	sp, sp, -16
8020174e: 2a e4        	sd	a0, 8(sp)
80201750: 41 01        	addi	sp, sp, 16
80201752: 82 80        	ret

0000000080201754 <_ZN4core3ptr9const_ptr33_$LT$impl$u20$$BP$const$u20$T$GT$13read_volatile17h93a2f2f218844383E>:
80201754: 01 11        	addi	sp, sp, -32
80201756: 06 ec        	sd	ra, 24(sp)
80201758: 2a e8        	sd	a0, 16(sp)
8020175a: 97 20 00 00  	auipc	ra, 2
8020175e: e7 80 a0 e2  	jalr	-470(ra)
80201762: 2a e4        	sd	a0, 8(sp)
80201764: 09 a0        	j	0x80201766 <_ZN4core3ptr9const_ptr33_$LT$impl$u20$$BP$const$u20$T$GT$13read_volatile17h93a2f2f218844383E+0x12>
80201766: 22 65        	ld	a0, 8(sp)
80201768: e2 60        	ld	ra, 24(sp)
8020176a: 05 61        	addi	sp, sp, 32
8020176c: 82 80        	ret

000000008020176e <_ZN4core6result19Result$LT$T$C$E$GT$6expect17hcebcf9d549685e19E>:
8020176e: 5d 71        	addi	sp, sp, -80
80201770: 3a e0        	sd	a4, 0(sp)
80201772: 36 e4        	sd	a3, 8(sp)
80201774: 32 e8        	sd	a2, 16(sp)
80201776: 2a ec        	sd	a0, 24(sp)
80201778: 2e f0        	sd	a1, 32(sp)
8020177a: 32 f8        	sd	a2, 48(sp)
8020177c: 36 fc        	sd	a3, 56(sp)
8020177e: 93 35 15 00  	seqz	a1, a0
80201782: 81 45        	mv	a1, zero
80201784: 63 15 b5 00  	bne	a0, a1, 0x8020178e <_ZN4core6result19Result$LT$T$C$E$GT$6expect17hcebcf9d549685e19E+0x20>
80201788: 09 a0        	j	0x8020178a <_ZN4core6result19Result$LT$T$C$E$GT$6expect17hcebcf9d549685e19E+0x1c>
8020178a: 01 a8        	j	0x8020179a <_ZN4core6result19Result$LT$T$C$E$GT$6expect17hcebcf9d549685e19E+0x2c>
8020178c: 00 00        	unimp	
8020178e: 62 65        	ld	a0, 24(sp)
80201790: 82 75        	ld	a1, 32(sp)
80201792: aa e0        	sd	a0, 64(sp)
80201794: ae e4        	sd	a1, 72(sp)
80201796: 61 61        	addi	sp, sp, 80
80201798: 82 80        	ret
8020179a: 02 67        	ld	a4, 0(sp)
8020179c: a2 65        	ld	a1, 8(sp)
8020179e: 42 65        	ld	a0, 16(sp)

00000000802017a0 <.LBB1_5>:
802017a0: 97 66 00 00  	auipc	a3, 6
802017a4: 93 86 06 14  	addi	a3, a3, 320
802017a8: 30 10        	addi	a2, sp, 40
802017aa: 97 30 00 00  	auipc	ra, 3
802017ae: e7 80 c0 49  	jalr	1180(ra)
802017b2: 00 00        	unimp	

00000000802017b4 <_ZN4core6result19Result$LT$T$C$E$GT$6unwrap17h462d61fed5f3a590E>:
802017b4: 79 71        	addi	sp, sp, -48
802017b6: 2e e0        	sd	a1, 0(sp)
802017b8: 2a e4        	sd	a0, 8(sp)
802017ba: 08 61        	ld	a0, 0(a0)
802017bc: 81 45        	mv	a1, zero
802017be: 63 05 b5 00  	beq	a0, a1, 0x802017c8 <_ZN4core6result19Result$LT$T$C$E$GT$6unwrap17h462d61fed5f3a590E+0x14>
802017c2: 09 a0        	j	0x802017c4 <_ZN4core6result19Result$LT$T$C$E$GT$6unwrap17h462d61fed5f3a590E+0x10>
802017c4: 09 a8        	j	0x802017d6 <_ZN4core6result19Result$LT$T$C$E$GT$6unwrap17h462d61fed5f3a590E+0x22>
802017c6: 00 00        	unimp	
802017c8: a2 65        	ld	a1, 8(sp)
802017ca: 88 65        	ld	a0, 8(a1)
802017cc: 8c 69        	ld	a1, 16(a1)
802017ce: 2a f0        	sd	a0, 32(sp)
802017d0: 2e f4        	sd	a1, 40(sp)
802017d2: 45 61        	addi	sp, sp, 48
802017d4: 82 80        	ret
802017d6: 02 67        	ld	a4, 0(sp)
802017d8: 22 65        	ld	a0, 8(sp)
802017da: 0c 69        	ld	a1, 16(a0)
802017dc: 2e ec        	sd	a1, 24(sp)
802017de: 08 65        	ld	a0, 8(a0)
802017e0: 2a e8        	sd	a0, 16(sp)

00000000802017e2 <.LBB2_5>:
802017e2: 17 65 00 00  	auipc	a0, 6
802017e6: 13 05 e5 11  	addi	a0, a0, 286

00000000802017ea <.LBB2_6>:
802017ea: 97 66 00 00  	auipc	a3, 6
802017ee: 93 86 66 14  	addi	a3, a3, 326
802017f2: 93 05 b0 02  	addi	a1, zero, 43
802017f6: 10 08        	addi	a2, sp, 16
802017f8: 97 30 00 00  	auipc	ra, 3
802017fc: e7 80 e0 44  	jalr	1102(ra)
80201800: 00 00        	unimp	

0000000080201802 <_ZN4core6result19Result$LT$T$C$E$GT$6unwrap17h9e46d97aaaa3e485E>:
80201802: 01 11        	addi	sp, sp, -32
80201804: 2e e0        	sd	a1, 0(sp)
80201806: a3 07 a1 00  	sb	a0, 15(sp)
8020180a: 81 45        	mv	a1, zero
8020180c: 63 05 b5 00  	beq	a0, a1, 0x80201816 <_ZN4core6result19Result$LT$T$C$E$GT$6unwrap17h9e46d97aaaa3e485E+0x14>
80201810: 09 a0        	j	0x80201812 <_ZN4core6result19Result$LT$T$C$E$GT$6unwrap17h9e46d97aaaa3e485E+0x10>
80201812: 21 a0        	j	0x8020181a <_ZN4core6result19Result$LT$T$C$E$GT$6unwrap17h9e46d97aaaa3e485E+0x18>
80201814: 00 00        	unimp	
80201816: 05 61        	addi	sp, sp, 32
80201818: 82 80        	ret
8020181a: 02 67        	ld	a4, 0(sp)

000000008020181c <.LBB3_5>:
8020181c: 17 65 00 00  	auipc	a0, 6
80201820: 13 05 45 0e  	addi	a0, a0, 228

0000000080201824 <.LBB3_6>:
80201824: 97 66 00 00  	auipc	a3, 6
80201828: 93 86 c6 12  	addi	a3, a3, 300
8020182c: 93 05 b0 02  	addi	a1, zero, 43
80201830: 10 08        	addi	a2, sp, 16
80201832: 97 30 00 00  	auipc	ra, 3
80201836: e7 80 40 41  	jalr	1044(ra)
8020183a: 00 00        	unimp	

000000008020183c <_ZN4core3str11validations15next_code_point17ha489964019f05e3aE>:
8020183c: 31 71        	addi	sp, sp, -192
8020183e: 06 fd        	sd	ra, 184(sp)
80201840: aa f0        	sd	a0, 96(sp)
80201842: 2a e5        	sd	a0, 136(sp)
80201844: 97 10 00 00  	auipc	ra, 1
80201848: e7 80 40 9b  	jalr	-1612(ra)
8020184c: aa f4        	sd	a0, 104(sp)
8020184e: 09 a0        	j	0x80201850 <_ZN4core3str11validations15next_code_point17ha489964019f05e3aE+0x14>
80201850: 26 75        	ld	a0, 104(sp)
80201852: 97 10 00 00  	auipc	ra, 1
80201856: e7 80 60 4e  	jalr	1254(ra)
8020185a: aa fc        	sd	a0, 120(sp)
8020185c: 09 a0        	j	0x8020185e <_ZN4core3str11validations15next_code_point17ha489964019f05e3aE+0x22>
8020185e: 66 75        	ld	a0, 120(sp)
80201860: 93 35 15 00  	seqz	a1, a0
80201864: 81 45        	mv	a1, zero
80201866: 63 15 b5 00  	bne	a0, a1, 0x80201870 <_ZN4core3str11validations15next_code_point17ha489964019f05e3aE+0x34>
8020186a: 09 a0        	j	0x8020186c <_ZN4core3str11validations15next_code_point17ha489964019f05e3aE+0x30>
8020186c: 39 a8        	j	0x8020188a <_ZN4core3str11validations15next_code_point17ha489964019f05e3aE+0x4e>
8020186e: 00 00        	unimp	
80201870: 66 75        	ld	a0, 120(sp)
80201872: 2a ed        	sd	a0, 152(sp)
80201874: 03 05 05 00  	lb	a0, 0(a0)
80201878: 93 75 f5 0f  	andi	a1, a0, 255
8020187c: ae ec        	sd	a1, 88(sp)
8020187e: a3 03 a1 0a  	sb	a0, 167(sp)
80201882: 81 45        	mv	a1, zero
80201884: 63 56 b5 02  	bge	a0, a1, 0x802018b0 <_ZN4core3str11validations15next_code_point17ha489964019f05e3aE+0x74>
80201888: 11 a8        	j	0x8020189c <_ZN4core3str11validations15next_code_point17ha489964019f05e3aE+0x60>
8020188a: 97 10 00 00  	auipc	ra, 1
8020188e: e7 80 a0 50  	jalr	1290(ra)
80201892: aa d8        	sw	a0, 112(sp)
80201894: ae da        	sw	a1, 116(sp)
80201896: 09 a0        	j	0x80201898 <_ZN4core3str11validations15next_code_point17ha489964019f05e3aE+0x5c>
80201898: 09 a0        	j	0x8020189a <_ZN4core3str11validations15next_code_point17ha489964019f05e3aE+0x5e>
8020189a: 05 a0        	j	0x802018ba <_ZN4core3str11validations15next_code_point17ha489964019f05e3aE+0x7e>
8020189c: 66 65        	ld	a0, 88(sp)
8020189e: 89 45        	addi	a1, zero, 2
802018a0: 97 00 00 00  	auipc	ra, 0
802018a4: e7 80 e0 46  	jalr	1134(ra)
802018a8: aa 85        	mv	a1, a0
802018aa: ae e8        	sd	a1, 80(sp)
802018ac: 2a d5        	sw	a0, 168(sp)
802018ae: 19 a8        	j	0x802018c4 <_ZN4core3str11validations15next_code_point17ha489964019f05e3aE+0x88>
802018b0: 66 65        	ld	a0, 88(sp)
802018b2: aa da        	sw	a0, 116(sp)
802018b4: 05 45        	addi	a0, zero, 1
802018b6: aa d8        	sw	a0, 112(sp)
802018b8: cd b7        	j	0x8020189a <_ZN4core3str11validations15next_code_point17ha489964019f05e3aE+0x5e>
802018ba: 46 55        	lw	a0, 112(sp)
802018bc: d6 55        	lw	a1, 116(sp)
802018be: ea 70        	ld	ra, 184(sp)
802018c0: 29 61        	addi	sp, sp, 192
802018c2: 82 80        	ret
802018c4: 06 75        	ld	a0, 96(sp)
802018c6: 97 10 00 00  	auipc	ra, 1
802018ca: e7 80 20 93  	jalr	-1742(ra)
802018ce: aa e4        	sd	a0, 72(sp)
802018d0: 09 a0        	j	0x802018d2 <_ZN4core3str11validations15next_code_point17ha489964019f05e3aE+0x96>
802018d2: 26 65        	ld	a0, 72(sp)

00000000802018d4 <.LBB0_26>:
802018d4: 97 65 00 00  	auipc	a1, 6
802018d8: 93 85 45 0f  	addi	a1, a1, 244
802018dc: 97 10 00 00  	auipc	ra, 1
802018e0: e7 80 60 3d  	jalr	982(ra)
802018e4: aa e0        	sd	a0, 64(sp)
802018e6: 09 a0        	j	0x802018e8 <.LBB0_26+0x14>
802018e8: 46 65        	ld	a0, 80(sp)
802018ea: 86 65        	ld	a1, 64(sp)
802018ec: 83 c5 05 00  	lbu	a1, 0(a1)
802018f0: 2e fc        	sd	a1, 56(sp)
802018f2: 23 07 b1 0a  	sb	a1, 174(sp)
802018f6: 97 00 00 00  	auipc	ra, 0
802018fa: e7 80 20 43  	jalr	1074(ra)
802018fe: 2a c3        	sw	a0, 132(sp)
80201900: 09 a0        	j	0x80201902 <.LBB0_26+0x2e>
80201902: e6 65        	ld	a1, 88(sp)
80201904: 13 05 f0 0d  	addi	a0, zero, 223
80201908: 63 68 b5 00  	bltu	a0, a1, 0x80201918 <.LBB0_26+0x44>
8020190c: 09 a0        	j	0x8020190e <.LBB0_26+0x3a>
8020190e: 1a 45        	lw	a0, 132(sp)
80201910: aa da        	sw	a0, 116(sp)
80201912: 05 45        	addi	a0, zero, 1
80201914: aa d8        	sw	a0, 112(sp)
80201916: 55 b7        	j	0x802018ba <_ZN4core3str11validations15next_code_point17ha489964019f05e3aE+0x7e>
80201918: 06 75        	ld	a0, 96(sp)
8020191a: 97 10 00 00  	auipc	ra, 1
8020191e: e7 80 e0 8d  	jalr	-1826(ra)
80201922: 2a f8        	sd	a0, 48(sp)
80201924: 09 a0        	j	0x80201926 <.LBB0_26+0x52>
80201926: 42 75        	ld	a0, 48(sp)

0000000080201928 <.LBB0_27>:
80201928: 97 65 00 00  	auipc	a1, 6
8020192c: 93 85 85 0b  	addi	a1, a1, 184
80201930: 97 10 00 00  	auipc	ra, 1
80201934: e7 80 20 38  	jalr	898(ra)
80201938: 2a f4        	sd	a0, 40(sp)
8020193a: 09 a0        	j	0x8020193c <.LBB0_27+0x14>
8020193c: 62 75        	ld	a0, 56(sp)
8020193e: a2 75        	ld	a1, 40(sp)
80201940: 83 85 05 00  	lb	a1, 0(a1)
80201944: a3 07 b1 0a  	sb	a1, 175(sp)
80201948: 13 75 f5 03  	andi	a0, a0, 63
8020194c: 97 00 00 00  	auipc	ra, 0
80201950: e7 80 c0 3d  	jalr	988(ra)
80201954: aa 85        	mv	a1, a0
80201956: 2e f0        	sd	a1, 32(sp)
80201958: 2a d9        	sw	a0, 176(sp)
8020195a: 09 a0        	j	0x8020195c <.LBB0_27+0x34>
8020195c: e6 65        	ld	a1, 88(sp)
8020195e: 02 76        	ld	a2, 32(sp)
80201960: 46 65        	ld	a0, 80(sp)
80201962: 32 05        	slli	a0, a0, 12
80201964: 51 8d        	or	a0, a0, a2
80201966: 2a c3        	sw	a0, 132(sp)
80201968: 13 05 f0 0e  	addi	a0, zero, 239
8020196c: 63 64 b5 00  	bltu	a0, a1, 0x80201974 <.LBB0_27+0x4c>
80201970: 09 a0        	j	0x80201972 <.LBB0_27+0x4a>
80201972: 71 bf        	j	0x8020190e <.LBB0_26+0x3a>
80201974: 06 75        	ld	a0, 96(sp)
80201976: 97 10 00 00  	auipc	ra, 1
8020197a: e7 80 20 88  	jalr	-1918(ra)
8020197e: 2a ec        	sd	a0, 24(sp)
80201980: 09 a0        	j	0x80201982 <.LBB0_27+0x5a>
80201982: 62 65        	ld	a0, 24(sp)

0000000080201984 <.LBB0_28>:
80201984: 97 65 00 00  	auipc	a1, 6
80201988: 93 85 45 07  	addi	a1, a1, 116
8020198c: 97 10 00 00  	auipc	ra, 1
80201990: e7 80 60 32  	jalr	806(ra)
80201994: 2a e8        	sd	a0, 16(sp)
80201996: 09 a0        	j	0x80201998 <.LBB0_28+0x14>
80201998: 02 75        	ld	a0, 32(sp)
8020199a: 46 66        	ld	a2, 80(sp)
8020199c: c2 65        	ld	a1, 16(sp)
8020199e: 83 85 05 00  	lb	a1, 0(a1)
802019a2: a3 0b b1 0a  	sb	a1, 183(sp)
802019a6: 1d 8a        	andi	a2, a2, 7
802019a8: 4a 06        	slli	a2, a2, 18
802019aa: 32 e0        	sd	a2, 0(sp)
802019ac: 97 00 00 00  	auipc	ra, 0
802019b0: e7 80 c0 37  	jalr	892(ra)
802019b4: 2a e4        	sd	a0, 8(sp)
802019b6: 09 a0        	j	0x802019b8 <.LBB0_28+0x34>
802019b8: 02 65        	ld	a0, 0(sp)
802019ba: a2 65        	ld	a1, 8(sp)
802019bc: 4d 8d        	or	a0, a0, a1
802019be: 2a c3        	sw	a0, 132(sp)
802019c0: 4d bf        	j	0x80201972 <.LBB0_27+0x4a>

00000000802019c2 <_ZN56_$LT$os..console..Stdout$u20$as$u20$core..fmt..Write$GT$9write_str17h0c5e32379aec3949E>:
802019c2: 11 71        	addi	sp, sp, -256
802019c4: 86 fd        	sd	ra, 248(sp)
802019c6: b2 ec        	sd	a2, 88(sp)
802019c8: 2e 86        	mv	a2, a1
802019ca: e6 65        	ld	a1, 88(sp)
802019cc: b2 f0        	sd	a2, 96(sp)
802019ce: 2a 86        	mv	a2, a0
802019d0: 06 75        	ld	a0, 96(sp)
802019d2: 32 f9        	sd	a2, 176(sp)
802019d4: 2a fd        	sd	a0, 184(sp)
802019d6: ae e1        	sd	a1, 192(sp)
802019d8: 01 46        	mv	a2, zero
802019da: b2 de        	sw	a2, 124(sp)
802019dc: 97 20 00 00  	auipc	ra, 2
802019e0: e7 80 c0 bc  	jalr	-1076(ra)
802019e4: aa f4        	sd	a0, 104(sp)
802019e6: ae f8        	sd	a1, 112(sp)
802019e8: 09 a0        	j	0x802019ea <_ZN56_$LT$os..console..Stdout$u20$as$u20$core..fmt..Write$GT$9write_str17h0c5e32379aec3949E+0x28>
802019ea: c6 75        	ld	a1, 112(sp)
802019ec: 26 75        	ld	a0, 104(sp)
802019ee: 97 10 00 00  	auipc	ra, 1
802019f2: e7 80 40 5d  	jalr	1492(ra)
802019f6: aa e4        	sd	a0, 72(sp)
802019f8: ae e8        	sd	a1, 80(sp)
802019fa: 09 a0        	j	0x802019fc <_ZN56_$LT$os..console..Stdout$u20$as$u20$core..fmt..Write$GT$9write_str17h0c5e32379aec3949E+0x3a>
802019fc: 46 65        	ld	a0, 80(sp)
802019fe: a6 65        	ld	a1, 72(sp)
80201a00: 2e e1        	sd	a1, 128(sp)
80201a02: 2a e5        	sd	a0, 136(sp)
80201a04: 09 a0        	j	0x80201a06 <_ZN56_$LT$os..console..Stdout$u20$as$u20$core..fmt..Write$GT$9write_str17h0c5e32379aec3949E+0x44>
80201a06: 08 01        	addi	a0, sp, 128
80201a08: 97 f0 ff ff  	auipc	ra, 1048575
80201a0c: e7 80 80 87  	jalr	-1928(ra)
80201a10: 02 15        	slli	a0, a0, 32
80201a12: 01 91        	srli	a0, a0, 32
80201a14: 2a cb        	sw	a0, 148(sp)
80201a16: 09 a0        	j	0x80201a18 <_ZN56_$LT$os..console..Stdout$u20$as$u20$core..fmt..Write$GT$9write_str17h0c5e32379aec3949E+0x56>
80201a18: 5a 45        	lw	a0, 148(sp)
80201a1a: b7 05 ef ff  	lui	a1, 1048304
80201a1e: 2d 9d        	addw	a0, a0, a1
80201a20: b3 35 a0 00  	snez	a1, a0
80201a24: 81 45        	mv	a1, zero
80201a26: 63 05 b5 00  	beq	a0, a1, 0x80201a30 <_ZN56_$LT$os..console..Stdout$u20$as$u20$core..fmt..Write$GT$9write_str17h0c5e32379aec3949E+0x6e>
80201a2a: 09 a0        	j	0x80201a2c <_ZN56_$LT$os..console..Stdout$u20$as$u20$core..fmt..Write$GT$9write_str17h0c5e32379aec3949E+0x6a>
80201a2c: 01 a8        	j	0x80201a3c <_ZN56_$LT$os..console..Stdout$u20$as$u20$core..fmt..Write$GT$9write_str17h0c5e32379aec3949E+0x7a>
80201a2e: 00 00        	unimp	
80201a30: 01 45        	mv	a0, zero
80201a32: a3 0d a1 06  	sb	a0, 123(sp)
80201a36: ee 70        	ld	ra, 248(sp)
80201a38: 11 61        	addi	sp, sp, 256
80201a3a: 82 80        	ret
80201a3c: 5a 45        	lw	a0, 148(sp)
80201a3e: aa c7        	sw	a0, 204(sp)
80201a40: ec 18        	addi	a1, sp, 124
80201a42: 11 46        	addi	a2, zero, 4
80201a44: 97 10 00 00  	auipc	ra, 1
80201a48: e7 80 e0 5d  	jalr	1502(ra)
80201a4c: 2a fc        	sd	a0, 56(sp)
80201a4e: ae e0        	sd	a1, 64(sp)
80201a50: 09 a0        	j	0x80201a52 <_ZN56_$LT$os..console..Stdout$u20$as$u20$core..fmt..Write$GT$9write_str17h0c5e32379aec3949E+0x90>
80201a52: 06 65        	ld	a0, 64(sp)
80201a54: e2 75        	ld	a1, 56(sp)
80201a56: ae ed        	sd	a1, 216(sp)
80201a58: aa f1        	sd	a0, 224(sp)
80201a5a: ae f5        	sd	a1, 232(sp)
80201a5c: aa f9        	sd	a0, 240(sp)
80201a5e: 2e f4        	sd	a1, 40(sp)
80201a60: 2a f8        	sd	a0, 48(sp)
80201a62: 09 a0        	j	0x80201a64 <_ZN56_$LT$os..console..Stdout$u20$as$u20$core..fmt..Write$GT$9write_str17h0c5e32379aec3949E+0xa2>
80201a64: c2 75        	ld	a1, 48(sp)
80201a66: 22 75        	ld	a0, 40(sp)
80201a68: 97 10 00 00  	auipc	ra, 1
80201a6c: e7 80 a0 11  	jalr	282(ra)
80201a70: 2a ec        	sd	a0, 24(sp)
80201a72: 2e f0        	sd	a1, 32(sp)
80201a74: 09 a0        	j	0x80201a76 <_ZN56_$LT$os..console..Stdout$u20$as$u20$core..fmt..Write$GT$9write_str17h0c5e32379aec3949E+0xb4>
80201a76: 82 75        	ld	a1, 32(sp)
80201a78: 62 65        	ld	a0, 24(sp)
80201a7a: 97 00 00 00  	auipc	ra, 0
80201a7e: e7 80 40 5d  	jalr	1492(ra)
80201a82: 2a e4        	sd	a0, 8(sp)
80201a84: 2e e8        	sd	a1, 16(sp)
80201a86: 09 a0        	j	0x80201a88 <_ZN56_$LT$os..console..Stdout$u20$as$u20$core..fmt..Write$GT$9write_str17h0c5e32379aec3949E+0xc6>
80201a88: 42 65        	ld	a0, 16(sp)
80201a8a: a2 65        	ld	a1, 8(sp)
80201a8c: 2e ed        	sd	a1, 152(sp)
80201a8e: 2a f1        	sd	a0, 160(sp)
80201a90: 09 a0        	j	0x80201a92 <_ZN56_$LT$os..console..Stdout$u20$as$u20$core..fmt..Write$GT$9write_str17h0c5e32379aec3949E+0xd0>
80201a92: 28 09        	addi	a0, sp, 152
80201a94: 97 00 00 00  	auipc	ra, 0
80201a98: e7 80 40 76  	jalr	1892(ra)
80201a9c: 2a f5        	sd	a0, 168(sp)
80201a9e: 09 a0        	j	0x80201aa0 <_ZN56_$LT$os..console..Stdout$u20$as$u20$core..fmt..Write$GT$9write_str17h0c5e32379aec3949E+0xde>
80201aa0: 2a 75        	ld	a0, 168(sp)
80201aa2: b3 35 a0 00  	snez	a1, a0
80201aa6: 81 45        	mv	a1, zero
80201aa8: e3 0f b5 f4  	beq	a0, a1, 0x80201a06 <_ZN56_$LT$os..console..Stdout$u20$as$u20$core..fmt..Write$GT$9write_str17h0c5e32379aec3949E+0x44>
80201aac: 09 a0        	j	0x80201aae <_ZN56_$LT$os..console..Stdout$u20$as$u20$core..fmt..Write$GT$9write_str17h0c5e32379aec3949E+0xec>
80201aae: 11 a0        	j	0x80201ab2 <_ZN56_$LT$os..console..Stdout$u20$as$u20$core..fmt..Write$GT$9write_str17h0c5e32379aec3949E+0xf0>
80201ab0: 00 00        	unimp	
80201ab2: 2a 75        	ld	a0, 168(sp)
80201ab4: aa e9        	sd	a0, 208(sp)
80201ab6: 03 05 05 00  	lb	a0, 0(a0)
80201aba: 97 00 00 00  	auipc	ra, 0
80201abe: e7 80 e0 b4  	jalr	-1202(ra)
80201ac2: c1 bf        	j	0x80201a92 <_ZN56_$LT$os..console..Stdout$u20$as$u20$core..fmt..Write$GT$9write_str17h0c5e32379aec3949E+0xd0>

0000000080201ac4 <_ZN2os7console5print17hf29bb92ae93e1911E>:
80201ac4: 5d 71        	addi	sp, sp, -80
80201ac6: 86 e4        	sd	ra, 72(sp)
80201ac8: 0c 75        	ld	a1, 40(a0)
80201aca: ae e0        	sd	a1, 64(sp)
80201acc: 0c 71        	ld	a1, 32(a0)
80201ace: 2e fc        	sd	a1, 56(sp)
80201ad0: 0c 6d        	ld	a1, 24(a0)
80201ad2: 2e f8        	sd	a1, 48(sp)
80201ad4: 0c 69        	ld	a1, 16(a0)
80201ad6: 2e f4        	sd	a1, 40(sp)
80201ad8: 0c 65        	ld	a1, 8(a0)
80201ada: 2e f0        	sd	a1, 32(sp)
80201adc: 08 61        	ld	a0, 0(a0)
80201ade: 2a ec        	sd	a0, 24(sp)
80201ae0: 08 08        	addi	a0, sp, 16
80201ae2: 2c 08        	addi	a1, sp, 24
80201ae4: 97 20 00 00  	auipc	ra, 2
80201ae8: e7 80 a0 b3  	jalr	-1222(ra)
80201aec: 2a e4        	sd	a0, 8(sp)
80201aee: 09 a0        	j	0x80201af0 <_ZN2os7console5print17hf29bb92ae93e1911E+0x2c>
80201af0: 22 65        	ld	a0, 8(sp)

0000000080201af2 <.LBB1_3>:
80201af2: 97 65 00 00  	auipc	a1, 6
80201af6: 93 85 e5 f2  	addi	a1, a1, -210
80201afa: 97 00 00 00  	auipc	ra, 0
80201afe: e7 80 80 d0  	jalr	-760(ra)
80201b02: 09 a0        	j	0x80201b04 <.LBB1_3+0x12>
80201b04: a6 60        	ld	ra, 72(sp)
80201b06: 61 61        	addi	sp, sp, 80
80201b08: 82 80        	ret

0000000080201b0a <_ZN4core4iter6traits8iterator8Iterator3map17h6850e9a38b83c33aE>:
80201b0a: 01 11        	addi	sp, sp, -32
80201b0c: 06 ec        	sd	ra, 24(sp)
80201b0e: 2e e0        	sd	a1, 0(sp)
80201b10: 32 e4        	sd	a2, 8(sp)
80201b12: 36 e8        	sd	a3, 16(sp)
80201b14: 97 10 00 00  	auipc	ra, 1
80201b18: e7 80 60 f7  	jalr	-138(ra)
80201b1c: 09 a0        	j	0x80201b1e <_ZN4core4iter6traits8iterator8Iterator3map17h6850e9a38b83c33aE+0x14>
80201b1e: e2 60        	ld	ra, 24(sp)
80201b20: 05 61        	addi	sp, sp, 32
80201b22: 82 80        	ret

0000000080201b24 <_ZN4core4iter6traits8iterator8Iterator8for_each17h60b7502c7594959eE>:
80201b24: 79 71        	addi	sp, sp, -48
80201b26: 06 f4        	sd	ra, 40(sp)
80201b28: 2e e0        	sd	a1, 0(sp)
80201b2a: 2a e4        	sd	a0, 8(sp)
80201b2c: 2a e8        	sd	a0, 16(sp)
80201b2e: 2e ec        	sd	a1, 24(sp)
80201b30: 97 10 00 00  	auipc	ra, 1
80201b34: e7 80 80 9b  	jalr	-1608(ra)
80201b38: 09 a0        	j	0x80201b3a <_ZN4core4iter6traits8iterator8Iterator8for_each17h60b7502c7594959eE+0x16>
80201b3a: 82 65        	ld	a1, 0(sp)
80201b3c: 22 65        	ld	a0, 8(sp)
80201b3e: 97 00 00 00  	auipc	ra, 0
80201b42: e7 80 00 0a  	jalr	160(ra)
80201b46: 09 a0        	j	0x80201b48 <_ZN4core4iter6traits8iterator8Iterator8for_each17h60b7502c7594959eE+0x24>
80201b48: a2 70        	ld	ra, 40(sp)
80201b4a: 45 61        	addi	sp, sp, 48
80201b4c: 82 80        	ret

0000000080201b4e <_ZN4core4iter6traits8iterator8Iterator8try_fold17he8af001b296c8b68E>:
80201b4e: 35 71        	addi	sp, sp, -160
80201b50: 06 ed        	sd	ra, 152(sp)
80201b52: 2a ec        	sd	a0, 24(sp)
80201b54: 2e f0        	sd	a1, 32(sp)
80201b56: 32 f4        	sd	a2, 40(sp)
80201b58: aa f4        	sd	a0, 104(sp)
80201b5a: 09 a0        	j	0x80201b5c <_ZN4core4iter6traits8iterator8Iterator8try_fold17he8af001b296c8b68E+0xe>
80201b5c: 62 65        	ld	a0, 24(sp)
80201b5e: 97 30 00 00  	auipc	ra, 3
80201b62: e7 80 c0 82  	jalr	-2004(ra)
80201b66: aa e0        	sd	a0, 64(sp)
80201b68: ae e4        	sd	a1, 72(sp)
80201b6a: 09 a0        	j	0x80201b6c <_ZN4core4iter6traits8iterator8Iterator8try_fold17he8af001b296c8b68E+0x1e>
80201b6c: 06 65        	ld	a0, 64(sp)
80201b6e: 81 45        	mv	a1, zero
80201b70: 63 0e b5 00  	beq	a0, a1, 0x80201b8c <_ZN4core4iter6traits8iterator8Iterator8try_fold17he8af001b296c8b68E+0x3e>
80201b74: 09 a0        	j	0x80201b76 <_ZN4core4iter6traits8iterator8Iterator8try_fold17he8af001b296c8b68E+0x28>
80201b76: a6 65        	ld	a1, 72(sp)
80201b78: 2e e5        	sd	a1, 136(sp)
80201b7a: ae f0        	sd	a1, 96(sp)
80201b7c: 08 10        	addi	a0, sp, 32
80201b7e: 97 10 00 00  	auipc	ra, 1
80201b82: e7 80 20 f3  	jalr	-206(ra)
80201b86: 2a e4        	sd	a0, 8(sp)
80201b88: 2e e8        	sd	a1, 16(sp)
80201b8a: 39 a8        	j	0x80201ba8 <_ZN4core4iter6traits8iterator8Iterator8try_fold17he8af001b296c8b68E+0x5a>
80201b8c: 09 a0        	j	0x80201b8e <_ZN4core4iter6traits8iterator8Iterator8try_fold17he8af001b296c8b68E+0x40>
80201b8e: 97 f0 ff ff  	auipc	ra, 1048575
80201b92: e7 80 e0 59  	jalr	1438(ra)
80201b96: 2a f8        	sd	a0, 48(sp)
80201b98: 2e fc        	sd	a1, 56(sp)
80201b9a: 09 a0        	j	0x80201b9c <_ZN4core4iter6traits8iterator8Iterator8try_fold17he8af001b296c8b68E+0x4e>
80201b9c: 09 a0        	j	0x80201b9e <_ZN4core4iter6traits8iterator8Iterator8try_fold17he8af001b296c8b68E+0x50>
80201b9e: 42 75        	ld	a0, 48(sp)
80201ba0: e2 75        	ld	a1, 56(sp)
80201ba2: ea 60        	ld	ra, 152(sp)
80201ba4: 0d 61        	addi	sp, sp, 160
80201ba6: 82 80        	ret
80201ba8: c2 65        	ld	a1, 16(sp)
80201baa: 22 65        	ld	a0, 8(sp)
80201bac: 97 f0 ff ff  	auipc	ra, 1048575
80201bb0: e7 80 c0 58  	jalr	1420(ra)
80201bb4: aa e8        	sd	a0, 80(sp)
80201bb6: ae ec        	sd	a1, 88(sp)
80201bb8: 09 a0        	j	0x80201bba <_ZN4core4iter6traits8iterator8Iterator8try_fold17he8af001b296c8b68E+0x6c>
80201bba: 46 65        	ld	a0, 80(sp)
80201bbc: 81 45        	mv	a1, zero
80201bbe: 63 05 b5 00  	beq	a0, a1, 0x80201bc8 <_ZN4core4iter6traits8iterator8Iterator8try_fold17he8af001b296c8b68E+0x7a>
80201bc2: 09 a0        	j	0x80201bc4 <_ZN4core4iter6traits8iterator8Iterator8try_fold17he8af001b296c8b68E+0x76>
80201bc4: 19 a0        	j	0x80201bca <_ZN4core4iter6traits8iterator8Iterator8try_fold17he8af001b296c8b68E+0x7c>
80201bc6: 00 00        	unimp	
80201bc8: 51 bf        	j	0x80201b5c <_ZN4core4iter6traits8iterator8Iterator8try_fold17he8af001b296c8b68E+0xe>
80201bca: 66 65        	ld	a0, 88(sp)
80201bcc: 2a e9        	sd	a0, 144(sp)
80201bce: 97 f0 ff ff  	auipc	ra, 1048575
80201bd2: e7 80 80 59  	jalr	1432(ra)
80201bd6: 2a f8        	sd	a0, 48(sp)
80201bd8: 2e fc        	sd	a1, 56(sp)
80201bda: 09 a0        	j	0x80201bdc <_ZN4core4iter6traits8iterator8Iterator8try_fold17he8af001b296c8b68E+0x8e>
80201bdc: c9 b7        	j	0x80201b9e <_ZN4core4iter6traits8iterator8Iterator8try_fold17he8af001b296c8b68E+0x50>

0000000080201bde <_ZN4core4iter6traits8iterator8Iterator4fold17hccadcaed5a3df242E>:
80201bde: 5d 71        	addi	sp, sp, -80
80201be0: 86 e4        	sd	ra, 72(sp)
80201be2: 2a e0        	sd	a0, 0(sp)
80201be4: 2e e4        	sd	a1, 8(sp)
80201be6: 09 a0        	j	0x80201be8 <_ZN4core4iter6traits8iterator8Iterator4fold17hccadcaed5a3df242E+0xa>
80201be8: 0a 85        	mv	a0, sp
80201bea: 97 20 00 00  	auipc	ra, 2
80201bee: e7 80 00 7a  	jalr	1952(ra)
80201bf2: 2a ec        	sd	a0, 24(sp)
80201bf4: 2e f0        	sd	a1, 32(sp)
80201bf6: 09 a0        	j	0x80201bf8 <_ZN4core4iter6traits8iterator8Iterator4fold17hccadcaed5a3df242E+0x1a>
80201bf8: 62 65        	ld	a0, 24(sp)
80201bfa: 81 45        	mv	a1, zero
80201bfc: 63 0c b5 00  	beq	a0, a1, 0x80201c14 <_ZN4core4iter6traits8iterator8Iterator4fold17hccadcaed5a3df242E+0x36>
80201c00: 09 a0        	j	0x80201c02 <_ZN4core4iter6traits8iterator8Iterator4fold17hccadcaed5a3df242E+0x24>
80201c02: 82 75        	ld	a1, 32(sp)
80201c04: ae e0        	sd	a1, 64(sp)
80201c06: 2e f4        	sd	a1, 40(sp)
80201c08: 08 08        	addi	a0, sp, 16
80201c0a: 97 10 00 00  	auipc	ra, 1
80201c0e: e7 80 40 8e  	jalr	-1820(ra)
80201c12: 39 a0        	j	0x80201c20 <_ZN4core4iter6traits8iterator8Iterator4fold17hccadcaed5a3df242E+0x42>
80201c14: 09 a0        	j	0x80201c16 <_ZN4core4iter6traits8iterator8Iterator4fold17hccadcaed5a3df242E+0x38>
80201c16: 09 a0        	j	0x80201c18 <_ZN4core4iter6traits8iterator8Iterator4fold17hccadcaed5a3df242E+0x3a>
80201c18: 09 a0        	j	0x80201c1a <_ZN4core4iter6traits8iterator8Iterator4fold17hccadcaed5a3df242E+0x3c>
80201c1a: a6 60        	ld	ra, 72(sp)
80201c1c: 61 61        	addi	sp, sp, 80
80201c1e: 82 80        	ret
80201c20: e1 b7        	j	0x80201be8 <_ZN4core4iter6traits8iterator8Iterator4fold17hccadcaed5a3df242E+0xa>

0000000080201c22 <_ZN106_$LT$core..ops..range..Range$LT$usize$GT$$u20$as$u20$core..slice..index..SliceIndex$LT$$u5b$T$u5d$$GT$$GT$17get_unchecked_mut17h7bc25c36fb91e7e4E>:
80201c22: 75 71        	addi	sp, sp, -144
80201c24: 06 e5        	sd	ra, 136(sp)
80201c26: 2e ec        	sd	a1, 24(sp)
80201c28: 2a f0        	sd	a0, 32(sp)
80201c2a: 2a f8        	sd	a0, 48(sp)
80201c2c: 2e fc        	sd	a1, 56(sp)
80201c2e: b2 e0        	sd	a2, 64(sp)
80201c30: b6 e4        	sd	a3, 72(sp)
80201c32: b2 fc        	sd	a2, 120(sp)
80201c34: 36 e1        	sd	a3, 128(sp)
80201c36: 32 f4        	sd	a2, 40(sp)
80201c38: 09 a0        	j	0x80201c3a <_ZN106_$LT$core..ops..range..Range$LT$usize$GT$$u20$as$u20$core..slice..index..SliceIndex$LT$$u5b$T$u5d$$GT$$GT$17get_unchecked_mut17h7bc25c36fb91e7e4E+0x18>
80201c3a: 22 75        	ld	a0, 40(sp)
80201c3c: 82 75        	ld	a1, 32(sp)
80201c3e: aa e8        	sd	a0, 80(sp)
80201c40: ae ec        	sd	a1, 88(sp)
80201c42: aa f0        	sd	a0, 96(sp)
80201c44: ae f4        	sd	a1, 104(sp)
80201c46: 2e 95        	add	a0, a0, a1
80201c48: 2a e8        	sd	a0, 16(sp)
80201c4a: aa f8        	sd	a0, 112(sp)
80201c4c: 09 a0        	j	0x80201c4e <_ZN106_$LT$core..ops..range..Range$LT$usize$GT$$u20$as$u20$core..slice..index..SliceIndex$LT$$u5b$T$u5d$$GT$$GT$17get_unchecked_mut17h7bc25c36fb91e7e4E+0x2c>
80201c4e: 42 65        	ld	a0, 16(sp)
80201c50: e2 65        	ld	a1, 24(sp)
80201c52: 02 76        	ld	a2, 32(sp)
80201c54: 91 8d        	sub	a1, a1, a2
80201c56: 97 30 00 00  	auipc	ra, 3
80201c5a: e7 80 e0 8c  	jalr	-1842(ra)
80201c5e: 2a e0        	sd	a0, 0(sp)
80201c60: 2e e4        	sd	a1, 8(sp)
80201c62: 09 a0        	j	0x80201c64 <_ZN106_$LT$core..ops..range..Range$LT$usize$GT$$u20$as$u20$core..slice..index..SliceIndex$LT$$u5b$T$u5d$$GT$$GT$17get_unchecked_mut17h7bc25c36fb91e7e4E+0x42>
80201c64: a2 65        	ld	a1, 8(sp)
80201c66: 02 65        	ld	a0, 0(sp)
80201c68: aa 60        	ld	ra, 136(sp)
80201c6a: 49 61        	addi	sp, sp, 144
80201c6c: 82 80        	ret

0000000080201c6e <_ZN106_$LT$core..ops..range..Range$LT$usize$GT$$u20$as$u20$core..slice..index..SliceIndex$LT$$u5b$T$u5d$$GT$$GT$9index_mut17h8d6ca4dcd4ad320eE>:
80201c6e: 1d 71        	addi	sp, sp, -96
80201c70: 86 ec        	sd	ra, 88(sp)
80201c72: 3a e8        	sd	a4, 16(sp)
80201c74: 36 ec        	sd	a3, 24(sp)
80201c76: 32 f0        	sd	a2, 32(sp)
80201c78: 2e f4        	sd	a1, 40(sp)
80201c7a: 2a f8        	sd	a0, 48(sp)
80201c7c: 2a fc        	sd	a0, 56(sp)
80201c7e: ae e0        	sd	a1, 64(sp)
80201c80: b2 e4        	sd	a2, 72(sp)
80201c82: b6 e8        	sd	a3, 80(sp)
80201c84: 63 e8 a5 00  	bltu	a1, a0, 0x80201c94 <_ZN106_$LT$core..ops..range..Range$LT$usize$GT$$u20$as$u20$core..slice..index..SliceIndex$LT$$u5b$T$u5d$$GT$$GT$9index_mut17h8d6ca4dcd4ad320eE+0x26>
80201c88: 09 a0        	j	0x80201c8a <_ZN106_$LT$core..ops..range..Range$LT$usize$GT$$u20$as$u20$core..slice..index..SliceIndex$LT$$u5b$T$u5d$$GT$$GT$9index_mut17h8d6ca4dcd4ad320eE+0x1c>
80201c8a: 62 65        	ld	a0, 24(sp)
80201c8c: a2 75        	ld	a1, 40(sp)
80201c8e: 63 66 b5 02  	bltu	a0, a1, 0x80201cba <_ZN106_$LT$core..ops..range..Range$LT$usize$GT$$u20$as$u20$core..slice..index..SliceIndex$LT$$u5b$T$u5d$$GT$$GT$9index_mut17h8d6ca4dcd4ad320eE+0x4c>
80201c92: 09 a8        	j	0x80201ca4 <_ZN106_$LT$core..ops..range..Range$LT$usize$GT$$u20$as$u20$core..slice..index..SliceIndex$LT$$u5b$T$u5d$$GT$$GT$9index_mut17h8d6ca4dcd4ad320eE+0x36>
80201c94: 42 66        	ld	a2, 16(sp)
80201c96: a2 75        	ld	a1, 40(sp)
80201c98: 42 75        	ld	a0, 48(sp)
80201c9a: 97 40 00 00  	auipc	ra, 4
80201c9e: e7 80 a0 03  	jalr	58(ra)
80201ca2: 00 00        	unimp	
80201ca4: e2 66        	ld	a3, 24(sp)
80201ca6: 02 76        	ld	a2, 32(sp)
80201ca8: a2 75        	ld	a1, 40(sp)
80201caa: 42 75        	ld	a0, 48(sp)
80201cac: 97 00 00 00  	auipc	ra, 0
80201cb0: e7 80 60 f7  	jalr	-138(ra)
80201cb4: 2a e0        	sd	a0, 0(sp)
80201cb6: 2e e4        	sd	a1, 8(sp)
80201cb8: 09 a8        	j	0x80201cca <_ZN106_$LT$core..ops..range..Range$LT$usize$GT$$u20$as$u20$core..slice..index..SliceIndex$LT$$u5b$T$u5d$$GT$$GT$9index_mut17h8d6ca4dcd4ad320eE+0x5c>
80201cba: 42 66        	ld	a2, 16(sp)
80201cbc: e2 65        	ld	a1, 24(sp)
80201cbe: 22 75        	ld	a0, 40(sp)
80201cc0: 97 40 00 00  	auipc	ra, 4
80201cc4: e7 80 40 fd  	jalr	-44(ra)
80201cc8: 00 00        	unimp	
80201cca: a2 65        	ld	a1, 8(sp)
80201ccc: 02 65        	ld	a0, 0(sp)
80201cce: e6 60        	ld	ra, 88(sp)
80201cd0: 25 61        	addi	sp, sp, 96
80201cd2: 82 80        	ret

0000000080201cd4 <_ZN108_$LT$core..ops..range..RangeTo$LT$usize$GT$$u20$as$u20$core..slice..index..SliceIndex$LT$$u5b$T$u5d$$GT$$GT$9index_mut17h39e67f2f43abb5acE>:
80201cd4: 39 71        	addi	sp, sp, -64
80201cd6: 06 fc        	sd	ra, 56(sp)
80201cd8: 36 87        	mv	a4, a3
80201cda: b2 86        	mv	a3, a2
80201cdc: 2e 86        	mv	a2, a1
80201cde: aa 85        	mv	a1, a0
80201ce0: 2e f0        	sd	a1, 32(sp)
80201ce2: 32 f4        	sd	a2, 40(sp)
80201ce4: 36 f8        	sd	a3, 48(sp)
80201ce6: 01 45        	mv	a0, zero
80201ce8: 2a e8        	sd	a0, 16(sp)
80201cea: 2e ec        	sd	a1, 24(sp)
80201cec: 97 00 00 00  	auipc	ra, 0
80201cf0: e7 80 20 f8  	jalr	-126(ra)
80201cf4: 2a e0        	sd	a0, 0(sp)
80201cf6: 2e e4        	sd	a1, 8(sp)
80201cf8: 09 a0        	j	0x80201cfa <_ZN108_$LT$core..ops..range..RangeTo$LT$usize$GT$$u20$as$u20$core..slice..index..SliceIndex$LT$$u5b$T$u5d$$GT$$GT$9index_mut17h39e67f2f43abb5acE+0x26>
80201cfa: a2 65        	ld	a1, 8(sp)
80201cfc: 02 65        	ld	a0, 0(sp)
80201cfe: e2 70        	ld	ra, 56(sp)
80201d00: 21 61        	addi	sp, sp, 64
80201d02: 82 80        	ret

0000000080201d04 <_ZN97_$LT$core..ops..range..RangeFull$u20$as$u20$core..slice..index..SliceIndex$LT$$u5b$T$u5d$$GT$$GT$9index_mut17h24a1fb185a2d4e8aE>:
80201d04: 01 11        	addi	sp, sp, -32
80201d06: 2a e8        	sd	a0, 16(sp)
80201d08: 2e ec        	sd	a1, 24(sp)
80201d0a: 05 61        	addi	sp, sp, 32
80201d0c: 82 80        	ret

0000000080201d0e <_ZN4core3str11validations15utf8_first_byte17h5477ac1bfd2088f7E>:
80201d0e: 41 11        	addi	sp, sp, -16
80201d10: a3 05 a1 00  	sb	a0, 11(sp)
80201d14: 2e c6        	sw	a1, 12(sp)
80201d16: 13 f6 75 00  	andi	a2, a1, 7
80201d1a: 93 05 f0 07  	addi	a1, zero, 127
80201d1e: b3 d5 c5 00  	srl	a1, a1, a2
80201d22: 6d 8d        	and	a0, a0, a1
80201d24: 41 01        	addi	sp, sp, 16
80201d26: 82 80        	ret

0000000080201d28 <_ZN4core3str11validations18utf8_acc_cont_byte17h17c83e38c30cb6e1E>:
80201d28: 41 11        	addi	sp, sp, -16
80201d2a: 2a c4        	sw	a0, 8(sp)
80201d2c: a3 07 b1 00  	sb	a1, 15(sp)
80201d30: 1a 05        	slli	a0, a0, 6
80201d32: 93 f5 f5 03  	andi	a1, a1, 63
80201d36: 4d 8d        	or	a0, a0, a1
80201d38: 41 01        	addi	sp, sp, 16
80201d3a: 82 80        	ret

0000000080201d3c <_ZN2os4trap7context11TrapContext6set_sp17hc841a50e36ce4466E>:
80201d3c: 41 11        	addi	sp, sp, -16
80201d3e: 2a e0        	sd	a0, 0(sp)
80201d40: 2e e4        	sd	a1, 8(sp)
80201d42: 0c e9        	sd	a1, 16(a0)
80201d44: 41 01        	addi	sp, sp, 16
80201d46: 82 80        	ret

0000000080201d48 <_ZN2os4trap7context11TrapContext16app_init_context17hfe8f7ba0fef2a505E>:
80201d48: 0d 71        	addi	sp, sp, -352
80201d4a: 86 ee        	sd	ra, 344(sp)
80201d4c: 32 f0        	sd	a2, 32(sp)
80201d4e: 2e f4        	sd	a1, 40(sp)
80201d50: 2a f8        	sd	a0, 48(sp)
80201d52: ae e6        	sd	a1, 328(sp)
80201d54: b2 ea        	sd	a2, 336(sp)
80201d56: 97 e0 ff ff  	auipc	ra, 1048574
80201d5a: e7 80 e0 71  	jalr	1822(ra)
80201d5e: 2a fc        	sd	a0, 56(sp)
80201d60: 09 a0        	j	0x80201d62 <_ZN2os4trap7context11TrapContext16app_init_context17hfe8f7ba0fef2a505E+0x1a>
80201d62: 81 45        	mv	a1, zero
80201d64: a3 03 b1 04  	sb	a1, 71(sp)
80201d68: 28 18        	addi	a0, sp, 56
80201d6a: 97 e0 ff ff  	auipc	ra, 1048574
80201d6e: e7 80 00 6a  	jalr	1696(ra)
80201d72: 09 a0        	j	0x80201d74 <_ZN2os4trap7context11TrapContext16app_init_context17hfe8f7ba0fef2a505E+0x2c>
80201d74: a8 00        	addi	a0, sp, 72
80201d76: 2a e4        	sd	a0, 8(sp)
80201d78: 81 45        	mv	a1, zero
80201d7a: 13 06 00 10  	addi	a2, zero, 256
80201d7e: 32 e8        	sd	a2, 16(sp)
80201d80: 97 50 00 00  	auipc	ra, 5
80201d84: e7 80 00 de  	jalr	-544(ra)
80201d88: a2 65        	ld	a1, 8(sp)
80201d8a: 42 66        	ld	a2, 16(sp)
80201d8c: 42 75        	ld	a0, 48(sp)
80201d8e: e2 76        	ld	a3, 56(sp)
80201d90: 36 ec        	sd	a3, 24(sp)
80201d92: 97 50 00 00  	auipc	ra, 5
80201d96: e7 80 80 d1  	jalr	-744(ra)
80201d9a: e2 66        	ld	a3, 24(sp)
80201d9c: 22 76        	ld	a2, 40(sp)
80201d9e: 82 75        	ld	a1, 32(sp)
80201da0: 42 75        	ld	a0, 48(sp)
80201da2: 23 30 d5 10  	sd	a3, 256(a0)
80201da6: 23 34 c5 10  	sd	a2, 264(a0)
80201daa: 97 00 00 00  	auipc	ra, 0
80201dae: e7 80 20 f9  	jalr	-110(ra)
80201db2: 09 a0        	j	0x80201db4 <_ZN2os4trap7context11TrapContext16app_init_context17hfe8f7ba0fef2a505E+0x6c>
80201db4: f6 60        	ld	ra, 344(sp)
80201db6: 35 61        	addi	sp, sp, 352
80201db8: 82 80        	ret

0000000080201dba <_ZN4spin4once13Once$LT$T$GT$9force_get17h864b8647981c6ed7E>:
80201dba: 79 71        	addi	sp, sp, -48
80201dbc: 06 f4        	sd	ra, 40(sp)
80201dbe: 2a e8        	sd	a0, 16(sp)
80201dc0: 21 05        	addi	a0, a0, 8
80201dc2: 2a e0        	sd	a0, 0(sp)
80201dc4: 2a f0        	sd	a0, 32(sp)
80201dc6: 09 a0        	j	0x80201dc8 <_ZN4spin4once13Once$LT$T$GT$9force_get17h864b8647981c6ed7E+0xe>
80201dc8: 02 65        	ld	a0, 0(sp)
80201dca: 97 10 00 00  	auipc	ra, 1
80201dce: e7 80 80 e8  	jalr	-376(ra)
80201dd2: 2a e4        	sd	a0, 8(sp)
80201dd4: 09 a0        	j	0x80201dd6 <_ZN4spin4once13Once$LT$T$GT$9force_get17h864b8647981c6ed7E+0x1c>
80201dd6: 22 65        	ld	a0, 8(sp)
80201dd8: b3 35 a0 00  	snez	a1, a0
80201ddc: 81 45        	mv	a1, zero
80201dde: 63 05 b5 00  	beq	a0, a1, 0x80201de8 <_ZN4spin4once13Once$LT$T$GT$9force_get17h864b8647981c6ed7E+0x2e>
80201de2: 09 a0        	j	0x80201de4 <_ZN4spin4once13Once$LT$T$GT$9force_get17h864b8647981c6ed7E+0x2a>
80201de4: 39 a0        	j	0x80201df2 <_ZN4spin4once13Once$LT$T$GT$9force_get17h864b8647981c6ed7E+0x38>
80201de6: 00 00        	unimp	
80201de8: 97 f0 ff ff  	auipc	ra, 1048575
80201dec: e7 80 00 3f  	jalr	1008(ra)
80201df0: 00 00        	unimp	
80201df2: 22 65        	ld	a0, 8(sp)
80201df4: 2a ec        	sd	a0, 24(sp)
80201df6: a2 70        	ld	ra, 40(sp)
80201df8: 45 61        	addi	sp, sp, 48
80201dfa: 82 80        	ret

0000000080201dfc <_ZN4spin4once13Once$LT$T$GT$9call_once17h3e2209319c85fb21E>:
80201dfc: 13 01 01 b7  	addi	sp, sp, -1168
80201e00: 23 34 11 48  	sd	ra, 1160(sp)
80201e04: aa e0        	sd	a0, 64(sp)
80201e06: 23 38 a1 46  	sd	a0, 1136(sp)
80201e0a: 85 45        	addi	a1, zero, 1
80201e0c: a3 07 b1 46  	sb	a1, 1135(sp)
80201e10: 91 45        	addi	a1, zero, 4
80201e12: 23 0f b1 04  	sb	a1, 94(sp)
80201e16: 97 10 00 00  	auipc	ra, 1
80201e1a: e7 80 80 5f  	jalr	1528(ra)
80201e1e: aa e8        	sd	a0, 80(sp)
80201e20: 09 a0        	j	0x80201e22 <_ZN4spin4once13Once$LT$T$GT$9call_once17h3e2209319c85fb21E+0x26>
80201e22: 46 65        	ld	a0, 80(sp)
80201e24: 81 45        	mv	a1, zero
80201e26: 63 08 b5 02  	beq	a0, a1, 0x80201e56 <_ZN4spin4once13Once$LT$T$GT$9call_once17h3e2209319c85fb21E+0x5a>
80201e2a: 09 a0        	j	0x80201e2c <_ZN4spin4once13Once$LT$T$GT$9call_once17h3e2209319c85fb21E+0x30>
80201e2c: 46 65        	ld	a0, 80(sp)
80201e2e: 2a fc        	sd	a0, 56(sp)
80201e30: 81 45        	mv	a1, zero
80201e32: 63 04 b5 0e  	beq	a0, a1, 0x80201f1a <.LBB1_25>
80201e36: 09 a0        	j	0x80201e38 <_ZN4spin4once13Once$LT$T$GT$9call_once17h3e2209319c85fb21E+0x3c>
80201e38: 62 75        	ld	a0, 56(sp)
80201e3a: 85 45        	addi	a1, zero, 1
80201e3c: 63 0e b5 0e  	beq	a0, a1, 0x80201f38 <.LBB1_26+0x16>
80201e40: 09 a0        	j	0x80201e42 <_ZN4spin4once13Once$LT$T$GT$9call_once17h3e2209319c85fb21E+0x46>
80201e42: 62 75        	ld	a0, 56(sp)
80201e44: 89 45        	addi	a1, zero, 2
80201e46: 63 0c b5 10  	beq	a0, a1, 0x80201f5e <.LBB1_28+0x14>
80201e4a: 09 a0        	j	0x80201e4c <_ZN4spin4once13Once$LT$T$GT$9call_once17h3e2209319c85fb21E+0x50>
80201e4c: 62 75        	ld	a0, 56(sp)
80201e4e: 8d 45        	addi	a1, zero, 3
80201e50: 63 09 b5 0e  	beq	a0, a1, 0x80201f42 <.LBB1_27>
80201e54: 75 a8        	j	0x80201f10 <_ZN4spin4once13Once$LT$T$GT$9call_once17h3e2209319c85fb21E+0x114>
80201e56: 06 65        	ld	a0, 64(sp)
80201e58: 91 46        	addi	a3, zero, 4
80201e5a: a3 0f d1 04  	sb	a3, 95(sp)
80201e5e: 81 45        	mv	a1, zero
80201e60: 05 46        	addi	a2, zero, 1
80201e62: 97 10 00 00  	auipc	ra, 1
80201e66: e7 80 a0 60  	jalr	1546(ra)
80201e6a: 2a f8        	sd	a0, 48(sp)
80201e6c: 09 a0        	j	0x80201e6e <_ZN4spin4once13Once$LT$T$GT$9call_once17h3e2209319c85fb21E+0x72>
80201e6e: 42 75        	ld	a0, 48(sp)
80201e70: aa e8        	sd	a0, 80(sp)
80201e72: 81 45        	mv	a1, zero
80201e74: e3 1c b5 fa  	bne	a0, a1, 0x80201e2c <_ZN4spin4once13Once$LT$T$GT$9call_once17h3e2209319c85fb21E+0x30>
80201e78: 09 a0        	j	0x80201e7a <_ZN4spin4once13Once$LT$T$GT$9call_once17h3e2209319c85fb21E+0x7e>
80201e7a: 06 65        	ld	a0, 64(sp)
80201e7c: aa f0        	sd	a0, 96(sp)
80201e7e: 05 45        	addi	a0, zero, 1
80201e80: 23 04 a1 06  	sb	a0, 104(sp)
80201e84: 01 45        	mv	a0, zero
80201e86: a3 07 a1 46  	sb	a0, 1135(sp)
80201e8a: 88 1c        	addi	a0, sp, 624
80201e8c: 97 f0 ff ff  	auipc	ra, 1048575
80201e90: e7 80 20 36  	jalr	866(ra)
80201e94: 09 a0        	j	0x80201e96 <_ZN4spin4once13Once$LT$T$GT$9call_once17h3e2209319c85fb21E+0x9a>
80201e96: a8 18        	addi	a0, sp, 120
80201e98: 8c 1c        	addi	a1, sp, 624
80201e9a: 13 06 80 1f  	addi	a2, zero, 504
80201e9e: 97 50 00 00  	auipc	ra, 5
80201ea2: e7 80 c0 c0  	jalr	-1012(ra)
80201ea6: 06 65        	ld	a0, 64(sp)
80201ea8: 85 45        	addi	a1, zero, 1
80201eaa: ae f8        	sd	a1, 112(sp)
80201eac: 21 05        	addi	a0, a0, 8
80201eae: 2a f4        	sd	a0, 40(sp)
80201eb0: 23 30 a1 48  	sd	a0, 1152(sp)
80201eb4: 09 a0        	j	0x80201eb6 <_ZN4spin4once13Once$LT$T$GT$9call_once17h3e2209319c85fb21E+0xba>
80201eb6: 09 a0        	j	0x80201eb8 <_ZN4spin4once13Once$LT$T$GT$9call_once17h3e2209319c85fb21E+0xbc>
80201eb8: 22 75        	ld	a0, 40(sp)
80201eba: 8c 18        	addi	a1, sp, 112
80201ebc: 13 06 00 20  	addi	a2, zero, 512
80201ec0: 97 50 00 00  	auipc	ra, 5
80201ec4: e7 80 a0 be  	jalr	-1046(ra)
80201ec8: 06 65        	ld	a0, 64(sp)
80201eca: 81 45        	mv	a1, zero
80201ecc: 23 04 b1 06  	sb	a1, 104(sp)
80201ed0: 89 45        	addi	a1, zero, 2
80201ed2: ae e8        	sd	a1, 80(sp)
80201ed4: 11 46        	addi	a2, zero, 4
80201ed6: a3 06 c1 46  	sb	a2, 1133(sp)
80201eda: 97 10 00 00  	auipc	ra, 1
80201ede: e7 80 20 56  	jalr	1378(ra)
80201ee2: 09 a0        	j	0x80201ee4 <_ZN4spin4once13Once$LT$T$GT$9call_once17h3e2209319c85fb21E+0xe8>
80201ee4: 06 65        	ld	a0, 64(sp)
80201ee6: 97 00 00 00  	auipc	ra, 0
80201eea: e7 80 40 ed  	jalr	-300(ra)
80201eee: 2a f0        	sd	a0, 32(sp)
80201ef0: 09 a0        	j	0x80201ef2 <_ZN4spin4once13Once$LT$T$GT$9call_once17h3e2209319c85fb21E+0xf6>
80201ef2: 02 75        	ld	a0, 32(sp)
80201ef4: aa e4        	sd	a0, 72(sp)
80201ef6: 88 10        	addi	a0, sp, 96
80201ef8: 97 f0 ff ff  	auipc	ra, 1048575
80201efc: e7 80 40 49  	jalr	1172(ra)
80201f00: 09 a0        	j	0x80201f02 <_ZN4spin4once13Once$LT$T$GT$9call_once17h3e2209319c85fb21E+0x106>
80201f02: 03 45 f1 46  	lbu	a0, 1135(sp)
80201f06: 05 89        	andi	a0, a0, 1
80201f08: 81 45        	mv	a1, zero
80201f0a: 63 1a b5 06  	bne	a0, a1, 0x80201f7e <.LBB1_28+0x34>
80201f0e: 95 a0        	j	0x80201f72 <.LBB1_28+0x28>
80201f10: 97 f0 ff ff  	auipc	ra, 1048575
80201f14: e7 80 80 2c  	jalr	712(ra)
80201f18: 00 00        	unimp	

0000000080201f1a <.LBB1_25>:
80201f1a: 17 65 00 00  	auipc	a0, 6
80201f1e: 13 05 65 ba  	addi	a0, a0, -1114

0000000080201f22 <.LBB1_26>:
80201f22: 17 66 00 00  	auipc	a2, 6
80201f26: 13 06 66 bc  	addi	a2, a2, -1082
80201f2a: 93 05 80 02  	addi	a1, zero, 40
80201f2e: 97 30 00 00  	auipc	ra, 3
80201f32: e7 80 e0 c7  	jalr	-898(ra)
80201f36: 00 00        	unimp	
80201f38: 97 10 00 00  	auipc	ra, 1
80201f3c: e7 80 20 4c  	jalr	1218(ra)
80201f40: 81 a0        	j	0x80201f80 <.LBB1_28+0x36>

0000000080201f42 <.LBB1_27>:
80201f42: 17 65 00 00  	auipc	a0, 6
80201f46: 13 05 65 af  	addi	a0, a0, -1290

0000000080201f4a <.LBB1_28>:
80201f4a: 17 66 00 00  	auipc	a2, 6
80201f4e: 13 06 e6 b5  	addi	a2, a2, -1186
80201f52: c5 45        	addi	a1, zero, 17
80201f54: 97 30 00 00  	auipc	ra, 3
80201f58: e7 80 80 c5  	jalr	-936(ra)
80201f5c: 00 00        	unimp	
80201f5e: 06 65        	ld	a0, 64(sp)
80201f60: 97 00 00 00  	auipc	ra, 0
80201f64: e7 80 a0 e5  	jalr	-422(ra)
80201f68: 2a ec        	sd	a0, 24(sp)
80201f6a: 09 a0        	j	0x80201f6c <.LBB1_28+0x22>
80201f6c: 62 65        	ld	a0, 24(sp)
80201f6e: aa e4        	sd	a0, 72(sp)
80201f70: 49 bf        	j	0x80201f02 <_ZN4spin4once13Once$LT$T$GT$9call_once17h3e2209319c85fb21E+0x106>
80201f72: 26 65        	ld	a0, 72(sp)
80201f74: 83 30 81 48  	ld	ra, 1160(sp)
80201f78: 13 01 01 49  	addi	sp, sp, 1168
80201f7c: 82 80        	ret
80201f7e: d5 bf        	j	0x80201f72 <.LBB1_28+0x28>
80201f80: 06 65        	ld	a0, 64(sp)
80201f82: 91 45        	addi	a1, zero, 4
80201f84: 23 07 b1 46  	sb	a1, 1134(sp)
80201f88: 97 10 00 00  	auipc	ra, 1
80201f8c: e7 80 60 48  	jalr	1158(ra)
80201f90: 2a e8        	sd	a0, 16(sp)
80201f92: 09 a0        	j	0x80201f94 <.LBB1_28+0x4a>
80201f94: 42 65        	ld	a0, 16(sp)
80201f96: aa e8        	sd	a0, 80(sp)
80201f98: 51 bd        	j	0x80201e2c <_ZN4spin4once13Once$LT$T$GT$9call_once17h3e2209319c85fb21E+0x30>

0000000080201f9a <_ZN4core5slice3raw14from_raw_parts17h4de984c1465533c6E>:
80201f9a: 39 71        	addi	sp, sp, -64
80201f9c: 06 fc        	sd	ra, 56(sp)
80201f9e: 2e ec        	sd	a1, 24(sp)
80201fa0: 2a f0        	sd	a0, 32(sp)
80201fa2: 2a f4        	sd	a0, 40(sp)
80201fa4: 2e f8        	sd	a1, 48(sp)
80201fa6: 97 00 00 00  	auipc	ra, 0
80201faa: e7 80 40 09  	jalr	148(ra)
80201fae: 09 a0        	j	0x80201fb0 <_ZN4core5slice3raw14from_raw_parts17h4de984c1465533c6E+0x16>
80201fb0: e2 65        	ld	a1, 24(sp)
80201fb2: 02 75        	ld	a0, 32(sp)
80201fb4: 97 20 00 00  	auipc	ra, 2
80201fb8: e7 80 e0 53  	jalr	1342(ra)
80201fbc: 2a e4        	sd	a0, 8(sp)
80201fbe: 2e e8        	sd	a1, 16(sp)
80201fc0: 09 a0        	j	0x80201fc2 <_ZN4core5slice3raw14from_raw_parts17h4de984c1465533c6E+0x28>
80201fc2: c2 65        	ld	a1, 16(sp)
80201fc4: 22 65        	ld	a0, 8(sp)
80201fc6: e2 70        	ld	ra, 56(sp)
80201fc8: 21 61        	addi	sp, sp, 64
80201fca: 82 80        	ret

0000000080201fcc <_ZN4core5slice3raw14from_raw_parts17hf0f60010cb01d67fE>:
80201fcc: 39 71        	addi	sp, sp, -64
80201fce: 06 fc        	sd	ra, 56(sp)
80201fd0: 2e ec        	sd	a1, 24(sp)
80201fd2: 2a f0        	sd	a0, 32(sp)
80201fd4: 2a f4        	sd	a0, 40(sp)
80201fd6: 2e f8        	sd	a1, 48(sp)
80201fd8: 97 00 00 00  	auipc	ra, 0
80201fdc: e7 80 80 05  	jalr	88(ra)
80201fe0: 09 a0        	j	0x80201fe2 <_ZN4core5slice3raw14from_raw_parts17hf0f60010cb01d67fE+0x16>
80201fe2: e2 65        	ld	a1, 24(sp)
80201fe4: 02 75        	ld	a0, 32(sp)
80201fe6: 97 10 00 00  	auipc	ra, 1
80201fea: e7 80 a0 53  	jalr	1338(ra)
80201fee: 2a e4        	sd	a0, 8(sp)
80201ff0: 2e e8        	sd	a1, 16(sp)
80201ff2: 09 a0        	j	0x80201ff4 <_ZN4core5slice3raw14from_raw_parts17hf0f60010cb01d67fE+0x28>
80201ff4: c2 65        	ld	a1, 16(sp)
80201ff6: 22 65        	ld	a0, 8(sp)
80201ff8: e2 70        	ld	ra, 56(sp)
80201ffa: 21 61        	addi	sp, sp, 64
80201ffc: 82 80        	ret

0000000080201ffe <_ZN4core5slice3raw18from_raw_parts_mut17hb1cc42b1578ac6d1E>:
80201ffe: 39 71        	addi	sp, sp, -64
80202000: 06 fc        	sd	ra, 56(sp)
80202002: 2e ec        	sd	a1, 24(sp)
80202004: 2a f0        	sd	a0, 32(sp)
80202006: 2a f4        	sd	a0, 40(sp)
80202008: 2e f8        	sd	a1, 48(sp)
8020200a: 97 00 00 00  	auipc	ra, 0
8020200e: e7 80 60 02  	jalr	38(ra)
80202012: 09 a0        	j	0x80202014 <_ZN4core5slice3raw18from_raw_parts_mut17hb1cc42b1578ac6d1E+0x16>
80202014: e2 65        	ld	a1, 24(sp)
80202016: 02 75        	ld	a0, 32(sp)
80202018: 97 20 00 00  	auipc	ra, 2
8020201c: e7 80 c0 50  	jalr	1292(ra)
80202020: 2a e4        	sd	a0, 8(sp)
80202022: 2e e8        	sd	a1, 16(sp)
80202024: 09 a0        	j	0x80202026 <_ZN4core5slice3raw18from_raw_parts_mut17hb1cc42b1578ac6d1E+0x28>
80202026: c2 65        	ld	a1, 16(sp)
80202028: 22 65        	ld	a0, 8(sp)
8020202a: e2 70        	ld	ra, 56(sp)
8020202c: 21 61        	addi	sp, sp, 64
8020202e: 82 80        	ret

0000000080202030 <_ZN4core5slice3raw20debug_check_data_len17h3386b24f4d6125bbE>:
80202030: 41 11        	addi	sp, sp, -16
80202032: 2a e0        	sd	a0, 0(sp)
80202034: 2e e4        	sd	a1, 8(sp)
80202036: 41 01        	addi	sp, sp, 16
80202038: 82 80        	ret

000000008020203a <_ZN4core5slice3raw20debug_check_data_len17h88904884179e92d1E>:
8020203a: 41 11        	addi	sp, sp, -16
8020203c: 2a e0        	sd	a0, 0(sp)
8020203e: 2e e4        	sd	a1, 8(sp)
80202040: 41 01        	addi	sp, sp, 16
80202042: 82 80        	ret

0000000080202044 <_ZN63_$LT$I$u20$as$u20$core..iter..traits..collect..IntoIterator$GT$9into_iter17hc9b4b3ffc432bfa5E>:
80202044: 41 11        	addi	sp, sp, -16
80202046: 2a e0        	sd	a0, 0(sp)
80202048: 2e e4        	sd	a1, 8(sp)
8020204a: 41 01        	addi	sp, sp, 16
8020204c: 82 80        	ret

000000008020204e <_ZN63_$LT$I$u20$as$u20$core..iter..traits..collect..IntoIterator$GT$9into_iter17hd52a874130efe6e4E>:
8020204e: 41 11        	addi	sp, sp, -16
80202050: 2a e0        	sd	a0, 0(sp)
80202052: 2e e4        	sd	a1, 8(sp)
80202054: 41 01        	addi	sp, sp, 16
80202056: 82 80        	ret

0000000080202058 <_ZN4core4iter6traits8iterator8Iterator9enumerate17h940d56ce410af6caE>:
80202058: 01 11        	addi	sp, sp, -32
8020205a: 06 ec        	sd	ra, 24(sp)
8020205c: 2e e4        	sd	a1, 8(sp)
8020205e: 32 e8        	sd	a2, 16(sp)
80202060: 97 f0 ff ff  	auipc	ra, 1048575
80202064: e7 80 e0 5f  	jalr	1534(ra)
80202068: 09 a0        	j	0x8020206a <_ZN4core4iter6traits8iterator8Iterator9enumerate17h940d56ce410af6caE+0x12>
8020206a: e2 60        	ld	ra, 24(sp)
8020206c: 05 61        	addi	sp, sp, 32
8020206e: 82 80        	ret

0000000080202070 <_ZN4core5slice4iter13Iter$LT$T$GT$3new17h64c86c5df9da13f1E>:
80202070: 71 71        	addi	sp, sp, -176
80202072: 06 f5        	sd	ra, 168(sp)
80202074: 2e ec        	sd	a1, 24(sp)
80202076: aa e0        	sd	a0, 64(sp)
80202078: ae e4        	sd	a1, 72(sp)
8020207a: 97 10 00 00  	auipc	ra, 1
8020207e: e7 80 40 af  	jalr	-1292(ra)
80202082: aa 85        	mv	a1, a0
80202084: 2e f0        	sd	a1, 32(sp)
80202086: aa e8        	sd	a0, 80(sp)
80202088: 09 a0        	j	0x8020208a <_ZN4core5slice4iter13Iter$LT$T$GT$3new17h64c86c5df9da13f1E+0x1a>
8020208a: 02 75        	ld	a0, 32(sp)
8020208c: 97 f0 ff ff  	auipc	ra, 1048575
80202090: e7 80 e0 69  	jalr	1694(ra)
80202094: 09 a0        	j	0x80202096 <_ZN4core5slice4iter13Iter$LT$T$GT$3new17h64c86c5df9da13f1E+0x26>
80202096: 09 a0        	j	0x80202098 <_ZN4core5slice4iter13Iter$LT$T$GT$3new17h64c86c5df9da13f1E+0x28>
80202098: 09 a0        	j	0x8020209a <_ZN4core5slice4iter13Iter$LT$T$GT$3new17h64c86c5df9da13f1E+0x2a>
8020209a: 81 45        	mv	a1, zero
8020209c: 05 45        	addi	a0, zero, 1
8020209e: 63 1d b5 00  	bne	a0, a1, 0x802020b8 <_ZN4core5slice4iter13Iter$LT$T$GT$3new17h64c86c5df9da13f1E+0x48>
802020a2: 09 a0        	j	0x802020a4 <_ZN4core5slice4iter13Iter$LT$T$GT$3new17h64c86c5df9da13f1E+0x34>
802020a4: 02 75        	ld	a0, 32(sp)
802020a6: e2 65        	ld	a1, 24(sp)
802020a8: 2a e1        	sd	a0, 128(sp)
802020aa: 2e e5        	sd	a1, 136(sp)
802020ac: 2a e9        	sd	a0, 144(sp)
802020ae: 2e ed        	sd	a1, 152(sp)
802020b0: 2e 95        	add	a0, a0, a1
802020b2: 2a e8        	sd	a0, 16(sp)
802020b4: 2a f1        	sd	a0, 160(sp)
802020b6: 1d a0        	j	0x802020dc <_ZN4core5slice4iter13Iter$LT$T$GT$3new17h64c86c5df9da13f1E+0x6c>
802020b8: 02 75        	ld	a0, 32(sp)
802020ba: e2 65        	ld	a1, 24(sp)
802020bc: aa ec        	sd	a0, 88(sp)
802020be: ae f0        	sd	a1, 96(sp)
802020c0: aa f4        	sd	a0, 104(sp)
802020c2: ae f8        	sd	a1, 112(sp)
802020c4: 2e 95        	add	a0, a0, a1
802020c6: aa fc        	sd	a0, 120(sp)
802020c8: 2a fc        	sd	a0, 56(sp)
802020ca: 09 a0        	j	0x802020cc <_ZN4core5slice4iter13Iter$LT$T$GT$3new17h64c86c5df9da13f1E+0x5c>
802020cc: 09 a0        	j	0x802020ce <_ZN4core5slice4iter13Iter$LT$T$GT$3new17h64c86c5df9da13f1E+0x5e>
802020ce: 02 75        	ld	a0, 32(sp)
802020d0: 97 20 00 00  	auipc	ra, 2
802020d4: e7 80 a0 34  	jalr	842(ra)
802020d8: 2a e4        	sd	a0, 8(sp)
802020da: 21 a0        	j	0x802020e2 <_ZN4core5slice4iter13Iter$LT$T$GT$3new17h64c86c5df9da13f1E+0x72>
802020dc: 42 65        	ld	a0, 16(sp)
802020de: 2a fc        	sd	a0, 56(sp)
802020e0: fd b7        	j	0x802020ce <_ZN4core5slice4iter13Iter$LT$T$GT$3new17h64c86c5df9da13f1E+0x5e>
802020e2: 22 65        	ld	a0, 8(sp)
802020e4: e2 75        	ld	a1, 56(sp)
802020e6: 2a f4        	sd	a0, 40(sp)
802020e8: 2e f8        	sd	a1, 48(sp)
802020ea: aa 70        	ld	ra, 168(sp)
802020ec: 4d 61        	addi	sp, sp, 176
802020ee: 82 80        	ret

00000000802020f0 <_ZN4core5slice4iter16IterMut$LT$T$GT$3new17h51de14ff10c61a68E>:
802020f0: 71 71        	addi	sp, sp, -176
802020f2: 06 f5        	sd	ra, 168(sp)
802020f4: 2e ec        	sd	a1, 24(sp)
802020f6: aa e0        	sd	a0, 64(sp)
802020f8: ae e4        	sd	a1, 72(sp)
802020fa: 97 10 00 00  	auipc	ra, 1
802020fe: e7 80 e0 a7  	jalr	-1410(ra)
80202102: aa 85        	mv	a1, a0
80202104: 2e f0        	sd	a1, 32(sp)
80202106: aa e8        	sd	a0, 80(sp)
80202108: 09 a0        	j	0x8020210a <_ZN4core5slice4iter16IterMut$LT$T$GT$3new17h51de14ff10c61a68E+0x1a>
8020210a: 02 75        	ld	a0, 32(sp)
8020210c: 97 20 00 00  	auipc	ra, 2
80202110: e7 80 80 39  	jalr	920(ra)
80202114: 09 a0        	j	0x80202116 <_ZN4core5slice4iter16IterMut$LT$T$GT$3new17h51de14ff10c61a68E+0x26>
80202116: 09 a0        	j	0x80202118 <_ZN4core5slice4iter16IterMut$LT$T$GT$3new17h51de14ff10c61a68E+0x28>
80202118: 09 a0        	j	0x8020211a <_ZN4core5slice4iter16IterMut$LT$T$GT$3new17h51de14ff10c61a68E+0x2a>
8020211a: 81 45        	mv	a1, zero
8020211c: 05 45        	addi	a0, zero, 1
8020211e: 63 1d b5 00  	bne	a0, a1, 0x80202138 <_ZN4core5slice4iter16IterMut$LT$T$GT$3new17h51de14ff10c61a68E+0x48>
80202122: 09 a0        	j	0x80202124 <_ZN4core5slice4iter16IterMut$LT$T$GT$3new17h51de14ff10c61a68E+0x34>
80202124: 02 75        	ld	a0, 32(sp)
80202126: e2 65        	ld	a1, 24(sp)
80202128: 2a e1        	sd	a0, 128(sp)
8020212a: 2e e5        	sd	a1, 136(sp)
8020212c: 2a e9        	sd	a0, 144(sp)
8020212e: 2e ed        	sd	a1, 152(sp)
80202130: 2e 95        	add	a0, a0, a1
80202132: 2a e8        	sd	a0, 16(sp)
80202134: 2a f1        	sd	a0, 160(sp)
80202136: 1d a0        	j	0x8020215c <_ZN4core5slice4iter16IterMut$LT$T$GT$3new17h51de14ff10c61a68E+0x6c>
80202138: 02 75        	ld	a0, 32(sp)
8020213a: e2 65        	ld	a1, 24(sp)
8020213c: aa ec        	sd	a0, 88(sp)
8020213e: ae f0        	sd	a1, 96(sp)
80202140: aa f4        	sd	a0, 104(sp)
80202142: ae f8        	sd	a1, 112(sp)
80202144: 2e 95        	add	a0, a0, a1
80202146: aa fc        	sd	a0, 120(sp)
80202148: 2a fc        	sd	a0, 56(sp)
8020214a: 09 a0        	j	0x8020214c <_ZN4core5slice4iter16IterMut$LT$T$GT$3new17h51de14ff10c61a68E+0x5c>
8020214c: 09 a0        	j	0x8020214e <_ZN4core5slice4iter16IterMut$LT$T$GT$3new17h51de14ff10c61a68E+0x5e>
8020214e: 02 75        	ld	a0, 32(sp)
80202150: 97 20 00 00  	auipc	ra, 2
80202154: e7 80 a0 2c  	jalr	714(ra)
80202158: 2a e4        	sd	a0, 8(sp)
8020215a: 21 a0        	j	0x80202162 <_ZN4core5slice4iter16IterMut$LT$T$GT$3new17h51de14ff10c61a68E+0x72>
8020215c: 42 65        	ld	a0, 16(sp)
8020215e: 2a fc        	sd	a0, 56(sp)
80202160: fd b7        	j	0x8020214e <_ZN4core5slice4iter16IterMut$LT$T$GT$3new17h51de14ff10c61a68E+0x5e>
80202162: 22 65        	ld	a0, 8(sp)
80202164: e2 75        	ld	a1, 56(sp)
80202166: 2a f4        	sd	a0, 40(sp)
80202168: 2e f8        	sd	a1, 48(sp)
8020216a: aa 70        	ld	ra, 168(sp)
8020216c: 4d 61        	addi	sp, sp, 176
8020216e: 82 80        	ret

0000000080202170 <_ZN4core5slice4iter16IterMut$LT$T$GT$3new17h80e1fd7f8d7eade0E>:
80202170: 71 71        	addi	sp, sp, -176
80202172: 06 f5        	sd	ra, 168(sp)
80202174: 2e ec        	sd	a1, 24(sp)
80202176: aa e0        	sd	a0, 64(sp)
80202178: ae e4        	sd	a1, 72(sp)
8020217a: 97 10 00 00  	auipc	ra, 1
8020217e: e7 80 40 17  	jalr	372(ra)
80202182: aa 85        	mv	a1, a0
80202184: 2e f0        	sd	a1, 32(sp)
80202186: aa e8        	sd	a0, 80(sp)
80202188: 09 a0        	j	0x8020218a <_ZN4core5slice4iter16IterMut$LT$T$GT$3new17h80e1fd7f8d7eade0E+0x1a>
8020218a: 02 75        	ld	a0, 32(sp)
8020218c: 97 10 00 00  	auipc	ra, 1
80202190: e7 80 00 14  	jalr	320(ra)
80202194: 09 a0        	j	0x80202196 <_ZN4core5slice4iter16IterMut$LT$T$GT$3new17h80e1fd7f8d7eade0E+0x26>
80202196: 09 a0        	j	0x80202198 <_ZN4core5slice4iter16IterMut$LT$T$GT$3new17h80e1fd7f8d7eade0E+0x28>
80202198: 09 a0        	j	0x8020219a <_ZN4core5slice4iter16IterMut$LT$T$GT$3new17h80e1fd7f8d7eade0E+0x2a>
8020219a: 81 45        	mv	a1, zero
8020219c: 05 45        	addi	a0, zero, 1
8020219e: 63 1d b5 00  	bne	a0, a1, 0x802021b8 <_ZN4core5slice4iter16IterMut$LT$T$GT$3new17h80e1fd7f8d7eade0E+0x48>
802021a2: 09 a0        	j	0x802021a4 <_ZN4core5slice4iter16IterMut$LT$T$GT$3new17h80e1fd7f8d7eade0E+0x34>
802021a4: 02 75        	ld	a0, 32(sp)
802021a6: e2 65        	ld	a1, 24(sp)
802021a8: 2a e1        	sd	a0, 128(sp)
802021aa: 2e e5        	sd	a1, 136(sp)
802021ac: 2a e9        	sd	a0, 144(sp)
802021ae: 2e ed        	sd	a1, 152(sp)
802021b0: 2e 95        	add	a0, a0, a1
802021b2: 2a e8        	sd	a0, 16(sp)
802021b4: 2a f1        	sd	a0, 160(sp)
802021b6: 3d a0        	j	0x802021e4 <_ZN4core5slice4iter16IterMut$LT$T$GT$3new17h80e1fd7f8d7eade0E+0x74>
802021b8: 02 75        	ld	a0, 32(sp)
802021ba: e2 65        	ld	a1, 24(sp)
802021bc: aa ec        	sd	a0, 88(sp)
802021be: ae f0        	sd	a1, 96(sp)
802021c0: aa f4        	sd	a0, 104(sp)
802021c2: ae f8        	sd	a1, 112(sp)
802021c4: 13 06 80 07  	addi	a2, zero, 120
802021c8: b3 85 c5 02  	mul	a1, a1, a2
802021cc: 2e 95        	add	a0, a0, a1
802021ce: aa fc        	sd	a0, 120(sp)
802021d0: 2a fc        	sd	a0, 56(sp)
802021d2: 09 a0        	j	0x802021d4 <_ZN4core5slice4iter16IterMut$LT$T$GT$3new17h80e1fd7f8d7eade0E+0x64>
802021d4: 09 a0        	j	0x802021d6 <_ZN4core5slice4iter16IterMut$LT$T$GT$3new17h80e1fd7f8d7eade0E+0x66>
802021d6: 02 75        	ld	a0, 32(sp)
802021d8: 97 10 00 00  	auipc	ra, 1
802021dc: e7 80 80 a6  	jalr	-1432(ra)
802021e0: 2a e4        	sd	a0, 8(sp)
802021e2: 21 a0        	j	0x802021ea <_ZN4core5slice4iter16IterMut$LT$T$GT$3new17h80e1fd7f8d7eade0E+0x7a>
802021e4: 42 65        	ld	a0, 16(sp)
802021e6: 2a fc        	sd	a0, 56(sp)
802021e8: fd b7        	j	0x802021d6 <_ZN4core5slice4iter16IterMut$LT$T$GT$3new17h80e1fd7f8d7eade0E+0x66>
802021ea: 22 65        	ld	a0, 8(sp)
802021ec: e2 75        	ld	a1, 56(sp)
802021ee: 2a f4        	sd	a0, 40(sp)
802021f0: 2e f8        	sd	a1, 48(sp)
802021f2: aa 70        	ld	ra, 168(sp)
802021f4: 4d 61        	addi	sp, sp, 176
802021f6: 82 80        	ret

00000000802021f8 <_ZN91_$LT$core..slice..iter..Iter$LT$T$GT$$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4next17had3bc9f48be68edaE>:
802021f8: 19 71        	addi	sp, sp, -128
802021fa: 86 fc        	sd	ra, 120(sp)
802021fc: 2a f0        	sd	a0, 32(sp)
802021fe: 2a fc        	sd	a0, 56(sp)
80202200: 08 61        	ld	a0, 0(a0)
80202202: 97 20 00 00  	auipc	ra, 2
80202206: e7 80 20 22  	jalr	546(ra)
8020220a: 2a f4        	sd	a0, 40(sp)
8020220c: 09 a0        	j	0x8020220e <_ZN91_$LT$core..slice..iter..Iter$LT$T$GT$$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4next17had3bc9f48be68edaE+0x16>
8020220e: 22 75        	ld	a0, 40(sp)
80202210: 97 20 00 00  	auipc	ra, 2
80202214: e7 80 40 29  	jalr	660(ra)
80202218: 09 a0        	j	0x8020221a <_ZN91_$LT$core..slice..iter..Iter$LT$T$GT$$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4next17had3bc9f48be68edaE+0x22>
8020221a: 09 a0        	j	0x8020221c <_ZN91_$LT$core..slice..iter..Iter$LT$T$GT$$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4next17had3bc9f48be68edaE+0x24>
8020221c: 09 a0        	j	0x8020221e <_ZN91_$LT$core..slice..iter..Iter$LT$T$GT$$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4next17had3bc9f48be68edaE+0x26>
8020221e: 81 45        	mv	a1, zero
80202220: 05 45        	addi	a0, zero, 1
80202222: 63 14 b5 00  	bne	a0, a1, 0x8020222a <_ZN91_$LT$core..slice..iter..Iter$LT$T$GT$$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4next17had3bc9f48be68edaE+0x32>
80202226: 09 a0        	j	0x80202228 <_ZN91_$LT$core..slice..iter..Iter$LT$T$GT$$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4next17had3bc9f48be68edaE+0x30>
80202228: 11 a8        	j	0x8020223c <_ZN91_$LT$core..slice..iter..Iter$LT$T$GT$$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4next17had3bc9f48be68edaE+0x44>
8020222a: 02 75        	ld	a0, 32(sp)
8020222c: 08 65        	ld	a0, 8(a0)
8020222e: 97 f0 ff ff  	auipc	ra, 1048575
80202232: e7 80 c0 4f  	jalr	1276(ra)
80202236: 09 a0        	j	0x80202238 <_ZN91_$LT$core..slice..iter..Iter$LT$T$GT$$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4next17had3bc9f48be68edaE+0x40>
80202238: 09 a0        	j	0x8020223a <_ZN91_$LT$core..slice..iter..Iter$LT$T$GT$$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4next17had3bc9f48be68edaE+0x42>
8020223a: 09 a0        	j	0x8020223c <_ZN91_$LT$core..slice..iter..Iter$LT$T$GT$$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4next17had3bc9f48be68edaE+0x44>
8020223c: 02 75        	ld	a0, 32(sp)
8020223e: 08 61        	ld	a0, 0(a0)
80202240: 97 20 00 00  	auipc	ra, 2
80202244: e7 80 40 1e  	jalr	484(ra)
80202248: 2a ec        	sd	a0, 24(sp)
8020224a: 09 a0        	j	0x8020224c <_ZN91_$LT$core..slice..iter..Iter$LT$T$GT$$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4next17had3bc9f48be68edaE+0x54>
8020224c: 62 65        	ld	a0, 24(sp)
8020224e: 82 75        	ld	a1, 32(sp)
80202250: 8c 65        	ld	a1, 8(a1)
80202252: 63 06 b5 04  	beq	a0, a1, 0x8020229e <_ZN91_$LT$core..slice..iter..Iter$LT$T$GT$$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4next17had3bc9f48be68edaE+0xa6>
80202256: 09 a0        	j	0x80202258 <_ZN91_$LT$core..slice..iter..Iter$LT$T$GT$$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4next17had3bc9f48be68edaE+0x60>
80202258: 02 75        	ld	a0, 32(sp)
8020225a: aa e4        	sd	a0, 72(sp)
8020225c: 85 45        	addi	a1, zero, 1
8020225e: 2e e0        	sd	a1, 0(sp)
80202260: ae e8        	sd	a1, 80(sp)
80202262: 08 61        	ld	a0, 0(a0)
80202264: 97 20 00 00  	auipc	ra, 2
80202268: e7 80 00 1c  	jalr	448(ra)
8020226c: aa 85        	mv	a1, a0
8020226e: 02 75        	ld	a0, 32(sp)
80202270: 2e e4        	sd	a1, 8(sp)
80202272: ae ec        	sd	a1, 88(sp)
80202274: 08 61        	ld	a0, 0(a0)
80202276: 97 20 00 00  	auipc	ra, 2
8020227a: e7 80 e0 1a  	jalr	430(ra)
8020227e: 82 65        	ld	a1, 0(sp)
80202280: aa f0        	sd	a0, 96(sp)
80202282: ae f4        	sd	a1, 104(sp)
80202284: 05 05        	addi	a0, a0, 1
80202286: aa f8        	sd	a0, 112(sp)
80202288: 97 20 00 00  	auipc	ra, 2
8020228c: e7 80 20 19  	jalr	402(ra)
80202290: 02 76        	ld	a2, 32(sp)
80202292: aa 85        	mv	a1, a0
80202294: 22 65        	ld	a0, 8(sp)
80202296: 0c e2        	sd	a1, 0(a2)
80202298: aa e0        	sd	a0, 64(sp)
8020229a: 2a e8        	sd	a0, 16(sp)
8020229c: 01 a8        	j	0x802022ac <_ZN91_$LT$core..slice..iter..Iter$LT$T$GT$$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4next17had3bc9f48be68edaE+0xb4>
8020229e: 01 45        	mv	a0, zero
802022a0: 2a f8        	sd	a0, 48(sp)
802022a2: 09 a0        	j	0x802022a4 <_ZN91_$LT$core..slice..iter..Iter$LT$T$GT$$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4next17had3bc9f48be68edaE+0xac>
802022a4: 42 75        	ld	a0, 48(sp)
802022a6: e6 70        	ld	ra, 120(sp)
802022a8: 09 61        	addi	sp, sp, 128
802022aa: 82 80        	ret
802022ac: 42 65        	ld	a0, 16(sp)
802022ae: 2a f8        	sd	a0, 48(sp)
802022b0: d5 bf        	j	0x802022a4 <_ZN91_$LT$core..slice..iter..Iter$LT$T$GT$$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4next17had3bc9f48be68edaE+0xac>

00000000802022b2 <_ZN94_$LT$core..slice..iter..IterMut$LT$T$GT$$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4next17h1d8f5dac58124d6dE>:
802022b2: 19 71        	addi	sp, sp, -128
802022b4: 86 fc        	sd	ra, 120(sp)
802022b6: 2a f0        	sd	a0, 32(sp)
802022b8: 2a fc        	sd	a0, 56(sp)
802022ba: 08 61        	ld	a0, 0(a0)
802022bc: 97 20 00 00  	auipc	ra, 2
802022c0: e7 80 80 16  	jalr	360(ra)
802022c4: 2a f4        	sd	a0, 40(sp)
802022c6: 09 a0        	j	0x802022c8 <_ZN94_$LT$core..slice..iter..IterMut$LT$T$GT$$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4next17h1d8f5dac58124d6dE+0x16>
802022c8: 22 75        	ld	a0, 40(sp)
802022ca: 97 20 00 00  	auipc	ra, 2
802022ce: e7 80 a0 1d  	jalr	474(ra)
802022d2: 09 a0        	j	0x802022d4 <_ZN94_$LT$core..slice..iter..IterMut$LT$T$GT$$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4next17h1d8f5dac58124d6dE+0x22>
802022d4: 09 a0        	j	0x802022d6 <_ZN94_$LT$core..slice..iter..IterMut$LT$T$GT$$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4next17h1d8f5dac58124d6dE+0x24>
802022d6: 09 a0        	j	0x802022d8 <_ZN94_$LT$core..slice..iter..IterMut$LT$T$GT$$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4next17h1d8f5dac58124d6dE+0x26>
802022d8: 81 45        	mv	a1, zero
802022da: 05 45        	addi	a0, zero, 1
802022dc: 63 14 b5 00  	bne	a0, a1, 0x802022e4 <_ZN94_$LT$core..slice..iter..IterMut$LT$T$GT$$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4next17h1d8f5dac58124d6dE+0x32>
802022e0: 09 a0        	j	0x802022e2 <_ZN94_$LT$core..slice..iter..IterMut$LT$T$GT$$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4next17h1d8f5dac58124d6dE+0x30>
802022e2: 11 a8        	j	0x802022f6 <_ZN94_$LT$core..slice..iter..IterMut$LT$T$GT$$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4next17h1d8f5dac58124d6dE+0x44>
802022e4: 02 75        	ld	a0, 32(sp)
802022e6: 08 65        	ld	a0, 8(a0)
802022e8: 97 20 00 00  	auipc	ra, 2
802022ec: e7 80 c0 1b  	jalr	444(ra)
802022f0: 09 a0        	j	0x802022f2 <_ZN94_$LT$core..slice..iter..IterMut$LT$T$GT$$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4next17h1d8f5dac58124d6dE+0x40>
802022f2: 09 a0        	j	0x802022f4 <_ZN94_$LT$core..slice..iter..IterMut$LT$T$GT$$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4next17h1d8f5dac58124d6dE+0x42>
802022f4: 09 a0        	j	0x802022f6 <_ZN94_$LT$core..slice..iter..IterMut$LT$T$GT$$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4next17h1d8f5dac58124d6dE+0x44>
802022f6: 02 75        	ld	a0, 32(sp)
802022f8: 08 61        	ld	a0, 0(a0)
802022fa: 97 20 00 00  	auipc	ra, 2
802022fe: e7 80 a0 12  	jalr	298(ra)
80202302: 2a ec        	sd	a0, 24(sp)
80202304: 09 a0        	j	0x80202306 <_ZN94_$LT$core..slice..iter..IterMut$LT$T$GT$$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4next17h1d8f5dac58124d6dE+0x54>
80202306: 62 65        	ld	a0, 24(sp)
80202308: 82 75        	ld	a1, 32(sp)
8020230a: 8c 65        	ld	a1, 8(a1)
8020230c: 63 06 b5 04  	beq	a0, a1, 0x80202358 <_ZN94_$LT$core..slice..iter..IterMut$LT$T$GT$$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4next17h1d8f5dac58124d6dE+0xa6>
80202310: 09 a0        	j	0x80202312 <_ZN94_$LT$core..slice..iter..IterMut$LT$T$GT$$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4next17h1d8f5dac58124d6dE+0x60>
80202312: 02 75        	ld	a0, 32(sp)
80202314: aa e4        	sd	a0, 72(sp)
80202316: 85 45        	addi	a1, zero, 1
80202318: 2e e0        	sd	a1, 0(sp)
8020231a: ae e8        	sd	a1, 80(sp)
8020231c: 08 61        	ld	a0, 0(a0)
8020231e: 97 20 00 00  	auipc	ra, 2
80202322: e7 80 60 10  	jalr	262(ra)
80202326: aa 85        	mv	a1, a0
80202328: 02 75        	ld	a0, 32(sp)
8020232a: 2e e4        	sd	a1, 8(sp)
8020232c: ae ec        	sd	a1, 88(sp)
8020232e: 08 61        	ld	a0, 0(a0)
80202330: 97 20 00 00  	auipc	ra, 2
80202334: e7 80 40 0f  	jalr	244(ra)
80202338: 82 65        	ld	a1, 0(sp)
8020233a: aa f0        	sd	a0, 96(sp)
8020233c: ae f4        	sd	a1, 104(sp)
8020233e: 05 05        	addi	a0, a0, 1
80202340: aa f8        	sd	a0, 112(sp)
80202342: 97 20 00 00  	auipc	ra, 2
80202346: e7 80 80 0d  	jalr	216(ra)
8020234a: 02 76        	ld	a2, 32(sp)
8020234c: aa 85        	mv	a1, a0
8020234e: 22 65        	ld	a0, 8(sp)
80202350: 0c e2        	sd	a1, 0(a2)
80202352: aa e0        	sd	a0, 64(sp)
80202354: 2a e8        	sd	a0, 16(sp)
80202356: 01 a8        	j	0x80202366 <_ZN94_$LT$core..slice..iter..IterMut$LT$T$GT$$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4next17h1d8f5dac58124d6dE+0xb4>
80202358: 01 45        	mv	a0, zero
8020235a: 2a f8        	sd	a0, 48(sp)
8020235c: 09 a0        	j	0x8020235e <_ZN94_$LT$core..slice..iter..IterMut$LT$T$GT$$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4next17h1d8f5dac58124d6dE+0xac>
8020235e: 42 75        	ld	a0, 48(sp)
80202360: e6 70        	ld	ra, 120(sp)
80202362: 09 61        	addi	sp, sp, 128
80202364: 82 80        	ret
80202366: 42 65        	ld	a0, 16(sp)
80202368: 2a f8        	sd	a0, 48(sp)
8020236a: d5 bf        	j	0x8020235e <_ZN94_$LT$core..slice..iter..IterMut$LT$T$GT$$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4next17h1d8f5dac58124d6dE+0xac>

000000008020236c <_ZN94_$LT$core..slice..iter..IterMut$LT$T$GT$$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4next17h3c4d04c71162d02eE>:
8020236c: 19 71        	addi	sp, sp, -128
8020236e: 86 fc        	sd	ra, 120(sp)
80202370: 2a f0        	sd	a0, 32(sp)
80202372: 2a fc        	sd	a0, 56(sp)
80202374: 08 61        	ld	a0, 0(a0)
80202376: 97 10 00 00  	auipc	ra, 1
8020237a: e7 80 40 8d  	jalr	-1836(ra)
8020237e: 2a f4        	sd	a0, 40(sp)
80202380: 09 a0        	j	0x80202382 <_ZN94_$LT$core..slice..iter..IterMut$LT$T$GT$$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4next17h3c4d04c71162d02eE+0x16>
80202382: 22 75        	ld	a0, 40(sp)
80202384: 97 10 00 00  	auipc	ra, 1
80202388: e7 80 80 f4  	jalr	-184(ra)
8020238c: 09 a0        	j	0x8020238e <_ZN94_$LT$core..slice..iter..IterMut$LT$T$GT$$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4next17h3c4d04c71162d02eE+0x22>
8020238e: 09 a0        	j	0x80202390 <_ZN94_$LT$core..slice..iter..IterMut$LT$T$GT$$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4next17h3c4d04c71162d02eE+0x24>
80202390: 09 a0        	j	0x80202392 <_ZN94_$LT$core..slice..iter..IterMut$LT$T$GT$$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4next17h3c4d04c71162d02eE+0x26>
80202392: 81 45        	mv	a1, zero
80202394: 05 45        	addi	a0, zero, 1
80202396: 63 14 b5 00  	bne	a0, a1, 0x8020239e <_ZN94_$LT$core..slice..iter..IterMut$LT$T$GT$$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4next17h3c4d04c71162d02eE+0x32>
8020239a: 09 a0        	j	0x8020239c <_ZN94_$LT$core..slice..iter..IterMut$LT$T$GT$$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4next17h3c4d04c71162d02eE+0x30>
8020239c: 11 a8        	j	0x802023b0 <_ZN94_$LT$core..slice..iter..IterMut$LT$T$GT$$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4next17h3c4d04c71162d02eE+0x44>
8020239e: 02 75        	ld	a0, 32(sp)
802023a0: 08 65        	ld	a0, 8(a0)
802023a2: 97 10 00 00  	auipc	ra, 1
802023a6: e7 80 a0 f2  	jalr	-214(ra)
802023aa: 09 a0        	j	0x802023ac <_ZN94_$LT$core..slice..iter..IterMut$LT$T$GT$$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4next17h3c4d04c71162d02eE+0x40>
802023ac: 09 a0        	j	0x802023ae <_ZN94_$LT$core..slice..iter..IterMut$LT$T$GT$$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4next17h3c4d04c71162d02eE+0x42>
802023ae: 09 a0        	j	0x802023b0 <_ZN94_$LT$core..slice..iter..IterMut$LT$T$GT$$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4next17h3c4d04c71162d02eE+0x44>
802023b0: 02 75        	ld	a0, 32(sp)
802023b2: 08 61        	ld	a0, 0(a0)
802023b4: 97 10 00 00  	auipc	ra, 1
802023b8: e7 80 60 89  	jalr	-1898(ra)
802023bc: 2a ec        	sd	a0, 24(sp)
802023be: 09 a0        	j	0x802023c0 <_ZN94_$LT$core..slice..iter..IterMut$LT$T$GT$$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4next17h3c4d04c71162d02eE+0x54>
802023c0: 62 65        	ld	a0, 24(sp)
802023c2: 82 75        	ld	a1, 32(sp)
802023c4: 8c 65        	ld	a1, 8(a1)
802023c6: 63 07 b5 04  	beq	a0, a1, 0x80202414 <_ZN94_$LT$core..slice..iter..IterMut$LT$T$GT$$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4next17h3c4d04c71162d02eE+0xa8>
802023ca: 09 a0        	j	0x802023cc <_ZN94_$LT$core..slice..iter..IterMut$LT$T$GT$$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4next17h3c4d04c71162d02eE+0x60>
802023cc: 02 75        	ld	a0, 32(sp)
802023ce: aa e4        	sd	a0, 72(sp)
802023d0: 85 45        	addi	a1, zero, 1
802023d2: 2e e0        	sd	a1, 0(sp)
802023d4: ae e8        	sd	a1, 80(sp)
802023d6: 08 61        	ld	a0, 0(a0)
802023d8: 97 10 00 00  	auipc	ra, 1
802023dc: e7 80 20 87  	jalr	-1934(ra)
802023e0: aa 85        	mv	a1, a0
802023e2: 02 75        	ld	a0, 32(sp)
802023e4: 2e e4        	sd	a1, 8(sp)
802023e6: ae ec        	sd	a1, 88(sp)
802023e8: 08 61        	ld	a0, 0(a0)
802023ea: 97 10 00 00  	auipc	ra, 1
802023ee: e7 80 00 86  	jalr	-1952(ra)
802023f2: 82 65        	ld	a1, 0(sp)
802023f4: aa f0        	sd	a0, 96(sp)
802023f6: ae f4        	sd	a1, 104(sp)
802023f8: 13 05 85 07  	addi	a0, a0, 120
802023fc: aa f8        	sd	a0, 112(sp)
802023fe: 97 10 00 00  	auipc	ra, 1
80202402: e7 80 20 84  	jalr	-1982(ra)
80202406: 02 76        	ld	a2, 32(sp)
80202408: aa 85        	mv	a1, a0
8020240a: 22 65        	ld	a0, 8(sp)
8020240c: 0c e2        	sd	a1, 0(a2)
8020240e: aa e0        	sd	a0, 64(sp)
80202410: 2a e8        	sd	a0, 16(sp)
80202412: 01 a8        	j	0x80202422 <_ZN94_$LT$core..slice..iter..IterMut$LT$T$GT$$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4next17h3c4d04c71162d02eE+0xb6>
80202414: 01 45        	mv	a0, zero
80202416: 2a f8        	sd	a0, 48(sp)
80202418: 09 a0        	j	0x8020241a <_ZN94_$LT$core..slice..iter..IterMut$LT$T$GT$$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4next17h3c4d04c71162d02eE+0xae>
8020241a: 42 75        	ld	a0, 48(sp)
8020241c: e6 70        	ld	ra, 120(sp)
8020241e: 09 61        	addi	sp, sp, 128
80202420: 82 80        	ret
80202422: 42 65        	ld	a0, 16(sp)
80202424: 2a f8        	sd	a0, 48(sp)
80202426: d5 bf        	j	0x8020241a <_ZN94_$LT$core..slice..iter..IterMut$LT$T$GT$$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4next17h3c4d04c71162d02eE+0xae>

0000000080202428 <_ZN4core3fmt9Arguments6new_v117h19fb42bbb0f5fc26E>:
80202428: 35 71        	addi	sp, sp, -160
8020242a: 06 ed        	sd	ra, 152(sp)
8020242c: 3a e4        	sd	a4, 8(sp)
8020242e: 36 e8        	sd	a3, 16(sp)
80202430: 32 ec        	sd	a2, 24(sp)
80202432: 2e f0        	sd	a1, 32(sp)
80202434: 2a f4        	sd	a0, 40(sp)
80202436: ae fc        	sd	a1, 120(sp)
80202438: 32 e1        	sd	a2, 128(sp)
8020243a: 36 e5        	sd	a3, 136(sp)
8020243c: 3a e9        	sd	a4, 144(sp)
8020243e: 63 6b e6 00  	bltu	a2, a4, 0x80202454 <_ZN4core3fmt9Arguments6new_v117h19fb42bbb0f5fc26E+0x2c>
80202442: 09 a0        	j	0x80202444 <_ZN4core3fmt9Arguments6new_v117h19fb42bbb0f5fc26E+0x1c>
80202444: e2 65        	ld	a1, 24(sp)
80202446: 22 65        	ld	a0, 8(sp)
80202448: 05 05        	addi	a0, a0, 1
8020244a: 33 35 b5 00  	sltu	a0, a0, a1
8020244e: a3 0b a1 02  	sb	a0, 55(sp)
80202452: 29 a0        	j	0x8020245c <_ZN4core3fmt9Arguments6new_v117h19fb42bbb0f5fc26E+0x34>
80202454: 05 45        	addi	a0, zero, 1
80202456: a3 0b a1 02  	sb	a0, 55(sp)
8020245a: 09 a0        	j	0x8020245c <_ZN4core3fmt9Arguments6new_v117h19fb42bbb0f5fc26E+0x34>
8020245c: 03 45 71 03  	lbu	a0, 55(sp)
80202460: 05 89        	andi	a0, a0, 1
80202462: 81 45        	mv	a1, zero
80202464: 63 15 b5 02  	bne	a0, a1, 0x8020248e <.LBB0_7>
80202468: 09 a0        	j	0x8020246a <_ZN4core3fmt9Arguments6new_v117h19fb42bbb0f5fc26E+0x42>
8020246a: 22 65        	ld	a0, 8(sp)
8020246c: a2 75        	ld	a1, 40(sp)
8020246e: 42 66        	ld	a2, 16(sp)
80202470: e2 66        	ld	a3, 24(sp)
80202472: 02 77        	ld	a4, 32(sp)
80202474: 81 47        	mv	a5, zero
80202476: be f4        	sd	a5, 104(sp)
80202478: 98 e1        	sd	a4, 0(a1)
8020247a: 94 e5        	sd	a3, 8(a1)
8020247c: 26 77        	ld	a4, 104(sp)
8020247e: c6 76        	ld	a3, 112(sp)
80202480: 98 e9        	sd	a4, 16(a1)
80202482: 94 ed        	sd	a3, 24(a1)
80202484: 90 f1        	sd	a2, 32(a1)
80202486: 88 f5        	sd	a0, 40(a1)
80202488: ea 60        	ld	ra, 152(sp)
8020248a: 0d 61        	addi	sp, sp, 160
8020248c: 82 80        	ret

000000008020248e <.LBB0_7>:
8020248e: 97 55 00 00  	auipc	a1, 5
80202492: 93 85 25 68  	addi	a1, a1, 1666

0000000080202496 <.LBB0_8>:
80202496: 97 56 00 00  	auipc	a3, 5
8020249a: 93 86 a6 68  	addi	a3, a3, 1674
8020249e: 28 18        	addi	a0, sp, 56
802024a0: 05 46        	addi	a2, zero, 1
802024a2: 01 47        	mv	a4, zero
802024a4: 97 00 00 00  	auipc	ra, 0
802024a8: e7 80 40 f8  	jalr	-124(ra)
802024ac: 09 a0        	j	0x802024ae <.LBB0_9>

00000000802024ae <.LBB0_9>:
802024ae: 97 55 00 00  	auipc	a1, 5
802024b2: 93 85 25 6c  	addi	a1, a1, 1730
802024b6: 28 18        	addi	a0, sp, 56
802024b8: 97 20 00 00  	auipc	ra, 2
802024bc: e7 80 00 76  	jalr	1888(ra)
802024c0: 00 00        	unimp	

00000000802024c2 <_ZN4core3fmt9Arguments16new_v1_formatted17h677b1639d9da8effE>:
802024c2: 5d 71        	addi	sp, sp, -80
802024c4: 2e ec        	sd	a1, 24(sp)
802024c6: 32 f0        	sd	a2, 32(sp)
802024c8: 36 f4        	sd	a3, 40(sp)
802024ca: 3a f8        	sd	a4, 48(sp)
802024cc: 3e fc        	sd	a5, 56(sp)
802024ce: c2 e0        	sd	a6, 64(sp)
802024d0: 3e e4        	sd	a5, 8(sp)
802024d2: 42 e8        	sd	a6, 16(sp)
802024d4: 0c e1        	sd	a1, 0(a0)
802024d6: 10 e5        	sd	a2, 8(a0)
802024d8: 22 66        	ld	a2, 8(sp)
802024da: c2 65        	ld	a1, 16(sp)
802024dc: 10 e9        	sd	a2, 16(a0)
802024de: 0c ed        	sd	a1, 24(a0)
802024e0: 14 f1        	sd	a3, 32(a0)
802024e2: 18 f5        	sd	a4, 40(a0)
802024e4: 61 61        	addi	sp, sp, 80
802024e6: 82 80        	ret

00000000802024e8 <_ZN4core4iter6traits8iterator8Iterator8for_each4call17hb25e1c8dae220c1eE>:
802024e8: 41 11        	addi	sp, sp, -16
802024ea: 41 01        	addi	sp, sp, 16
802024ec: 82 80        	ret

00000000802024ee <_ZN4core4iter6traits8iterator8Iterator8for_each4call28_$u7b$$u7b$closure$u7d$$u7d$17h63c53557aa70739fE>:
802024ee: 79 71        	addi	sp, sp, -48
802024f0: 06 f4        	sd	ra, 40(sp)
802024f2: 2a e8        	sd	a0, 16(sp)
802024f4: 2e f0        	sd	a1, 32(sp)
802024f6: 2e e4        	sd	a1, 8(sp)
802024f8: 97 e0 ff ff  	auipc	ra, 1048574
802024fc: e7 80 80 db  	jalr	-584(ra)
80202500: 09 a0        	j	0x80202502 <_ZN4core4iter6traits8iterator8Iterator8for_each4call28_$u7b$$u7b$closure$u7d$$u7d$17h63c53557aa70739fE+0x14>
80202502: a2 70        	ld	ra, 40(sp)
80202504: 45 61        	addi	sp, sp, 48
80202506: 82 80        	ret

0000000080202508 <_ZN4core4iter6traits8iterator8Iterator4find5check17ha942355cc1fcacd6E>:
80202508: 41 11        	addi	sp, sp, -16
8020250a: 2a e4        	sd	a0, 8(sp)
8020250c: 2a e0        	sd	a0, 0(sp)
8020250e: 41 01        	addi	sp, sp, 16
80202510: 82 80        	ret

0000000080202512 <_ZN4core4iter6traits8iterator8Iterator4find5check28_$u7b$$u7b$closure$u7d$$u7d$17hf0d95aa1caad26c3E>:
80202512: 5d 71        	addi	sp, sp, -80
80202514: 86 e4        	sd	ra, 72(sp)
80202516: 2e e8        	sd	a1, 16(sp)
80202518: 2a fc        	sd	a0, 56(sp)
8020251a: 85 45        	addi	a1, zero, 1
8020251c: a3 0b b1 02  	sb	a1, 55(sp)
80202520: 0c 08        	addi	a1, sp, 16
80202522: 2e f4        	sd	a1, 40(sp)
80202524: 97 00 00 00  	auipc	ra, 0
80202528: e7 80 20 09  	jalr	146(ra)
8020252c: 2a e4        	sd	a0, 8(sp)
8020252e: 09 a0        	j	0x80202530 <_ZN4core4iter6traits8iterator8Iterator4find5check28_$u7b$$u7b$closure$u7d$$u7d$17hf0d95aa1caad26c3E+0x1e>
80202530: 22 65        	ld	a0, 8(sp)
80202532: 81 45        	mv	a1, zero
80202534: 63 1c b5 00  	bne	a0, a1, 0x8020254c <.LBB3_7+0x12>
80202538: 09 a0        	j	0x8020253a <.LBB3_7>

000000008020253a <.LBB3_7>:
8020253a: 17 55 00 00  	auipc	a0, 5
8020253e: 13 05 e5 b7  	addi	a0, a0, -1154
80202542: 0c 61        	ld	a1, 0(a0)
80202544: 08 65        	ld	a0, 8(a0)
80202546: 2e ec        	sd	a1, 24(sp)
80202548: 2a f0        	sd	a0, 32(sp)
8020254a: 09 a8        	j	0x8020255c <.LBB3_7+0x22>
8020254c: 01 45        	mv	a0, zero
8020254e: a3 0b a1 02  	sb	a0, 55(sp)
80202552: 42 65        	ld	a0, 16(sp)
80202554: 2a f0        	sd	a0, 32(sp)
80202556: 05 45        	addi	a0, zero, 1
80202558: 2a ec        	sd	a0, 24(sp)
8020255a: 09 a0        	j	0x8020255c <.LBB3_7+0x22>
8020255c: 03 45 71 03  	lbu	a0, 55(sp)
80202560: 05 89        	andi	a0, a0, 1
80202562: 81 45        	mv	a1, zero
80202564: 63 18 b5 00  	bne	a0, a1, 0x80202574 <.LBB3_7+0x3a>
80202568: 09 a0        	j	0x8020256a <.LBB3_7+0x30>
8020256a: 62 65        	ld	a0, 24(sp)
8020256c: 82 75        	ld	a1, 32(sp)
8020256e: a6 60        	ld	ra, 72(sp)
80202570: 61 61        	addi	sp, sp, 80
80202572: 82 80        	ret
80202574: dd bf        	j	0x8020256a <.LBB3_7+0x30>

0000000080202576 <_ZN2os4task11TaskManager14find_next_task28_$u7b$$u7b$closure$u7d$$u7d$17hac00f9503be1b407E>:
80202576: 01 11        	addi	sp, sp, -32
80202578: 2e e0        	sd	a1, 0(sp)
8020257a: 2a e8        	sd	a0, 16(sp)
8020257c: 2e ec        	sd	a1, 24(sp)
8020257e: 08 61        	ld	a0, 0(a0)
80202580: 08 61        	ld	a0, 0(a0)
80202582: 2a e4        	sd	a0, 8(sp)
80202584: 81 45        	mv	a1, zero
80202586: 63 09 b5 00  	beq	a0, a1, 0x80202598 <.LBB0_3>
8020258a: 09 a0        	j	0x8020258c <_ZN2os4task11TaskManager14find_next_task28_$u7b$$u7b$closure$u7d$$u7d$17hac00f9503be1b407E+0x16>
8020258c: 02 65        	ld	a0, 0(sp)
8020258e: a2 65        	ld	a1, 8(sp)
80202590: 33 75 b5 02  	remu	a0, a0, a1
80202594: 05 61        	addi	sp, sp, 32
80202596: 82 80        	ret

0000000080202598 <.LBB0_3>:
80202598: 17 55 00 00  	auipc	a0, 5
8020259c: 13 05 85 61  	addi	a0, a0, 1560

00000000802025a0 <.LBB0_4>:
802025a0: 17 56 00 00  	auipc	a2, 5
802025a4: 13 06 86 5f  	addi	a2, a2, 1528
802025a8: 93 05 90 03  	addi	a1, zero, 57
802025ac: 97 20 00 00  	auipc	ra, 2
802025b0: e7 80 00 60  	jalr	1536(ra)
802025b4: 00 00        	unimp	

00000000802025b6 <_ZN2os4task11TaskManager14find_next_task28_$u7b$$u7b$closure$u7d$$u7d$17heed504db75ebd598E>:
802025b6: 39 71        	addi	sp, sp, -64
802025b8: 06 fc        	sd	ra, 56(sp)
802025ba: 2e ec        	sd	a1, 24(sp)
802025bc: 2a f4        	sd	a0, 40(sp)
802025be: 2e f8        	sd	a1, 48(sp)
802025c0: 08 61        	ld	a0, 0(a0)
802025c2: 97 e0 ff ff  	auipc	ra, 1048574
802025c6: e7 80 20 c8  	jalr	-894(ra)
802025ca: 2a f0        	sd	a0, 32(sp)
802025cc: 09 a0        	j	0x802025ce <_ZN2os4task11TaskManager14find_next_task28_$u7b$$u7b$closure$u7d$$u7d$17heed504db75ebd598E+0x18>
802025ce: 62 65        	ld	a0, 24(sp)
802025d0: 0c 61        	ld	a1, 0(a0)
802025d2: 2e e8        	sd	a1, 16(sp)
802025d4: 0d 45        	addi	a0, zero, 3
802025d6: 63 66 b5 02  	bltu	a0, a1, 0x80202602 <.LBB1_5+0x14>
802025da: 09 a0        	j	0x802025dc <_ZN2os4task11TaskManager14find_next_task28_$u7b$$u7b$closure$u7d$$u7d$17heed504db75ebd598E+0x26>
802025dc: 02 75        	ld	a0, 32(sp)
802025de: c2 65        	ld	a1, 16(sp)
802025e0: 13 06 80 07  	addi	a2, zero, 120
802025e4: b3 85 c5 02  	mul	a1, a1, a2
802025e8: 2e 95        	add	a0, a0, a1
802025ea: 13 05 05 07  	addi	a0, a0, 112

00000000802025ee <.LBB1_5>:
802025ee: 97 55 00 00  	auipc	a1, 5
802025f2: 93 85 a5 61  	addi	a1, a1, 1562
802025f6: 97 f0 ff ff  	auipc	ra, 1048575
802025fa: e7 80 60 b0  	jalr	-1274(ra)
802025fe: 2a e4        	sd	a0, 8(sp)
80202600: 21 a8        	j	0x80202618 <.LBB1_6+0x14>
80202602: 42 65        	ld	a0, 16(sp)

0000000080202604 <.LBB1_6>:
80202604: 17 56 00 00  	auipc	a2, 5
80202608: 13 06 c6 5e  	addi	a2, a2, 1516
8020260c: 91 45        	addi	a1, zero, 4
8020260e: 97 20 00 00  	auipc	ra, 2
80202612: e7 80 a0 5c  	jalr	1482(ra)
80202616: 00 00        	unimp	
80202618: 22 65        	ld	a0, 8(sp)
8020261a: e2 70        	ld	ra, 56(sp)
8020261c: 21 61        	addi	sp, sp, 64
8020261e: 82 80        	ret

0000000080202620 <_ZN2os6loader11KernelStack6get_sp17h9a95fb9db4a47cd2E>:
80202620: 01 11        	addi	sp, sp, -32
80202622: 06 ec        	sd	ra, 24(sp)
80202624: 2a e8        	sd	a0, 16(sp)
80202626: 89 65        	lui	a1, 2
80202628: 97 00 00 00  	auipc	ra, 0
8020262c: e7 80 60 54  	jalr	1350(ra)
80202630: 2a e4        	sd	a0, 8(sp)
80202632: 09 a0        	j	0x80202634 <_ZN2os6loader11KernelStack6get_sp17h9a95fb9db4a47cd2E+0x14>
80202634: a2 65        	ld	a1, 8(sp)
80202636: 09 65        	lui	a0, 2
80202638: 2e 95        	add	a0, a0, a1
8020263a: 2a e0        	sd	a0, 0(sp)
8020263c: 63 67 b5 00  	bltu	a0, a1, 0x8020264a <.LBB0_4>
80202640: 09 a0        	j	0x80202642 <_ZN2os6loader11KernelStack6get_sp17h9a95fb9db4a47cd2E+0x22>
80202642: 02 65        	ld	a0, 0(sp)
80202644: e2 60        	ld	ra, 24(sp)
80202646: 05 61        	addi	sp, sp, 32
80202648: 82 80        	ret

000000008020264a <.LBB0_4>:
8020264a: 17 65 01 00  	auipc	a0, 22
8020264e: 13 05 65 9e  	addi	a0, a0, -1562

0000000080202652 <.LBB0_5>:
80202652: 17 66 01 00  	auipc	a2, 22
80202656: 13 06 e6 9b  	addi	a2, a2, -1602
8020265a: f1 45        	addi	a1, zero, 28
8020265c: 97 20 00 00  	auipc	ra, 2
80202660: e7 80 00 55  	jalr	1360(ra)
80202664: 00 00        	unimp	

0000000080202666 <_ZN2os6loader11KernelStack12push_context17h925580d5852b1480E>:
80202666: 4d 71        	addi	sp, sp, -336
80202668: 86 e6        	sd	ra, 328(sp)
8020266a: 2e ec        	sd	a1, 24(sp)
8020266c: 2a fe        	sd	a0, 312(sp)
8020266e: 97 00 00 00  	auipc	ra, 0
80202672: e7 80 20 fb  	jalr	-78(ra)
80202676: 2a f0        	sd	a0, 32(sp)
80202678: 09 a0        	j	0x8020267a <_ZN2os6loader11KernelStack12push_context17h925580d5852b1480E+0x14>
8020267a: 09 a0        	j	0x8020267c <_ZN2os6loader11KernelStack12push_context17h925580d5852b1480E+0x16>
8020267c: 02 75        	ld	a0, 32(sp)
8020267e: 93 05 05 ef  	addi	a1, a0, -272
80202682: 2e e8        	sd	a1, 16(sp)
80202684: 63 6a b5 02  	bltu	a0, a1, 0x802026b8 <.LBB1_5>
80202688: 09 a0        	j	0x8020268a <_ZN2os6loader11KernelStack12push_context17h925580d5852b1480E+0x24>
8020268a: 42 65        	ld	a0, 16(sp)
8020268c: e2 65        	ld	a1, 24(sp)
8020268e: aa e2        	sd	a0, 320(sp)
80202690: 28 10        	addi	a0, sp, 40
80202692: 2a e0        	sd	a0, 0(sp)
80202694: 13 06 00 11  	addi	a2, zero, 272
80202698: 32 e4        	sd	a2, 8(sp)
8020269a: 97 40 00 00  	auipc	ra, 4
8020269e: e7 80 00 41  	jalr	1040(ra)
802026a2: 82 65        	ld	a1, 0(sp)
802026a4: 22 66        	ld	a2, 8(sp)
802026a6: 42 65        	ld	a0, 16(sp)
802026a8: 97 40 00 00  	auipc	ra, 4
802026ac: e7 80 20 40  	jalr	1026(ra)
802026b0: 42 65        	ld	a0, 16(sp)
802026b2: b6 60        	ld	ra, 328(sp)
802026b4: 71 61        	addi	sp, sp, 336
802026b6: 82 80        	ret

00000000802026b8 <.LBB1_5>:
802026b8: 17 65 01 00  	auipc	a0, 22
802026bc: 13 05 85 9b  	addi	a0, a0, -1608

00000000802026c0 <.LBB1_6>:
802026c0: 17 66 01 00  	auipc	a2, 22
802026c4: 13 06 06 99  	addi	a2, a2, -1648
802026c8: 93 05 10 02  	addi	a1, zero, 33
802026cc: 97 20 00 00  	auipc	ra, 2
802026d0: e7 80 00 4e  	jalr	1248(ra)
802026d4: 00 00        	unimp	

00000000802026d6 <_ZN2os6loader9UserStack6get_sp17h255d2b364405eac9E>:
802026d6: 01 11        	addi	sp, sp, -32
802026d8: 06 ec        	sd	ra, 24(sp)
802026da: 2a e8        	sd	a0, 16(sp)
802026dc: 89 65        	lui	a1, 2
802026de: 97 00 00 00  	auipc	ra, 0
802026e2: e7 80 00 49  	jalr	1168(ra)
802026e6: 2a e4        	sd	a0, 8(sp)
802026e8: 09 a0        	j	0x802026ea <_ZN2os6loader9UserStack6get_sp17h255d2b364405eac9E+0x14>
802026ea: a2 65        	ld	a1, 8(sp)
802026ec: 09 65        	lui	a0, 2
802026ee: 2e 95        	add	a0, a0, a1
802026f0: 2a e0        	sd	a0, 0(sp)
802026f2: 63 67 b5 00  	bltu	a0, a1, 0x80202700 <.LBB2_4>
802026f6: 09 a0        	j	0x802026f8 <_ZN2os6loader9UserStack6get_sp17h255d2b364405eac9E+0x22>
802026f8: 02 65        	ld	a0, 0(sp)
802026fa: e2 60        	ld	ra, 24(sp)
802026fc: 05 61        	addi	sp, sp, 32
802026fe: 82 80        	ret

0000000080202700 <.LBB2_4>:
80202700: 17 65 01 00  	auipc	a0, 22
80202704: 13 05 05 93  	addi	a0, a0, -1744

0000000080202708 <.LBB2_5>:
80202708: 17 66 01 00  	auipc	a2, 22
8020270c: 13 06 06 99  	addi	a2, a2, -1648
80202710: f1 45        	addi	a1, zero, 28
80202712: 97 20 00 00  	auipc	ra, 2
80202716: e7 80 a0 49  	jalr	1178(ra)
8020271a: 00 00        	unimp	

000000008020271c <_ZN2os6loader10get_base_i17h3f0f65065c58d467E>:
8020271c: 01 11        	addi	sp, sp, -32
8020271e: aa 85        	mv	a1, a0
80202720: 2e ec        	sd	a1, 24(sp)
80202722: 7d 55        	addi	a0, zero, -1
80202724: 45 81        	srli	a0, a0, 17
80202726: 6d 8d        	and	a0, a0, a1
80202728: 13 96 15 01  	slli	a2, a1, 17
8020272c: 32 e8        	sd	a2, 16(sp)
8020272e: 63 1c b5 00  	bne	a0, a1, 0x80202746 <.LBB3_5>
80202732: 09 a0        	j	0x80202734 <_ZN2os6loader10get_base_i17h3f0f65065c58d467E+0x18>
80202734: c2 65        	ld	a1, 16(sp)
80202736: 13 05 10 20  	addi	a0, zero, 513
8020273a: 5a 05        	slli	a0, a0, 22
8020273c: 2e 95        	add	a0, a0, a1
8020273e: 2a e4        	sd	a0, 8(sp)
80202740: 63 65 b5 02  	bltu	a0, a1, 0x8020276a <.LBB3_7>
80202744: 05 a0        	j	0x80202764 <.LBB3_6+0x16>

0000000080202746 <.LBB3_5>:
80202746: 17 65 01 00  	auipc	a0, 22
8020274a: 13 05 a5 98  	addi	a0, a0, -1654

000000008020274e <.LBB3_6>:
8020274e: 17 66 01 00  	auipc	a2, 22
80202752: 13 06 26 96  	addi	a2, a2, -1694
80202756: 93 05 10 02  	addi	a1, zero, 33
8020275a: 97 20 00 00  	auipc	ra, 2
8020275e: e7 80 20 45  	jalr	1106(ra)
80202762: 00 00        	unimp	
80202764: 22 65        	ld	a0, 8(sp)
80202766: 05 61        	addi	sp, sp, 32
80202768: 82 80        	ret

000000008020276a <.LBB3_7>:
8020276a: 17 65 01 00  	auipc	a0, 22
8020276e: 13 05 65 8c  	addi	a0, a0, -1850

0000000080202772 <.LBB3_8>:
80202772: 17 66 01 00  	auipc	a2, 22
80202776: 13 06 66 98  	addi	a2, a2, -1658
8020277a: f1 45        	addi	a1, zero, 28
8020277c: 97 20 00 00  	auipc	ra, 2
80202780: e7 80 00 43  	jalr	1072(ra)
80202784: 00 00        	unimp	

0000000080202786 <_ZN2os6loader11get_num_app17h58484202f71b6f17E>:
80202786: 41 11        	addi	sp, sp, -16
80202788: 06 e4        	sd	ra, 8(sp)

000000008020278a <.LBB4_2>:
8020278a: 17 95 01 00  	auipc	a0, 25
8020278e: 13 05 65 87  	addi	a0, a0, -1930
80202792: 97 f0 ff ff  	auipc	ra, 1048575
80202796: e7 80 20 fc  	jalr	-62(ra)
8020279a: 2a e0        	sd	a0, 0(sp)
8020279c: 09 a0        	j	0x8020279e <.LBB4_2+0x14>
8020279e: 02 65        	ld	a0, 0(sp)
802027a0: a2 60        	ld	ra, 8(sp)
802027a2: 41 01        	addi	sp, sp, 16
802027a4: 82 80        	ret

00000000802027a6 <_ZN2os6loader9load_apps17hcde39198d8d3bb8bE>:
802027a6: 4d 71        	addi	sp, sp, -336
802027a8: 86 e6        	sd	ra, 328(sp)

00000000802027aa <.LBB5_30>:
802027aa: 17 95 01 00  	auipc	a0, 25
802027ae: 13 05 65 85  	addi	a0, a0, -1962
802027b2: aa e9        	sd	a0, 208(sp)
802027b4: 97 00 00 00  	auipc	ra, 0
802027b8: e7 80 20 fd  	jalr	-46(ra)
802027bc: aa 85        	mv	a1, a0
802027be: 2e e5        	sd	a1, 136(sp)
802027c0: aa ed        	sd	a0, 216(sp)
802027c2: 09 a0        	j	0x802027c4 <.LBB5_31>

00000000802027c4 <.LBB5_31>:
802027c4: 17 95 01 00  	auipc	a0, 25
802027c8: 13 05 c5 83  	addi	a0, a0, -1988
802027cc: 2a f2        	sd	a0, 288(sp)
802027ce: 85 45        	addi	a1, zero, 1
802027d0: 2e f6        	sd	a1, 296(sp)
802027d2: 2a fa        	sd	a0, 304(sp)
802027d4: 2e fe        	sd	a1, 312(sp)
802027d6: 21 05        	addi	a0, a0, 8
802027d8: 2a e1        	sd	a0, 128(sp)
802027da: aa e2        	sd	a0, 320(sp)
802027dc: 09 a0        	j	0x802027de <.LBB5_31+0x1a>
802027de: aa 65        	ld	a1, 136(sp)
802027e0: 13 85 15 00  	addi	a0, a1, 1
802027e4: aa fc        	sd	a0, 120(sp)
802027e6: 63 60 b5 02  	bltu	a0, a1, 0x80202806 <.LBB5_32>
802027ea: 09 a0        	j	0x802027ec <.LBB5_31+0x28>
802027ec: e6 75        	ld	a1, 120(sp)
802027ee: 0a 65        	ld	a0, 128(sp)
802027f0: 97 f0 ff ff  	auipc	ra, 1048575
802027f4: e7 80 a0 7a  	jalr	1962(ra)
802027f8: 2a 86        	mv	a2, a0
802027fa: b2 f4        	sd	a2, 104(sp)
802027fc: 2e 86        	mv	a2, a1
802027fe: b2 f8        	sd	a2, 112(sp)
80202800: aa f1        	sd	a0, 224(sp)
80202802: ae f5        	sd	a1, 232(sp)
80202804: 39 a8        	j	0x80202822 <.LBB5_33+0x14>

0000000080202806 <.LBB5_32>:
80202806: 17 65 01 00  	auipc	a0, 22
8020280a: 13 05 a5 82  	addi	a0, a0, -2006

000000008020280e <.LBB5_33>:
8020280e: 17 66 01 00  	auipc	a2, 22
80202812: 13 06 26 90  	addi	a2, a2, -1790
80202816: f1 45        	addi	a1, zero, 28
80202818: 97 20 00 00  	auipc	ra, 2
8020281c: e7 80 40 39  	jalr	916(ra)
80202820: 00 00        	unimp	
80202822: 0f 10 00 00  	fence.i	
80202826: 09 a0        	j	0x80202828 <.LBB5_33+0x1a>
80202828: aa 65        	ld	a1, 136(sp)
8020282a: 01 45        	mv	a0, zero
8020282c: 2a e9        	sd	a0, 144(sp)
8020282e: 2e ed        	sd	a1, 152(sp)
80202830: 97 20 00 00  	auipc	ra, 2
80202834: e7 80 80 b7  	jalr	-1160(ra)
80202838: aa ec        	sd	a0, 88(sp)
8020283a: ae f0        	sd	a1, 96(sp)
8020283c: 09 a0        	j	0x8020283e <.LBB5_33+0x30>
8020283e: 06 75        	ld	a0, 96(sp)
80202840: e6 65        	ld	a1, 88(sp)
80202842: 2e f1        	sd	a1, 160(sp)
80202844: 2a f5        	sd	a0, 168(sp)
80202846: 09 a0        	j	0x80202848 <.LBB5_33+0x3a>
80202848: 08 11        	addi	a0, sp, 160
8020284a: 97 20 00 00  	auipc	ra, 2
8020284e: e7 80 00 b4  	jalr	-1216(ra)
80202852: 2a f9        	sd	a0, 176(sp)
80202854: 2e fd        	sd	a1, 184(sp)
80202856: 09 a0        	j	0x80202858 <.LBB5_33+0x4a>
80202858: 4a 75        	ld	a0, 176(sp)
8020285a: 81 45        	mv	a1, zero
8020285c: 63 05 b5 00  	beq	a0, a1, 0x80202866 <.LBB5_33+0x58>
80202860: 09 a0        	j	0x80202862 <.LBB5_33+0x54>
80202862: 29 a0        	j	0x8020286c <.LBB5_33+0x5e>
80202864: 00 00        	unimp	
80202866: b6 60        	ld	ra, 328(sp)
80202868: 71 61        	addi	sp, sp, 336
8020286a: 82 80        	ret
8020286c: 6a 75        	ld	a0, 184(sp)
8020286e: aa e4        	sd	a0, 72(sp)
80202870: aa f9        	sd	a0, 240(sp)
80202872: 97 00 00 00  	auipc	ra, 0
80202876: e7 80 a0 ea  	jalr	-342(ra)
8020287a: aa 85        	mv	a1, a0
8020287c: ae e8        	sd	a1, 80(sp)
8020287e: aa fd        	sd	a0, 248(sp)
80202880: 09 a0        	j	0x80202882 <.LBB5_33+0x74>
80202882: c6 65        	ld	a1, 80(sp)
80202884: 37 05 02 00  	lui	a0, 32
80202888: 2e 95        	add	a0, a0, a1
8020288a: aa e0        	sd	a0, 64(sp)
8020288c: 63 6c b5 00  	bltu	a0, a1, 0x802028a4 <.LBB5_34>
80202890: 09 a0        	j	0x80202892 <.LBB5_33+0x84>
80202892: 86 65        	ld	a1, 64(sp)
80202894: 46 65        	ld	a0, 80(sp)
80202896: aa e1        	sd	a0, 192(sp)
80202898: ae e5        	sd	a1, 200(sp)
8020289a: 97 f0 ff ff  	auipc	ra, 1048575
8020289e: e7 80 a0 28  	jalr	650(ra)
802028a2: 39 a8        	j	0x802028c0 <.LBB5_35+0x14>

00000000802028a4 <.LBB5_34>:
802028a4: 17 55 01 00  	auipc	a0, 21
802028a8: 13 05 c5 78  	addi	a0, a0, 1932

00000000802028ac <.LBB5_35>:
802028ac: 17 66 01 00  	auipc	a2, 22
802028b0: 13 06 c6 87  	addi	a2, a2, -1924
802028b4: f1 45        	addi	a1, zero, 28
802028b6: 97 20 00 00  	auipc	ra, 2
802028ba: e7 80 60 2f  	jalr	758(ra)
802028be: 00 00        	unimp	
802028c0: 26 65        	ld	a0, 72(sp)
802028c2: c6 75        	ld	a1, 112(sp)
802028c4: 63 70 b5 02  	bgeu	a0, a1, 0x802028e4 <.LBB5_35+0x38>
802028c8: 09 a0        	j	0x802028ca <.LBB5_35+0x1e>
802028ca: a6 65        	ld	a1, 72(sp)
802028cc: 26 75        	ld	a0, 104(sp)
802028ce: 13 96 35 00  	slli	a2, a1, 3
802028d2: 32 95        	add	a0, a0, a2
802028d4: 08 61        	ld	a0, 0(a0)
802028d6: 2a f8        	sd	a0, 48(sp)
802028d8: 13 85 15 00  	addi	a0, a1, 1
802028dc: 2a fc        	sd	a0, 56(sp)
802028de: 63 63 b5 02  	bltu	a0, a1, 0x80202904 <.LBB5_37>
802028e2: 21 a8        	j	0x802028fa <.LBB5_36+0x12>
802028e4: c6 75        	ld	a1, 112(sp)
802028e6: 26 65        	ld	a0, 72(sp)

00000000802028e8 <.LBB5_36>:
802028e8: 17 66 01 00  	auipc	a2, 22
802028ec: 13 06 86 85  	addi	a2, a2, -1960
802028f0: 97 20 00 00  	auipc	ra, 2
802028f4: e7 80 80 2e  	jalr	744(ra)
802028f8: 00 00        	unimp	
802028fa: 62 75        	ld	a0, 56(sp)
802028fc: c6 75        	ld	a1, 112(sp)
802028fe: 63 61 b5 02  	bltu	a0, a1, 0x80202920 <.LBB5_38+0x14>
80202902: 15 a8        	j	0x80202936 <.LBB5_38+0x2a>

0000000080202904 <.LBB5_37>:
80202904: 17 55 01 00  	auipc	a0, 21
80202908: 13 05 c5 72  	addi	a0, a0, 1836

000000008020290c <.LBB5_38>:
8020290c: 17 66 01 00  	auipc	a2, 22
80202910: 13 06 c6 84  	addi	a2, a2, -1972
80202914: f1 45        	addi	a1, zero, 28
80202916: 97 20 00 00  	auipc	ra, 2
8020291a: e7 80 60 29  	jalr	662(ra)
8020291e: 00 00        	unimp	
80202920: 26 65        	ld	a0, 72(sp)
80202922: c6 75        	ld	a1, 112(sp)
80202924: 26 76        	ld	a2, 104(sp)
80202926: e2 76        	ld	a3, 56(sp)
80202928: 8e 06        	slli	a3, a3, 3
8020292a: 36 96        	add	a2, a2, a3
8020292c: 10 62        	ld	a2, 0(a2)
8020292e: 32 f4        	sd	a2, 40(sp)
80202930: 63 6e b5 00  	bltu	a0, a1, 0x8020294c <.LBB5_39+0x12>
80202934: 05 a8        	j	0x80202964 <.LBB5_39+0x2a>
80202936: c6 75        	ld	a1, 112(sp)
80202938: 62 75        	ld	a0, 56(sp)

000000008020293a <.LBB5_39>:
8020293a: 17 66 01 00  	auipc	a2, 22
8020293e: 13 06 66 83  	addi	a2, a2, -1994
80202942: 97 20 00 00  	auipc	ra, 2
80202946: e7 80 60 29  	jalr	662(ra)
8020294a: 00 00        	unimp	
8020294c: 22 75        	ld	a0, 40(sp)
8020294e: a6 75        	ld	a1, 104(sp)
80202950: 26 66        	ld	a2, 72(sp)
80202952: 0e 06        	slli	a2, a2, 3
80202954: b2 95        	add	a1, a1, a2
80202956: 8c 61        	ld	a1, 0(a1)
80202958: b3 05 b5 40  	sub	a1, a0, a1
8020295c: 2e f0        	sd	a1, 32(sp)
8020295e: 63 6b b5 02  	bltu	a0, a1, 0x80202994 <.LBB5_41>
80202962: 21 a8        	j	0x8020297a <.LBB5_40+0x12>
80202964: c6 75        	ld	a1, 112(sp)
80202966: 26 65        	ld	a0, 72(sp)

0000000080202968 <.LBB5_40>:
80202968: 17 66 01 00  	auipc	a2, 22
8020296c: 13 06 06 82  	addi	a2, a2, -2016
80202970: 97 20 00 00  	auipc	ra, 2
80202974: e7 80 80 26  	jalr	616(ra)
80202978: 00 00        	unimp	
8020297a: 82 75        	ld	a1, 32(sp)
8020297c: 42 75        	ld	a0, 48(sp)
8020297e: 97 f0 ff ff  	auipc	ra, 1048575
80202982: e7 80 e0 64  	jalr	1614(ra)
80202986: 2a 86        	mv	a2, a0
80202988: 32 e8        	sd	a2, 16(sp)
8020298a: 2e 86        	mv	a2, a1
8020298c: 32 ec        	sd	a2, 24(sp)
8020298e: 2a e2        	sd	a0, 256(sp)
80202990: 2e e6        	sd	a1, 264(sp)
80202992: 05 a0        	j	0x802029b2 <.LBB5_42+0x16>

0000000080202994 <.LBB5_41>:
80202994: 17 55 01 00  	auipc	a0, 21
80202998: 13 05 c5 6d  	addi	a0, a0, 1756

000000008020299c <.LBB5_42>:
8020299c: 17 56 01 00  	auipc	a2, 21
802029a0: 13 06 46 7d  	addi	a2, a2, 2004
802029a4: 93 05 10 02  	addi	a1, zero, 33
802029a8: 97 20 00 00  	auipc	ra, 2
802029ac: e7 80 40 20  	jalr	516(ra)
802029b0: 00 00        	unimp	
802029b2: e2 65        	ld	a1, 24(sp)
802029b4: 46 65        	ld	a0, 80(sp)
802029b6: 97 f0 ff ff  	auipc	ra, 1048575
802029ba: e7 80 80 64  	jalr	1608(ra)
802029be: 2a e0        	sd	a0, 0(sp)
802029c0: 2e e4        	sd	a1, 8(sp)
802029c2: 09 a0        	j	0x802029c4 <.LBB5_42+0x28>
802029c4: e2 66        	ld	a3, 24(sp)
802029c6: 42 66        	ld	a2, 16(sp)
802029c8: a2 65        	ld	a1, 8(sp)
802029ca: 02 65        	ld	a0, 0(sp)
802029cc: 2a ea        	sd	a0, 272(sp)
802029ce: 2e ee        	sd	a1, 280(sp)

00000000802029d0 <.LBB5_43>:
802029d0: 17 57 01 00  	auipc	a4, 21
802029d4: 13 07 07 7d  	addi	a4, a4, 2000
802029d8: 97 00 00 00  	auipc	ra, 0
802029dc: e7 80 60 20  	jalr	518(ra)
802029e0: a5 b5        	j	0x80202848 <.LBB5_33+0x3a>

00000000802029e2 <_ZN2os6loader11init_app_cx17hcddf34aaccefcf3aE>:
802029e2: 4d 71        	addi	sp, sp, -336
802029e4: 86 e6        	sd	ra, 328(sp)
802029e6: aa 85        	mv	a1, a0
802029e8: 2e f4        	sd	a1, 40(sp)
802029ea: ae e2        	sd	a1, 320(sp)
802029ec: 0d 45        	addi	a0, zero, 3
802029ee: 63 62 b5 02  	bltu	a0, a1, 0x80202a12 <.LBB6_9+0x18>
802029f2: 09 a0        	j	0x802029f4 <_ZN2os6loader11init_app_cx17hcddf34aaccefcf3aE+0x12>
802029f4: 22 75        	ld	a0, 40(sp)
802029f6: 93 15 d5 00  	slli	a1, a0, 13

00000000802029fa <.LBB6_9>:
802029fa: 17 56 00 00  	auipc	a2, 5
802029fe: 13 06 66 60  	addi	a2, a2, 1542
80202a02: b2 95        	add	a1, a1, a2
80202a04: 2e ec        	sd	a1, 24(sp)
80202a06: 97 00 00 00  	auipc	ra, 0
80202a0a: e7 80 60 d1  	jalr	-746(ra)
80202a0e: 2a f0        	sd	a0, 32(sp)
80202a10: 21 a8        	j	0x80202a28 <.LBB6_10+0x14>
80202a12: 22 75        	ld	a0, 40(sp)

0000000080202a14 <.LBB6_10>:
80202a14: 17 56 01 00  	auipc	a2, 21
80202a18: 13 06 46 7a  	addi	a2, a2, 1956
80202a1c: 91 45        	addi	a1, zero, 4
80202a1e: 97 20 00 00  	auipc	ra, 2
80202a22: e7 80 a0 1b  	jalr	442(ra)
80202a26: 00 00        	unimp	
80202a28: a2 75        	ld	a1, 40(sp)
80202a2a: 0d 45        	addi	a0, zero, 3
80202a2c: 63 60 b5 02  	bltu	a0, a1, 0x80202a4c <.LBB6_11+0x16>
80202a30: 09 a0        	j	0x80202a32 <.LBB6_10+0x1e>
80202a32: 22 75        	ld	a0, 40(sp)
80202a34: 36 05        	slli	a0, a0, 13

0000000080202a36 <.LBB6_11>:
80202a36: 97 d5 00 00  	auipc	a1, 13
80202a3a: 93 85 a5 5c  	addi	a1, a1, 1482
80202a3e: 2e 95        	add	a0, a0, a1
80202a40: 97 00 00 00  	auipc	ra, 0
80202a44: e7 80 60 c9  	jalr	-874(ra)
80202a48: 2a e8        	sd	a0, 16(sp)
80202a4a: 21 a8        	j	0x80202a62 <.LBB6_12+0x14>
80202a4c: 22 75        	ld	a0, 40(sp)

0000000080202a4e <.LBB6_12>:
80202a4e: 17 56 01 00  	auipc	a2, 21
80202a52: 13 06 26 78  	addi	a2, a2, 1922
80202a56: 91 45        	addi	a1, zero, 4
80202a58: 97 20 00 00  	auipc	ra, 2
80202a5c: e7 80 00 18  	jalr	384(ra)
80202a60: 00 00        	unimp	
80202a62: 42 66        	ld	a2, 16(sp)
80202a64: 82 75        	ld	a1, 32(sp)
80202a66: 08 18        	addi	a0, sp, 48
80202a68: 97 f0 ff ff  	auipc	ra, 1048575
80202a6c: e7 80 00 2e  	jalr	736(ra)
80202a70: 09 a0        	j	0x80202a72 <.LBB6_12+0x24>
80202a72: 62 65        	ld	a0, 24(sp)
80202a74: 0c 18        	addi	a1, sp, 48
80202a76: 97 00 00 00  	auipc	ra, 0
80202a7a: e7 80 00 bf  	jalr	-1040(ra)
80202a7e: 2a e4        	sd	a0, 8(sp)
80202a80: 09 a0        	j	0x80202a82 <.LBB6_12+0x34>
80202a82: 22 65        	ld	a0, 8(sp)
80202a84: b6 60        	ld	ra, 328(sp)
80202a86: 71 61        	addi	sp, sp, 336
80202a88: 82 80        	ret

0000000080202a8a <_ZN4core4iter8adapters3map16Map$LT$I$C$F$GT$3new17hef5d2569b2d78520E>:
80202a8a: 01 11        	addi	sp, sp, -32
80202a8c: 2e e4        	sd	a1, 8(sp)
80202a8e: 32 e8        	sd	a2, 16(sp)
80202a90: 36 ec        	sd	a3, 24(sp)
80202a92: 0c e1        	sd	a1, 0(a0)
80202a94: 10 e5        	sd	a2, 8(a0)
80202a96: 14 e9        	sd	a3, 16(a0)
80202a98: 05 61        	addi	sp, sp, 32
80202a9a: 82 80        	ret

0000000080202a9c <_ZN4core4iter8adapters3map12map_try_fold17hd7697730ccecf7b8E>:
80202a9c: 79 71        	addi	sp, sp, -48
80202a9e: 2e e4        	sd	a1, 8(sp)
80202aa0: aa 85        	mv	a1, a0
80202aa2: 22 65        	ld	a0, 8(sp)
80202aa4: 2e f0        	sd	a1, 32(sp)
80202aa6: 2a f4        	sd	a0, 40(sp)
80202aa8: 2a e8        	sd	a0, 16(sp)
80202aaa: 2e ec        	sd	a1, 24(sp)
80202aac: 45 61        	addi	sp, sp, 48
80202aae: 82 80        	ret

0000000080202ab0 <_ZN4core4iter8adapters3map12map_try_fold28_$u7b$$u7b$closure$u7d$$u7d$17h83728ef49e341cd7E>:
80202ab0: 5d 71        	addi	sp, sp, -80
80202ab2: 86 e4        	sd	ra, 72(sp)
80202ab4: 2a f8        	sd	a0, 48(sp)
80202ab6: ae e0        	sd	a1, 64(sp)
80202ab8: 2a 86        	mv	a2, a0
80202aba: 32 e8        	sd	a2, 16(sp)
80202abc: 08 65        	ld	a0, 8(a0)
80202abe: 2e f4        	sd	a1, 40(sp)
80202ac0: 97 00 00 00  	auipc	ra, 0
80202ac4: e7 80 60 ab  	jalr	-1354(ra)
80202ac8: 2a ec        	sd	a0, 24(sp)
80202aca: 09 a0        	j	0x80202acc <_ZN4core4iter8adapters3map12map_try_fold28_$u7b$$u7b$closure$u7d$$u7d$17h83728ef49e341cd7E+0x1c>
80202acc: e2 65        	ld	a1, 24(sp)
80202ace: 42 65        	ld	a0, 16(sp)
80202ad0: 2e f0        	sd	a1, 32(sp)
80202ad2: 97 00 00 00  	auipc	ra, 0
80202ad6: e7 80 00 a4  	jalr	-1472(ra)
80202ada: 2a e0        	sd	a0, 0(sp)
80202adc: 2e e4        	sd	a1, 8(sp)
80202ade: 09 a0        	j	0x80202ae0 <_ZN4core4iter8adapters3map12map_try_fold28_$u7b$$u7b$closure$u7d$$u7d$17h83728ef49e341cd7E+0x30>
80202ae0: a2 65        	ld	a1, 8(sp)
80202ae2: 02 65        	ld	a0, 0(sp)
80202ae4: a6 60        	ld	ra, 72(sp)
80202ae6: 61 61        	addi	sp, sp, 80
80202ae8: 82 80        	ret

0000000080202aea <_ZN102_$LT$core..iter..adapters..map..Map$LT$I$C$F$GT$$u20$as$u20$core..iter..traits..iterator..Iterator$GT$8try_fold17h4727ca8909b6bf56E>:
80202aea: 5d 71        	addi	sp, sp, -80
80202aec: 86 e4        	sd	ra, 72(sp)
80202aee: 2a f8        	sd	a0, 48(sp)
80202af0: ae e0        	sd	a1, 64(sp)
80202af2: 2a 86        	mv	a2, a0
80202af4: 32 ec        	sd	a2, 24(sp)
80202af6: 41 05        	addi	a0, a0, 16
80202af8: 97 00 00 00  	auipc	ra, 0
80202afc: e7 80 40 fa  	jalr	-92(ra)
80202b00: 2a f0        	sd	a0, 32(sp)
80202b02: 2e f4        	sd	a1, 40(sp)
80202b04: 09 a0        	j	0x80202b06 <_ZN102_$LT$core..iter..adapters..map..Map$LT$I$C$F$GT$$u20$as$u20$core..iter..traits..iterator..Iterator$GT$8try_fold17h4727ca8909b6bf56E+0x1c>
80202b06: 22 76        	ld	a2, 40(sp)
80202b08: 82 75        	ld	a1, 32(sp)
80202b0a: 62 65        	ld	a0, 24(sp)
80202b0c: 97 f0 ff ff  	auipc	ra, 1048575
80202b10: e7 80 20 04  	jalr	66(ra)
80202b14: 2a e4        	sd	a0, 8(sp)
80202b16: 2e e8        	sd	a1, 16(sp)
80202b18: 09 a0        	j	0x80202b1a <_ZN102_$LT$core..iter..adapters..map..Map$LT$I$C$F$GT$$u20$as$u20$core..iter..traits..iterator..Iterator$GT$8try_fold17h4727ca8909b6bf56E+0x30>
80202b1a: c2 65        	ld	a1, 16(sp)
80202b1c: 22 65        	ld	a0, 8(sp)
80202b1e: a6 60        	ld	ra, 72(sp)
80202b20: 61 61        	addi	sp, sp, 80
80202b22: 82 80        	ret

0000000080202b24 <_ZN4core4iter6traits8iterator8Iterator4find17h84f1412ad536fb19E>:
80202b24: 5d 71        	addi	sp, sp, -80
80202b26: 86 e4        	sd	ra, 72(sp)
80202b28: 2e f0        	sd	a1, 32(sp)
80202b2a: aa 85        	mv	a1, a0
80202b2c: 02 75        	ld	a0, 32(sp)
80202b2e: 2e f4        	sd	a1, 40(sp)
80202b30: 2e fc        	sd	a1, 56(sp)
80202b32: aa e0        	sd	a0, 64(sp)
80202b34: 97 00 00 00  	auipc	ra, 0
80202b38: e7 80 40 9d  	jalr	-1580(ra)
80202b3c: 2a f8        	sd	a0, 48(sp)
80202b3e: 09 a0        	j	0x80202b40 <_ZN4core4iter6traits8iterator8Iterator4find17h84f1412ad536fb19E+0x1c>
80202b40: c2 75        	ld	a1, 48(sp)
80202b42: 22 75        	ld	a0, 40(sp)
80202b44: 97 00 00 00  	auipc	ra, 0
80202b48: e7 80 60 fa  	jalr	-90(ra)
80202b4c: 2a e8        	sd	a0, 16(sp)
80202b4e: 2e ec        	sd	a1, 24(sp)
80202b50: 09 a0        	j	0x80202b52 <_ZN4core4iter6traits8iterator8Iterator4find17h84f1412ad536fb19E+0x2e>
80202b52: e2 65        	ld	a1, 24(sp)
80202b54: 42 65        	ld	a0, 16(sp)
80202b56: 97 e0 ff ff  	auipc	ra, 1048574
80202b5a: e7 80 20 62  	jalr	1570(ra)
80202b5e: 2a e0        	sd	a0, 0(sp)
80202b60: 2e e4        	sd	a1, 8(sp)
80202b62: 09 a0        	j	0x80202b64 <_ZN4core4iter6traits8iterator8Iterator4find17h84f1412ad536fb19E+0x40>
80202b64: a2 65        	ld	a1, 8(sp)
80202b66: 02 65        	ld	a0, 0(sp)
80202b68: a6 60        	ld	ra, 72(sp)
80202b6a: 61 61        	addi	sp, sp, 80
80202b6c: 82 80        	ret

0000000080202b6e <_ZN4core5slice29_$LT$impl$u20$$u5b$T$u5d$$GT$6as_ptr17hd321ffa10d65c1fcE>:
80202b6e: 41 11        	addi	sp, sp, -16
80202b70: 2a e0        	sd	a0, 0(sp)
80202b72: 2e e4        	sd	a1, 8(sp)
80202b74: 41 01        	addi	sp, sp, 16
80202b76: 82 80        	ret

0000000080202b78 <_ZN4core5slice29_$LT$impl$u20$$u5b$T$u5d$$GT$10as_mut_ptr17h1ee5204fbca1a2bfE>:
80202b78: 41 11        	addi	sp, sp, -16
80202b7a: 2a e0        	sd	a0, 0(sp)
80202b7c: 2e e4        	sd	a1, 8(sp)
80202b7e: 41 01        	addi	sp, sp, 16
80202b80: 82 80        	ret

0000000080202b82 <_ZN4core5slice29_$LT$impl$u20$$u5b$T$u5d$$GT$4iter17hc96edd9b006d126aE>:
80202b82: 79 71        	addi	sp, sp, -48
80202b84: 06 f4        	sd	ra, 40(sp)
80202b86: 2a ec        	sd	a0, 24(sp)
80202b88: 2e f0        	sd	a1, 32(sp)
80202b8a: 97 f0 ff ff  	auipc	ra, 1048575
80202b8e: e7 80 60 4e  	jalr	1254(ra)
80202b92: 2a e4        	sd	a0, 8(sp)
80202b94: 2e e8        	sd	a1, 16(sp)
80202b96: 09 a0        	j	0x80202b98 <_ZN4core5slice29_$LT$impl$u20$$u5b$T$u5d$$GT$4iter17hc96edd9b006d126aE+0x16>
80202b98: c2 65        	ld	a1, 16(sp)
80202b9a: 22 65        	ld	a0, 8(sp)
80202b9c: a2 70        	ld	ra, 40(sp)
80202b9e: 45 61        	addi	sp, sp, 48
80202ba0: 82 80        	ret

0000000080202ba2 <_ZN4core5slice29_$LT$impl$u20$$u5b$T$u5d$$GT$8iter_mut17h9fe5080b46f84f2dE>:
80202ba2: 79 71        	addi	sp, sp, -48
80202ba4: 06 f4        	sd	ra, 40(sp)
80202ba6: 2a ec        	sd	a0, 24(sp)
80202ba8: 2e f0        	sd	a1, 32(sp)
80202baa: 97 f0 ff ff  	auipc	ra, 1048575
80202bae: e7 80 60 54  	jalr	1350(ra)
80202bb2: 2a e4        	sd	a0, 8(sp)
80202bb4: 2e e8        	sd	a1, 16(sp)
80202bb6: 09 a0        	j	0x80202bb8 <_ZN4core5slice29_$LT$impl$u20$$u5b$T$u5d$$GT$8iter_mut17h9fe5080b46f84f2dE+0x16>
80202bb8: c2 65        	ld	a1, 16(sp)
80202bba: 22 65        	ld	a0, 8(sp)
80202bbc: a2 70        	ld	ra, 40(sp)
80202bbe: 45 61        	addi	sp, sp, 48
80202bc0: 82 80        	ret

0000000080202bc2 <_ZN4core5slice29_$LT$impl$u20$$u5b$T$u5d$$GT$4fill17hdb3716d27c9812e7E>:
80202bc2: 01 11        	addi	sp, sp, -32
80202bc4: 06 ec        	sd	ra, 24(sp)
80202bc6: 2a e0        	sd	a0, 0(sp)
80202bc8: 2e e4        	sd	a1, 8(sp)
80202bca: a3 0b c1 00  	sb	a2, 23(sp)
80202bce: 97 e0 ff ff  	auipc	ra, 1048574
80202bd2: e7 80 20 4c  	jalr	1218(ra)
80202bd6: 09 a0        	j	0x80202bd8 <_ZN4core5slice29_$LT$impl$u20$$u5b$T$u5d$$GT$4fill17hdb3716d27c9812e7E+0x16>
80202bd8: e2 60        	ld	ra, 24(sp)
80202bda: 05 61        	addi	sp, sp, 32
80202bdc: 82 80        	ret

0000000080202bde <_ZN4core5slice29_$LT$impl$u20$$u5b$T$u5d$$GT$15copy_from_slice17he0fc0b8b6304744bE>:
80202bde: 1d 71        	addi	sp, sp, -96
80202be0: 86 ec        	sd	ra, 88(sp)
80202be2: 3a e8        	sd	a4, 16(sp)
80202be4: 36 ec        	sd	a3, 24(sp)
80202be6: 32 f0        	sd	a2, 32(sp)
80202be8: 2e f4        	sd	a1, 40(sp)
80202bea: 2a f8        	sd	a0, 48(sp)
80202bec: 2a fc        	sd	a0, 56(sp)
80202bee: ae e0        	sd	a1, 64(sp)
80202bf0: b2 e4        	sd	a2, 72(sp)
80202bf2: b6 e8        	sd	a3, 80(sp)
80202bf4: 63 9b d5 00  	bne	a1, a3, 0x80202c0a <_ZN4core5slice29_$LT$impl$u20$$u5b$T$u5d$$GT$15copy_from_slice17he0fc0b8b6304744bE+0x2c>
80202bf8: 09 a0        	j	0x80202bfa <_ZN4core5slice29_$LT$impl$u20$$u5b$T$u5d$$GT$15copy_from_slice17he0fc0b8b6304744bE+0x1c>
80202bfa: e2 65        	ld	a1, 24(sp)
80202bfc: 02 75        	ld	a0, 32(sp)
80202bfe: 97 00 00 00  	auipc	ra, 0
80202c02: e7 80 00 f7  	jalr	-144(ra)
80202c06: 2a e4        	sd	a0, 8(sp)
80202c08: 09 a8        	j	0x80202c1a <_ZN4core5slice29_$LT$impl$u20$$u5b$T$u5d$$GT$15copy_from_slice17he0fc0b8b6304744bE+0x3c>
80202c0a: 42 66        	ld	a2, 16(sp)
80202c0c: e2 65        	ld	a1, 24(sp)
80202c0e: 22 75        	ld	a0, 40(sp)
80202c10: 97 30 00 00  	auipc	ra, 3
80202c14: e7 80 40 10  	jalr	260(ra)
80202c18: 00 00        	unimp	
80202c1a: a2 75        	ld	a1, 40(sp)
80202c1c: 42 75        	ld	a0, 48(sp)
80202c1e: 97 00 00 00  	auipc	ra, 0
80202c22: e7 80 a0 f5  	jalr	-166(ra)
80202c26: 2a e0        	sd	a0, 0(sp)
80202c28: 09 a0        	j	0x80202c2a <_ZN4core5slice29_$LT$impl$u20$$u5b$T$u5d$$GT$15copy_from_slice17he0fc0b8b6304744bE+0x4c>
80202c2a: 22 76        	ld	a2, 40(sp)
80202c2c: 82 65        	ld	a1, 0(sp)
80202c2e: 22 65        	ld	a0, 8(sp)
80202c30: 97 d0 ff ff  	auipc	ra, 1048573
80202c34: e7 80 c0 7b  	jalr	1980(ra)
80202c38: 09 a0        	j	0x80202c3a <_ZN4core5slice29_$LT$impl$u20$$u5b$T$u5d$$GT$15copy_from_slice17he0fc0b8b6304744bE+0x5c>
80202c3a: e6 60        	ld	ra, 88(sp)
80202c3c: 25 61        	addi	sp, sp, 96
80202c3e: 82 80        	ret

0000000080202c40 <_ZN4core3ptr8non_null16NonNull$LT$T$GT$13new_unchecked17hb2ac30efcf35dd6bE>:
80202c40: 41 11        	addi	sp, sp, -16
80202c42: 2a e4        	sd	a0, 8(sp)
80202c44: 2a e0        	sd	a0, 0(sp)
80202c46: 41 01        	addi	sp, sp, 16
80202c48: 82 80        	ret

0000000080202c4a <_ZN4core3ptr8non_null16NonNull$LT$T$GT$6as_ptr17h53d28efe344583c9E>:
80202c4a: 41 11        	addi	sp, sp, -16
80202c4c: 2a e4        	sd	a0, 8(sp)
80202c4e: 41 01        	addi	sp, sp, 16
80202c50: 82 80        	ret

0000000080202c52 <_ZN4core6option15Option$LT$T$GT$6as_ref17h9dc3f93957ff44f5E>:
80202c52: 01 11        	addi	sp, sp, -32
80202c54: 2a e0        	sd	a0, 0(sp)
80202c56: 2a e8        	sd	a0, 16(sp)
80202c58: 08 61        	ld	a0, 0(a0)
80202c5a: 81 45        	mv	a1, zero
80202c5c: 63 05 b5 00  	beq	a0, a1, 0x80202c66 <_ZN4core6option15Option$LT$T$GT$6as_ref17h9dc3f93957ff44f5E+0x14>
80202c60: 09 a0        	j	0x80202c62 <_ZN4core6option15Option$LT$T$GT$6as_ref17h9dc3f93957ff44f5E+0x10>
80202c62: 29 a0        	j	0x80202c6c <_ZN4core6option15Option$LT$T$GT$6as_ref17h9dc3f93957ff44f5E+0x1a>
80202c64: 00 00        	unimp	
80202c66: 01 45        	mv	a0, zero
80202c68: 2a e4        	sd	a0, 8(sp)
80202c6a: 31 a0        	j	0x80202c76 <_ZN4core6option15Option$LT$T$GT$6as_ref17h9dc3f93957ff44f5E+0x24>
80202c6c: 02 65        	ld	a0, 0(sp)
80202c6e: 21 05        	addi	a0, a0, 8
80202c70: 2a ec        	sd	a0, 24(sp)
80202c72: 2a e4        	sd	a0, 8(sp)
80202c74: 09 a0        	j	0x80202c76 <_ZN4core6option15Option$LT$T$GT$6as_ref17h9dc3f93957ff44f5E+0x24>
80202c76: 22 65        	ld	a0, 8(sp)
80202c78: 05 61        	addi	sp, sp, 32
80202c7a: 82 80        	ret

0000000080202c7c <_ZN4core6option15Option$LT$T$GT$6unwrap17h37a4566fdd422bb9E>:
80202c7c: 01 11        	addi	sp, sp, -32
80202c7e: 2e e4        	sd	a1, 8(sp)
80202c80: 2a e8        	sd	a0, 16(sp)
80202c82: b3 35 a0 00  	snez	a1, a0
80202c86: 81 45        	mv	a1, zero
80202c88: 63 05 b5 00  	beq	a0, a1, 0x80202c92 <_ZN4core6option15Option$LT$T$GT$6unwrap17h37a4566fdd422bb9E+0x16>
80202c8c: 09 a0        	j	0x80202c8e <_ZN4core6option15Option$LT$T$GT$6unwrap17h37a4566fdd422bb9E+0x12>
80202c8e: 31 a8        	j	0x80202caa <.LBB2_5+0x16>
80202c90: 00 00        	unimp	
80202c92: 22 66        	ld	a2, 8(sp)

0000000080202c94 <.LBB2_5>:
80202c94: 17 55 01 00  	auipc	a0, 21
80202c98: 13 05 45 55  	addi	a0, a0, 1364
80202c9c: 93 05 b0 02  	addi	a1, zero, 43
80202ca0: 97 20 00 00  	auipc	ra, 2
80202ca4: e7 80 c0 f0  	jalr	-244(ra)
80202ca8: 00 00        	unimp	
80202caa: 42 65        	ld	a0, 16(sp)
80202cac: 2a ec        	sd	a0, 24(sp)
80202cae: 05 61        	addi	sp, sp, 32
80202cb0: 82 80        	ret

0000000080202cb2 <_ZN4core6option15Option$LT$T$GT$16unwrap_unchecked17h0b570ab2d00fea3eE>:
80202cb2: 41 11        	addi	sp, sp, -16
80202cb4: 2a e0        	sd	a0, 0(sp)
80202cb6: b3 35 a0 00  	snez	a1, a0
80202cba: 81 45        	mv	a1, zero
80202cbc: 63 05 b5 00  	beq	a0, a1, 0x80202cc6 <_ZN4core6option15Option$LT$T$GT$16unwrap_unchecked17h0b570ab2d00fea3eE+0x14>
80202cc0: 09 a0        	j	0x80202cc2 <_ZN4core6option15Option$LT$T$GT$16unwrap_unchecked17h0b570ab2d00fea3eE+0x10>
80202cc2: 39 a0        	j	0x80202cd0 <_ZN4core6option15Option$LT$T$GT$16unwrap_unchecked17h0b570ab2d00fea3eE+0x1e>
80202cc4: 00 00        	unimp	
80202cc6: 97 e0 ff ff  	auipc	ra, 1048574
80202cca: e7 80 20 51  	jalr	1298(ra)
80202cce: 00 00        	unimp	
80202cd0: 02 65        	ld	a0, 0(sp)
80202cd2: 2a e4        	sd	a0, 8(sp)
80202cd4: 41 01        	addi	sp, sp, 16
80202cd6: 82 80        	ret

0000000080202cd8 <_ZN4core6option15Option$LT$T$GT$3map17hfd9c8b05376cb385E>:
80202cd8: 79 71        	addi	sp, sp, -48
80202cda: 06 f4        	sd	ra, 40(sp)
80202cdc: 2a c4        	sw	a0, 8(sp)
80202cde: 2e c6        	sw	a1, 12(sp)
80202ce0: 85 45        	addi	a1, zero, 1
80202ce2: a3 0f b1 00  	sb	a1, 31(sp)
80202ce6: 02 15        	slli	a0, a0, 32
80202ce8: 01 91        	srli	a0, a0, 32
80202cea: 81 45        	mv	a1, zero
80202cec: 63 05 b5 00  	beq	a0, a1, 0x80202cf6 <_ZN4core6option15Option$LT$T$GT$3map17hfd9c8b05376cb385E+0x1e>
80202cf0: 09 a0        	j	0x80202cf2 <_ZN4core6option15Option$LT$T$GT$3map17hfd9c8b05376cb385E+0x1a>
80202cf2: 31 a0        	j	0x80202cfe <_ZN4core6option15Option$LT$T$GT$3map17hfd9c8b05376cb385E+0x26>
80202cf4: 00 00        	unimp	
80202cf6: 37 05 11 00  	lui	a0, 272
80202cfa: 2a ca        	sw	a0, 20(sp)
80202cfc: 15 a0        	j	0x80202d20 <_ZN4core6option15Option$LT$T$GT$3map17hfd9c8b05376cb385E+0x48>
80202cfe: 32 45        	lw	a0, 12(sp)
80202d00: 2a d2        	sw	a0, 36(sp)
80202d02: 81 45        	mv	a1, zero
80202d04: a3 0f b1 00  	sb	a1, 31(sp)
80202d08: 2a cc        	sw	a0, 24(sp)
80202d0a: 97 00 00 00  	auipc	ra, 0
80202d0e: e7 80 20 2c  	jalr	706(ra)
80202d12: 02 15        	slli	a0, a0, 32
80202d14: 01 91        	srli	a0, a0, 32
80202d16: 2a e0        	sd	a0, 0(sp)
80202d18: 09 a0        	j	0x80202d1a <_ZN4core6option15Option$LT$T$GT$3map17hfd9c8b05376cb385E+0x42>
80202d1a: 02 65        	ld	a0, 0(sp)
80202d1c: 2a ca        	sw	a0, 20(sp)
80202d1e: 09 a0        	j	0x80202d20 <_ZN4core6option15Option$LT$T$GT$3map17hfd9c8b05376cb385E+0x48>
80202d20: 03 45 f1 01  	lbu	a0, 31(sp)
80202d24: 05 89        	andi	a0, a0, 1
80202d26: 81 45        	mv	a1, zero
80202d28: 63 17 b5 00  	bne	a0, a1, 0x80202d36 <_ZN4core6option15Option$LT$T$GT$3map17hfd9c8b05376cb385E+0x5e>
80202d2c: 09 a0        	j	0x80202d2e <_ZN4core6option15Option$LT$T$GT$3map17hfd9c8b05376cb385E+0x56>
80202d2e: 52 45        	lw	a0, 20(sp)
80202d30: a2 70        	ld	ra, 40(sp)
80202d32: 45 61        	addi	sp, sp, 48
80202d34: 82 80        	ret
80202d36: e5 bf        	j	0x80202d2e <_ZN4core6option15Option$LT$T$GT$3map17hfd9c8b05376cb385E+0x56>

0000000080202d38 <_ZN75_$LT$core..option..Option$LT$T$GT$$u20$as$u20$core..ops..try_trait..Try$GT$6branch17h2f93e5f005d052e8E>:
80202d38: 01 11        	addi	sp, sp, -32
80202d3a: 2a e4        	sd	a0, 8(sp)
80202d3c: b3 35 a0 00  	snez	a1, a0
80202d40: 81 45        	mv	a1, zero
80202d42: 63 05 b5 00  	beq	a0, a1, 0x80202d4c <_ZN75_$LT$core..option..Option$LT$T$GT$$u20$as$u20$core..ops..try_trait..Try$GT$6branch17h2f93e5f005d052e8E+0x14>
80202d46: 09 a0        	j	0x80202d48 <_ZN75_$LT$core..option..Option$LT$T$GT$$u20$as$u20$core..ops..try_trait..Try$GT$6branch17h2f93e5f005d052e8E+0x10>
80202d48: 29 a0        	j	0x80202d52 <_ZN75_$LT$core..option..Option$LT$T$GT$$u20$as$u20$core..ops..try_trait..Try$GT$6branch17h2f93e5f005d052e8E+0x1a>
80202d4a: 00 00        	unimp	
80202d4c: 01 45        	mv	a0, zero
80202d4e: 2a e8        	sd	a0, 16(sp)
80202d50: 29 a0        	j	0x80202d5a <_ZN75_$LT$core..option..Option$LT$T$GT$$u20$as$u20$core..ops..try_trait..Try$GT$6branch17h2f93e5f005d052e8E+0x22>
80202d52: 22 65        	ld	a0, 8(sp)
80202d54: 2a ec        	sd	a0, 24(sp)
80202d56: 2a e8        	sd	a0, 16(sp)
80202d58: 09 a0        	j	0x80202d5a <_ZN75_$LT$core..option..Option$LT$T$GT$$u20$as$u20$core..ops..try_trait..Try$GT$6branch17h2f93e5f005d052e8E+0x22>
80202d5a: 42 65        	ld	a0, 16(sp)
80202d5c: 05 61        	addi	sp, sp, 32
80202d5e: 82 80        	ret

0000000080202d60 <_ZN75_$LT$core..option..Option$LT$T$GT$$u20$as$u20$core..ops..try_trait..Try$GT$6branch17hab1c75e873f9a27fE>:
80202d60: 01 11        	addi	sp, sp, -32
80202d62: 2a e4        	sd	a0, 8(sp)
80202d64: b3 35 a0 00  	snez	a1, a0
80202d68: 81 45        	mv	a1, zero
80202d6a: 63 05 b5 00  	beq	a0, a1, 0x80202d74 <_ZN75_$LT$core..option..Option$LT$T$GT$$u20$as$u20$core..ops..try_trait..Try$GT$6branch17hab1c75e873f9a27fE+0x14>
80202d6e: 09 a0        	j	0x80202d70 <_ZN75_$LT$core..option..Option$LT$T$GT$$u20$as$u20$core..ops..try_trait..Try$GT$6branch17hab1c75e873f9a27fE+0x10>
80202d70: 29 a0        	j	0x80202d7a <_ZN75_$LT$core..option..Option$LT$T$GT$$u20$as$u20$core..ops..try_trait..Try$GT$6branch17hab1c75e873f9a27fE+0x1a>
80202d72: 00 00        	unimp	
80202d74: 01 45        	mv	a0, zero
80202d76: 2a e8        	sd	a0, 16(sp)
80202d78: 29 a0        	j	0x80202d82 <_ZN75_$LT$core..option..Option$LT$T$GT$$u20$as$u20$core..ops..try_trait..Try$GT$6branch17hab1c75e873f9a27fE+0x22>
80202d7a: 22 65        	ld	a0, 8(sp)
80202d7c: 2a ec        	sd	a0, 24(sp)
80202d7e: 2a e8        	sd	a0, 16(sp)
80202d80: 09 a0        	j	0x80202d82 <_ZN75_$LT$core..option..Option$LT$T$GT$$u20$as$u20$core..ops..try_trait..Try$GT$6branch17hab1c75e873f9a27fE+0x22>
80202d82: 42 65        	ld	a0, 16(sp)
80202d84: 05 61        	addi	sp, sp, 32
80202d86: 82 80        	ret

0000000080202d88 <_ZN84_$LT$core..option..Option$LT$T$GT$$u20$as$u20$core..ops..try_trait..FromResidual$GT$13from_residual17hb3dae21477d19da8E>:
80202d88: 01 11        	addi	sp, sp, -32
80202d8a: 81 45        	mv	a1, zero
80202d8c: 2e e8        	sd	a1, 16(sp)
80202d8e: 22 65        	ld	a0, 8(sp)
80202d90: 05 61        	addi	sp, sp, 32
80202d92: 82 80        	ret

0000000080202d94 <_ZN84_$LT$core..option..Option$LT$T$GT$$u20$as$u20$core..ops..try_trait..FromResidual$GT$13from_residual17hdddf0d2829c06356E>:
80202d94: 41 11        	addi	sp, sp, -16
80202d96: 01 45        	mv	a0, zero
80202d98: 2a c0        	sw	a0, 0(sp)
80202d9a: 92 45        	lw	a1, 4(sp)
80202d9c: 41 01        	addi	sp, sp, 16
80202d9e: 82 80        	ret

0000000080202da0 <_ZN45_$LT$usize$u20$as$u20$bit_field..BitField$GT$7get_bit17hf9726c157a07e3afE>:
80202da0: 79 71        	addi	sp, sp, -48
80202da2: 2e e8        	sd	a1, 16(sp)
80202da4: 2a ec        	sd	a0, 24(sp)
80202da6: 2a f0        	sd	a0, 32(sp)
80202da8: 2e f4        	sd	a1, 40(sp)
80202daa: 13 05 f0 03  	addi	a0, zero, 63
80202dae: 63 61 b5 02  	bltu	a0, a1, 0x80202dd0 <.LBB0_5>
80202db2: 09 a0        	j	0x80202db4 <_ZN45_$LT$usize$u20$as$u20$bit_field..BitField$GT$7get_bit17hf9726c157a07e3afE+0x14>
80202db4: 42 66        	ld	a2, 16(sp)
80202db6: 62 65        	ld	a0, 24(sp)
80202db8: 08 61        	ld	a0, 0(a0)
80202dba: 2a e0        	sd	a0, 0(sp)
80202dbc: 13 75 06 fc  	andi	a0, a2, -64
80202dc0: 85 45        	addi	a1, zero, 1
80202dc2: b3 95 c5 00  	sll	a1, a1, a2
80202dc6: 2e e4        	sd	a1, 8(sp)
80202dc8: 81 45        	mv	a1, zero
80202dca: 63 19 b5 02  	bne	a0, a1, 0x80202dfc <.LBB0_7>
80202dce: 05 a0        	j	0x80202dee <.LBB0_6+0x16>

0000000080202dd0 <.LBB0_5>:
80202dd0: 17 55 01 00  	auipc	a0, 21
80202dd4: 13 05 35 44  	addi	a0, a0, 1091

0000000080202dd8 <.LBB0_6>:
80202dd8: 17 56 01 00  	auipc	a2, 21
80202ddc: 13 06 86 4c  	addi	a2, a2, 1224
80202de0: 93 05 80 02  	addi	a1, zero, 40
80202de4: 97 20 00 00  	auipc	ra, 2
80202de8: e7 80 80 dc  	jalr	-568(ra)
80202dec: 00 00        	unimp	
80202dee: 02 65        	ld	a0, 0(sp)
80202df0: a2 65        	ld	a1, 8(sp)
80202df2: 6d 8d        	and	a0, a0, a1
80202df4: 33 35 a0 00  	snez	a0, a0
80202df8: 45 61        	addi	sp, sp, 48
80202dfa: 82 80        	ret

0000000080202dfc <.LBB0_7>:
80202dfc: 17 55 01 00  	auipc	a0, 21
80202e00: 13 05 45 4c  	addi	a0, a0, 1220

0000000080202e04 <.LBB0_8>:
80202e04: 17 56 01 00  	auipc	a2, 21
80202e08: 13 06 c6 49  	addi	a2, a2, 1180
80202e0c: 93 05 30 02  	addi	a1, zero, 35
80202e10: 97 20 00 00  	auipc	ra, 2
80202e14: e7 80 c0 d9  	jalr	-612(ra)
80202e18: 00 00        	unimp	

0000000080202e1a <_ZN45_$LT$usize$u20$as$u20$bit_field..BitField$GT$7set_bit17ha3a793ac41bc57a9E>:
80202e1a: 39 71        	addi	sp, sp, -64
80202e1c: 2e e8        	sd	a1, 16(sp)
80202e1e: 2a ec        	sd	a0, 24(sp)
80202e20: b2 86        	mv	a3, a2
80202e22: 36 f0        	sd	a3, 32(sp)
80202e24: 2a f4        	sd	a0, 40(sp)
80202e26: 2e f8        	sd	a1, 48(sp)
80202e28: a3 0f c1 02  	sb	a2, 63(sp)
80202e2c: 13 05 f0 03  	addi	a0, zero, 63
80202e30: 63 68 b5 00  	bltu	a0, a1, 0x80202e40 <.LBB1_10>
80202e34: 09 a0        	j	0x80202e36 <_ZN45_$LT$usize$u20$as$u20$bit_field..BitField$GT$7set_bit17ha3a793ac41bc57a9E+0x1c>
80202e36: 02 75        	ld	a0, 32(sp)
80202e38: 81 45        	mv	a1, zero
80202e3a: 63 1d b5 02  	bne	a0, a1, 0x80202e74 <.LBB1_11+0x2c>
80202e3e: 05 a0        	j	0x80202e5e <.LBB1_11+0x16>

0000000080202e40 <.LBB1_10>:
80202e40: 17 55 01 00  	auipc	a0, 21
80202e44: 13 05 35 3d  	addi	a0, a0, 979

0000000080202e48 <.LBB1_11>:
80202e48: 17 56 01 00  	auipc	a2, 21
80202e4c: 13 06 86 45  	addi	a2, a2, 1112
80202e50: 93 05 80 02  	addi	a1, zero, 40
80202e54: 97 20 00 00  	auipc	ra, 2
80202e58: e7 80 80 d5  	jalr	-680(ra)
80202e5c: 00 00        	unimp	
80202e5e: 42 66        	ld	a2, 16(sp)
80202e60: 13 75 06 fc  	andi	a0, a2, -64
80202e64: 85 45        	addi	a1, zero, 1
80202e66: b3 95 c5 00  	sll	a1, a1, a2
80202e6a: 2e e4        	sd	a1, 8(sp)
80202e6c: 81 45        	mv	a1, zero
80202e6e: 63 1e b5 04  	bne	a0, a1, 0x80202eca <.LBB1_14>
80202e72: a1 a0        	j	0x80202eba <.LBB1_13+0x1c>
80202e74: 42 66        	ld	a2, 16(sp)
80202e76: 13 75 06 fc  	andi	a0, a2, -64
80202e7a: 85 45        	addi	a1, zero, 1
80202e7c: b3 95 c5 00  	sll	a1, a1, a2
80202e80: 2e e0        	sd	a1, 0(sp)
80202e82: 81 45        	mv	a1, zero
80202e84: 63 19 b5 00  	bne	a0, a1, 0x80202e96 <.LBB1_12>
80202e88: 09 a0        	j	0x80202e8a <.LBB1_11+0x42>
80202e8a: e2 65        	ld	a1, 24(sp)
80202e8c: 02 66        	ld	a2, 0(sp)
80202e8e: 88 61        	ld	a0, 0(a1)
80202e90: 51 8d        	or	a0, a0, a2
80202e92: 88 e1        	sd	a0, 0(a1)
80202e94: 05 a0        	j	0x80202eb4 <.LBB1_13+0x16>

0000000080202e96 <.LBB1_12>:
80202e96: 17 55 01 00  	auipc	a0, 21
80202e9a: 13 05 a5 42  	addi	a0, a0, 1066

0000000080202e9e <.LBB1_13>:
80202e9e: 17 56 01 00  	auipc	a2, 21
80202ea2: 13 06 26 40  	addi	a2, a2, 1026
80202ea6: 93 05 30 02  	addi	a1, zero, 35
80202eaa: 97 20 00 00  	auipc	ra, 2
80202eae: e7 80 20 d0  	jalr	-766(ra)
80202eb2: 00 00        	unimp	
80202eb4: 62 65        	ld	a0, 24(sp)
80202eb6: 21 61        	addi	sp, sp, 64
80202eb8: 82 80        	ret
80202eba: e2 65        	ld	a1, 24(sp)
80202ebc: 22 65        	ld	a0, 8(sp)
80202ebe: 13 46 f5 ff  	not	a2, a0
80202ec2: 88 61        	ld	a0, 0(a1)
80202ec4: 71 8d        	and	a0, a0, a2
80202ec6: 88 e1        	sd	a0, 0(a1)
80202ec8: f5 b7        	j	0x80202eb4 <.LBB1_13+0x16>

0000000080202eca <.LBB1_14>:
80202eca: 17 55 01 00  	auipc	a0, 21
80202ece: 13 05 65 3f  	addi	a0, a0, 1014

0000000080202ed2 <.LBB1_15>:
80202ed2: 17 56 01 00  	auipc	a2, 21
80202ed6: 13 06 e6 3c  	addi	a2, a2, 974
80202eda: 93 05 30 02  	addi	a1, zero, 35
80202ede: 97 20 00 00  	auipc	ra, 2
80202ee2: e7 80 e0 cc  	jalr	-818(ra)
80202ee6: 00 00        	unimp	

0000000080202ee8 <_ZN2os7syscall2fs9sys_write17h61ef71c0ca944ba1E>:
80202ee8: 11 71        	addi	sp, sp, -256
80202eea: 86 fd        	sd	ra, 248(sp)
80202eec: 32 f4        	sd	a2, 40(sp)
80202eee: 2e f8        	sd	a1, 48(sp)
80202ef0: aa e9        	sd	a0, 208(sp)
80202ef2: ae ed        	sd	a1, 216(sp)
80202ef4: b2 f1        	sd	a2, 224(sp)
80202ef6: 85 45        	addi	a1, zero, 1
80202ef8: 63 10 b5 02  	bne	a0, a1, 0x80202f18 <.LBB0_10>
80202efc: 09 a0        	j	0x80202efe <_ZN2os7syscall2fs9sys_write17h61ef71c0ca944ba1E+0x16>
80202efe: a2 75        	ld	a1, 40(sp)
80202f00: 42 75        	ld	a0, 48(sp)
80202f02: 97 f0 ff ff  	auipc	ra, 1048575
80202f06: e7 80 a0 0c  	jalr	202(ra)
80202f0a: 2a 86        	mv	a2, a0
80202f0c: 32 ec        	sd	a2, 24(sp)
80202f0e: 2e 86        	mv	a2, a1
80202f10: 32 f0        	sd	a2, 32(sp)
80202f12: aa f5        	sd	a0, 232(sp)
80202f14: ae f9        	sd	a1, 240(sp)
80202f16: 1d a8        	j	0x80202f4c <.LBB0_12+0x14>

0000000080202f18 <.LBB0_10>:
80202f18: 97 55 01 00  	auipc	a1, 21
80202f1c: 93 85 85 3e  	addi	a1, a1, 1000

0000000080202f20 <.LBB0_11>:
80202f20: 97 56 01 00  	auipc	a3, 21
80202f24: 93 86 06 3f  	addi	a3, a3, 1008
80202f28: 08 11        	addi	a0, sp, 160
80202f2a: 05 46        	addi	a2, zero, 1
80202f2c: 01 47        	mv	a4, zero
80202f2e: 97 f0 ff ff  	auipc	ra, 1048575
80202f32: e7 80 a0 4f  	jalr	1274(ra)
80202f36: 09 a0        	j	0x80202f38 <.LBB0_12>

0000000080202f38 <.LBB0_12>:
80202f38: 97 55 01 00  	auipc	a1, 21
80202f3c: 93 85 05 3f  	addi	a1, a1, 1008
80202f40: 08 11        	addi	a0, sp, 160
80202f42: 97 20 00 00  	auipc	ra, 2
80202f46: e7 80 60 cd  	jalr	-810(ra)
80202f4a: 00 00        	unimp	
80202f4c: 02 76        	ld	a2, 32(sp)
80202f4e: e2 65        	ld	a1, 24(sp)
80202f50: a8 00        	addi	a0, sp, 72
80202f52: 97 30 00 00  	auipc	ra, 3
80202f56: e7 80 40 e0  	jalr	-508(ra)
80202f5a: 09 a0        	j	0x80202f5c <.LBB0_13>

0000000080202f5c <.LBB0_13>:
80202f5c: 97 55 01 00  	auipc	a1, 21
80202f60: 93 85 45 3e  	addi	a1, a1, 996
80202f64: a8 00        	addi	a0, sp, 72
80202f66: 97 f0 ff ff  	auipc	ra, 1048575
80202f6a: e7 80 e0 84  	jalr	-1970(ra)
80202f6e: 2a fc        	sd	a0, 56(sp)
80202f70: ae e0        	sd	a1, 64(sp)
80202f72: 09 a0        	j	0x80202f74 <.LBB0_14>

0000000080202f74 <.LBB0_14>:
80202f74: 97 15 00 00  	auipc	a1, 1
80202f78: 93 85 05 46  	addi	a1, a1, 1120
80202f7c: 28 18        	addi	a0, sp, 56
80202f7e: 97 10 00 00  	auipc	ra, 1
80202f82: e7 80 40 43  	jalr	1076(ra)
80202f86: 2a e4        	sd	a0, 8(sp)
80202f88: 2e e8        	sd	a1, 16(sp)
80202f8a: 09 a0        	j	0x80202f8c <.LBB0_14+0x18>
80202f8c: 42 65        	ld	a0, 16(sp)
80202f8e: a2 65        	ld	a1, 8(sp)
80202f90: 2e e9        	sd	a1, 144(sp)
80202f92: 2a ed        	sd	a0, 152(sp)

0000000080202f94 <.LBB0_15>:
80202f94: 97 55 01 00  	auipc	a1, 21
80202f98: 93 85 45 3c  	addi	a1, a1, 964
80202f9c: 88 10        	addi	a0, sp, 96
80202f9e: 14 09        	addi	a3, sp, 144
80202fa0: 05 47        	addi	a4, zero, 1
80202fa2: 3a 86        	mv	a2, a4
80202fa4: 97 f0 ff ff  	auipc	ra, 1048575
80202fa8: e7 80 40 48  	jalr	1156(ra)
80202fac: 09 a0        	j	0x80202fae <.LBB0_15+0x1a>
80202fae: 88 10        	addi	a0, sp, 96
80202fb0: 97 f0 ff ff  	auipc	ra, 1048575
80202fb4: e7 80 40 b1  	jalr	-1260(ra)
80202fb8: 09 a0        	j	0x80202fba <.LBB0_15+0x26>
80202fba: 22 75        	ld	a0, 40(sp)
80202fbc: ee 70        	ld	ra, 248(sp)
80202fbe: 11 61        	addi	sp, sp, 256
80202fc0: 82 80        	ret

0000000080202fc2 <_ZN63_$LT$I$u20$as$u20$core..iter..traits..collect..IntoIterator$GT$9into_iter17h92a575408dcef914E>:
80202fc2: 41 11        	addi	sp, sp, -16
80202fc4: 2a e0        	sd	a0, 0(sp)
80202fc6: 2e e4        	sd	a1, 8(sp)
80202fc8: 41 01        	addi	sp, sp, 16
80202fca: 82 80        	ret

0000000080202fcc <_ZN81_$LT$core..str..iter..Chars$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4next28_$u7b$$u7b$closure$u7d$$u7d$17h127d2b24bf913fe7E>:
80202fcc: 01 11        	addi	sp, sp, -32
80202fce: 06 ec        	sd	ra, 24(sp)
80202fd0: 2a ca        	sw	a0, 20(sp)
80202fd2: 97 d0 ff ff  	auipc	ra, 1048573
80202fd6: e7 80 60 40  	jalr	1030(ra)
80202fda: 02 15        	slli	a0, a0, 32
80202fdc: 01 91        	srli	a0, a0, 32
80202fde: 2a e4        	sd	a0, 8(sp)
80202fe0: 09 a0        	j	0x80202fe2 <_ZN81_$LT$core..str..iter..Chars$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4next28_$u7b$$u7b$closure$u7d$$u7d$17h127d2b24bf913fe7E+0x16>
80202fe2: 22 65        	ld	a0, 8(sp)
80202fe4: e2 60        	ld	ra, 24(sp)
80202fe6: 05 61        	addi	sp, sp, 32
80202fe8: 82 80        	ret

0000000080202fea <_ZN5riscv8register3sie4_set17he5c2f3f4a5b6a36bE>:
80202fea: 41 11        	addi	sp, sp, -16
80202fec: 2a e4        	sd	a0, 8(sp)
80202fee: 73 20 45 10  	csrs	sie, a0
80202ff2: 09 a0        	j	0x80202ff4 <_ZN5riscv8register3sie4_set17he5c2f3f4a5b6a36bE+0xa>
80202ff4: 41 01        	addi	sp, sp, 16
80202ff6: 82 80        	ret

0000000080202ff8 <_ZN5riscv8register3sie10set_stimer17h76d0a4e586c4adbdE>:
80202ff8: 41 11        	addi	sp, sp, -16
80202ffa: 06 e4        	sd	ra, 8(sp)
80202ffc: 13 05 00 02  	addi	a0, zero, 32
80203000: 97 00 00 00  	auipc	ra, 0
80203004: e7 80 a0 fe  	jalr	-22(ra)
80203008: 09 a0        	j	0x8020300a <_ZN5riscv8register3sie10set_stimer17h76d0a4e586c4adbdE+0x12>
8020300a: a2 60        	ld	ra, 8(sp)
8020300c: 41 01        	addi	sp, sp, 16
8020300e: 82 80        	ret

0000000080203010 <_ZN4core3ptr8metadata14from_raw_parts17he3349ee0bc4b72e7E>:
80203010: 79 71        	addi	sp, sp, -48
80203012: 2a f0        	sd	a0, 32(sp)
80203014: 2e f4        	sd	a1, 40(sp)
80203016: 2a e8        	sd	a0, 16(sp)
80203018: 2e ec        	sd	a1, 24(sp)
8020301a: 2a e0        	sd	a0, 0(sp)
8020301c: 2e e4        	sd	a1, 8(sp)
8020301e: 45 61        	addi	sp, sp, 48
80203020: 82 80        	ret

0000000080203022 <_ZN4core4char7methods22_$LT$impl$u20$char$GT$11encode_utf817ha6358c07cc4db580E>:
80203022: 39 71        	addi	sp, sp, -64
80203024: 06 fc        	sd	ra, 56(sp)
80203026: 2a d2        	sw	a0, 36(sp)
80203028: 2e f4        	sd	a1, 40(sp)
8020302a: 32 f8        	sd	a2, 48(sp)
8020302c: 97 00 00 00  	auipc	ra, 0
80203030: e7 80 00 08  	jalr	128(ra)
80203034: 2a e8        	sd	a0, 16(sp)
80203036: 2e ec        	sd	a1, 24(sp)
80203038: 09 a0        	j	0x8020303a <_ZN4core4char7methods22_$LT$impl$u20$char$GT$11encode_utf817ha6358c07cc4db580E+0x18>
8020303a: e2 65        	ld	a1, 24(sp)
8020303c: 42 65        	ld	a0, 16(sp)
8020303e: 97 10 00 00  	auipc	ra, 1
80203042: e7 80 e0 c8  	jalr	-882(ra)
80203046: 2a e0        	sd	a0, 0(sp)
80203048: 2e e4        	sd	a1, 8(sp)
8020304a: 09 a0        	j	0x8020304c <_ZN4core4char7methods22_$LT$impl$u20$char$GT$11encode_utf817ha6358c07cc4db580E+0x2a>
8020304c: a2 65        	ld	a1, 8(sp)
8020304e: 02 65        	ld	a0, 0(sp)
80203050: e2 70        	ld	ra, 56(sp)
80203052: 21 61        	addi	sp, sp, 64
80203054: 82 80        	ret

0000000080203056 <_ZN4core4char7methods8len_utf817h254ab9c803d74a25E>:
80203056: 01 11        	addi	sp, sp, -32
80203058: aa 85        	mv	a1, a0
8020305a: 1b 85 05 00  	sext.w	a0, a1
8020305e: 2e 86        	mv	a2, a1
80203060: 32 e4        	sd	a2, 8(sp)
80203062: 2e ce        	sw	a1, 28(sp)
80203064: 93 05 00 08  	addi	a1, zero, 128
80203068: 63 6a b5 00  	bltu	a0, a1, 0x8020307c <_ZN4core4char7methods8len_utf817h254ab9c803d74a25E+0x26>
8020306c: 09 a0        	j	0x8020306e <_ZN4core4char7methods8len_utf817h254ab9c803d74a25E+0x18>
8020306e: 22 65        	ld	a0, 8(sp)
80203070: 1b 55 b5 00  	srliw	a0, a0, 11
80203074: 81 45        	mv	a1, zero
80203076: 63 00 b5 02  	beq	a0, a1, 0x80203096 <_ZN4core4char7methods8len_utf817h254ab9c803d74a25E+0x40>
8020307a: 39 a0        	j	0x80203088 <_ZN4core4char7methods8len_utf817h254ab9c803d74a25E+0x32>
8020307c: 05 45        	addi	a0, zero, 1
8020307e: 2a e8        	sd	a0, 16(sp)
80203080: 09 a0        	j	0x80203082 <_ZN4core4char7methods8len_utf817h254ab9c803d74a25E+0x2c>
80203082: 42 65        	ld	a0, 16(sp)
80203084: 05 61        	addi	sp, sp, 32
80203086: 82 80        	ret
80203088: 22 65        	ld	a0, 8(sp)
8020308a: 1b 55 05 01  	srliw	a0, a0, 16
8020308e: 81 45        	mv	a1, zero
80203090: 63 0a b5 00  	beq	a0, a1, 0x802030a4 <_ZN4core4char7methods8len_utf817h254ab9c803d74a25E+0x4e>
80203094: 29 a0        	j	0x8020309e <_ZN4core4char7methods8len_utf817h254ab9c803d74a25E+0x48>
80203096: 09 45        	addi	a0, zero, 2
80203098: 2a e8        	sd	a0, 16(sp)
8020309a: 09 a0        	j	0x8020309c <_ZN4core4char7methods8len_utf817h254ab9c803d74a25E+0x46>
8020309c: dd b7        	j	0x80203082 <_ZN4core4char7methods8len_utf817h254ab9c803d74a25E+0x2c>
8020309e: 11 45        	addi	a0, zero, 4
802030a0: 2a e8        	sd	a0, 16(sp)
802030a2: 21 a0        	j	0x802030aa <_ZN4core4char7methods8len_utf817h254ab9c803d74a25E+0x54>
802030a4: 0d 45        	addi	a0, zero, 3
802030a6: 2a e8        	sd	a0, 16(sp)
802030a8: 09 a0        	j	0x802030aa <_ZN4core4char7methods8len_utf817h254ab9c803d74a25E+0x54>
802030aa: cd bf        	j	0x8020309c <_ZN4core4char7methods8len_utf817h254ab9c803d74a25E+0x46>

00000000802030ac <_ZN4core4char7methods15encode_utf8_raw17h1dc4d699dd27cfd1E>:
802030ac: 09 71        	addi	sp, sp, -384
802030ae: 86 fe        	sd	ra, 376(sp)
802030b0: b2 f8        	sd	a2, 112(sp)
802030b2: ae fc        	sd	a1, 120(sp)
802030b4: 2a c3        	sw	a0, 132(sp)
802030b6: 2e ee        	sd	a1, 280(sp)
802030b8: 32 f2        	sd	a2, 288(sp)
802030ba: 97 00 00 00  	auipc	ra, 0
802030be: e7 80 c0 f9  	jalr	-100(ra)
802030c2: 2a e5        	sd	a0, 136(sp)
802030c4: 09 a0        	j	0x802030c6 <_ZN4core4char7methods15encode_utf8_raw17h1dc4d699dd27cfd1E+0x1a>
802030c6: c6 75        	ld	a1, 112(sp)
802030c8: 66 75        	ld	a0, 120(sp)
802030ca: 2a 66        	ld	a2, 136(sp)
802030cc: b2 ec        	sd	a2, 88(sp)

00000000802030ce <.LBB2_21>:
802030ce: 17 56 01 00  	auipc	a2, 21
802030d2: 13 06 a6 2e  	addi	a2, a2, 746
802030d6: 97 10 00 00  	auipc	ra, 1
802030da: e7 80 a0 c2  	jalr	-982(ra)
802030de: aa f0        	sd	a0, 96(sp)
802030e0: ae f4        	sd	a1, 104(sp)
802030e2: 09 a0        	j	0x802030e4 <.LBB2_21+0x16>
802030e4: 66 65        	ld	a0, 88(sp)
802030e6: a6 75        	ld	a1, 104(sp)
802030e8: 06 76        	ld	a2, 96(sp)
802030ea: 2a e9        	sd	a0, 144(sp)
802030ec: 32 ed        	sd	a2, 152(sp)
802030ee: 2e f1        	sd	a1, 160(sp)
802030f0: aa 85        	mv	a1, a0
802030f2: ae e8        	sd	a1, 80(sp)
802030f4: 85 45        	addi	a1, zero, 1
802030f6: 63 0e b5 02  	beq	a0, a1, 0x80203132 <.LBB2_22+0x18>
802030fa: 09 a0        	j	0x802030fc <.LBB2_21+0x2e>
802030fc: 46 65        	ld	a0, 80(sp)
802030fe: 89 45        	addi	a1, zero, 2
80203100: 63 0e b5 02  	beq	a0, a1, 0x8020313c <.LBB2_22+0x22>
80203104: 09 a0        	j	0x80203106 <.LBB2_21+0x38>
80203106: 46 65        	ld	a0, 80(sp)
80203108: 8d 45        	addi	a1, zero, 3
8020310a: 63 0e b5 02  	beq	a0, a1, 0x80203146 <.LBB2_22+0x2c>
8020310e: 09 a0        	j	0x80203110 <.LBB2_21+0x42>
80203110: 46 65        	ld	a0, 80(sp)
80203112: 91 45        	addi	a1, zero, 4
80203114: 63 0e b5 02  	beq	a0, a1, 0x80203150 <.LBB2_22+0x36>
80203118: 09 a0        	j	0x8020311a <.LBB2_22>

000000008020311a <.LBB2_22>:
8020311a: 97 35 00 00  	auipc	a1, 3
8020311e: 93 85 25 68  	addi	a1, a1, 1666
80203122: 28 01        	addi	a0, sp, 136
80203124: 97 e0 ff ff  	auipc	ra, 1048574
80203128: e7 80 c0 f2  	jalr	-212(ra)
8020312c: aa e0        	sd	a0, 64(sp)
8020312e: ae e4        	sd	a1, 72(sp)
80203130: 0d a2        	j	0x80203252 <.LBB2_24>
80203132: 0a 75        	ld	a0, 160(sp)
80203134: 81 45        	mv	a1, zero
80203136: 63 12 b5 10  	bne	a0, a1, 0x8020323a <.LBB2_23+0x80>
8020313a: c5 b7        	j	0x8020311a <.LBB2_22>
8020313c: 8a 75        	ld	a1, 160(sp)
8020313e: 05 45        	addi	a0, zero, 1
80203140: 63 68 b5 0c  	bltu	a0, a1, 0x80203210 <.LBB2_23+0x56>
80203144: d9 bf        	j	0x8020311a <.LBB2_22>
80203146: 8a 75        	ld	a1, 160(sp)
80203148: 09 45        	addi	a0, zero, 2
8020314a: 63 63 b5 08  	bltu	a0, a1, 0x802031d0 <.LBB2_23+0x16>
8020314e: f1 b7        	j	0x8020311a <.LBB2_22>
80203150: 0a 75        	ld	a0, 160(sp)
80203152: 91 45        	addi	a1, zero, 4
80203154: e3 63 b5 fc  	bltu	a0, a1, 0x8020311a <.LBB2_22>
80203158: 09 a0        	j	0x8020315a <.LBB2_22+0x40>
8020315a: ea 65        	ld	a1, 152(sp)
8020315c: 2e fc        	sd	a1, 56(sp)
8020315e: 2e f6        	sd	a1, 296(sp)
80203160: 13 85 15 00  	addi	a0, a1, 1
80203164: 2a fa        	sd	a0, 304(sp)
80203166: 13 85 25 00  	addi	a0, a1, 2
8020316a: 2a fe        	sd	a0, 312(sp)
8020316c: 13 85 35 00  	addi	a0, a1, 3
80203170: aa e2        	sd	a0, 320(sp)
80203172: 1a 45        	lw	a0, 132(sp)
80203174: 49 81        	srli	a0, a0, 18
80203176: 1d 89        	andi	a0, a0, 7
80203178: 13 65 05 0f  	ori	a0, a0, 240
8020317c: 23 80 a5 00  	sb	a0, 0(a1)
80203180: 1a 45        	lw	a0, 132(sp)
80203182: 31 81        	srli	a0, a0, 12
80203184: 13 75 f5 03  	andi	a0, a0, 63
80203188: 13 65 05 08  	ori	a0, a0, 128
8020318c: a3 80 a5 00  	sb	a0, 1(a1)
80203190: 1a 45        	lw	a0, 132(sp)
80203192: 19 81        	srli	a0, a0, 6
80203194: 13 75 f5 03  	andi	a0, a0, 63
80203198: 13 65 05 08  	ori	a0, a0, 128
8020319c: 23 81 a5 00  	sb	a0, 2(a1)
802031a0: 03 45 41 08  	lbu	a0, 132(sp)
802031a4: 13 75 f5 03  	andi	a0, a0, 63
802031a8: 13 65 05 08  	ori	a0, a0, 128
802031ac: a3 81 a5 00  	sb	a0, 3(a1)
802031b0: 09 a0        	j	0x802031b2 <.LBB2_22+0x98>
802031b2: c6 75        	ld	a1, 112(sp)
802031b4: 66 75        	ld	a0, 120(sp)
802031b6: 2a 66        	ld	a2, 136(sp)
802031b8: 32 ea        	sd	a2, 272(sp)

00000000802031ba <.LBB2_23>:
802031ba: 97 56 01 00  	auipc	a3, 21
802031be: 93 86 66 21  	addi	a3, a3, 534
802031c2: 97 10 00 00  	auipc	ra, 1
802031c6: e7 80 40 b1  	jalr	-1260(ra)
802031ca: 2a f4        	sd	a0, 40(sp)
802031cc: 2e f8        	sd	a1, 48(sp)
802031ce: ad a8        	j	0x80203248 <.LBB2_23+0x8e>
802031d0: ea 65        	ld	a1, 152(sp)
802031d2: ae e6        	sd	a1, 328(sp)
802031d4: 13 85 15 00  	addi	a0, a1, 1
802031d8: aa ea        	sd	a0, 336(sp)
802031da: 13 85 25 00  	addi	a0, a1, 2
802031de: aa ee        	sd	a0, 344(sp)
802031e0: 1a 45        	lw	a0, 132(sp)
802031e2: 31 81        	srli	a0, a0, 12
802031e4: 3d 89        	andi	a0, a0, 15
802031e6: 13 65 05 0e  	ori	a0, a0, 224
802031ea: 23 80 a5 00  	sb	a0, 0(a1)
802031ee: 1a 45        	lw	a0, 132(sp)
802031f0: 19 81        	srli	a0, a0, 6
802031f2: 13 75 f5 03  	andi	a0, a0, 63
802031f6: 13 65 05 08  	ori	a0, a0, 128
802031fa: a3 80 a5 00  	sb	a0, 1(a1)
802031fe: 03 45 41 08  	lbu	a0, 132(sp)
80203202: 13 75 f5 03  	andi	a0, a0, 63
80203206: 13 65 05 08  	ori	a0, a0, 128
8020320a: 23 81 a5 00  	sb	a0, 2(a1)
8020320e: 55 b7        	j	0x802031b2 <.LBB2_22+0x98>
80203210: ea 65        	ld	a1, 152(sp)
80203212: ae f2        	sd	a1, 352(sp)
80203214: 13 85 15 00  	addi	a0, a1, 1
80203218: aa f6        	sd	a0, 360(sp)
8020321a: 1a 45        	lw	a0, 132(sp)
8020321c: 19 81        	srli	a0, a0, 6
8020321e: 7d 89        	andi	a0, a0, 31
80203220: 13 65 05 0c  	ori	a0, a0, 192
80203224: 23 80 a5 00  	sb	a0, 0(a1)
80203228: 03 45 41 08  	lbu	a0, 132(sp)
8020322c: 13 75 f5 03  	andi	a0, a0, 63
80203230: 13 65 05 08  	ori	a0, a0, 128
80203234: a3 80 a5 00  	sb	a0, 1(a1)
80203238: ad bf        	j	0x802031b2 <.LBB2_22+0x98>
8020323a: ea 65        	ld	a1, 152(sp)
8020323c: ae fa        	sd	a1, 368(sp)
8020323e: 03 05 41 08  	lb	a0, 132(sp)
80203242: 23 80 a5 00  	sb	a0, 0(a1)
80203246: b5 b7        	j	0x802031b2 <.LBB2_22+0x98>
80203248: c2 75        	ld	a1, 48(sp)
8020324a: 22 75        	ld	a0, 40(sp)
8020324c: f6 70        	ld	ra, 376(sp)
8020324e: 19 61        	addi	sp, sp, 384
80203250: 82 80        	ret

0000000080203252 <.LBB2_24>:
80203252: 97 35 00 00  	auipc	a1, 3
80203256: 93 85 e5 0d  	addi	a1, a1, 222
8020325a: 48 01        	addi	a0, sp, 132
8020325c: 97 e0 ff ff  	auipc	ra, 1048574
80203260: e7 80 20 dd  	jalr	-558(ra)
80203264: 2a ec        	sd	a0, 24(sp)
80203266: 2e f0        	sd	a1, 32(sp)
80203268: 09 a0        	j	0x8020326a <.LBB2_24+0x18>
8020326a: 46 75        	ld	a0, 112(sp)
8020326c: 2a e6        	sd	a0, 264(sp)

000000008020326e <.LBB2_25>:
8020326e: 97 35 00 00  	auipc	a1, 3
80203272: 93 85 e5 52  	addi	a1, a1, 1326
80203276: 28 02        	addi	a0, sp, 264
80203278: 97 e0 ff ff  	auipc	ra, 1048574
8020327c: e7 80 80 dd  	jalr	-552(ra)
80203280: 2a e4        	sd	a0, 8(sp)
80203282: 2e e8        	sd	a1, 16(sp)
80203284: 09 a0        	j	0x80203286 <.LBB2_25+0x18>
80203286: 42 65        	ld	a0, 16(sp)
80203288: a2 65        	ld	a1, 8(sp)
8020328a: 02 76        	ld	a2, 32(sp)
8020328c: e2 66        	ld	a3, 24(sp)
8020328e: 26 67        	ld	a4, 72(sp)
80203290: 86 67        	ld	a5, 64(sp)
80203292: be ed        	sd	a5, 216(sp)
80203294: ba f1        	sd	a4, 224(sp)
80203296: b6 f5        	sd	a3, 232(sp)
80203298: b2 f9        	sd	a2, 240(sp)
8020329a: ae fd        	sd	a1, 248(sp)
8020329c: 2a e2        	sd	a0, 256(sp)

000000008020329e <.LBB2_26>:
8020329e: 97 55 01 00  	auipc	a1, 21
802032a2: 93 85 a5 18  	addi	a1, a1, 394
802032a6: 28 11        	addi	a0, sp, 168
802032a8: b4 09        	addi	a3, sp, 216
802032aa: 0d 47        	addi	a4, zero, 3
802032ac: 3a 86        	mv	a2, a4
802032ae: 97 f0 ff ff  	auipc	ra, 1048575
802032b2: e7 80 a0 17  	jalr	378(ra)
802032b6: 09 a0        	j	0x802032b8 <.LBB2_27>

00000000802032b8 <.LBB2_27>:
802032b8: 97 55 01 00  	auipc	a1, 21
802032bc: 93 85 05 1a  	addi	a1, a1, 416
802032c0: 28 11        	addi	a0, sp, 168
802032c2: 97 20 00 00  	auipc	ra, 2
802032c6: e7 80 60 95  	jalr	-1706(ra)
802032ca: 00 00        	unimp	

00000000802032cc <_ZN4core3ptr7mut_ptr31_$LT$impl$u20$$BP$mut$u20$T$GT$7is_null17h9dbfa9b2ce82c5d8E>:
802032cc: 01 11        	addi	sp, sp, -32
802032ce: 06 ec        	sd	ra, 24(sp)
802032d0: 2a e8        	sd	a0, 16(sp)
802032d2: 2a e4        	sd	a0, 8(sp)
802032d4: 09 a0        	j	0x802032d6 <_ZN4core3ptr7mut_ptr31_$LT$impl$u20$$BP$mut$u20$T$GT$7is_null17h9dbfa9b2ce82c5d8E+0xa>
802032d6: 22 65        	ld	a0, 8(sp)
802032d8: 81 45        	mv	a1, zero
802032da: 97 10 00 00  	auipc	ra, 1
802032de: e7 80 c0 1e  	jalr	492(ra)
802032e2: 2a e0        	sd	a0, 0(sp)
802032e4: 09 a0        	j	0x802032e6 <_ZN4core3ptr7mut_ptr31_$LT$impl$u20$$BP$mut$u20$T$GT$7is_null17h9dbfa9b2ce82c5d8E+0x1a>
802032e6: 02 65        	ld	a0, 0(sp)
802032e8: e2 60        	ld	ra, 24(sp)
802032ea: 05 61        	addi	sp, sp, 32
802032ec: 82 80        	ret

00000000802032ee <_ZN4core5slice29_$LT$impl$u20$$u5b$T$u5d$$GT$10as_mut_ptr17h200ac7abd9a0da32E>:
802032ee: 41 11        	addi	sp, sp, -16
802032f0: 2a e0        	sd	a0, 0(sp)
802032f2: 2e e4        	sd	a1, 8(sp)
802032f4: 41 01        	addi	sp, sp, 16
802032f6: 82 80        	ret

00000000802032f8 <_ZN4core5slice29_$LT$impl$u20$$u5b$T$u5d$$GT$8iter_mut17h51b84e1eb677a4e1E>:
802032f8: 79 71        	addi	sp, sp, -48
802032fa: 06 f4        	sd	ra, 40(sp)
802032fc: 2a ec        	sd	a0, 24(sp)
802032fe: 2e f0        	sd	a1, 32(sp)
80203300: 97 f0 ff ff  	auipc	ra, 1048575
80203304: e7 80 00 e7  	jalr	-400(ra)
80203308: 2a e4        	sd	a0, 8(sp)
8020330a: 2e e8        	sd	a1, 16(sp)
8020330c: 09 a0        	j	0x8020330e <_ZN4core5slice29_$LT$impl$u20$$u5b$T$u5d$$GT$8iter_mut17h51b84e1eb677a4e1E+0x16>
8020330e: c2 65        	ld	a1, 16(sp)
80203310: 22 65        	ld	a0, 8(sp)
80203312: a2 70        	ld	ra, 40(sp)
80203314: 45 61        	addi	sp, sp, 48
80203316: 82 80        	ret

0000000080203318 <_ZN5riscv8register5stval4read17h5cbaab0258b261d0E>:
80203318: 41 11        	addi	sp, sp, -16
8020331a: 06 e4        	sd	ra, 8(sp)
8020331c: 97 00 00 00  	auipc	ra, 0
80203320: e7 80 40 01  	jalr	20(ra)
80203324: 2a e0        	sd	a0, 0(sp)
80203326: 09 a0        	j	0x80203328 <_ZN5riscv8register5stval4read17h5cbaab0258b261d0E+0x10>
80203328: 02 65        	ld	a0, 0(sp)
8020332a: a2 60        	ld	ra, 8(sp)
8020332c: 41 01        	addi	sp, sp, 16
8020332e: 82 80        	ret

0000000080203330 <_ZN5riscv8register5stval5_read17he12fda98a9bb1044E>:
80203330: 41 11        	addi	sp, sp, -16
80203332: 73 25 30 14  	csrr	a0, stval
80203336: 2a e4        	sd	a0, 8(sp)
80203338: 09 a0        	j	0x8020333a <_ZN5riscv8register5stval5_read17he12fda98a9bb1044E+0xa>
8020333a: 22 65        	ld	a0, 8(sp)
8020333c: 41 01        	addi	sp, sp, 16
8020333e: 82 80        	ret

0000000080203340 <__switch>:
80203340: 23 34 25 00  	sd	sp, 8(a0)
80203344: 23 30 15 00  	sd	ra, 0(a0)
80203348: 00 e9        	sd	s0, 16(a0)
8020334a: 04 ed        	sd	s1, 24(a0)
8020334c: 23 30 25 03  	sd	s2, 32(a0)
80203350: 23 34 35 03  	sd	s3, 40(a0)
80203354: 23 38 45 03  	sd	s4, 48(a0)
80203358: 23 3c 55 03  	sd	s5, 56(a0)
8020335c: 23 30 65 05  	sd	s6, 64(a0)
80203360: 23 34 75 05  	sd	s7, 72(a0)
80203364: 23 38 85 05  	sd	s8, 80(a0)
80203368: 23 3c 95 05  	sd	s9, 88(a0)
8020336c: 23 30 a5 07  	sd	s10, 96(a0)
80203370: 23 34 b5 07  	sd	s11, 104(a0)
80203374: 83 b0 05 00  	ld	ra, 0(a1)
80203378: 80 69        	ld	s0, 16(a1)
8020337a: 84 6d        	ld	s1, 24(a1)
8020337c: 03 b9 05 02  	ld	s2, 32(a1)
80203380: 83 b9 85 02  	ld	s3, 40(a1)
80203384: 03 ba 05 03  	ld	s4, 48(a1)
80203388: 83 ba 85 03  	ld	s5, 56(a1)
8020338c: 03 bb 05 04  	ld	s6, 64(a1)
80203390: 83 bb 85 04  	ld	s7, 72(a1)
80203394: 03 bc 05 05  	ld	s8, 80(a1)
80203398: 83 bc 85 05  	ld	s9, 88(a1)
8020339c: 03 bd 05 06  	ld	s10, 96(a1)
802033a0: 83 bd 85 06  	ld	s11, 104(a1)
802033a4: 03 b1 85 00  	ld	sp, 8(a1)
802033a8: 82 80        	ret

00000000802033aa <_ZN4core4sync6atomic26strongest_failure_ordering17ha87fb343cf14450fE>:
802033aa: 41 11        	addi	sp, sp, -16
802033ac: 23 07 a1 00  	sb	a0, 14(sp)
802033b0: 13 75 f5 0f  	andi	a0, a0, 255
802033b4: 2a e0        	sd	a0, 0(sp)
802033b6: 02 65        	ld	a0, 0(sp)
802033b8: 0e 05        	slli	a0, a0, 3

00000000802033ba <.LBB0_9>:
802033ba: 97 55 01 00  	auipc	a1, 21
802033be: 93 85 65 0b  	addi	a1, a1, 182
802033c2: 2e 95        	add	a0, a0, a1
802033c4: 08 61        	ld	a0, 0(a0)
802033c6: 02 85        	jr	a0
802033c8: 00 00        	unimp	

00000000802033ca <.LBB0_3>:
802033ca: 01 45        	mv	a0, zero
802033cc: a3 07 a1 00  	sb	a0, 15(sp)
802033d0: 0d a0        	j	0x802033f2 <.LBB0_7+0x8>

00000000802033d2 <.LBB0_4>:
802033d2: 01 45        	mv	a0, zero
802033d4: a3 07 a1 00  	sb	a0, 15(sp)
802033d8: 29 a8        	j	0x802033f2 <.LBB0_7+0x8>

00000000802033da <.LBB0_5>:
802033da: 09 45        	addi	a0, zero, 2
802033dc: a3 07 a1 00  	sb	a0, 15(sp)
802033e0: 09 a8        	j	0x802033f2 <.LBB0_7+0x8>

00000000802033e2 <.LBB0_6>:
802033e2: 09 45        	addi	a0, zero, 2
802033e4: a3 07 a1 00  	sb	a0, 15(sp)
802033e8: 29 a0        	j	0x802033f2 <.LBB0_7+0x8>

00000000802033ea <.LBB0_7>:
802033ea: 11 45        	addi	a0, zero, 4
802033ec: a3 07 a1 00  	sb	a0, 15(sp)
802033f0: 09 a0        	j	0x802033f2 <.LBB0_7+0x8>
802033f2: 03 05 f1 00  	lb	a0, 15(sp)
802033f6: 41 01        	addi	sp, sp, 16
802033f8: 82 80        	ret

00000000802033fa <_ZN4core4sync6atomic14spin_loop_hint17h08435da1a63c8f63E>:
802033fa: 41 11        	addi	sp, sp, -16
802033fc: 06 e4        	sd	ra, 8(sp)
802033fe: 97 e0 ff ff  	auipc	ra, 1048574
80203402: e7 80 c0 dd  	jalr	-548(ra)
80203406: 09 a0        	j	0x80203408 <_ZN4core4sync6atomic14spin_loop_hint17h08435da1a63c8f63E+0xe>
80203408: a2 60        	ld	ra, 8(sp)
8020340a: 41 01        	addi	sp, sp, 16
8020340c: 82 80        	ret

000000008020340e <_ZN4core4sync6atomic11AtomicUsize4load17hc04f5365be578f5cE>:
8020340e: 39 71        	addi	sp, sp, -64
80203410: 06 fc        	sd	ra, 56(sp)
80203412: 2e 86        	mv	a2, a1
80203414: 32 e8        	sd	a2, 16(sp)
80203416: 2a f0        	sd	a0, 32(sp)
80203418: a3 07 b1 02  	sb	a1, 47(sp)
8020341c: aa 85        	mv	a1, a0
8020341e: 2e ec        	sd	a1, 24(sp)
80203420: 2a f8        	sd	a0, 48(sp)
80203422: 09 a0        	j	0x80203424 <_ZN4core4sync6atomic11AtomicUsize4load17hc04f5365be578f5cE+0x16>
80203424: c2 65        	ld	a1, 16(sp)
80203426: 62 65        	ld	a0, 24(sp)
80203428: 97 10 00 00  	auipc	ra, 1
8020342c: e7 80 a0 15  	jalr	346(ra)
80203430: 2a e4        	sd	a0, 8(sp)
80203432: 09 a0        	j	0x80203434 <_ZN4core4sync6atomic11AtomicUsize4load17hc04f5365be578f5cE+0x26>
80203434: 22 65        	ld	a0, 8(sp)
80203436: e2 70        	ld	ra, 56(sp)
80203438: 21 61        	addi	sp, sp, 64
8020343a: 82 80        	ret

000000008020343c <_ZN4core4sync6atomic11AtomicUsize5store17hc50cf8c1647de4fbE>:
8020343c: 39 71        	addi	sp, sp, -64
8020343e: 06 fc        	sd	ra, 56(sp)
80203440: 2e e0        	sd	a1, 0(sp)
80203442: b2 86        	mv	a3, a2
80203444: 36 e4        	sd	a3, 8(sp)
80203446: 2a ec        	sd	a0, 24(sp)
80203448: 2e f0        	sd	a1, 32(sp)
8020344a: a3 07 c1 02  	sb	a2, 47(sp)
8020344e: aa 85        	mv	a1, a0
80203450: 2e e8        	sd	a1, 16(sp)
80203452: 2a f8        	sd	a0, 48(sp)
80203454: 09 a0        	j	0x80203456 <_ZN4core4sync6atomic11AtomicUsize5store17hc50cf8c1647de4fbE+0x1a>
80203456: 22 66        	ld	a2, 8(sp)
80203458: 82 65        	ld	a1, 0(sp)
8020345a: 42 65        	ld	a0, 16(sp)
8020345c: 97 10 00 00  	auipc	ra, 1
80203460: e7 80 20 2b  	jalr	690(ra)
80203464: 09 a0        	j	0x80203466 <_ZN4core4sync6atomic11AtomicUsize5store17hc50cf8c1647de4fbE+0x2a>
80203466: e2 70        	ld	ra, 56(sp)
80203468: 21 61        	addi	sp, sp, 64
8020346a: 82 80        	ret

000000008020346c <_ZN4core4sync6atomic11AtomicUsize16compare_and_swap17h06fd0fdefbedd954E>:
8020346c: 19 71        	addi	sp, sp, -128
8020346e: 86 fc        	sd	ra, 120(sp)
80203470: 36 e8        	sd	a3, 16(sp)
80203472: 32 e0        	sd	a2, 0(sp)
80203474: 2e e4        	sd	a1, 8(sp)
80203476: aa 86        	mv	a3, a0
80203478: 42 65        	ld	a0, 16(sp)
8020347a: 36 ec        	sd	a3, 24(sp)
8020347c: 2a 87        	mv	a4, a0
8020347e: 3a f0        	sd	a4, 32(sp)
80203480: b6 e4        	sd	a3, 72(sp)
80203482: ae e8        	sd	a1, 80(sp)
80203484: b2 ec        	sd	a2, 88(sp)
80203486: a3 03 a1 06  	sb	a0, 103(sp)
8020348a: 97 00 00 00  	auipc	ra, 0
8020348e: e7 80 00 f2  	jalr	-224(ra)
80203492: 13 75 f5 0f  	andi	a0, a0, 255
80203496: 2a f4        	sd	a0, 40(sp)
80203498: 09 a0        	j	0x8020349a <_ZN4core4sync6atomic11AtomicUsize16compare_and_swap17h06fd0fdefbedd954E+0x2e>
8020349a: 22 77        	ld	a4, 40(sp)
8020349c: 82 76        	ld	a3, 32(sp)
8020349e: 02 66        	ld	a2, 0(sp)
802034a0: a2 65        	ld	a1, 8(sp)
802034a2: 62 65        	ld	a0, 24(sp)
802034a4: 97 00 00 00  	auipc	ra, 0
802034a8: e7 80 40 03  	jalr	52(ra)
802034ac: 2a fc        	sd	a0, 56(sp)
802034ae: ae e0        	sd	a1, 64(sp)
802034b0: 09 a0        	j	0x802034b2 <_ZN4core4sync6atomic11AtomicUsize16compare_and_swap17h06fd0fdefbedd954E+0x46>
802034b2: 62 75        	ld	a0, 56(sp)
802034b4: 81 45        	mv	a1, zero
802034b6: 63 05 b5 00  	beq	a0, a1, 0x802034c0 <_ZN4core4sync6atomic11AtomicUsize16compare_and_swap17h06fd0fdefbedd954E+0x54>
802034ba: 09 a0        	j	0x802034bc <_ZN4core4sync6atomic11AtomicUsize16compare_and_swap17h06fd0fdefbedd954E+0x50>
802034bc: 31 a0        	j	0x802034c8 <_ZN4core4sync6atomic11AtomicUsize16compare_and_swap17h06fd0fdefbedd954E+0x5c>
802034be: 00 00        	unimp	
802034c0: 06 65        	ld	a0, 64(sp)
802034c2: aa f8        	sd	a0, 112(sp)
802034c4: 2a f8        	sd	a0, 48(sp)
802034c6: 29 a0        	j	0x802034d0 <_ZN4core4sync6atomic11AtomicUsize16compare_and_swap17h06fd0fdefbedd954E+0x64>
802034c8: 06 65        	ld	a0, 64(sp)
802034ca: aa f4        	sd	a0, 104(sp)
802034cc: 2a f8        	sd	a0, 48(sp)
802034ce: 09 a0        	j	0x802034d0 <_ZN4core4sync6atomic11AtomicUsize16compare_and_swap17h06fd0fdefbedd954E+0x64>
802034d0: 42 75        	ld	a0, 48(sp)
802034d2: e6 70        	ld	ra, 120(sp)
802034d4: 09 61        	addi	sp, sp, 128
802034d6: 82 80        	ret

00000000802034d8 <_ZN4core4sync6atomic11AtomicUsize16compare_exchange17ha0a565c9f4204756E>:
802034d8: 59 71        	addi	sp, sp, -112
802034da: 86 f4        	sd	ra, 104(sp)
802034dc: 32 ec        	sd	a2, 24(sp)
802034de: 2e f0        	sd	a1, 32(sp)
802034e0: ba 87        	mv	a5, a4
802034e2: 3e f4        	sd	a5, 40(sp)
802034e4: b6 87        	mv	a5, a3
802034e6: 3e f8        	sd	a5, 48(sp)
802034e8: aa e0        	sd	a0, 64(sp)
802034ea: ae e4        	sd	a1, 72(sp)
802034ec: b2 e8        	sd	a2, 80(sp)
802034ee: 23 0f d1 04  	sb	a3, 94(sp)
802034f2: a3 0f e1 04  	sb	a4, 95(sp)
802034f6: aa 85        	mv	a1, a0
802034f8: 2e fc        	sd	a1, 56(sp)
802034fa: aa f0        	sd	a0, 96(sp)
802034fc: 09 a0        	j	0x802034fe <_ZN4core4sync6atomic11AtomicUsize16compare_exchange17ha0a565c9f4204756E+0x26>
802034fe: 22 77        	ld	a4, 40(sp)
80203500: c2 76        	ld	a3, 48(sp)
80203502: 62 66        	ld	a2, 24(sp)
80203504: 82 75        	ld	a1, 32(sp)
80203506: 62 75        	ld	a0, 56(sp)
80203508: 97 d0 ff ff  	auipc	ra, 1048573
8020350c: e7 80 80 2c  	jalr	712(ra)
80203510: 2a e4        	sd	a0, 8(sp)
80203512: 2e e8        	sd	a1, 16(sp)
80203514: 09 a0        	j	0x80203516 <_ZN4core4sync6atomic11AtomicUsize16compare_exchange17ha0a565c9f4204756E+0x3e>
80203516: c2 65        	ld	a1, 16(sp)
80203518: 22 65        	ld	a0, 8(sp)
8020351a: a6 70        	ld	ra, 104(sp)
8020351c: 65 61        	addi	sp, sp, 112
8020351e: 82 80        	ret

0000000080203520 <_ZN4core3ptr20slice_from_raw_parts17hcb25eab4ede95068E>:
80203520: 39 71        	addi	sp, sp, -64
80203522: 06 fc        	sd	ra, 56(sp)
80203524: 2e ec        	sd	a1, 24(sp)
80203526: 2a f4        	sd	a0, 40(sp)
80203528: 2e f8        	sd	a1, 48(sp)
8020352a: 97 e0 ff ff  	auipc	ra, 1048574
8020352e: e7 80 20 22  	jalr	546(ra)
80203532: 2a f0        	sd	a0, 32(sp)
80203534: 09 a0        	j	0x80203536 <_ZN4core3ptr20slice_from_raw_parts17hcb25eab4ede95068E+0x16>
80203536: e2 65        	ld	a1, 24(sp)
80203538: 02 75        	ld	a0, 32(sp)
8020353a: 97 00 00 00  	auipc	ra, 0
8020353e: e7 80 60 ad  	jalr	-1322(ra)
80203542: 2a e4        	sd	a0, 8(sp)
80203544: 2e e8        	sd	a1, 16(sp)
80203546: 09 a0        	j	0x80203548 <_ZN4core3ptr20slice_from_raw_parts17hcb25eab4ede95068E+0x28>
80203548: c2 65        	ld	a1, 16(sp)
8020354a: 22 65        	ld	a0, 8(sp)
8020354c: e2 70        	ld	ra, 56(sp)
8020354e: 21 61        	addi	sp, sp, 64
80203550: 82 80        	ret

0000000080203552 <_ZN4core3ptr4read17h289824f2fc626955E>:
80203552: 39 71        	addi	sp, sp, -64
80203554: 2a e4        	sd	a0, 8(sp)
80203556: 2a ec        	sd	a0, 24(sp)
80203558: 02 75        	ld	a0, 32(sp)
8020355a: 2a e8        	sd	a0, 16(sp)
8020355c: 09 a0        	j	0x8020355e <_ZN4core3ptr4read17h289824f2fc626955E+0xc>
8020355e: 08 08        	addi	a0, sp, 16
80203560: 2a f4        	sd	a0, 40(sp)
80203562: 09 a0        	j	0x80203564 <_ZN4core3ptr4read17h289824f2fc626955E+0x12>
80203564: 22 65        	ld	a0, 8(sp)
80203566: 08 61        	ld	a0, 0(a0)
80203568: 2a e0        	sd	a0, 0(sp)
8020356a: 2a e8        	sd	a0, 16(sp)
8020356c: 2a f8        	sd	a0, 48(sp)
8020356e: 2a fc        	sd	a0, 56(sp)
80203570: 09 a0        	j	0x80203572 <_ZN4core3ptr4read17h289824f2fc626955E+0x20>
80203572: 02 65        	ld	a0, 0(sp)
80203574: 21 61        	addi	sp, sp, 64
80203576: 82 80        	ret

0000000080203578 <_ZN4core3ptr5write17h450696c1baaa5b29E>:
80203578: 41 11        	addi	sp, sp, -16
8020357a: 2e e0        	sd	a1, 0(sp)
8020357c: 2a e4        	sd	a0, 8(sp)
8020357e: 0c e1        	sd	a1, 0(a0)
80203580: 41 01        	addi	sp, sp, 16
80203582: 82 80        	ret

0000000080203584 <_ZN4core3ptr13read_volatile17h0822ad166f7b597bE>:
80203584: 01 11        	addi	sp, sp, -32
80203586: 2a e8        	sd	a0, 16(sp)
80203588: 08 61        	ld	a0, 0(a0)
8020358a: 2a e4        	sd	a0, 8(sp)
8020358c: 2a ec        	sd	a0, 24(sp)
8020358e: 09 a0        	j	0x80203590 <_ZN4core3ptr13read_volatile17h0822ad166f7b597bE+0xc>
80203590: 22 65        	ld	a0, 8(sp)
80203592: 05 61        	addi	sp, sp, 32
80203594: 82 80        	ret

0000000080203596 <_ZN4core3ptr14write_volatile17h514c5cd02961b0feE>:
80203596: 41 11        	addi	sp, sp, -16
80203598: 2a e0        	sd	a0, 0(sp)
8020359a: a3 07 b1 00  	sb	a1, 15(sp)
8020359e: 23 00 b5 00  	sb	a1, 0(a0)
802035a2: 09 a0        	j	0x802035a4 <_ZN4core3ptr14write_volatile17h514c5cd02961b0feE+0xe>
802035a4: 41 01        	addi	sp, sp, 16
802035a6: 82 80        	ret

00000000802035a8 <_ZN4core3str21_$LT$impl$u20$str$GT$5chars17h585021776ebfe91fE>:
802035a8: 59 71        	addi	sp, sp, -112
802035aa: 86 f4        	sd	ra, 104(sp)
802035ac: 2a fc        	sd	a0, 56(sp)
802035ae: ae e0        	sd	a1, 64(sp)
802035b0: aa e4        	sd	a0, 72(sp)
802035b2: ae e8        	sd	a1, 80(sp)
802035b4: aa ec        	sd	a0, 88(sp)
802035b6: ae f0        	sd	a1, 96(sp)
802035b8: 2a ec        	sd	a0, 24(sp)
802035ba: 2e f0        	sd	a1, 32(sp)
802035bc: 09 a0        	j	0x802035be <_ZN4core3str21_$LT$impl$u20$str$GT$5chars17h585021776ebfe91fE+0x16>
802035be: 82 75        	ld	a1, 32(sp)
802035c0: 62 65        	ld	a0, 24(sp)
802035c2: 97 f0 ff ff  	auipc	ra, 1048575
802035c6: e7 80 00 5c  	jalr	1472(ra)
802035ca: 2a e4        	sd	a0, 8(sp)
802035cc: 2e e8        	sd	a1, 16(sp)
802035ce: 09 a0        	j	0x802035d0 <_ZN4core3str21_$LT$impl$u20$str$GT$5chars17h585021776ebfe91fE+0x28>
802035d0: c2 65        	ld	a1, 16(sp)
802035d2: 22 65        	ld	a0, 8(sp)
802035d4: 2a f4        	sd	a0, 40(sp)
802035d6: 2e f8        	sd	a1, 48(sp)
802035d8: a6 70        	ld	ra, 104(sp)
802035da: 65 61        	addi	sp, sp, 112
802035dc: 82 80        	ret

00000000802035de <_ZN4core3fmt5Write10write_char17h630299fdcf55cd11E>:
802035de: 5d 71        	addi	sp, sp, -80
802035e0: 86 e4        	sd	ra, 72(sp)
802035e2: 2e e8        	sd	a1, 16(sp)
802035e4: aa 85        	mv	a1, a0
802035e6: 42 65        	ld	a0, 16(sp)
802035e8: 2e ec        	sd	a1, 24(sp)
802035ea: 2e fc        	sd	a1, 56(sp)
802035ec: aa c2        	sw	a0, 68(sp)
802035ee: 81 45        	mv	a1, zero
802035f0: 2e da        	sw	a1, 52(sp)
802035f2: 4c 18        	addi	a1, sp, 52
802035f4: 11 46        	addi	a2, zero, 4
802035f6: 97 00 00 00  	auipc	ra, 0
802035fa: e7 80 c0 a2  	jalr	-1492(ra)
802035fe: 2a f0        	sd	a0, 32(sp)
80203600: 2e f4        	sd	a1, 40(sp)
80203602: 09 a0        	j	0x80203604 <_ZN4core3fmt5Write10write_char17h630299fdcf55cd11E+0x26>
80203604: 22 76        	ld	a2, 40(sp)
80203606: 82 75        	ld	a1, 32(sp)
80203608: 62 65        	ld	a0, 24(sp)
8020360a: 97 e0 ff ff  	auipc	ra, 1048574
8020360e: e7 80 80 3b  	jalr	952(ra)
80203612: 2a e4        	sd	a0, 8(sp)
80203614: 09 a0        	j	0x80203616 <_ZN4core3fmt5Write10write_char17h630299fdcf55cd11E+0x38>
80203616: 22 65        	ld	a0, 8(sp)
80203618: a6 60        	ld	ra, 72(sp)
8020361a: 61 61        	addi	sp, sp, 80
8020361c: 82 80        	ret

000000008020361e <_ZN4core3fmt5Write9write_fmt17h7cc32fe8a904b584E>:
8020361e: 5d 71        	addi	sp, sp, -80
80203620: 86 e4        	sd	ra, 72(sp)
80203622: 2a e8        	sd	a0, 16(sp)
80203624: 88 61        	ld	a0, 0(a1)
80203626: 2a ec        	sd	a0, 24(sp)
80203628: 88 65        	ld	a0, 8(a1)
8020362a: 2a f0        	sd	a0, 32(sp)
8020362c: 88 69        	ld	a0, 16(a1)
8020362e: 2a f4        	sd	a0, 40(sp)
80203630: 88 6d        	ld	a0, 24(a1)
80203632: 2a f8        	sd	a0, 48(sp)
80203634: 88 71        	ld	a0, 32(a1)
80203636: 2a fc        	sd	a0, 56(sp)
80203638: 88 75        	ld	a0, 40(a1)
8020363a: aa e0        	sd	a0, 64(sp)

000000008020363c <.LBB1_2>:
8020363c: 97 55 01 00  	auipc	a1, 21
80203640: 93 85 c5 e5  	addi	a1, a1, -420
80203644: 08 08        	addi	a0, sp, 16
80203646: 30 08        	addi	a2, sp, 24
80203648: 97 20 00 00  	auipc	ra, 2
8020364c: e7 80 80 d9  	jalr	-616(ra)
80203650: 2a e4        	sd	a0, 8(sp)
80203652: 09 a0        	j	0x80203654 <.LBB1_2+0x18>
80203654: 22 65        	ld	a0, 8(sp)
80203656: a6 60        	ld	ra, 72(sp)
80203658: 61 61        	addi	sp, sp, 80
8020365a: 82 80        	ret

000000008020365c <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$9write_str17h98ca2a7c4850ff81E>:
8020365c: 79 71        	addi	sp, sp, -48
8020365e: 06 f4        	sd	ra, 40(sp)
80203660: 2a e8        	sd	a0, 16(sp)
80203662: 2e ec        	sd	a1, 24(sp)
80203664: 32 f0        	sd	a2, 32(sp)
80203666: 08 61        	ld	a0, 0(a0)
80203668: 97 e0 ff ff  	auipc	ra, 1048574
8020366c: e7 80 a0 35  	jalr	858(ra)
80203670: 2a e4        	sd	a0, 8(sp)
80203672: 09 a0        	j	0x80203674 <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$9write_str17h98ca2a7c4850ff81E+0x18>
80203674: 22 65        	ld	a0, 8(sp)
80203676: a2 70        	ld	ra, 40(sp)
80203678: 45 61        	addi	sp, sp, 48
8020367a: 82 80        	ret

000000008020367c <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$10write_char17h911611c83178d2d8E>:
8020367c: 01 11        	addi	sp, sp, -32
8020367e: 06 ec        	sd	ra, 24(sp)
80203680: 2a e4        	sd	a0, 8(sp)
80203682: 2e ca        	sw	a1, 20(sp)
80203684: 08 61        	ld	a0, 0(a0)
80203686: 97 00 00 00  	auipc	ra, 0
8020368a: e7 80 80 f5  	jalr	-168(ra)
8020368e: 2a e0        	sd	a0, 0(sp)
80203690: 09 a0        	j	0x80203692 <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$10write_char17h911611c83178d2d8E+0x16>
80203692: 02 65        	ld	a0, 0(sp)
80203694: e2 60        	ld	ra, 24(sp)
80203696: 05 61        	addi	sp, sp, 32
80203698: 82 80        	ret

000000008020369a <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$9write_fmt17heb0f7ced44736fd6E>:
8020369a: 5d 71        	addi	sp, sp, -80
8020369c: 86 e4        	sd	ra, 72(sp)
8020369e: aa e0        	sd	a0, 64(sp)
802036a0: 08 61        	ld	a0, 0(a0)
802036a2: 90 75        	ld	a2, 40(a1)
802036a4: 32 fc        	sd	a2, 56(sp)
802036a6: 90 71        	ld	a2, 32(a1)
802036a8: 32 f8        	sd	a2, 48(sp)
802036aa: 90 6d        	ld	a2, 24(a1)
802036ac: 32 f4        	sd	a2, 40(sp)
802036ae: 90 69        	ld	a2, 16(a1)
802036b0: 32 f0        	sd	a2, 32(sp)
802036b2: 90 65        	ld	a2, 8(a1)
802036b4: 32 ec        	sd	a2, 24(sp)
802036b6: 8c 61        	ld	a1, 0(a1)
802036b8: 2e e8        	sd	a1, 16(sp)
802036ba: 0c 08        	addi	a1, sp, 16
802036bc: 97 00 00 00  	auipc	ra, 0
802036c0: e7 80 20 f6  	jalr	-158(ra)
802036c4: 2a e4        	sd	a0, 8(sp)
802036c6: 09 a0        	j	0x802036c8 <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$9write_fmt17heb0f7ced44736fd6E+0x2e>
802036c8: 22 65        	ld	a0, 8(sp)
802036ca: a6 60        	ld	ra, 72(sp)
802036cc: 61 61        	addi	sp, sp, 80
802036ce: 82 80        	ret

00000000802036d0 <_ZN4core3mem7replace17hbb0efca297cd9b13E>:
802036d0: 39 71        	addi	sp, sp, -64
802036d2: 06 fc        	sd	ra, 56(sp)
802036d4: 2e e4        	sd	a1, 8(sp)
802036d6: 2a e8        	sd	a0, 16(sp)
802036d8: 2a f0        	sd	a0, 32(sp)
802036da: 2e f4        	sd	a1, 40(sp)
802036dc: 97 00 00 00  	auipc	ra, 0
802036e0: e7 80 60 e7  	jalr	-394(ra)
802036e4: aa 85        	mv	a1, a0
802036e6: 2e ec        	sd	a1, 24(sp)
802036e8: 2a f8        	sd	a0, 48(sp)
802036ea: 09 a0        	j	0x802036ec <_ZN4core3mem7replace17hbb0efca297cd9b13E+0x1c>
802036ec: a2 65        	ld	a1, 8(sp)
802036ee: 42 65        	ld	a0, 16(sp)
802036f0: 97 00 00 00  	auipc	ra, 0
802036f4: e7 80 80 e8  	jalr	-376(ra)
802036f8: 09 a0        	j	0x802036fa <_ZN4core3mem7replace17hbb0efca297cd9b13E+0x2a>
802036fa: 62 65        	ld	a0, 24(sp)
802036fc: e2 70        	ld	ra, 56(sp)
802036fe: 21 61        	addi	sp, sp, 64
80203700: 82 80        	ret

0000000080203702 <_ZN4core3mem4drop17h4073549e203549c5E>:
80203702: 01 11        	addi	sp, sp, -32
80203704: 06 ec        	sd	ra, 24(sp)
80203706: 2a e4        	sd	a0, 8(sp)
80203708: 2e e8        	sd	a1, 16(sp)
8020370a: 28 00        	addi	a0, sp, 8
8020370c: 97 e0 ff ff  	auipc	ra, 1048574
80203710: e7 80 40 cc  	jalr	-828(ra)
80203714: 09 a0        	j	0x80203716 <_ZN4core3mem4drop17h4073549e203549c5E+0x14>
80203716: e2 60        	ld	ra, 24(sp)
80203718: 05 61        	addi	sp, sp, 32
8020371a: 82 80        	ret

000000008020371c <_ZN4core3mem4drop17hfe96256680db6a65E>:
8020371c: 41 11        	addi	sp, sp, -16
8020371e: 2a e4        	sd	a0, 8(sp)
80203720: 09 a0        	j	0x80203722 <_ZN4core3mem4drop17hfe96256680db6a65E+0x6>
80203722: 41 01        	addi	sp, sp, 16
80203724: 82 80        	ret
80203726: 00 00        	unimp	

0000000080203728 <__alltraps>:
80203728: 73 11 01 14  	csrrw	sp, sscratch, sp
8020372c: 6d 71        	addi	sp, sp, -272
8020372e: 06 e4        	sd	ra, 8(sp)
80203730: 0e ec        	sd	gp, 24(sp)
80203732: 16 f4        	sd	t0, 40(sp)
80203734: 1a f8        	sd	t1, 48(sp)
80203736: 1e fc        	sd	t2, 56(sp)
80203738: a2 e0        	sd	s0, 64(sp)
8020373a: a6 e4        	sd	s1, 72(sp)
8020373c: aa e8        	sd	a0, 80(sp)
8020373e: ae ec        	sd	a1, 88(sp)
80203740: b2 f0        	sd	a2, 96(sp)
80203742: b6 f4        	sd	a3, 104(sp)
80203744: ba f8        	sd	a4, 112(sp)
80203746: be fc        	sd	a5, 120(sp)
80203748: 42 e1        	sd	a6, 128(sp)
8020374a: 46 e5        	sd	a7, 136(sp)
8020374c: 4a e9        	sd	s2, 144(sp)
8020374e: 4e ed        	sd	s3, 152(sp)
80203750: 52 f1        	sd	s4, 160(sp)
80203752: 56 f5        	sd	s5, 168(sp)
80203754: 5a f9        	sd	s6, 176(sp)
80203756: 5e fd        	sd	s7, 184(sp)
80203758: e2 e1        	sd	s8, 192(sp)
8020375a: e6 e5        	sd	s9, 200(sp)
8020375c: ea e9        	sd	s10, 208(sp)
8020375e: ee ed        	sd	s11, 216(sp)
80203760: f2 f1        	sd	t3, 224(sp)
80203762: f6 f5        	sd	t4, 232(sp)
80203764: fa f9        	sd	t5, 240(sp)
80203766: fe fd        	sd	t6, 248(sp)
80203768: f3 22 00 10  	csrr	t0, sstatus
8020376c: 73 23 10 14  	csrr	t1, sepc
80203770: 16 e2        	sd	t0, 256(sp)
80203772: 1a e6        	sd	t1, 264(sp)
80203774: f3 23 00 14  	csrr	t2, sscratch
80203778: 1e e8        	sd	t2, 16(sp)
8020377a: 0a 85        	mv	a0, sp
8020377c: 97 00 00 00  	auipc	ra, 0
80203780: e7 80 c0 1c  	jalr	460(ra)

0000000080203784 <__restore>:
80203784: 92 62        	ld	t0, 256(sp)
80203786: 32 63        	ld	t1, 264(sp)
80203788: c2 63        	ld	t2, 16(sp)
8020378a: 73 90 02 10  	csrw	sstatus, t0
8020378e: 73 10 13 14  	csrw	sepc, t1
80203792: 73 90 03 14  	csrw	sscratch, t2
80203796: a2 60        	ld	ra, 8(sp)
80203798: e2 61        	ld	gp, 24(sp)
8020379a: a2 72        	ld	t0, 40(sp)
8020379c: 42 73        	ld	t1, 48(sp)
8020379e: e2 73        	ld	t2, 56(sp)
802037a0: 06 64        	ld	s0, 64(sp)
802037a2: a6 64        	ld	s1, 72(sp)
802037a4: 46 65        	ld	a0, 80(sp)
802037a6: e6 65        	ld	a1, 88(sp)
802037a8: 06 76        	ld	a2, 96(sp)
802037aa: a6 76        	ld	a3, 104(sp)
802037ac: 46 77        	ld	a4, 112(sp)
802037ae: e6 77        	ld	a5, 120(sp)
802037b0: 0a 68        	ld	a6, 128(sp)
802037b2: aa 68        	ld	a7, 136(sp)
802037b4: 4a 69        	ld	s2, 144(sp)
802037b6: ea 69        	ld	s3, 152(sp)
802037b8: 0a 7a        	ld	s4, 160(sp)
802037ba: aa 7a        	ld	s5, 168(sp)
802037bc: 4a 7b        	ld	s6, 176(sp)
802037be: ea 7b        	ld	s7, 184(sp)
802037c0: 0e 6c        	ld	s8, 192(sp)
802037c2: ae 6c        	ld	s9, 200(sp)
802037c4: 4e 6d        	ld	s10, 208(sp)
802037c6: ee 6d        	ld	s11, 216(sp)
802037c8: 0e 7e        	ld	t3, 224(sp)
802037ca: ae 7e        	ld	t4, 232(sp)
802037cc: 4e 7f        	ld	t5, 240(sp)
802037ce: ee 7f        	ld	t6, 248(sp)
802037d0: 51 61        	addi	sp, sp, 272
802037d2: 73 11 01 14  	csrrw	sp, sscratch, sp
802037d6: 73 00 20 10  	sret	

00000000802037da <_ZN2os4trap4init17hd0636a926c65d044E>:
802037da: 41 11        	addi	sp, sp, -16
802037dc: 06 e4        	sd	ra, 8(sp)
802037de: 81 45        	mv	a1, zero
802037e0: a3 03 b1 00  	sb	a1, 7(sp)

00000000802037e4 <.LBB0_2>:
802037e4: 17 05 00 00  	auipc	a0, 0
802037e8: 13 05 45 f4  	addi	a0, a0, -188
802037ec: 97 d0 ff ff  	auipc	ra, 1048573
802037f0: e7 80 40 82  	jalr	-2012(ra)
802037f4: 09 a0        	j	0x802037f6 <.LBB0_2+0x12>
802037f6: a2 60        	ld	ra, 8(sp)
802037f8: 41 01        	addi	sp, sp, 16
802037fa: 82 80        	ret

00000000802037fc <_ZN2os4trap22enable_timer_interrupt17h50ddfed1aec6f8b7E>:
802037fc: 41 11        	addi	sp, sp, -16
802037fe: 06 e4        	sd	ra, 8(sp)
80203800: 97 f0 ff ff  	auipc	ra, 1048575
80203804: e7 80 80 7f  	jalr	2040(ra)
80203808: 09 a0        	j	0x8020380a <_ZN2os4trap22enable_timer_interrupt17h50ddfed1aec6f8b7E+0xe>
8020380a: a2 60        	ld	ra, 8(sp)
8020380c: 41 01        	addi	sp, sp, 16
8020380e: 82 80        	ret

0000000080203810 <_ZN2os4trap4tick17ha69ee7996327feb6E>:
80203810: 1d 71        	addi	sp, sp, -96
80203812: 86 ec        	sd	ra, 88(sp)

0000000080203814 <.LBB2_7>:
80203814: 17 d5 02 00  	auipc	a0, 45
80203818: 13 05 45 9f  	addi	a0, a0, -1548
8020381c: 0c 61        	ld	a1, 0(a0)
8020381e: 13 85 15 00  	addi	a0, a1, 1
80203822: 2a e8        	sd	a0, 16(sp)
80203824: 63 6c b5 04  	bltu	a0, a1, 0x8020387c <.LBB2_9>
80203828: 09 a0        	j	0x8020382a <.LBB2_7+0x16>
8020382a: 42 65        	ld	a0, 16(sp)

000000008020382c <.LBB2_8>:
8020382c: 97 d5 02 00  	auipc	a1, 45
80203830: 93 85 c5 9d  	addi	a1, a1, -1572
80203834: 88 e1        	sd	a0, 0(a1)
80203836: b7 65 8f ff  	lui	a1, 1046774
8020383a: 9b 85 95 c2  	addiw	a1, a1, -983
8020383e: be 05        	slli	a1, a1, 15
80203840: 93 85 15 ae  	addi	a1, a1, -1311
80203844: b2 05        	slli	a1, a1, 12
80203846: 93 85 b5 47  	addi	a1, a1, 1147
8020384a: b6 05        	slli	a1, a1, 13
8020384c: 93 85 95 c2  	addi	a1, a1, -983
80203850: 33 05 b5 02  	mul	a0, a0, a1
80203854: 93 15 e5 03  	slli	a1, a0, 62
80203858: 09 81        	srli	a0, a0, 2
8020385a: 4d 8d        	or	a0, a0, a1
8020385c: b7 85 14 00  	lui	a1, 328
80203860: 9b 85 15 ae  	addiw	a1, a1, -1311
80203864: b2 05        	slli	a1, a1, 12
80203866: 93 85 b5 47  	addi	a1, a1, 1147
8020386a: b6 05        	slli	a1, a1, 13
8020386c: 93 85 95 c2  	addi	a1, a1, -983
80203870: b2 05        	slli	a1, a1, 12
80203872: 93 85 d5 f5  	addi	a1, a1, -163
80203876: 63 61 b5 02  	bltu	a0, a1, 0x80203898 <.LBB2_11>
8020387a: 35 a8        	j	0x802038b6 <.LBB2_12+0x16>

000000008020387c <.LBB2_9>:
8020387c: 17 55 01 00  	auipc	a0, 21
80203880: 13 05 45 cc  	addi	a0, a0, -828

0000000080203884 <.LBB2_10>:
80203884: 17 56 01 00  	auipc	a2, 21
80203888: 13 06 46 ca  	addi	a2, a2, -860
8020388c: f1 45        	addi	a1, zero, 28
8020388e: 97 10 00 00  	auipc	ra, 1
80203892: e7 80 e0 31  	jalr	798(ra)
80203896: 00 00        	unimp	

0000000080203898 <.LBB2_11>:
80203898: 17 d5 02 00  	auipc	a0, 45
8020389c: 13 05 05 97  	addi	a0, a0, -1680

00000000802038a0 <.LBB2_12>:
802038a0: 97 35 00 00  	auipc	a1, 3
802038a4: 93 85 c5 ef  	addi	a1, a1, -260
802038a8: 97 d0 ff ff  	auipc	ra, 1048573
802038ac: e7 80 80 7a  	jalr	1960(ra)
802038b0: 2a e0        	sd	a0, 0(sp)
802038b2: 2e e4        	sd	a1, 8(sp)
802038b4: 21 a0        	j	0x802038bc <.LBB2_12+0x1c>
802038b6: e6 60        	ld	ra, 88(sp)
802038b8: 25 61        	addi	sp, sp, 96
802038ba: 82 80        	ret
802038bc: 22 65        	ld	a0, 8(sp)
802038be: 82 65        	ld	a1, 0(sp)
802038c0: ae e4        	sd	a1, 72(sp)
802038c2: aa e8        	sd	a0, 80(sp)

00000000802038c4 <.LBB2_13>:
802038c4: 97 55 01 00  	auipc	a1, 21
802038c8: 93 85 45 ca  	addi	a1, a1, -860
802038cc: 28 08        	addi	a0, sp, 24
802038ce: 09 46        	addi	a2, zero, 2
802038d0: b4 00        	addi	a3, sp, 72
802038d2: 05 47        	addi	a4, zero, 1
802038d4: 97 f0 ff ff  	auipc	ra, 1048575
802038d8: e7 80 40 b5  	jalr	-1196(ra)
802038dc: 09 a0        	j	0x802038de <.LBB2_13+0x1a>
802038de: 28 08        	addi	a0, sp, 24
802038e0: 97 e0 ff ff  	auipc	ra, 1048574
802038e4: e7 80 40 1e  	jalr	484(ra)
802038e8: f9 b7        	j	0x802038b6 <.LBB2_12+0x16>

00000000802038ea <_ZN2os4trap10breakpoint17h84dd4c1ad2edb91cE>:
802038ea: 59 71        	addi	sp, sp, -112
802038ec: 86 f4        	sd	ra, 104(sp)
802038ee: aa f0        	sd	a0, 96(sp)
802038f0: 97 d0 ff ff  	auipc	ra, 1048573
802038f4: e7 80 80 96  	jalr	-1688(ra)
802038f8: 2a ec        	sd	a0, 24(sp)
802038fa: 09 a0        	j	0x802038fc <.LBB3_5>

00000000802038fc <.LBB3_5>:
802038fc: 97 35 00 00  	auipc	a1, 3
80203900: 93 85 e5 ab  	addi	a1, a1, -1346
80203904: 28 08        	addi	a0, sp, 24
80203906: 97 d0 ff ff  	auipc	ra, 1048573
8020390a: e7 80 a0 74  	jalr	1866(ra)
8020390e: 2a e4        	sd	a0, 8(sp)
80203910: 2e e8        	sd	a1, 16(sp)
80203912: 09 a0        	j	0x80203914 <.LBB3_5+0x18>
80203914: 42 65        	ld	a0, 16(sp)
80203916: a2 65        	ld	a1, 8(sp)
80203918: ae e8        	sd	a1, 80(sp)
8020391a: aa ec        	sd	a0, 88(sp)

000000008020391c <.LBB3_6>:
8020391c: 97 55 01 00  	auipc	a1, 21
80203920: 93 85 45 c9  	addi	a1, a1, -876
80203924: 08 10        	addi	a0, sp, 32
80203926: 09 46        	addi	a2, zero, 2
80203928: 94 08        	addi	a3, sp, 80
8020392a: 05 47        	addi	a4, zero, 1
8020392c: 97 f0 ff ff  	auipc	ra, 1048575
80203930: e7 80 c0 af  	jalr	-1284(ra)
80203934: 09 a0        	j	0x80203936 <.LBB3_6+0x1a>
80203936: 08 10        	addi	a0, sp, 32
80203938: 97 e0 ff ff  	auipc	ra, 1048574
8020393c: e7 80 c0 18  	jalr	396(ra)
80203940: 09 a0        	j	0x80203942 <.LBB3_6+0x26>
80203942: a6 70        	ld	ra, 104(sp)
80203944: 65 61        	addi	sp, sp, 112
80203946: 82 80        	ret

0000000080203948 <trap_handler>:
80203948: 01 71        	addi	sp, sp, -512
8020394a: 86 ff        	sd	ra, 504(sp)
8020394c: 2a e9        	sd	a0, 144(sp)
8020394e: aa fb        	sd	a0, 496(sp)
80203950: 97 e0 ff ff  	auipc	ra, 1048574
80203954: e7 80 60 c4  	jalr	-954(ra)
80203958: 2a ed        	sd	a0, 152(sp)
8020395a: 09 a0        	j	0x8020395c <trap_handler+0x14>
8020395c: 97 00 00 00  	auipc	ra, 0
80203960: e7 80 c0 9b  	jalr	-1604(ra)
80203964: 2a f1        	sd	a0, 160(sp)
80203966: 09 a0        	j	0x80203968 <trap_handler+0x20>
80203968: 97 d0 ff ff  	auipc	ra, 1048573
8020396c: e7 80 00 8f  	jalr	-1808(ra)
80203970: 2a f5        	sd	a0, 168(sp)
80203972: 09 a0        	j	0x80203974 <trap_handler+0x2c>
80203974: 28 09        	addi	a0, sp, 152
80203976: 97 e0 ff ff  	auipc	ra, 1048574
8020397a: e7 80 e0 b1  	jalr	-1250(ra)
8020397e: 23 08 a1 0a  	sb	a0, 176(sp)
80203982: a3 08 b1 0a  	sb	a1, 177(sp)
80203986: 09 a0        	j	0x80203988 <trap_handler+0x40>
80203988: 03 45 01 0b  	lbu	a0, 176(sp)
8020398c: 2a e5        	sd	a0, 136(sp)
8020398e: 05 89        	andi	a0, a0, 1
80203990: 81 45        	mv	a1, zero
80203992: 63 02 b5 02  	beq	a0, a1, 0x802039b6 <.LBB4_6+0x14>
80203996: 09 a0        	j	0x80203998 <trap_handler+0x50>
80203998: 2a 65        	ld	a0, 136(sp)
8020399a: 85 45        	addi	a1, zero, 1
8020399c: 63 03 b5 02  	beq	a0, a1, 0x802039c2 <.LBB4_6+0x20>
802039a0: 09 a0        	j	0x802039a2 <.LBB4_6>

00000000802039a2 <.LBB4_6>:
802039a2: 28 09        	addi	a0, sp, 152
802039a4: 97 e0 ff ff  	auipc	ra, 1048574
802039a8: e7 80 00 af  	jalr	-1296(ra)
802039ac: 23 04 a1 1e  	sb	a0, 488(sp)
802039b0: a3 04 b1 1e  	sb	a1, 489(sp)
802039b4: d1 a2        	j	0x80203b78 <.LBB4_51>
802039b6: 03 45 11 0b  	lbu	a0, 177(sp)
802039ba: 95 45        	addi	a1, zero, 5
802039bc: 63 09 b5 1a  	beq	a0, a1, 0x80203b6e <.LBB4_50+0x20>
802039c0: cd b7        	j	0x802039a2 <.LBB4_6>
802039c2: 03 45 11 0b  	lbu	a0, 177(sp)
802039c6: 93 05 e5 ff  	addi	a1, a0, -2
802039ca: 2e e1        	sd	a1, 128(sp)
802039cc: 25 45        	addi	a0, zero, 9
802039ce: e3 6a b5 fc  	bltu	a0, a1, 0x802039a2 <.LBB4_6>
802039d2: 0a 65        	ld	a0, 128(sp)
802039d4: 0e 05        	slli	a0, a0, 3

00000000802039d6 <.LBB4_38>:
802039d6: 97 55 01 00  	auipc	a1, 21
802039da: 93 85 25 af  	addi	a1, a1, -1294
802039de: 2e 95        	add	a0, a0, a1
802039e0: 08 61        	ld	a0, 0(a0)
802039e2: 02 85        	jr	a0

00000000802039e4 <.LBB4_39>:
802039e4: 97 55 01 00  	auipc	a1, 21
802039e8: 93 85 45 d6  	addi	a1, a1, -668

00000000802039ec <.LBB4_40>:
802039ec: 97 56 01 00  	auipc	a3, 21
802039f0: 93 86 46 b7  	addi	a3, a3, -1164
802039f4: a8 0a        	addi	a0, sp, 344
802039f6: 05 46        	addi	a2, zero, 1
802039f8: 01 47        	mv	a4, zero
802039fa: 97 f0 ff ff  	auipc	ra, 1048575
802039fe: e7 80 e0 a2  	jalr	-1490(ra)
80203a02: 85 a2        	j	0x80203b62 <.LBB4_50+0x14>

0000000080203a04 <.LBB4_11>:
80203a04: 4a 65        	ld	a0, 144(sp)
80203a06: 97 00 00 00  	auipc	ra, 0
80203a0a: e7 80 40 ee  	jalr	-284(ra)
80203a0e: 31 aa        	j	0x80203b2a <.LBB4_48+0x26>

0000000080203a10 <.LBB4_41>:
80203a10: 97 55 01 00  	auipc	a1, 21
80203a14: 93 85 05 c1  	addi	a1, a1, -1008

0000000080203a18 <.LBB4_42>:
80203a18: 97 56 01 00  	auipc	a3, 21
80203a1c: 93 86 86 b4  	addi	a3, a3, -1208
80203a20: 88 09        	addi	a0, sp, 208
80203a22: 05 46        	addi	a2, zero, 1
80203a24: 01 47        	mv	a4, zero
80203a26: 97 f0 ff ff  	auipc	ra, 1048575
80203a2a: e7 80 20 a0  	jalr	-1534(ra)
80203a2e: 9d a0        	j	0x80203a94 <.LBB4_44+0x26>

0000000080203a30 <.LBB4_13>:
80203a30: 4a 65        	ld	a0, 144(sp)
80203a32: 83 35 85 10  	ld	a1, 264(a0)
80203a36: 13 85 45 00  	addi	a0, a1, 4
80203a3a: aa fc        	sd	a0, 120(sp)
80203a3c: 63 65 b5 02  	bltu	a0, a1, 0x80203a66 <.LBB4_43>
80203a40: 09 a0        	j	0x80203a42 <.LBB4_13+0x12>
80203a42: ca 65        	ld	a1, 144(sp)
80203a44: 66 75        	ld	a0, 120(sp)
80203a46: 23 b4 a5 10  	sd	a0, 264(a1)
80203a4a: c8 65        	ld	a0, 136(a1)
80203a4c: b4 69        	ld	a3, 80(a1)
80203a4e: b0 6d        	ld	a2, 88(a1)
80203a50: ac 71        	ld	a1, 96(a1)
80203a52: 36 fd        	sd	a3, 184(sp)
80203a54: b2 e1        	sd	a2, 192(sp)
80203a56: ae e5        	sd	a1, 200(sp)
80203a58: 2c 19        	addi	a1, sp, 184
80203a5a: 97 d0 ff ff  	auipc	ra, 1048573
80203a5e: e7 80 c0 ca  	jalr	-852(ra)
80203a62: aa f8        	sd	a0, 112(sp)
80203a64: 39 a8        	j	0x80203a82 <.LBB4_44+0x14>

0000000080203a66 <.LBB4_43>:
80203a66: 17 55 01 00  	auipc	a0, 21
80203a6a: 13 05 a5 ad  	addi	a0, a0, -1318

0000000080203a6e <.LBB4_44>:
80203a6e: 17 56 01 00  	auipc	a2, 21
80203a72: 13 06 26 b6  	addi	a2, a2, -1182
80203a76: f1 45        	addi	a1, zero, 28
80203a78: 97 10 00 00  	auipc	ra, 1
80203a7c: e7 80 40 13  	jalr	308(ra)
80203a80: 00 00        	unimp	
80203a82: 46 75        	ld	a0, 112(sp)
80203a84: ca 65        	ld	a1, 144(sp)
80203a86: a8 e9        	sd	a0, 80(a1)
80203a88: 09 a0        	j	0x80203a8a <.LBB4_44+0x1c>
80203a8a: 4a 65        	ld	a0, 144(sp)
80203a8c: fe 70        	ld	ra, 504(sp)
80203a8e: 13 01 01 20  	addi	sp, sp, 512
80203a92: 82 80        	ret
80203a94: 88 09        	addi	a0, sp, 208
80203a96: 97 e0 ff ff  	auipc	ra, 1048574
80203a9a: e7 80 e0 02  	jalr	46(ra)
80203a9e: 09 a0        	j	0x80203aa0 <.LBB4_44+0x32>
80203aa0: 28 09        	addi	a0, sp, 152
80203aa2: 97 e0 ff ff  	auipc	ra, 1048574
80203aa6: e7 80 20 9f  	jalr	-1550(ra)
80203aaa: 23 08 a1 14  	sb	a0, 336(sp)
80203aae: a3 08 b1 14  	sb	a1, 337(sp)
80203ab2: 09 a0        	j	0x80203ab4 <.LBB4_45>

0000000080203ab4 <.LBB4_45>:
80203ab4: 97 05 00 00  	auipc	a1, 0
80203ab8: 93 85 e5 43  	addi	a1, a1, 1086
80203abc: 88 0a        	addi	a0, sp, 336
80203abe: 97 d0 ff ff  	auipc	ra, 1048573
80203ac2: e7 80 a0 50  	jalr	1290(ra)
80203ac6: aa f0        	sd	a0, 96(sp)
80203ac8: ae f4        	sd	a1, 104(sp)
80203aca: 09 a0        	j	0x80203acc <.LBB4_46>

0000000080203acc <.LBB4_46>:
80203acc: 97 35 00 00  	auipc	a1, 3
80203ad0: 93 85 e5 8e  	addi	a1, a1, -1810
80203ad4: 28 11        	addi	a0, sp, 168
80203ad6: 97 d0 ff ff  	auipc	ra, 1048573
80203ada: e7 80 a0 57  	jalr	1402(ra)
80203ade: aa e8        	sd	a0, 80(sp)
80203ae0: ae ec        	sd	a1, 88(sp)
80203ae2: 09 a0        	j	0x80203ae4 <.LBB4_46+0x18>
80203ae4: 66 65        	ld	a0, 88(sp)
80203ae6: c6 65        	ld	a1, 80(sp)
80203ae8: 26 76        	ld	a2, 104(sp)
80203aea: 86 76        	ld	a3, 96(sp)
80203aec: 36 fa        	sd	a3, 304(sp)
80203aee: 32 fe        	sd	a2, 312(sp)
80203af0: ae e2        	sd	a1, 320(sp)
80203af2: aa e6        	sd	a0, 328(sp)
80203af4: 08 1a        	addi	a0, sp, 304
80203af6: aa e4        	sd	a0, 72(sp)
80203af8: 09 a0        	j	0x80203afa <.LBB4_46+0x2e>
80203afa: a6 66        	ld	a3, 72(sp)

0000000080203afc <.LBB4_47>:
80203afc: 97 55 01 00  	auipc	a1, 21
80203b00: 93 85 45 b5  	addi	a1, a1, -1196

0000000080203b04 <.LBB4_48>:
80203b04: 97 57 01 00  	auipc	a5, 21
80203b08: 93 87 c7 b7  	addi	a5, a5, -1156
80203b0c: 08 02        	addi	a0, sp, 256
80203b0e: 0d 46        	addi	a2, zero, 3
80203b10: 09 48        	addi	a6, zero, 2
80203b12: 42 87        	mv	a4, a6
80203b14: 97 f0 ff ff  	auipc	ra, 1048575
80203b18: e7 80 e0 9a  	jalr	-1618(ra)
80203b1c: 09 a0        	j	0x80203b1e <.LBB4_48+0x1a>
80203b1e: 08 02        	addi	a0, sp, 256
80203b20: 97 e0 ff ff  	auipc	ra, 1048574
80203b24: e7 80 40 fa  	jalr	-92(ra)
80203b28: 8d b7        	j	0x80203a8a <.LBB4_44+0x1c>
80203b2a: 4a 65        	ld	a0, 144(sp)
80203b2c: 83 35 85 10  	ld	a1, 264(a0)
80203b30: 13 85 25 00  	addi	a0, a1, 2
80203b34: aa e0        	sd	a0, 64(sp)
80203b36: 63 68 b5 00  	bltu	a0, a1, 0x80203b46 <.LBB4_49>
80203b3a: 09 a0        	j	0x80203b3c <.LBB4_48+0x38>
80203b3c: 06 65        	ld	a0, 64(sp)
80203b3e: ca 65        	ld	a1, 144(sp)
80203b40: 23 b4 a5 10  	sd	a0, 264(a1)
80203b44: 99 b7        	j	0x80203a8a <.LBB4_44+0x1c>

0000000080203b46 <.LBB4_49>:
80203b46: 17 55 01 00  	auipc	a0, 21
80203b4a: 13 05 a5 9f  	addi	a0, a0, -1542

0000000080203b4e <.LBB4_50>:
80203b4e: 17 56 01 00  	auipc	a2, 21
80203b52: 13 06 26 ba  	addi	a2, a2, -1118
80203b56: f1 45        	addi	a1, zero, 28
80203b58: 97 10 00 00  	auipc	ra, 1
80203b5c: e7 80 40 05  	jalr	84(ra)
80203b60: 00 00        	unimp	
80203b62: a8 0a        	addi	a0, sp, 344
80203b64: 97 e0 ff ff  	auipc	ra, 1048574
80203b68: e7 80 00 f6  	jalr	-160(ra)
80203b6c: 39 bf        	j	0x80203a8a <.LBB4_44+0x1c>
80203b6e: 97 00 00 00  	auipc	ra, 0
80203b72: e7 80 20 ca  	jalr	-862(ra)
80203b76: 45 a0        	j	0x80203c16 <.LBB4_56+0x14>

0000000080203b78 <.LBB4_51>:
80203b78: 97 05 00 00  	auipc	a1, 0
80203b7c: 93 85 a5 37  	addi	a1, a1, 890
80203b80: a8 13        	addi	a0, sp, 488
80203b82: 97 d0 ff ff  	auipc	ra, 1048573
80203b86: e7 80 60 44  	jalr	1094(ra)
80203b8a: 2a f8        	sd	a0, 48(sp)
80203b8c: 2e fc        	sd	a1, 56(sp)
80203b8e: 09 a0        	j	0x80203b90 <.LBB4_52>

0000000080203b90 <.LBB4_52>:
80203b90: 97 35 00 00  	auipc	a1, 3
80203b94: 93 85 a5 82  	addi	a1, a1, -2006
80203b98: 08 11        	addi	a0, sp, 160
80203b9a: 97 d0 ff ff  	auipc	ra, 1048573
80203b9e: e7 80 60 4b  	jalr	1206(ra)
80203ba2: 2a f0        	sd	a0, 32(sp)
80203ba4: 2e f4        	sd	a1, 40(sp)
80203ba6: 09 a0        	j	0x80203ba8 <.LBB4_53>

0000000080203ba8 <.LBB4_53>:
80203ba8: 97 35 00 00  	auipc	a1, 3
80203bac: 93 85 25 81  	addi	a1, a1, -2030
80203bb0: 28 11        	addi	a0, sp, 168
80203bb2: 97 d0 ff ff  	auipc	ra, 1048573
80203bb6: e7 80 e0 49  	jalr	1182(ra)
80203bba: 2a e8        	sd	a0, 16(sp)
80203bbc: 2e ec        	sd	a1, 24(sp)
80203bbe: 09 a0        	j	0x80203bc0 <.LBB4_53+0x18>
80203bc0: 62 65        	ld	a0, 24(sp)
80203bc2: c2 65        	ld	a1, 16(sp)
80203bc4: 22 76        	ld	a2, 40(sp)
80203bc6: 82 76        	ld	a3, 32(sp)
80203bc8: 62 77        	ld	a4, 56(sp)
80203bca: c2 77        	ld	a5, 48(sp)
80203bcc: 3e ff        	sd	a5, 440(sp)
80203bce: ba e3        	sd	a4, 448(sp)
80203bd0: b6 e7        	sd	a3, 456(sp)
80203bd2: b2 eb        	sd	a2, 464(sp)
80203bd4: ae ef        	sd	a1, 472(sp)
80203bd6: aa f3        	sd	a0, 480(sp)
80203bd8: 28 1b        	addi	a0, sp, 440
80203bda: 2a e4        	sd	a0, 8(sp)
80203bdc: 09 a0        	j	0x80203bde <.LBB4_53+0x36>
80203bde: a2 66        	ld	a3, 8(sp)

0000000080203be0 <.LBB4_54>:
80203be0: 97 55 01 00  	auipc	a1, 21
80203be4: 93 85 05 b9  	addi	a1, a1, -1136

0000000080203be8 <.LBB4_55>:
80203be8: 97 57 01 00  	auipc	a5, 21
80203bec: 93 87 87 bb  	addi	a5, a5, -1096
80203bf0: 28 03        	addi	a0, sp, 392
80203bf2: 0d 48        	addi	a6, zero, 3
80203bf4: 42 86        	mv	a2, a6
80203bf6: 42 87        	mv	a4, a6
80203bf8: 97 f0 ff ff  	auipc	ra, 1048575
80203bfc: e7 80 a0 8c  	jalr	-1846(ra)
80203c00: 09 a0        	j	0x80203c02 <.LBB4_56>

0000000080203c02 <.LBB4_56>:
80203c02: 97 55 01 00  	auipc	a1, 21
80203c06: 93 85 65 c4  	addi	a1, a1, -954
80203c0a: 28 03        	addi	a0, sp, 392
80203c0c: 97 10 00 00  	auipc	ra, 1
80203c10: e7 80 c0 00  	jalr	12(ra)
80203c14: 00 00        	unimp	
80203c16: 97 00 00 00  	auipc	ra, 0
80203c1a: e7 80 60 06  	jalr	102(ra)
80203c1e: 09 a0        	j	0x80203c20 <.LBB4_56+0x1e>
80203c20: 97 d0 ff ff  	auipc	ra, 1048573
80203c24: e7 80 80 34  	jalr	840(ra)
80203c28: 8d b5        	j	0x80203a8a <.LBB4_44+0x1c>

0000000080203c2a <_ZN2os5timer8get_time17hd1e4f81cbe13e62dE>:
80203c2a: 41 11        	addi	sp, sp, -16
80203c2c: 06 e4        	sd	ra, 8(sp)
80203c2e: 97 d0 ff ff  	auipc	ra, 1048573
80203c32: e7 80 20 58  	jalr	1410(ra)
80203c36: 2a e0        	sd	a0, 0(sp)
80203c38: 09 a0        	j	0x80203c3a <_ZN2os5timer8get_time17hd1e4f81cbe13e62dE+0x10>
80203c3a: 02 65        	ld	a0, 0(sp)
80203c3c: a2 60        	ld	ra, 8(sp)
80203c3e: 41 01        	addi	sp, sp, 16
80203c40: 82 80        	ret

0000000080203c42 <_ZN2os5timer11get_time_ms17h7123ae4460152040E>:
80203c42: 41 11        	addi	sp, sp, -16
80203c44: 06 e4        	sd	ra, 8(sp)
80203c46: 97 d0 ff ff  	auipc	ra, 1048573
80203c4a: e7 80 a0 56  	jalr	1386(ra)
80203c4e: 2a e0        	sd	a0, 0(sp)
80203c50: 09 a0        	j	0x80203c52 <_ZN2os5timer11get_time_ms17h7123ae4460152040E+0x10>
80203c52: 02 65        	ld	a0, 0(sp)
80203c54: 09 81        	srli	a0, a0, 2
80203c56: b7 95 4f 01  	lui	a1, 5369
80203c5a: 9b 85 95 b5  	addiw	a1, a1, -1191
80203c5e: b2 05        	slli	a1, a1, 12
80203c60: 93 85 35 8e  	addi	a1, a1, -1821
80203c64: b2 05        	slli	a1, a1, 12
80203c66: 93 85 f5 68  	addi	a1, a1, 1679
80203c6a: b6 05        	slli	a1, a1, 13
80203c6c: 93 85 95 10  	addi	a1, a1, 265
80203c70: 33 35 b5 02  	mulhu	a0, a0, a1
80203c74: 25 81        	srli	a0, a0, 9
80203c76: a2 60        	ld	ra, 8(sp)
80203c78: 41 01        	addi	sp, sp, 16
80203c7a: 82 80        	ret

0000000080203c7c <_ZN2os5timer16set_next_trigger17hf543bd505cdfa85eE>:
80203c7c: 01 11        	addi	sp, sp, -32
80203c7e: 06 ec        	sd	ra, 24(sp)
80203c80: 97 00 00 00  	auipc	ra, 0
80203c84: e7 80 a0 fa  	jalr	-86(ra)
80203c88: 2a e8        	sd	a0, 16(sp)
80203c8a: 09 a0        	j	0x80203c8c <_ZN2os5timer16set_next_trigger17hf543bd505cdfa85eE+0x10>
80203c8c: c2 65        	ld	a1, 16(sp)
80203c8e: 7d 65        	lui	a0, 31
80203c90: 1b 05 85 84  	addiw	a0, a0, -1976
80203c94: 2e 95        	add	a0, a0, a1
80203c96: 2a e4        	sd	a0, 8(sp)
80203c98: 63 69 b5 00  	bltu	a0, a1, 0x80203caa <.LBB2_5>
80203c9c: 09 a0        	j	0x80203c9e <_ZN2os5timer16set_next_trigger17hf543bd505cdfa85eE+0x22>
80203c9e: 22 65        	ld	a0, 8(sp)
80203ca0: 97 e0 ff ff  	auipc	ra, 1048574
80203ca4: e7 80 a0 94  	jalr	-1718(ra)
80203ca8: 39 a8        	j	0x80203cc6 <.LBB2_6+0x14>

0000000080203caa <.LBB2_5>:
80203caa: 17 55 01 00  	auipc	a0, 21
80203cae: 13 05 65 be  	addi	a0, a0, -1050

0000000080203cb2 <.LBB2_6>:
80203cb2: 17 56 01 00  	auipc	a2, 21
80203cb6: 13 06 e6 bb  	addi	a2, a2, -1090
80203cba: f1 45        	addi	a1, zero, 28
80203cbc: 97 10 00 00  	auipc	ra, 1
80203cc0: e7 80 00 ef  	jalr	-272(ra)
80203cc4: 00 00        	unimp	
80203cc6: e2 60        	ld	ra, 24(sp)
80203cc8: 05 61        	addi	sp, sp, 32
80203cca: 82 80        	ret

0000000080203ccc <_ZN4core3str8converts23from_utf8_unchecked_mut17h5a3dba8593f24a0aE>:
80203ccc: 41 11        	addi	sp, sp, -16
80203cce: 2a e0        	sd	a0, 0(sp)
80203cd0: 2e e4        	sd	a1, 8(sp)
80203cd2: 41 01        	addi	sp, sp, 16
80203cd4: 82 80        	ret

0000000080203cd6 <_ZN4core5slice5index77_$LT$impl$u20$core..ops..index..IndexMut$LT$I$GT$$u20$for$u20$$u5b$T$u5d$$GT$9index_mut17h503ba2edec640e7dE>:
80203cd6: 39 71        	addi	sp, sp, -64
80203cd8: 06 fc        	sd	ra, 56(sp)
80203cda: 32 e4        	sd	a2, 8(sp)
80203cdc: 2e 86        	mv	a2, a1
80203cde: aa 85        	mv	a1, a0
80203ce0: 22 65        	ld	a0, 8(sp)
80203ce2: 2e f0        	sd	a1, 32(sp)
80203ce4: 32 f4        	sd	a2, 40(sp)
80203ce6: 2a f8        	sd	a0, 48(sp)
80203ce8: 97 e0 ff ff  	auipc	ra, 1048574
80203cec: e7 80 c0 fe  	jalr	-20(ra)
80203cf0: 2a e8        	sd	a0, 16(sp)
80203cf2: 2e ec        	sd	a1, 24(sp)
80203cf4: 09 a0        	j	0x80203cf6 <_ZN4core5slice5index77_$LT$impl$u20$core..ops..index..IndexMut$LT$I$GT$$u20$for$u20$$u5b$T$u5d$$GT$9index_mut17h503ba2edec640e7dE+0x20>
80203cf6: e2 65        	ld	a1, 24(sp)
80203cf8: 42 65        	ld	a0, 16(sp)
80203cfa: e2 70        	ld	ra, 56(sp)
80203cfc: 21 61        	addi	sp, sp, 64
80203cfe: 82 80        	ret

0000000080203d00 <_ZN4core5slice5index77_$LT$impl$u20$core..ops..index..IndexMut$LT$I$GT$$u20$for$u20$$u5b$T$u5d$$GT$9index_mut17h6d66f3b799e5ff40E>:
80203d00: 79 71        	addi	sp, sp, -48
80203d02: 06 f4        	sd	ra, 40(sp)
80203d04: 2a e8        	sd	a0, 16(sp)
80203d06: 2e ec        	sd	a1, 24(sp)
80203d08: 97 e0 ff ff  	auipc	ra, 1048574
80203d0c: e7 80 c0 ff  	jalr	-4(ra)
80203d10: 2a e0        	sd	a0, 0(sp)
80203d12: 2e e4        	sd	a1, 8(sp)
80203d14: 09 a0        	j	0x80203d16 <_ZN4core5slice5index77_$LT$impl$u20$core..ops..index..IndexMut$LT$I$GT$$u20$for$u20$$u5b$T$u5d$$GT$9index_mut17h6d66f3b799e5ff40E+0x16>
80203d16: a2 65        	ld	a1, 8(sp)
80203d18: 02 65        	ld	a0, 0(sp)
80203d1a: a2 70        	ld	ra, 40(sp)
80203d1c: 45 61        	addi	sp, sp, 48
80203d1e: 82 80        	ret

0000000080203d20 <_ZN5riscv8register6scause9Interrupt4from17h8901e5ab25a0220dE>:
80203d20: 01 11        	addi	sp, sp, -32
80203d22: aa 85        	mv	a1, a0
80203d24: 2e ec        	sd	a1, 24(sp)
80203d26: 2e 85        	mv	a0, a1
80203d28: 2a e4        	sd	a0, 8(sp)
80203d2a: 29 45        	addi	a0, zero, 10
80203d2c: 63 6b b5 00  	bltu	a0, a1, 0x80203d42 <.LBB0_2>
80203d30: 22 65        	ld	a0, 8(sp)
80203d32: 0e 05        	slli	a0, a0, 3

0000000080203d34 <.LBB0_13>:
80203d34: 97 55 01 00  	auipc	a1, 21
80203d38: 93 85 c5 b7  	addi	a1, a1, -1156
80203d3c: 2e 95        	add	a0, a0, a1
80203d3e: 08 61        	ld	a0, 0(a0)
80203d40: 02 85        	jr	a0

0000000080203d42 <.LBB0_2>:
80203d42: 25 45        	addi	a0, zero, 9
80203d44: a3 0b a1 00  	sb	a0, 23(sp)
80203d48: a9 a0        	j	0x80203d92 <.LBB0_11+0x8>

0000000080203d4a <.LBB0_3>:
80203d4a: 01 45        	mv	a0, zero
80203d4c: a3 0b a1 00  	sb	a0, 23(sp)
80203d50: 89 a0        	j	0x80203d92 <.LBB0_11+0x8>

0000000080203d52 <.LBB0_4>:
80203d52: 09 45        	addi	a0, zero, 2
80203d54: a3 0b a1 00  	sb	a0, 23(sp)
80203d58: 2d a8        	j	0x80203d92 <.LBB0_11+0x8>

0000000080203d5a <.LBB0_5>:
80203d5a: 05 45        	addi	a0, zero, 1
80203d5c: a3 0b a1 00  	sb	a0, 23(sp)
80203d60: 0d a8        	j	0x80203d92 <.LBB0_11+0x8>

0000000080203d62 <.LBB0_6>:
80203d62: 0d 45        	addi	a0, zero, 3
80203d64: a3 0b a1 00  	sb	a0, 23(sp)
80203d68: 2d a0        	j	0x80203d92 <.LBB0_11+0x8>

0000000080203d6a <.LBB0_7>:
80203d6a: 15 45        	addi	a0, zero, 5
80203d6c: a3 0b a1 00  	sb	a0, 23(sp)
80203d70: 0d a0        	j	0x80203d92 <.LBB0_11+0x8>

0000000080203d72 <.LBB0_8>:
80203d72: 11 45        	addi	a0, zero, 4
80203d74: a3 0b a1 00  	sb	a0, 23(sp)
80203d78: 29 a8        	j	0x80203d92 <.LBB0_11+0x8>

0000000080203d7a <.LBB0_9>:
80203d7a: 19 45        	addi	a0, zero, 6
80203d7c: a3 0b a1 00  	sb	a0, 23(sp)
80203d80: 09 a8        	j	0x80203d92 <.LBB0_11+0x8>

0000000080203d82 <.LBB0_10>:
80203d82: 21 45        	addi	a0, zero, 8
80203d84: a3 0b a1 00  	sb	a0, 23(sp)
80203d88: 29 a0        	j	0x80203d92 <.LBB0_11+0x8>

0000000080203d8a <.LBB0_11>:
80203d8a: 1d 45        	addi	a0, zero, 7
80203d8c: a3 0b a1 00  	sb	a0, 23(sp)
80203d90: 09 a0        	j	0x80203d92 <.LBB0_11+0x8>
80203d92: 03 05 71 01  	lb	a0, 23(sp)
80203d96: 05 61        	addi	sp, sp, 32
80203d98: 82 80        	ret

0000000080203d9a <_ZN5riscv8register6scause9Exception4from17h9acea35d05b05f20E>:
80203d9a: 01 11        	addi	sp, sp, -32
80203d9c: aa 85        	mv	a1, a0
80203d9e: 2e ec        	sd	a1, 24(sp)
80203da0: 2e 85        	mv	a0, a1
80203da2: 2a e4        	sd	a0, 8(sp)
80203da4: 5d 45        	addi	a0, zero, 23
80203da6: 63 6b b5 00  	bltu	a0, a1, 0x80203dbc <.LBB1_2>
80203daa: 22 65        	ld	a0, 8(sp)
80203dac: 0e 05        	slli	a0, a0, 3

0000000080203dae <.LBB1_20>:
80203dae: 97 55 01 00  	auipc	a1, 21
80203db2: 93 85 a5 b5  	addi	a1, a1, -1190
80203db6: 2e 95        	add	a0, a0, a1
80203db8: 08 61        	ld	a0, 0(a0)
80203dba: 02 85        	jr	a0

0000000080203dbc <.LBB1_2>:
80203dbc: 41 45        	addi	a0, zero, 16
80203dbe: a3 0b a1 00  	sb	a0, 23(sp)
80203dc2: 49 a0        	j	0x80203e44 <.LBB1_18+0x8>

0000000080203dc4 <.LBB1_3>:
80203dc4: 01 45        	mv	a0, zero
80203dc6: a3 0b a1 00  	sb	a0, 23(sp)
80203dca: ad a8        	j	0x80203e44 <.LBB1_18+0x8>

0000000080203dcc <.LBB1_4>:
80203dcc: 05 45        	addi	a0, zero, 1
80203dce: a3 0b a1 00  	sb	a0, 23(sp)
80203dd2: 8d a8        	j	0x80203e44 <.LBB1_18+0x8>

0000000080203dd4 <.LBB1_5>:
80203dd4: 09 45        	addi	a0, zero, 2
80203dd6: a3 0b a1 00  	sb	a0, 23(sp)
80203dda: ad a0        	j	0x80203e44 <.LBB1_18+0x8>

0000000080203ddc <.LBB1_6>:
80203ddc: 0d 45        	addi	a0, zero, 3
80203dde: a3 0b a1 00  	sb	a0, 23(sp)
80203de2: 8d a0        	j	0x80203e44 <.LBB1_18+0x8>

0000000080203de4 <.LBB1_7>:
80203de4: 11 45        	addi	a0, zero, 4
80203de6: a3 0b a1 00  	sb	a0, 23(sp)
80203dea: a9 a8        	j	0x80203e44 <.LBB1_18+0x8>

0000000080203dec <.LBB1_8>:
80203dec: 15 45        	addi	a0, zero, 5
80203dee: a3 0b a1 00  	sb	a0, 23(sp)
80203df2: 89 a8        	j	0x80203e44 <.LBB1_18+0x8>

0000000080203df4 <.LBB1_9>:
80203df4: 19 45        	addi	a0, zero, 6
80203df6: a3 0b a1 00  	sb	a0, 23(sp)
80203dfa: a9 a0        	j	0x80203e44 <.LBB1_18+0x8>

0000000080203dfc <.LBB1_10>:
80203dfc: 1d 45        	addi	a0, zero, 7
80203dfe: a3 0b a1 00  	sb	a0, 23(sp)
80203e02: 89 a0        	j	0x80203e44 <.LBB1_18+0x8>

0000000080203e04 <.LBB1_11>:
80203e04: 21 45        	addi	a0, zero, 8
80203e06: a3 0b a1 00  	sb	a0, 23(sp)
80203e0a: 2d a8        	j	0x80203e44 <.LBB1_18+0x8>

0000000080203e0c <.LBB1_12>:
80203e0c: 25 45        	addi	a0, zero, 9
80203e0e: a3 0b a1 00  	sb	a0, 23(sp)
80203e12: 0d a8        	j	0x80203e44 <.LBB1_18+0x8>

0000000080203e14 <.LBB1_13>:
80203e14: 29 45        	addi	a0, zero, 10
80203e16: a3 0b a1 00  	sb	a0, 23(sp)
80203e1a: 2d a0        	j	0x80203e44 <.LBB1_18+0x8>

0000000080203e1c <.LBB1_14>:
80203e1c: 2d 45        	addi	a0, zero, 11
80203e1e: a3 0b a1 00  	sb	a0, 23(sp)
80203e22: 0d a0        	j	0x80203e44 <.LBB1_18+0x8>

0000000080203e24 <.LBB1_15>:
80203e24: 31 45        	addi	a0, zero, 12
80203e26: a3 0b a1 00  	sb	a0, 23(sp)
80203e2a: 29 a8        	j	0x80203e44 <.LBB1_18+0x8>

0000000080203e2c <.LBB1_16>:
80203e2c: 35 45        	addi	a0, zero, 13
80203e2e: a3 0b a1 00  	sb	a0, 23(sp)
80203e32: 09 a8        	j	0x80203e44 <.LBB1_18+0x8>

0000000080203e34 <.LBB1_17>:
80203e34: 39 45        	addi	a0, zero, 14
80203e36: a3 0b a1 00  	sb	a0, 23(sp)
80203e3a: 29 a0        	j	0x80203e44 <.LBB1_18+0x8>

0000000080203e3c <.LBB1_18>:
80203e3c: 3d 45        	addi	a0, zero, 15
80203e3e: a3 0b a1 00  	sb	a0, 23(sp)
80203e42: 09 a0        	j	0x80203e44 <.LBB1_18+0x8>
80203e44: 03 05 71 01  	lb	a0, 23(sp)
80203e48: 05 61        	addi	sp, sp, 32
80203e4a: 82 80        	ret

0000000080203e4c <_ZN5riscv8register6scause6Scause4code17h429df3f2afa7ec5eE>:
80203e4c: 79 71        	addi	sp, sp, -48
80203e4e: 2a ec        	sd	a0, 24(sp)
80203e50: 2a f0        	sd	a0, 32(sp)
80203e52: 09 a0        	j	0x80203e54 <_ZN5riscv8register6scause6Scause4code17h429df3f2afa7ec5eE+0x8>
80203e54: 13 05 00 04  	addi	a0, zero, 64
80203e58: 2a e8        	sd	a0, 16(sp)
80203e5a: 01 45        	mv	a0, zero
80203e5c: 63 1a a5 00  	bne	a0, a0, 0x80203e70 <.LBB2_8>
80203e60: 09 a0        	j	0x80203e62 <_ZN5riscv8register6scause6Scause4code17h429df3f2afa7ec5eE+0x16>
80203e62: 42 65        	ld	a0, 16(sp)
80203e64: 93 05 f5 ff  	addi	a1, a0, -1
80203e68: 2e e4        	sd	a1, 8(sp)
80203e6a: 63 6d b5 02  	bltu	a0, a1, 0x80203ea4 <.LBB2_10>
80203e6e: 05 a0        	j	0x80203e8e <.LBB2_9+0x16>

0000000080203e70 <.LBB2_8>:
80203e70: 17 55 01 00  	auipc	a0, 21
80203e74: 13 05 05 ca  	addi	a0, a0, -864

0000000080203e78 <.LBB2_9>:
80203e78: 17 56 01 00  	auipc	a2, 21
80203e7c: 13 06 06 c8  	addi	a2, a2, -896
80203e80: 93 05 10 02  	addi	a1, zero, 33
80203e84: 97 10 00 00  	auipc	ra, 1
80203e88: e7 80 80 d2  	jalr	-728(ra)
80203e8c: 00 00        	unimp	
80203e8e: 22 66        	ld	a2, 8(sp)
80203e90: 13 75 06 fc  	andi	a0, a2, -64
80203e94: 85 45        	addi	a1, zero, 1
80203e96: b3 95 c5 00  	sll	a1, a1, a2
80203e9a: 2e e0        	sd	a1, 0(sp)
80203e9c: 81 45        	mv	a1, zero
80203e9e: 63 1b b5 02  	bne	a0, a1, 0x80203ed4 <.LBB2_12>
80203ea2: 05 a0        	j	0x80203ec2 <.LBB2_11+0x16>

0000000080203ea4 <.LBB2_10>:
80203ea4: 17 55 01 00  	auipc	a0, 21
80203ea8: 13 05 c5 ca  	addi	a0, a0, -852

0000000080203eac <.LBB2_11>:
80203eac: 17 56 01 00  	auipc	a2, 21
80203eb0: 13 06 c6 c8  	addi	a2, a2, -884
80203eb4: 93 05 10 02  	addi	a1, zero, 33
80203eb8: 97 10 00 00  	auipc	ra, 1
80203ebc: e7 80 40 cf  	jalr	-780(ra)
80203ec0: 00 00        	unimp	
80203ec2: 82 65        	ld	a1, 0(sp)
80203ec4: 62 65        	ld	a0, 24(sp)
80203ec6: 2e f4        	sd	a1, 40(sp)
80203ec8: 08 61        	ld	a0, 0(a0)
80203eca: 93 c5 f5 ff  	not	a1, a1
80203ece: 6d 8d        	and	a0, a0, a1
80203ed0: 45 61        	addi	sp, sp, 48
80203ed2: 82 80        	ret

0000000080203ed4 <.LBB2_12>:
80203ed4: 17 55 01 00  	auipc	a0, 21
80203ed8: 13 05 c5 cb  	addi	a0, a0, -836

0000000080203edc <.LBB2_13>:
80203edc: 17 56 01 00  	auipc	a2, 21
80203ee0: 13 06 c6 c9  	addi	a2, a2, -868
80203ee4: 93 05 30 02  	addi	a1, zero, 35
80203ee8: 97 10 00 00  	auipc	ra, 1
80203eec: e7 80 40 cc  	jalr	-828(ra)
80203ef0: 00 00        	unimp	

0000000080203ef2 <_ZN66_$LT$riscv..register..scause..Trap$u20$as$u20$core..fmt..Debug$GT$3fmt17he5681bee9c6862ebE>:
80203ef2: 35 71        	addi	sp, sp, -160
80203ef4: 06 ed        	sd	ra, 152(sp)
80203ef6: 2e e8        	sd	a1, 16(sp)
80203ef8: aa f4        	sd	a0, 104(sp)
80203efa: ae f8        	sd	a1, 112(sp)
80203efc: 2a f0        	sd	a0, 32(sp)
80203efe: 03 45 05 00  	lbu	a0, 0(a0)
80203f02: 05 89        	andi	a0, a0, 1
80203f04: 81 45        	mv	a1, zero
80203f06: 63 05 b5 00  	beq	a0, a1, 0x80203f10 <_ZN66_$LT$riscv..register..scause..Trap$u20$as$u20$core..fmt..Debug$GT$3fmt17he5681bee9c6862ebE+0x1e>
80203f0a: 09 a0        	j	0x80203f0c <_ZN66_$LT$riscv..register..scause..Trap$u20$as$u20$core..fmt..Debug$GT$3fmt17he5681bee9c6862ebE+0x1a>
80203f0c: 15 a0        	j	0x80203f30 <.LBB3_10+0x16>
80203f0e: 00 00        	unimp	
80203f10: c2 65        	ld	a1, 16(sp)
80203f12: 02 75        	ld	a0, 32(sp)
80203f14: 05 05        	addi	a0, a0, 1
80203f16: 2a e4        	sd	a0, 8(sp)
80203f18: 2a e5        	sd	a0, 136(sp)

0000000080203f1a <.LBB3_10>:
80203f1a: 17 56 01 00  	auipc	a2, 21
80203f1e: 13 06 66 cc  	addi	a2, a2, -826
80203f22: 28 10        	addi	a0, sp, 40
80203f24: a5 46        	addi	a3, zero, 9
80203f26: 97 20 00 00  	auipc	ra, 2
80203f2a: e7 80 80 b3  	jalr	-1224(ra)
80203f2e: a1 a8        	j	0x80203f86 <.LBB3_12+0x2e>
80203f30: c2 65        	ld	a1, 16(sp)
80203f32: 02 75        	ld	a0, 32(sp)
80203f34: 05 05        	addi	a0, a0, 1
80203f36: 2a e0        	sd	a0, 0(sp)
80203f38: aa fc        	sd	a0, 120(sp)

0000000080203f3a <.LBB3_11>:
80203f3a: 17 56 01 00  	auipc	a2, 21
80203f3e: 13 06 96 c7  	addi	a2, a2, -903
80203f42: a8 00        	addi	a0, sp, 72
80203f44: a5 46        	addi	a3, zero, 9
80203f46: 97 20 00 00  	auipc	ra, 2
80203f4a: e7 80 80 b1  	jalr	-1256(ra)
80203f4e: 09 a0        	j	0x80203f50 <.LBB3_11+0x16>
80203f50: 82 65        	ld	a1, 0(sp)
80203f52: a8 00        	addi	a0, sp, 72
80203f54: 2a e1        	sd	a0, 128(sp)
80203f56: ae f0        	sd	a1, 96(sp)

0000000080203f58 <.LBB3_12>:
80203f58: 17 56 01 00  	auipc	a2, 21
80203f5c: 13 06 86 c6  	addi	a2, a2, -920
80203f60: 8c 10        	addi	a1, sp, 96
80203f62: 97 10 00 00  	auipc	ra, 1
80203f66: e7 80 00 0e  	jalr	224(ra)
80203f6a: 09 a0        	j	0x80203f6c <.LBB3_12+0x14>
80203f6c: a8 00        	addi	a0, sp, 72
80203f6e: 97 10 00 00  	auipc	ra, 1
80203f72: e7 80 40 1d  	jalr	468(ra)
80203f76: a3 0f a1 00  	sb	a0, 31(sp)
80203f7a: 09 a0        	j	0x80203f7c <.LBB3_12+0x24>
80203f7c: 03 45 f1 01  	lbu	a0, 31(sp)
80203f80: ea 60        	ld	ra, 152(sp)
80203f82: 0d 61        	addi	sp, sp, 160
80203f84: 82 80        	ret
80203f86: a2 65        	ld	a1, 8(sp)
80203f88: 28 10        	addi	a0, sp, 40
80203f8a: 2a e9        	sd	a0, 144(sp)
80203f8c: ae e0        	sd	a1, 64(sp)

0000000080203f8e <.LBB3_13>:
80203f8e: 17 56 01 00  	auipc	a2, 21
80203f92: 13 06 26 c6  	addi	a2, a2, -926
80203f96: 8c 00        	addi	a1, sp, 64
80203f98: 97 10 00 00  	auipc	ra, 1
80203f9c: e7 80 a0 0a  	jalr	170(ra)
80203fa0: 09 a0        	j	0x80203fa2 <.LBB3_13+0x14>
80203fa2: 28 10        	addi	a0, sp, 40
80203fa4: 97 10 00 00  	auipc	ra, 1
80203fa8: e7 80 e0 19  	jalr	414(ra)
80203fac: a3 0f a1 00  	sb	a0, 31(sp)
80203fb0: f1 b7        	j	0x80203f7c <.LBB3_12+0x24>

0000000080203fb2 <_ZN71_$LT$riscv..register..scause..Interrupt$u20$as$u20$core..fmt..Debug$GT$3fmt17h8c4ff4e9e1124ab2E>:
80203fb2: 39 71        	addi	sp, sp, -64
80203fb4: 06 fc        	sd	ra, 56(sp)
80203fb6: 2e e4        	sd	a1, 8(sp)
80203fb8: 2a f4        	sd	a0, 40(sp)
80203fba: 2e f8        	sd	a1, 48(sp)
80203fbc: 2a f0        	sd	a0, 32(sp)
80203fbe: 03 45 05 00  	lbu	a0, 0(a0)
80203fc2: 2a e8        	sd	a0, 16(sp)
80203fc4: 42 65        	ld	a0, 16(sp)
80203fc6: 0e 05        	slli	a0, a0, 3

0000000080203fc8 <.LBB4_14>:
80203fc8: 97 55 01 00  	auipc	a1, 21
80203fcc: 93 85 05 a0  	addi	a1, a1, -1536
80203fd0: 2e 95        	add	a0, a0, a1
80203fd2: 08 61        	ld	a0, 0(a0)
80203fd4: 02 85        	jr	a0
80203fd6: 00 00        	unimp	

0000000080203fd8 <.LBB4_3>:
80203fd8: 22 65        	ld	a0, 8(sp)

0000000080203fda <.LBB4_15>:
80203fda: 97 55 01 00  	auipc	a1, 21
80203fde: 93 85 d5 cc  	addi	a1, a1, -819
80203fe2: 21 46        	addi	a2, zero, 8
80203fe4: 97 20 00 00  	auipc	ra, 2
80203fe8: e7 80 20 a7  	jalr	-1422(ra)
80203fec: a3 0f a1 00  	sb	a0, 31(sp)
80203ff0: f5 a0        	j	0x802040dc <.LBB4_24+0x18>

0000000080203ff2 <.LBB4_4>:
80203ff2: 22 65        	ld	a0, 8(sp)

0000000080203ff4 <.LBB4_16>:
80203ff4: 97 55 01 00  	auipc	a1, 21
80203ff8: 93 85 65 c9  	addi	a1, a1, -874
80203ffc: 55 46        	addi	a2, zero, 21
80203ffe: 97 20 00 00  	auipc	ra, 2
80204002: e7 80 80 a5  	jalr	-1448(ra)
80204006: a3 0f a1 00  	sb	a0, 31(sp)
8020400a: c9 a8        	j	0x802040dc <.LBB4_24+0x18>

000000008020400c <.LBB4_5>:
8020400c: 22 65        	ld	a0, 8(sp)

000000008020400e <.LBB4_17>:
8020400e: 97 55 01 00  	auipc	a1, 21
80204012: 93 85 e5 c6  	addi	a1, a1, -914
80204016: 39 46        	addi	a2, zero, 14
80204018: 97 20 00 00  	auipc	ra, 2
8020401c: e7 80 e0 a3  	jalr	-1474(ra)
80204020: a3 0f a1 00  	sb	a0, 31(sp)
80204024: 65 a8        	j	0x802040dc <.LBB4_24+0x18>

0000000080204026 <.LBB4_6>:
80204026: 22 65        	ld	a0, 8(sp)

0000000080204028 <.LBB4_18>:
80204028: 97 55 01 00  	auipc	a1, 21
8020402c: 93 85 b5 c4  	addi	a1, a1, -949
80204030: 25 46        	addi	a2, zero, 9
80204032: 97 20 00 00  	auipc	ra, 2
80204036: e7 80 40 a2  	jalr	-1500(ra)
8020403a: a3 0f a1 00  	sb	a0, 31(sp)
8020403e: 79 a8        	j	0x802040dc <.LBB4_24+0x18>

0000000080204040 <.LBB4_7>:
80204040: 22 65        	ld	a0, 8(sp)

0000000080204042 <.LBB4_19>:
80204042: 97 55 01 00  	auipc	a1, 21
80204046: 93 85 b5 c1  	addi	a1, a1, -997
8020404a: 59 46        	addi	a2, zero, 22
8020404c: 97 20 00 00  	auipc	ra, 2
80204050: e7 80 a0 a0  	jalr	-1526(ra)
80204054: a3 0f a1 00  	sb	a0, 31(sp)
80204058: 51 a0        	j	0x802040dc <.LBB4_24+0x18>

000000008020405a <.LBB4_8>:
8020405a: 22 65        	ld	a0, 8(sp)

000000008020405c <.LBB4_20>:
8020405c: 97 55 01 00  	auipc	a1, 21
80204060: 93 85 25 bf  	addi	a1, a1, -1038
80204064: 3d 46        	addi	a2, zero, 15
80204066: 97 20 00 00  	auipc	ra, 2
8020406a: e7 80 00 9f  	jalr	-1552(ra)
8020406e: a3 0f a1 00  	sb	a0, 31(sp)
80204072: ad a0        	j	0x802040dc <.LBB4_24+0x18>

0000000080204074 <.LBB4_9>:
80204074: 22 65        	ld	a0, 8(sp)

0000000080204076 <.LBB4_21>:
80204076: 97 55 01 00  	auipc	a1, 21
8020407a: 93 85 c5 bc  	addi	a1, a1, -1076
8020407e: 31 46        	addi	a2, zero, 12
80204080: 97 20 00 00  	auipc	ra, 2
80204084: e7 80 60 9d  	jalr	-1578(ra)
80204088: a3 0f a1 00  	sb	a0, 31(sp)
8020408c: 81 a8        	j	0x802040dc <.LBB4_24+0x18>

000000008020408e <.LBB4_10>:
8020408e: 22 65        	ld	a0, 8(sp)

0000000080204090 <.LBB4_22>:
80204090: 97 55 01 00  	auipc	a1, 21
80204094: 93 85 95 b9  	addi	a1, a1, -1127
80204098: 65 46        	addi	a2, zero, 25
8020409a: 97 20 00 00  	auipc	ra, 2
8020409e: e7 80 c0 9b  	jalr	-1604(ra)
802040a2: a3 0f a1 00  	sb	a0, 31(sp)
802040a6: 1d a8        	j	0x802040dc <.LBB4_24+0x18>

00000000802040a8 <.LBB4_11>:
802040a8: 22 65        	ld	a0, 8(sp)

00000000802040aa <.LBB4_23>:
802040aa: 97 55 01 00  	auipc	a1, 21
802040ae: 93 85 d5 b6  	addi	a1, a1, -1171
802040b2: 49 46        	addi	a2, zero, 18
802040b4: 97 20 00 00  	auipc	ra, 2
802040b8: e7 80 20 9a  	jalr	-1630(ra)
802040bc: a3 0f a1 00  	sb	a0, 31(sp)
802040c0: 31 a8        	j	0x802040dc <.LBB4_24+0x18>

00000000802040c2 <.LBB4_12>:
802040c2: 22 65        	ld	a0, 8(sp)

00000000802040c4 <.LBB4_24>:
802040c4: 97 55 01 00  	auipc	a1, 21
802040c8: 93 85 c5 b4  	addi	a1, a1, -1204
802040cc: 1d 46        	addi	a2, zero, 7
802040ce: 97 20 00 00  	auipc	ra, 2
802040d2: e7 80 80 98  	jalr	-1656(ra)
802040d6: a3 0f a1 00  	sb	a0, 31(sp)
802040da: 09 a0        	j	0x802040dc <.LBB4_24+0x18>
802040dc: 03 45 f1 01  	lbu	a0, 31(sp)
802040e0: e2 70        	ld	ra, 56(sp)
802040e2: 21 61        	addi	sp, sp, 64
802040e4: 82 80        	ret

00000000802040e6 <_ZN71_$LT$riscv..register..scause..Exception$u20$as$u20$core..fmt..Debug$GT$3fmt17h7bbcdc6f50167c7fE>:
802040e6: 39 71        	addi	sp, sp, -64
802040e8: 06 fc        	sd	ra, 56(sp)
802040ea: 2e e4        	sd	a1, 8(sp)
802040ec: 2a f4        	sd	a0, 40(sp)
802040ee: 2e f8        	sd	a1, 48(sp)
802040f0: 2a f0        	sd	a0, 32(sp)
802040f2: 03 45 05 00  	lbu	a0, 0(a0)
802040f6: 2a e8        	sd	a0, 16(sp)
802040f8: 42 65        	ld	a0, 16(sp)
802040fa: 0e 05        	slli	a0, a0, 3

00000000802040fc <.LBB5_21>:
802040fc: 97 55 01 00  	auipc	a1, 21
80204100: 93 85 c5 91  	addi	a1, a1, -1764
80204104: 2e 95        	add	a0, a0, a1
80204106: 08 61        	ld	a0, 0(a0)
80204108: 02 85        	jr	a0
8020410a: 00 00        	unimp	

000000008020410c <.LBB5_3>:
8020410c: 22 65        	ld	a0, 8(sp)

000000008020410e <.LBB5_22>:
8020410e: 97 55 01 00  	auipc	a1, 21
80204112: 93 85 15 c8  	addi	a1, a1, -895
80204116: 55 46        	addi	a2, zero, 21
80204118: 97 20 00 00  	auipc	ra, 2
8020411c: e7 80 e0 93  	jalr	-1730(ra)
80204120: a3 0f a1 00  	sb	a0, 31(sp)
80204124: 4d a2        	j	0x802042c6 <.LBB5_38+0x18>

0000000080204126 <.LBB5_4>:
80204126: 22 65        	ld	a0, 8(sp)

0000000080204128 <.LBB5_23>:
80204128: 97 35 00 00  	auipc	a1, 3
8020412c: 93 85 05 fd  	addi	a1, a1, -48
80204130: 41 46        	addi	a2, zero, 16
80204132: 97 20 00 00  	auipc	ra, 2
80204136: e7 80 40 92  	jalr	-1756(ra)
8020413a: a3 0f a1 00  	sb	a0, 31(sp)
8020413e: 61 a2        	j	0x802042c6 <.LBB5_38+0x18>

0000000080204140 <.LBB5_5>:
80204140: 22 65        	ld	a0, 8(sp)

0000000080204142 <.LBB5_24>:
80204142: 97 55 01 00  	auipc	a1, 21
80204146: 93 85 b5 c3  	addi	a1, a1, -965
8020414a: 49 46        	addi	a2, zero, 18
8020414c: 97 20 00 00  	auipc	ra, 2
80204150: e7 80 a0 90  	jalr	-1782(ra)
80204154: a3 0f a1 00  	sb	a0, 31(sp)
80204158: bd a2        	j	0x802042c6 <.LBB5_38+0x18>

000000008020415a <.LBB5_6>:
8020415a: 22 65        	ld	a0, 8(sp)

000000008020415c <.LBB5_25>:
8020415c: 97 55 01 00  	auipc	a1, 21
80204160: 93 85 75 c1  	addi	a1, a1, -1001
80204164: 29 46        	addi	a2, zero, 10
80204166: 97 20 00 00  	auipc	ra, 2
8020416a: e7 80 00 8f  	jalr	-1808(ra)
8020416e: a3 0f a1 00  	sb	a0, 31(sp)
80204172: 91 aa        	j	0x802042c6 <.LBB5_38+0x18>

0000000080204174 <.LBB5_7>:
80204174: 22 65        	ld	a0, 8(sp)

0000000080204176 <.LBB5_26>:
80204176: 97 55 01 00  	auipc	a1, 21
8020417a: 93 85 45 bf  	addi	a1, a1, -1036
8020417e: 25 46        	addi	a2, zero, 9
80204180: 97 20 00 00  	auipc	ra, 2
80204184: e7 80 60 8d  	jalr	-1834(ra)
80204188: a3 0f a1 00  	sb	a0, 31(sp)
8020418c: 2d aa        	j	0x802042c6 <.LBB5_38+0x18>

000000008020418e <.LBB5_8>:
8020418e: 22 65        	ld	a0, 8(sp)

0000000080204190 <.LBB5_27>:
80204190: 97 55 01 00  	auipc	a1, 21
80204194: 93 85 b5 bc  	addi	a1, a1, -1077
80204198: 3d 46        	addi	a2, zero, 15
8020419a: 97 20 00 00  	auipc	ra, 2
8020419e: e7 80 c0 8b  	jalr	-1860(ra)
802041a2: a3 0f a1 00  	sb	a0, 31(sp)
802041a6: 05 a2        	j	0x802042c6 <.LBB5_38+0x18>

00000000802041a8 <.LBB5_9>:
802041a8: 22 65        	ld	a0, 8(sp)

00000000802041aa <.LBB5_28>:
802041aa: 97 55 01 00  	auipc	a1, 21
802041ae: 93 85 75 ba  	addi	a1, a1, -1113
802041b2: 29 46        	addi	a2, zero, 10
802041b4: 97 20 00 00  	auipc	ra, 2
802041b8: e7 80 20 8a  	jalr	-1886(ra)
802041bc: a3 0f a1 00  	sb	a0, 31(sp)
802041c0: 19 a2        	j	0x802042c6 <.LBB5_38+0x18>

00000000802041c2 <.LBB5_10>:
802041c2: 22 65        	ld	a0, 8(sp)

00000000802041c4 <.LBB5_29>:
802041c4: 97 55 01 00  	auipc	a1, 21
802041c8: 93 85 25 b8  	addi	a1, a1, -1150
802041cc: 2d 46        	addi	a2, zero, 11
802041ce: 97 20 00 00  	auipc	ra, 2
802041d2: e7 80 80 88  	jalr	-1912(ra)
802041d6: a3 0f a1 00  	sb	a0, 31(sp)
802041da: f5 a0        	j	0x802042c6 <.LBB5_38+0x18>

00000000802041dc <.LBB5_11>:
802041dc: 22 65        	ld	a0, 8(sp)

00000000802041de <.LBB5_30>:
802041de: 97 55 01 00  	auipc	a1, 21
802041e2: 93 85 05 b5  	addi	a1, a1, -1200
802041e6: 61 46        	addi	a2, zero, 24
802041e8: 97 20 00 00  	auipc	ra, 2
802041ec: e7 80 e0 86  	jalr	-1938(ra)
802041f0: a3 0f a1 00  	sb	a0, 31(sp)
802041f4: c9 a8        	j	0x802042c6 <.LBB5_38+0x18>

00000000802041f6 <.LBB5_12>:
802041f6: 22 65        	ld	a0, 8(sp)

00000000802041f8 <.LBB5_31>:
802041f8: 97 55 01 00  	auipc	a1, 21
802041fc: 93 85 25 b2  	addi	a1, a1, -1246
80204200: 51 46        	addi	a2, zero, 20
80204202: 97 20 00 00  	auipc	ra, 2
80204206: e7 80 40 85  	jalr	-1964(ra)
8020420a: a3 0f a1 00  	sb	a0, 31(sp)
8020420e: 65 a8        	j	0x802042c6 <.LBB5_38+0x18>

0000000080204210 <.LBB5_13>:
80204210: 22 65        	ld	a0, 8(sp)

0000000080204212 <.LBB5_32>:
80204212: 97 55 01 00  	auipc	a1, 21
80204216: 93 85 b5 af  	addi	a1, a1, -1285
8020421a: 35 46        	addi	a2, zero, 13
8020421c: 97 20 00 00  	auipc	ra, 2
80204220: e7 80 a0 83  	jalr	-1990(ra)
80204224: a3 0f a1 00  	sb	a0, 31(sp)
80204228: 79 a8        	j	0x802042c6 <.LBB5_38+0x18>

000000008020422a <.LBB5_14>:
8020422a: 22 65        	ld	a0, 8(sp)

000000008020422c <.LBB5_33>:
8020422c: 97 55 01 00  	auipc	a1, 21
80204230: 93 85 35 ad  	addi	a1, a1, -1325
80204234: 39 46        	addi	a2, zero, 14
80204236: 97 20 00 00  	auipc	ra, 2
8020423a: e7 80 00 82  	jalr	-2016(ra)
8020423e: a3 0f a1 00  	sb	a0, 31(sp)
80204242: 51 a0        	j	0x802042c6 <.LBB5_38+0x18>

0000000080204244 <.LBB5_15>:
80204244: 22 65        	ld	a0, 8(sp)

0000000080204246 <.LBB5_34>:
80204246: 97 55 01 00  	auipc	a1, 21
8020424a: 93 85 05 aa  	addi	a1, a1, -1376
8020424e: 65 46        	addi	a2, zero, 25
80204250: 97 20 00 00  	auipc	ra, 2
80204254: e7 80 60 80  	jalr	-2042(ra)
80204258: a3 0f a1 00  	sb	a0, 31(sp)
8020425c: ad a0        	j	0x802042c6 <.LBB5_38+0x18>

000000008020425e <.LBB5_16>:
8020425e: 22 65        	ld	a0, 8(sp)

0000000080204260 <.LBB5_35>:
80204260: 97 55 01 00  	auipc	a1, 21
80204264: 93 85 45 a7  	addi	a1, a1, -1420
80204268: 49 46        	addi	a2, zero, 18
8020426a: 97 10 00 00  	auipc	ra, 1
8020426e: e7 80 c0 7e  	jalr	2028(ra)
80204272: a3 0f a1 00  	sb	a0, 31(sp)
80204276: 81 a8        	j	0x802042c6 <.LBB5_38+0x18>

0000000080204278 <.LBB5_17>:
80204278: 22 65        	ld	a0, 8(sp)

000000008020427a <.LBB5_36>:
8020427a: 97 55 01 00  	auipc	a1, 21
8020427e: 93 85 85 a4  	addi	a1, a1, -1464
80204282: 49 46        	addi	a2, zero, 18
80204284: 97 10 00 00  	auipc	ra, 1
80204288: e7 80 20 7d  	jalr	2002(ra)
8020428c: a3 0f a1 00  	sb	a0, 31(sp)
80204290: 1d a8        	j	0x802042c6 <.LBB5_38+0x18>

0000000080204292 <.LBB5_18>:
80204292: 22 65        	ld	a0, 8(sp)

0000000080204294 <.LBB5_37>:
80204294: 97 55 01 00  	auipc	a1, 21
80204298: 93 85 b5 a1  	addi	a1, a1, -1509
8020429c: 4d 46        	addi	a2, zero, 19
8020429e: 97 10 00 00  	auipc	ra, 1
802042a2: e7 80 80 7b  	jalr	1976(ra)
802042a6: a3 0f a1 00  	sb	a0, 31(sp)
802042aa: 31 a8        	j	0x802042c6 <.LBB5_38+0x18>

00000000802042ac <.LBB5_19>:
802042ac: 22 65        	ld	a0, 8(sp)

00000000802042ae <.LBB5_38>:
802042ae: 97 55 01 00  	auipc	a1, 21
802042b2: 93 85 25 96  	addi	a1, a1, -1694
802042b6: 1d 46        	addi	a2, zero, 7
802042b8: 97 10 00 00  	auipc	ra, 1
802042bc: e7 80 e0 79  	jalr	1950(ra)
802042c0: a3 0f a1 00  	sb	a0, 31(sp)
802042c4: 09 a0        	j	0x802042c6 <.LBB5_38+0x18>
802042c6: 03 45 f1 01  	lbu	a0, 31(sp)
802042ca: e2 70        	ld	ra, 56(sp)
802042cc: 21 61        	addi	sp, sp, 64
802042ce: 82 80        	ret

00000000802042d0 <_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17h4e4a460e407e3418E>:
802042d0: 01 11        	addi	sp, sp, -32
802042d2: 06 ec        	sd	ra, 24(sp)
802042d4: 2a e4        	sd	a0, 8(sp)
802042d6: 2e e8        	sd	a1, 16(sp)
802042d8: 08 61        	ld	a0, 0(a0)
802042da: 97 00 00 00  	auipc	ra, 0
802042de: e7 80 c0 e0  	jalr	-500(ra)
802042e2: 2a e0        	sd	a0, 0(sp)
802042e4: 09 a0        	j	0x802042e6 <_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17h4e4a460e407e3418E+0x16>
802042e6: 02 65        	ld	a0, 0(sp)
802042e8: e2 60        	ld	ra, 24(sp)
802042ea: 05 61        	addi	sp, sp, 32
802042ec: 82 80        	ret

00000000802042ee <_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17hab71286b55747108E>:
802042ee: 01 11        	addi	sp, sp, -32
802042f0: 06 ec        	sd	ra, 24(sp)
802042f2: 2a e4        	sd	a0, 8(sp)
802042f4: 2e e8        	sd	a1, 16(sp)
802042f6: 08 61        	ld	a0, 0(a0)
802042f8: 97 00 00 00  	auipc	ra, 0
802042fc: e7 80 a0 cb  	jalr	-838(ra)
80204300: 2a e0        	sd	a0, 0(sp)
80204302: 09 a0        	j	0x80204304 <_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17hab71286b55747108E+0x16>
80204304: 02 65        	ld	a0, 0(sp)
80204306: e2 60        	ld	ra, 24(sp)
80204308: 05 61        	addi	sp, sp, 32
8020430a: 82 80        	ret

000000008020430c <_ZN4core3ptr59drop_in_place$LT$$RF$riscv..register..scause..Exception$GT$17hdb07fe199c44615dE>:
8020430c: 41 11        	addi	sp, sp, -16
8020430e: 2a e4        	sd	a0, 8(sp)
80204310: 41 01        	addi	sp, sp, 16
80204312: 82 80        	ret

0000000080204314 <_ZN4core3ptr59drop_in_place$LT$$RF$riscv..register..scause..Interrupt$GT$17h975958290588cd67E>:
80204314: 41 11        	addi	sp, sp, -16
80204316: 2a e4        	sd	a0, 8(sp)
80204318: 41 01        	addi	sp, sp, 16
8020431a: 82 80        	ret

000000008020431c <_ZN89_$LT$core..ops..range..Range$LT$T$GT$$u20$as$u20$core..iter..range..RangeIteratorImpl$GT$9spec_next17h36e09a4db9db4e6fE>:
8020431c: 5d 71        	addi	sp, sp, -80
8020431e: 86 e4        	sd	ra, 72(sp)
80204320: 2a ec        	sd	a0, 24(sp)
80204322: 2a fc        	sd	a0, 56(sp)
80204324: 93 05 85 00  	addi	a1, a0, 8
80204328: 97 00 00 00  	auipc	ra, 0
8020432c: e7 80 80 1b  	jalr	440(ra)
80204330: 2a f0        	sd	a0, 32(sp)
80204332: 09 a0        	j	0x80204334 <_ZN89_$LT$core..ops..range..Range$LT$T$GT$$u20$as$u20$core..iter..range..RangeIteratorImpl$GT$9spec_next17h36e09a4db9db4e6fE+0x18>
80204334: 02 75        	ld	a0, 32(sp)
80204336: 81 45        	mv	a1, zero
80204338: 63 16 b5 00  	bne	a0, a1, 0x80204344 <_ZN89_$LT$core..ops..range..Range$LT$T$GT$$u20$as$u20$core..iter..range..RangeIteratorImpl$GT$9spec_next17h36e09a4db9db4e6fE+0x28>
8020433c: 09 a0        	j	0x8020433e <_ZN89_$LT$core..ops..range..Range$LT$T$GT$$u20$as$u20$core..iter..range..RangeIteratorImpl$GT$9spec_next17h36e09a4db9db4e6fE+0x22>
8020433e: 01 45        	mv	a0, zero
80204340: 2a f4        	sd	a0, 40(sp)
80204342: 3d a8        	j	0x80204380 <_ZN89_$LT$core..ops..range..Range$LT$T$GT$$u20$as$u20$core..iter..range..RangeIteratorImpl$GT$9spec_next17h36e09a4db9db4e6fE+0x64>
80204344: 62 65        	ld	a0, 24(sp)
80204346: 97 00 00 00  	auipc	ra, 0
8020434a: e7 80 20 0b  	jalr	178(ra)
8020434e: 2a e8        	sd	a0, 16(sp)
80204350: 09 a0        	j	0x80204352 <_ZN89_$LT$core..ops..range..Range$LT$T$GT$$u20$as$u20$core..iter..range..RangeIteratorImpl$GT$9spec_next17h36e09a4db9db4e6fE+0x36>
80204352: 42 65        	ld	a0, 16(sp)
80204354: 85 45        	addi	a1, zero, 1
80204356: 97 00 00 00  	auipc	ra, 0
8020435a: e7 80 c0 0a  	jalr	172(ra)
8020435e: aa 85        	mv	a1, a0
80204360: 2e e4        	sd	a1, 8(sp)
80204362: aa e0        	sd	a0, 64(sp)
80204364: 09 a0        	j	0x80204366 <_ZN89_$LT$core..ops..range..Range$LT$T$GT$$u20$as$u20$core..iter..range..RangeIteratorImpl$GT$9spec_next17h36e09a4db9db4e6fE+0x4a>
80204366: a2 65        	ld	a1, 8(sp)
80204368: 62 65        	ld	a0, 24(sp)
8020436a: 97 00 00 00  	auipc	ra, 0
8020436e: e7 80 20 0c  	jalr	194(ra)
80204372: 2a e0        	sd	a0, 0(sp)
80204374: 09 a0        	j	0x80204376 <_ZN89_$LT$core..ops..range..Range$LT$T$GT$$u20$as$u20$core..iter..range..RangeIteratorImpl$GT$9spec_next17h36e09a4db9db4e6fE+0x5a>
80204376: 02 65        	ld	a0, 0(sp)
80204378: 2a f8        	sd	a0, 48(sp)
8020437a: 05 45        	addi	a0, zero, 1
8020437c: 2a f4        	sd	a0, 40(sp)
8020437e: 09 a0        	j	0x80204380 <_ZN89_$LT$core..ops..range..Range$LT$T$GT$$u20$as$u20$core..iter..range..RangeIteratorImpl$GT$9spec_next17h36e09a4db9db4e6fE+0x64>
80204380: 22 75        	ld	a0, 40(sp)
80204382: c2 75        	ld	a1, 48(sp)
80204384: a6 60        	ld	ra, 72(sp)
80204386: 61 61        	addi	sp, sp, 80
80204388: 82 80        	ret

000000008020438a <_ZN4core4iter5range101_$LT$impl$u20$core..iter..traits..iterator..Iterator$u20$for$u20$core..ops..range..Range$LT$A$GT$$GT$4next17h543d208880744934E>:
8020438a: 01 11        	addi	sp, sp, -32
8020438c: 06 ec        	sd	ra, 24(sp)
8020438e: 2a e8        	sd	a0, 16(sp)
80204390: 97 00 00 00  	auipc	ra, 0
80204394: e7 80 c0 f8  	jalr	-116(ra)
80204398: 2a e0        	sd	a0, 0(sp)
8020439a: 2e e4        	sd	a1, 8(sp)
8020439c: 09 a0        	j	0x8020439e <_ZN4core4iter5range101_$LT$impl$u20$core..iter..traits..iterator..Iterator$u20$for$u20$core..ops..range..Range$LT$A$GT$$GT$4next17h543d208880744934E+0x14>
8020439e: a2 65        	ld	a1, 8(sp)
802043a0: 02 65        	ld	a0, 0(sp)
802043a2: e2 60        	ld	ra, 24(sp)
802043a4: 05 61        	addi	sp, sp, 32
802043a6: 82 80        	ret

00000000802043a8 <_ZN63_$LT$I$u20$as$u20$core..iter..traits..collect..IntoIterator$GT$9into_iter17ha3161d1d0c951ba3E>:
802043a8: 41 11        	addi	sp, sp, -16
802043aa: 2a e0        	sd	a0, 0(sp)
802043ac: 2e e4        	sd	a1, 8(sp)
802043ae: 41 01        	addi	sp, sp, 16
802043b0: 82 80        	ret

00000000802043b2 <_ZN4core3fmt10ArgumentV13new17h18d4e3408dd31f0eE>:
802043b2: 5d 71        	addi	sp, sp, -80
802043b4: 2a e8        	sd	a0, 16(sp)
802043b6: 2a f8        	sd	a0, 48(sp)
802043b8: 2e fc        	sd	a1, 56(sp)
802043ba: ae e0        	sd	a1, 64(sp)
802043bc: 2e ec        	sd	a1, 24(sp)
802043be: 09 a0        	j	0x802043c0 <_ZN4core3fmt10ArgumentV13new17h18d4e3408dd31f0eE+0xe>
802043c0: 42 65        	ld	a0, 16(sp)
802043c2: aa e4        	sd	a0, 72(sp)
802043c4: 2a e4        	sd	a0, 8(sp)
802043c6: 09 a0        	j	0x802043c8 <_ZN4core3fmt10ArgumentV13new17h18d4e3408dd31f0eE+0x16>
802043c8: e2 65        	ld	a1, 24(sp)
802043ca: 22 65        	ld	a0, 8(sp)
802043cc: 2a f0        	sd	a0, 32(sp)
802043ce: 2e f4        	sd	a1, 40(sp)
802043d0: 61 61        	addi	sp, sp, 80
802043d2: 82 80        	ret

00000000802043d4 <_ZN44_$LT$$RF$T$u20$as$u20$core..fmt..Display$GT$3fmt17h587ca3e5ee079955E>:
802043d4: 01 11        	addi	sp, sp, -32
802043d6: 06 ec        	sd	ra, 24(sp)
802043d8: 2e 86        	mv	a2, a1
802043da: aa 85        	mv	a1, a0
802043dc: 2e e4        	sd	a1, 8(sp)
802043de: 32 e8        	sd	a2, 16(sp)
802043e0: 88 61        	ld	a0, 0(a1)
802043e2: 8c 65        	ld	a1, 8(a1)
802043e4: 97 10 00 00  	auipc	ra, 1
802043e8: e7 80 60 6b  	jalr	1718(ra)
802043ec: 2a e0        	sd	a0, 0(sp)
802043ee: 09 a0        	j	0x802043f0 <_ZN44_$LT$$RF$T$u20$as$u20$core..fmt..Display$GT$3fmt17h587ca3e5ee079955E+0x1c>
802043f0: 02 65        	ld	a0, 0(sp)
802043f2: e2 60        	ld	ra, 24(sp)
802043f4: 05 61        	addi	sp, sp, 32
802043f6: 82 80        	ret

00000000802043f8 <_ZN4core5clone5impls54_$LT$impl$u20$core..clone..Clone$u20$for$u20$usize$GT$5clone17h539a20b4de127d09E>:
802043f8: 41 11        	addi	sp, sp, -16
802043fa: 2a e4        	sd	a0, 8(sp)
802043fc: 08 61        	ld	a0, 0(a0)
802043fe: 41 01        	addi	sp, sp, 16
80204400: 82 80        	ret

0000000080204402 <_ZN49_$LT$usize$u20$as$u20$core..iter..range..Step$GT$17forward_unchecked17h3d87d9fa0372d3a7E>:
80204402: 79 71        	addi	sp, sp, -48
80204404: 2a e4        	sd	a0, 8(sp)
80204406: 2e e8        	sd	a1, 16(sp)
80204408: 2a ec        	sd	a0, 24(sp)
8020440a: 2e f0        	sd	a1, 32(sp)
8020440c: 2e 95        	add	a0, a0, a1
8020440e: 2a e0        	sd	a0, 0(sp)
80204410: 2a f4        	sd	a0, 40(sp)
80204412: 09 a0        	j	0x80204414 <_ZN49_$LT$usize$u20$as$u20$core..iter..range..Step$GT$17forward_unchecked17h3d87d9fa0372d3a7E+0x12>
80204414: 02 65        	ld	a0, 0(sp)
80204416: 45 61        	addi	sp, sp, 48
80204418: 82 80        	ret

000000008020441a <_ZN4core3ptr8non_null16NonNull$LT$T$GT$13new_unchecked17h1bbf751b8bccaa29E>:
8020441a: 41 11        	addi	sp, sp, -16
8020441c: 2a e4        	sd	a0, 8(sp)
8020441e: 2a e0        	sd	a0, 0(sp)
80204420: 41 01        	addi	sp, sp, 16
80204422: 82 80        	ret

0000000080204424 <_ZN4core3ptr8non_null16NonNull$LT$T$GT$6as_ptr17h9cf6f674397f8f8eE>:
80204424: 41 11        	addi	sp, sp, -16
80204426: 2a e4        	sd	a0, 8(sp)
80204428: 41 01        	addi	sp, sp, 16
8020442a: 82 80        	ret

000000008020442c <_ZN4core3mem7replace17h54c8a7978c483fe4E>:
8020442c: 39 71        	addi	sp, sp, -64
8020442e: 06 fc        	sd	ra, 56(sp)
80204430: 2e e4        	sd	a1, 8(sp)
80204432: 2a e8        	sd	a0, 16(sp)
80204434: 2a f0        	sd	a0, 32(sp)
80204436: 2e f4        	sd	a1, 40(sp)
80204438: 97 00 00 00  	auipc	ra, 0
8020443c: e7 80 80 11  	jalr	280(ra)
80204440: aa 85        	mv	a1, a0
80204442: 2e ec        	sd	a1, 24(sp)
80204444: 2a f8        	sd	a0, 48(sp)
80204446: 09 a0        	j	0x80204448 <_ZN4core3mem7replace17h54c8a7978c483fe4E+0x1c>
80204448: a2 65        	ld	a1, 8(sp)
8020444a: 42 65        	ld	a0, 16(sp)
8020444c: 97 00 00 00  	auipc	ra, 0
80204450: e7 80 a0 12  	jalr	298(ra)
80204454: 09 a0        	j	0x80204456 <_ZN4core3mem7replace17h54c8a7978c483fe4E+0x2a>
80204456: 62 65        	ld	a0, 24(sp)
80204458: e2 70        	ld	ra, 56(sp)
8020445a: 21 61        	addi	sp, sp, 64
8020445c: 82 80        	ret

000000008020445e <_ZN4core3ptr8metadata14from_raw_parts17hd6af5a2605860e70E>:
8020445e: 79 71        	addi	sp, sp, -48
80204460: 2a f0        	sd	a0, 32(sp)
80204462: 2e f4        	sd	a1, 40(sp)
80204464: 2a e8        	sd	a0, 16(sp)
80204466: 2e ec        	sd	a1, 24(sp)
80204468: 2a e0        	sd	a0, 0(sp)
8020446a: 2e e4        	sd	a1, 8(sp)
8020446c: 45 61        	addi	sp, sp, 48
8020446e: 82 80        	ret

0000000080204470 <_ZN4core3ptr8metadata18from_raw_parts_mut17h2d162a418d9ba98bE>:
80204470: 79 71        	addi	sp, sp, -48
80204472: 2a f0        	sd	a0, 32(sp)
80204474: 2e f4        	sd	a1, 40(sp)
80204476: 2a e8        	sd	a0, 16(sp)
80204478: 2e ec        	sd	a1, 24(sp)
8020447a: 2a e0        	sd	a0, 0(sp)
8020447c: 2e e4        	sd	a1, 8(sp)
8020447e: 45 61        	addi	sp, sp, 48
80204480: 82 80        	ret

0000000080204482 <_ZN4core3ptr9const_ptr33_$LT$impl$u20$$BP$const$u20$T$GT$4cast17h47efc856f2a59501E>:
80204482: 41 11        	addi	sp, sp, -16
80204484: 2a e4        	sd	a0, 8(sp)
80204486: 41 01        	addi	sp, sp, 16
80204488: 82 80        	ret

000000008020448a <_ZN4core3ptr9const_ptr33_$LT$impl$u20$$BP$const$u20$T$GT$13guaranteed_eq17hab8fb1c6be1695abE>:
8020448a: 01 11        	addi	sp, sp, -32
8020448c: 2a e4        	sd	a0, 8(sp)
8020448e: 2e e8        	sd	a1, 16(sp)
80204490: 2d 8d        	xor	a0, a0, a1
80204492: 13 35 15 00  	seqz	a0, a0
80204496: 2a e0        	sd	a0, 0(sp)
80204498: a3 0f a1 00  	sb	a0, 31(sp)
8020449c: 09 a0        	j	0x8020449e <_ZN4core3ptr9const_ptr33_$LT$impl$u20$$BP$const$u20$T$GT$13guaranteed_eq17hab8fb1c6be1695abE+0x14>
8020449e: 02 65        	ld	a0, 0(sp)
802044a0: 05 61        	addi	sp, sp, 32
802044a2: 82 80        	ret

00000000802044a4 <_ZN4core3ptr7mut_ptr31_$LT$impl$u20$$BP$mut$u20$T$GT$7is_null17h67b5a9eeed1145ffE>:
802044a4: 01 11        	addi	sp, sp, -32
802044a6: 06 ec        	sd	ra, 24(sp)
802044a8: 2a e4        	sd	a0, 8(sp)
802044aa: 2a e8        	sd	a0, 16(sp)
802044ac: 09 a0        	j	0x802044ae <_ZN4core3ptr7mut_ptr31_$LT$impl$u20$$BP$mut$u20$T$GT$7is_null17h67b5a9eeed1145ffE+0xa>
802044ae: 22 65        	ld	a0, 8(sp)
802044b0: 81 45        	mv	a1, zero
802044b2: 97 00 00 00  	auipc	ra, 0
802044b6: e7 80 40 01  	jalr	20(ra)
802044ba: 2a e0        	sd	a0, 0(sp)
802044bc: 09 a0        	j	0x802044be <_ZN4core3ptr7mut_ptr31_$LT$impl$u20$$BP$mut$u20$T$GT$7is_null17h67b5a9eeed1145ffE+0x1a>
802044be: 02 65        	ld	a0, 0(sp)
802044c0: e2 60        	ld	ra, 24(sp)
802044c2: 05 61        	addi	sp, sp, 32
802044c4: 82 80        	ret

00000000802044c6 <_ZN4core3ptr7mut_ptr31_$LT$impl$u20$$BP$mut$u20$T$GT$13guaranteed_eq17hcd42314900017a7fE>:
802044c6: 01 11        	addi	sp, sp, -32
802044c8: 2a e4        	sd	a0, 8(sp)
802044ca: 2e e8        	sd	a1, 16(sp)
802044cc: 2d 8d        	xor	a0, a0, a1
802044ce: 13 35 15 00  	seqz	a0, a0
802044d2: 2a e0        	sd	a0, 0(sp)
802044d4: a3 0f a1 00  	sb	a0, 31(sp)
802044d8: 09 a0        	j	0x802044da <_ZN4core3ptr7mut_ptr31_$LT$impl$u20$$BP$mut$u20$T$GT$13guaranteed_eq17hcd42314900017a7fE+0x14>
802044da: 02 65        	ld	a0, 0(sp)
802044dc: 05 61        	addi	sp, sp, 32
802044de: 82 80        	ret

00000000802044e0 <_ZN4core3cmp5impls57_$LT$impl$u20$core..cmp..PartialOrd$u20$for$u20$usize$GT$2lt17h9fa24387e44efd63E>:
802044e0: 41 11        	addi	sp, sp, -16
802044e2: 2a e0        	sd	a0, 0(sp)
802044e4: 2e e4        	sd	a1, 8(sp)
802044e6: 08 61        	ld	a0, 0(a0)
802044e8: 8c 61        	ld	a1, 0(a1)
802044ea: 33 35 b5 00  	sltu	a0, a0, a1
802044ee: 41 01        	addi	sp, sp, 16
802044f0: 82 80        	ret

00000000802044f2 <_ZN4core3ptr20slice_from_raw_parts17h7cf18d3f168a4a89E>:
802044f2: 39 71        	addi	sp, sp, -64
802044f4: 06 fc        	sd	ra, 56(sp)
802044f6: 2e ec        	sd	a1, 24(sp)
802044f8: 2a f4        	sd	a0, 40(sp)
802044fa: 2e f8        	sd	a1, 48(sp)
802044fc: 97 00 00 00  	auipc	ra, 0
80204500: e7 80 60 f8  	jalr	-122(ra)
80204504: 2a f0        	sd	a0, 32(sp)
80204506: 09 a0        	j	0x80204508 <_ZN4core3ptr20slice_from_raw_parts17h7cf18d3f168a4a89E+0x16>
80204508: e2 65        	ld	a1, 24(sp)
8020450a: 02 75        	ld	a0, 32(sp)
8020450c: 97 00 00 00  	auipc	ra, 0
80204510: e7 80 20 f5  	jalr	-174(ra)
80204514: 2a e4        	sd	a0, 8(sp)
80204516: 2e e8        	sd	a1, 16(sp)
80204518: 09 a0        	j	0x8020451a <_ZN4core3ptr20slice_from_raw_parts17h7cf18d3f168a4a89E+0x28>
8020451a: c2 65        	ld	a1, 16(sp)
8020451c: 22 65        	ld	a0, 8(sp)
8020451e: e2 70        	ld	ra, 56(sp)
80204520: 21 61        	addi	sp, sp, 64
80204522: 82 80        	ret

0000000080204524 <_ZN4core3ptr24slice_from_raw_parts_mut17h164c9841f1d11c5aE>:
80204524: 39 71        	addi	sp, sp, -64
80204526: 06 fc        	sd	ra, 56(sp)
80204528: 2e e8        	sd	a1, 16(sp)
8020452a: 2a f0        	sd	a0, 32(sp)
8020452c: 2e f4        	sd	a1, 40(sp)
8020452e: 2a f8        	sd	a0, 48(sp)
80204530: 2a ec        	sd	a0, 24(sp)
80204532: 09 a0        	j	0x80204534 <_ZN4core3ptr24slice_from_raw_parts_mut17h164c9841f1d11c5aE+0x10>
80204534: c2 65        	ld	a1, 16(sp)
80204536: 62 65        	ld	a0, 24(sp)
80204538: 97 00 00 00  	auipc	ra, 0
8020453c: e7 80 80 f3  	jalr	-200(ra)
80204540: 2a e0        	sd	a0, 0(sp)
80204542: 2e e4        	sd	a1, 8(sp)
80204544: 09 a0        	j	0x80204546 <_ZN4core3ptr24slice_from_raw_parts_mut17h164c9841f1d11c5aE+0x22>
80204546: a2 65        	ld	a1, 8(sp)
80204548: 02 65        	ld	a0, 0(sp)
8020454a: e2 70        	ld	ra, 56(sp)
8020454c: 21 61        	addi	sp, sp, 64
8020454e: 82 80        	ret

0000000080204550 <_ZN4core3ptr4read17h46b783f63fe61245E>:
80204550: 39 71        	addi	sp, sp, -64
80204552: 2a e4        	sd	a0, 8(sp)
80204554: 2a ec        	sd	a0, 24(sp)
80204556: 02 75        	ld	a0, 32(sp)
80204558: 2a e8        	sd	a0, 16(sp)
8020455a: 09 a0        	j	0x8020455c <_ZN4core3ptr4read17h46b783f63fe61245E+0xc>
8020455c: 08 08        	addi	a0, sp, 16
8020455e: 2a f4        	sd	a0, 40(sp)
80204560: 09 a0        	j	0x80204562 <_ZN4core3ptr4read17h46b783f63fe61245E+0x12>
80204562: 22 65        	ld	a0, 8(sp)
80204564: 08 61        	ld	a0, 0(a0)
80204566: 2a e0        	sd	a0, 0(sp)
80204568: 2a e8        	sd	a0, 16(sp)
8020456a: 2a f8        	sd	a0, 48(sp)
8020456c: 2a fc        	sd	a0, 56(sp)
8020456e: 09 a0        	j	0x80204570 <_ZN4core3ptr4read17h46b783f63fe61245E+0x20>
80204570: 02 65        	ld	a0, 0(sp)
80204572: 21 61        	addi	sp, sp, 64
80204574: 82 80        	ret

0000000080204576 <_ZN4core3ptr5write17hb1db7a0f3ea2e61fE>:
80204576: 41 11        	addi	sp, sp, -16
80204578: 2e e0        	sd	a1, 0(sp)
8020457a: 2a e4        	sd	a0, 8(sp)
8020457c: 0c e1        	sd	a1, 0(a0)
8020457e: 41 01        	addi	sp, sp, 16
80204580: 82 80        	ret

0000000080204582 <_ZN4core4sync6atomic11atomic_load17h92a1f9c515d5bb4eE>:
80204582: 75 71        	addi	sp, sp, -144
80204584: 06 e5        	sd	ra, 136(sp)
80204586: 2a e0        	sd	a0, 0(sp)
80204588: a3 0b b1 00  	sb	a1, 23(sp)
8020458c: 2a e1        	sd	a0, 128(sp)
8020458e: 13 f5 f5 0f  	andi	a0, a1, 255
80204592: 2a e4        	sd	a0, 8(sp)
80204594: 22 65        	ld	a0, 8(sp)
80204596: 0e 05        	slli	a0, a0, 3

0000000080204598 <.LBB1_14>:
80204598: 97 55 01 00  	auipc	a1, 21
8020459c: 93 85 05 81  	addi	a1, a1, -2032
802045a0: 2e 95        	add	a0, a0, a1
802045a2: 08 61        	ld	a0, 0(a0)
802045a4: 02 85        	jr	a0
802045a6: 00 00        	unimp	

00000000802045a8 <.LBB1_3>:
802045a8: 02 65        	ld	a0, 0(sp)
802045aa: 08 61        	ld	a0, 0(a0)
802045ac: 2a ec        	sd	a0, 24(sp)
802045ae: 49 a8        	j	0x80204640 <.LBB1_20+0x14>

00000000802045b0 <.LBB1_4>:
802045b0: 97 55 01 00  	auipc	a1, 21
802045b4: 93 85 05 8f  	addi	a1, a1, -1808

00000000802045b8 <.LBB1_16>:
802045b8: 97 56 01 00  	auipc	a3, 21
802045bc: 93 86 86 81  	addi	a3, a3, -2024
802045c0: 08 10        	addi	a0, sp, 32
802045c2: 05 46        	addi	a2, zero, 1
802045c4: 01 47        	mv	a4, zero
802045c6: 97 00 00 00  	auipc	ra, 0
802045ca: e7 80 c0 07  	jalr	124(ra)
802045ce: b9 a8        	j	0x8020462c <.LBB1_20>

00000000802045d0 <.LBB1_5>:
802045d0: 02 65        	ld	a0, 0(sp)
802045d2: 08 61        	ld	a0, 0(a0)
802045d4: 0f 00 30 02  	fence	r, rw
802045d8: 2a ec        	sd	a0, 24(sp)
802045da: 81 a8        	j	0x8020462a <.LBB1_19+0x14>

00000000802045dc <.LBB1_6>:
802045dc: 97 55 01 00  	auipc	a1, 21
802045e0: 93 85 45 87  	addi	a1, a1, -1932

00000000802045e4 <.LBB1_18>:
802045e4: 97 46 01 00  	auipc	a3, 20
802045e8: 93 86 c6 7e  	addi	a3, a3, 2028
802045ec: 88 08        	addi	a0, sp, 80
802045ee: 05 46        	addi	a2, zero, 1
802045f0: 01 47        	mv	a4, zero
802045f2: 97 00 00 00  	auipc	ra, 0
802045f6: e7 80 00 05  	jalr	80(ra)
802045fa: 31 a8        	j	0x80204616 <.LBB1_19>

00000000802045fc <.LBB1_7>:
802045fc: 02 65        	ld	a0, 0(sp)
802045fe: 0f 00 30 03  	fence	rw, rw
80204602: 08 61        	ld	a0, 0(a0)
80204604: 0f 00 30 02  	fence	r, rw
80204608: 2a ec        	sd	a0, 24(sp)
8020460a: 09 a0        	j	0x8020460c <.LBB1_7+0x10>
8020460c: 09 a0        	j	0x8020460e <.LBB1_7+0x12>
8020460e: 62 65        	ld	a0, 24(sp)
80204610: aa 60        	ld	ra, 136(sp)
80204612: 49 61        	addi	sp, sp, 144
80204614: 82 80        	ret

0000000080204616 <.LBB1_19>:
80204616: 97 55 01 00  	auipc	a1, 21
8020461a: 93 85 a5 84  	addi	a1, a1, -1974
8020461e: 88 08        	addi	a0, sp, 80
80204620: 97 00 00 00  	auipc	ra, 0
80204624: e7 80 80 5f  	jalr	1528(ra)
80204628: 00 00        	unimp	
8020462a: d5 b7        	j	0x8020460e <.LBB1_7+0x12>

000000008020462c <.LBB1_20>:
8020462c: 97 55 01 00  	auipc	a1, 21
80204630: 93 85 45 88  	addi	a1, a1, -1916
80204634: 08 10        	addi	a0, sp, 32
80204636: 97 00 00 00  	auipc	ra, 0
8020463a: e7 80 20 5e  	jalr	1506(ra)
8020463e: 00 00        	unimp	
80204640: f9 b7        	j	0x8020460e <.LBB1_7+0x12>

0000000080204642 <_ZN4core3fmt9Arguments6new_v117h593d2652078ae8ffE>:
80204642: 35 71        	addi	sp, sp, -160
80204644: 06 ed        	sd	ra, 152(sp)
80204646: 3a e4        	sd	a4, 8(sp)
80204648: 36 e8        	sd	a3, 16(sp)
8020464a: 32 ec        	sd	a2, 24(sp)
8020464c: 2e f0        	sd	a1, 32(sp)
8020464e: 2a f4        	sd	a0, 40(sp)
80204650: ae fc        	sd	a1, 120(sp)
80204652: 32 e1        	sd	a2, 128(sp)
80204654: 36 e5        	sd	a3, 136(sp)
80204656: 3a e9        	sd	a4, 144(sp)
80204658: 63 6b e6 00  	bltu	a2, a4, 0x8020466e <_ZN4core3fmt9Arguments6new_v117h593d2652078ae8ffE+0x2c>
8020465c: 09 a0        	j	0x8020465e <_ZN4core3fmt9Arguments6new_v117h593d2652078ae8ffE+0x1c>
8020465e: e2 65        	ld	a1, 24(sp)
80204660: 22 65        	ld	a0, 8(sp)
80204662: 05 05        	addi	a0, a0, 1
80204664: 33 35 b5 00  	sltu	a0, a0, a1
80204668: a3 0b a1 02  	sb	a0, 55(sp)
8020466c: 29 a0        	j	0x80204676 <_ZN4core3fmt9Arguments6new_v117h593d2652078ae8ffE+0x34>
8020466e: 05 45        	addi	a0, zero, 1
80204670: a3 0b a1 02  	sb	a0, 55(sp)
80204674: 09 a0        	j	0x80204676 <_ZN4core3fmt9Arguments6new_v117h593d2652078ae8ffE+0x34>
80204676: 03 45 71 03  	lbu	a0, 55(sp)
8020467a: 05 89        	andi	a0, a0, 1
8020467c: 81 45        	mv	a1, zero
8020467e: 63 15 b5 02  	bne	a0, a1, 0x802046a8 <.LBB0_7>
80204682: 09 a0        	j	0x80204684 <_ZN4core3fmt9Arguments6new_v117h593d2652078ae8ffE+0x42>
80204684: 22 65        	ld	a0, 8(sp)
80204686: a2 75        	ld	a1, 40(sp)
80204688: 42 66        	ld	a2, 16(sp)
8020468a: e2 66        	ld	a3, 24(sp)
8020468c: 02 77        	ld	a4, 32(sp)
8020468e: 81 47        	mv	a5, zero
80204690: be f4        	sd	a5, 104(sp)
80204692: 98 e1        	sd	a4, 0(a1)
80204694: 94 e5        	sd	a3, 8(a1)
80204696: 26 77        	ld	a4, 104(sp)
80204698: c6 76        	ld	a3, 112(sp)
8020469a: 98 e9        	sd	a4, 16(a1)
8020469c: 94 ed        	sd	a3, 24(a1)
8020469e: 90 f1        	sd	a2, 32(a1)
802046a0: 88 f5        	sd	a0, 40(a1)
802046a2: ea 60        	ld	ra, 152(sp)
802046a4: 0d 61        	addi	sp, sp, 160
802046a6: 82 80        	ret

00000000802046a8 <.LBB0_7>:
802046a8: 97 55 01 00  	auipc	a1, 21
802046ac: 93 85 05 83  	addi	a1, a1, -2000

00000000802046b0 <.LBB0_8>:
802046b0: 97 56 01 00  	auipc	a3, 21
802046b4: 93 86 86 83  	addi	a3, a3, -1992
802046b8: 28 18        	addi	a0, sp, 56
802046ba: 05 46        	addi	a2, zero, 1
802046bc: 01 47        	mv	a4, zero
802046be: 97 00 00 00  	auipc	ra, 0
802046c2: e7 80 40 f8  	jalr	-124(ra)
802046c6: 09 a0        	j	0x802046c8 <.LBB0_9>

00000000802046c8 <.LBB0_9>:
802046c8: 97 55 01 00  	auipc	a1, 21
802046cc: 93 85 05 87  	addi	a1, a1, -1936
802046d0: 28 18        	addi	a0, sp, 56
802046d2: 97 00 00 00  	auipc	ra, 0
802046d6: e7 80 60 54  	jalr	1350(ra)
802046da: 00 00        	unimp	

00000000802046dc <_ZN60_$LT$spin..once..Finish$u20$as$u20$core..ops..drop..Drop$GT$4drop17ha8eec578b2467fb6E>:
802046dc: 01 11        	addi	sp, sp, -32
802046de: 06 ec        	sd	ra, 24(sp)
802046e0: 2a e0        	sd	a0, 0(sp)
802046e2: 2a e8        	sd	a0, 16(sp)
802046e4: 03 45 85 00  	lbu	a0, 8(a0)
802046e8: 05 89        	andi	a0, a0, 1
802046ea: 81 45        	mv	a1, zero
802046ec: 63 16 b5 00  	bne	a0, a1, 0x802046f8 <_ZN60_$LT$spin..once..Finish$u20$as$u20$core..ops..drop..Drop$GT$4drop17ha8eec578b2467fb6E+0x1c>
802046f0: 09 a0        	j	0x802046f2 <_ZN60_$LT$spin..once..Finish$u20$as$u20$core..ops..drop..Drop$GT$4drop17ha8eec578b2467fb6E+0x16>
802046f2: e2 60        	ld	ra, 24(sp)
802046f4: 05 61        	addi	sp, sp, 32
802046f6: 82 80        	ret
802046f8: 02 65        	ld	a0, 0(sp)
802046fa: 08 61        	ld	a0, 0(a0)
802046fc: 11 46        	addi	a2, zero, 4
802046fe: a3 07 c1 00  	sb	a2, 15(sp)
80204702: 8d 45        	addi	a1, zero, 3
80204704: 97 00 00 00  	auipc	ra, 0
80204708: e7 80 80 0c  	jalr	200(ra)
8020470c: dd b7        	j	0x802046f2 <_ZN60_$LT$spin..once..Finish$u20$as$u20$core..ops..drop..Drop$GT$4drop17ha8eec578b2467fb6E+0x16>

000000008020470e <_ZN4core4sync6atomic12atomic_store17h776bbae4f962cdcfE>:
8020470e: 35 71        	addi	sp, sp, -160
80204710: 06 ed        	sd	ra, 152(sp)
80204712: 2e e4        	sd	a1, 8(sp)
80204714: 2a e8        	sd	a0, 16(sp)
80204716: a3 03 c1 02  	sb	a2, 39(sp)
8020471a: 2a e5        	sd	a0, 136(sp)
8020471c: 2e e9        	sd	a1, 144(sp)
8020471e: 13 75 f6 0f  	andi	a0, a2, 255
80204722: 2a ec        	sd	a0, 24(sp)
80204724: 62 65        	ld	a0, 24(sp)
80204726: 0e 05        	slli	a0, a0, 3

0000000080204728 <.LBB0_14>:
80204728: 97 55 01 00  	auipc	a1, 21
8020472c: 93 85 85 82  	addi	a1, a1, -2008
80204730: 2e 95        	add	a0, a0, a1
80204732: 08 61        	ld	a0, 0(a0)
80204734: 02 85        	jr	a0
80204736: 00 00        	unimp	

0000000080204738 <.LBB0_3>:
80204738: 22 65        	ld	a0, 8(sp)
8020473a: c2 65        	ld	a1, 16(sp)
8020473c: 88 e1        	sd	a0, 0(a1)
8020473e: 71 a0        	j	0x802047ca <.LBB0_20+0x16>

0000000080204740 <.LBB0_4>:
80204740: 22 65        	ld	a0, 8(sp)
80204742: c2 65        	ld	a1, 16(sp)
80204744: 0f 00 10 03  	fence	rw, w
80204748: 88 e1        	sd	a0, 0(a1)
8020474a: bd a8        	j	0x802047c8 <.LBB0_20+0x14>

000000008020474c <.LBB0_5>:
8020474c: 97 55 01 00  	auipc	a1, 21
80204750: 93 85 c5 90  	addi	a1, a1, -1780

0000000080204754 <.LBB0_16>:
80204754: 97 56 01 00  	auipc	a3, 21
80204758: 93 86 c6 86  	addi	a3, a3, -1940
8020475c: 28 10        	addi	a0, sp, 40
8020475e: 05 46        	addi	a2, zero, 1
80204760: 01 47        	mv	a4, zero
80204762: 97 00 00 00  	auipc	ra, 0
80204766: e7 80 a0 09  	jalr	154(ra)
8020476a: a9 a0        	j	0x802047b4 <.LBB0_20>

000000008020476c <.LBB0_6>:
8020476c: 97 55 01 00  	auipc	a1, 21
80204770: 93 85 45 84  	addi	a1, a1, -1980

0000000080204774 <.LBB0_18>:
80204774: 97 56 01 00  	auipc	a3, 21
80204778: 93 86 c6 84  	addi	a3, a3, -1972
8020477c: a8 08        	addi	a0, sp, 88
8020477e: 05 46        	addi	a2, zero, 1
80204780: 01 47        	mv	a4, zero
80204782: 97 00 00 00  	auipc	ra, 0
80204786: e7 80 a0 07  	jalr	122(ra)
8020478a: 19 a8        	j	0x802047a0 <.LBB0_19>

000000008020478c <.LBB0_7>:
8020478c: 22 65        	ld	a0, 8(sp)
8020478e: c2 65        	ld	a1, 16(sp)
80204790: 0f 00 10 03  	fence	rw, w
80204794: 88 e1        	sd	a0, 0(a1)
80204796: 09 a0        	j	0x80204798 <.LBB0_7+0xc>
80204798: 09 a0        	j	0x8020479a <.LBB0_7+0xe>
8020479a: ea 60        	ld	ra, 152(sp)
8020479c: 0d 61        	addi	sp, sp, 160
8020479e: 82 80        	ret

00000000802047a0 <.LBB0_19>:
802047a0: 97 55 01 00  	auipc	a1, 21
802047a4: 93 85 05 87  	addi	a1, a1, -1936
802047a8: a8 08        	addi	a0, sp, 88
802047aa: 97 00 00 00  	auipc	ra, 0
802047ae: e7 80 e0 46  	jalr	1134(ra)
802047b2: 00 00        	unimp	

00000000802047b4 <.LBB0_20>:
802047b4: 97 55 01 00  	auipc	a1, 21
802047b8: 93 85 45 8b  	addi	a1, a1, -1868
802047bc: 28 10        	addi	a0, sp, 40
802047be: 97 00 00 00  	auipc	ra, 0
802047c2: e7 80 a0 45  	jalr	1114(ra)
802047c6: 00 00        	unimp	
802047c8: c9 bf        	j	0x8020479a <.LBB0_7+0xe>
802047ca: c1 bf        	j	0x8020479a <.LBB0_7+0xe>

00000000802047cc <_ZN4core4sync6atomic11AtomicUsize5store17hc0817588e4be9256E>:
802047cc: 39 71        	addi	sp, sp, -64
802047ce: 06 fc        	sd	ra, 56(sp)
802047d0: 2e e0        	sd	a1, 0(sp)
802047d2: b2 86        	mv	a3, a2
802047d4: 36 e4        	sd	a3, 8(sp)
802047d6: 2a ec        	sd	a0, 24(sp)
802047d8: 2e f0        	sd	a1, 32(sp)
802047da: a3 07 c1 02  	sb	a2, 47(sp)
802047de: aa 85        	mv	a1, a0
802047e0: 2e e8        	sd	a1, 16(sp)
802047e2: 2a f8        	sd	a0, 48(sp)
802047e4: 09 a0        	j	0x802047e6 <_ZN4core4sync6atomic11AtomicUsize5store17hc0817588e4be9256E+0x1a>
802047e6: 22 66        	ld	a2, 8(sp)
802047e8: 82 65        	ld	a1, 0(sp)
802047ea: 42 65        	ld	a0, 16(sp)
802047ec: 97 00 00 00  	auipc	ra, 0
802047f0: e7 80 20 f2  	jalr	-222(ra)
802047f4: 09 a0        	j	0x802047f6 <_ZN4core4sync6atomic11AtomicUsize5store17hc0817588e4be9256E+0x2a>
802047f6: e2 70        	ld	ra, 56(sp)
802047f8: 21 61        	addi	sp, sp, 64
802047fa: 82 80        	ret

00000000802047fc <_ZN4core3fmt9Arguments6new_v117ha1cfa3f01b543e88E>:
802047fc: 35 71        	addi	sp, sp, -160
802047fe: 06 ed        	sd	ra, 152(sp)
80204800: 3a e4        	sd	a4, 8(sp)
80204802: 36 e8        	sd	a3, 16(sp)
80204804: 32 ec        	sd	a2, 24(sp)
80204806: 2e f0        	sd	a1, 32(sp)
80204808: 2a f4        	sd	a0, 40(sp)
8020480a: ae fc        	sd	a1, 120(sp)
8020480c: 32 e1        	sd	a2, 128(sp)
8020480e: 36 e5        	sd	a3, 136(sp)
80204810: 3a e9        	sd	a4, 144(sp)
80204812: 63 6b e6 00  	bltu	a2, a4, 0x80204828 <_ZN4core3fmt9Arguments6new_v117ha1cfa3f01b543e88E+0x2c>
80204816: 09 a0        	j	0x80204818 <_ZN4core3fmt9Arguments6new_v117ha1cfa3f01b543e88E+0x1c>
80204818: e2 65        	ld	a1, 24(sp)
8020481a: 22 65        	ld	a0, 8(sp)
8020481c: 05 05        	addi	a0, a0, 1
8020481e: 33 35 b5 00  	sltu	a0, a0, a1
80204822: a3 0b a1 02  	sb	a0, 55(sp)
80204826: 29 a0        	j	0x80204830 <_ZN4core3fmt9Arguments6new_v117ha1cfa3f01b543e88E+0x34>
80204828: 05 45        	addi	a0, zero, 1
8020482a: a3 0b a1 02  	sb	a0, 55(sp)
8020482e: 09 a0        	j	0x80204830 <_ZN4core3fmt9Arguments6new_v117ha1cfa3f01b543e88E+0x34>
80204830: 03 45 71 03  	lbu	a0, 55(sp)
80204834: 05 89        	andi	a0, a0, 1
80204836: 81 45        	mv	a1, zero
80204838: 63 15 b5 02  	bne	a0, a1, 0x80204862 <.LBB0_7>
8020483c: 09 a0        	j	0x8020483e <_ZN4core3fmt9Arguments6new_v117ha1cfa3f01b543e88E+0x42>
8020483e: 22 65        	ld	a0, 8(sp)
80204840: a2 75        	ld	a1, 40(sp)
80204842: 42 66        	ld	a2, 16(sp)
80204844: e2 66        	ld	a3, 24(sp)
80204846: 02 77        	ld	a4, 32(sp)
80204848: 81 47        	mv	a5, zero
8020484a: be f4        	sd	a5, 104(sp)
8020484c: 98 e1        	sd	a4, 0(a1)
8020484e: 94 e5        	sd	a3, 8(a1)
80204850: 26 77        	ld	a4, 104(sp)
80204852: c6 76        	ld	a3, 112(sp)
80204854: 98 e9        	sd	a4, 16(a1)
80204856: 94 ed        	sd	a3, 24(a1)
80204858: 90 f1        	sd	a2, 32(a1)
8020485a: 88 f5        	sd	a0, 40(a1)
8020485c: ea 60        	ld	ra, 152(sp)
8020485e: 0d 61        	addi	sp, sp, 160
80204860: 82 80        	ret

0000000080204862 <.LBB0_7>:
80204862: 97 55 01 00  	auipc	a1, 21
80204866: 93 85 e5 82  	addi	a1, a1, -2002

000000008020486a <.LBB0_8>:
8020486a: 97 56 01 00  	auipc	a3, 21
8020486e: 93 86 66 83  	addi	a3, a3, -1994
80204872: 28 18        	addi	a0, sp, 56
80204874: 05 46        	addi	a2, zero, 1
80204876: 01 47        	mv	a4, zero
80204878: 97 00 00 00  	auipc	ra, 0
8020487c: e7 80 40 f8  	jalr	-124(ra)
80204880: 09 a0        	j	0x80204882 <.LBB0_9>

0000000080204882 <.LBB0_9>:
80204882: 97 55 01 00  	auipc	a1, 21
80204886: 93 85 e5 86  	addi	a1, a1, -1938
8020488a: 28 18        	addi	a0, sp, 56
8020488c: 97 00 00 00  	auipc	ra, 0
80204890: e7 80 c0 38  	jalr	908(ra)
80204894: 00 00        	unimp	

0000000080204896 <_ZN4core3ops8function6FnOnce9call_once17h62315c932c119d3fE>:
80204896: 08 61        	ld	a0, 0(a0)
80204898: 01 a0        	j	0x80204898 <_ZN4core3ops8function6FnOnce9call_once17h62315c932c119d3fE+0x2>

000000008020489a <_ZN4core3ptr102drop_in_place$LT$$RF$core..iter..adapters..copied..Copied$LT$core..slice..iter..Iter$LT$u8$GT$$GT$$GT$17h7c56be6ec9fbc1b7E>:
8020489a: 82 80        	ret

000000008020489c <_ZN71_$LT$core..ops..range..Range$LT$Idx$GT$$u20$as$u20$core..fmt..Debug$GT$3fmt17hbbc55e93ff1a4c5dE>:
8020489c: 5d 71        	addi	sp, sp, -80
8020489e: 86 e4        	sd	ra, 72(sp)
802048a0: a2 e0        	sd	s0, 64(sp)
802048a2: 26 fc        	sd	s1, 56(sp)
802048a4: 2e 84        	mv	s0, a1
802048a6: aa 84        	mv	s1, a0
802048a8: 97 20 00 00  	auipc	ra, 2
802048ac: e7 80 00 c8  	jalr	-896(ra)
802048b0: 1d e5        	bnez	a0, 0x802048de <.LBB70_5+0x18>
802048b2: 08 70        	ld	a0, 32(s0)
802048b4: 0c 74        	ld	a1, 40(s0)

00000000802048b6 <.LBB70_4>:
802048b6: 17 56 01 00  	auipc	a2, 21
802048ba: 13 06 26 9b  	addi	a2, a2, -1614
802048be: 32 e4        	sd	a2, 8(sp)
802048c0: 05 46        	addi	a2, zero, 1
802048c2: 32 e8        	sd	a2, 16(sp)
802048c4: 02 ec        	sd	zero, 24(sp)

00000000802048c6 <.LBB70_5>:
802048c6: 17 56 01 00  	auipc	a2, 21
802048ca: 13 06 a6 99  	addi	a2, a2, -1638
802048ce: 32 f4        	sd	a2, 40(sp)
802048d0: 02 f8        	sd	zero, 48(sp)
802048d2: 30 00        	addi	a2, sp, 8
802048d4: 97 10 00 00  	auipc	ra, 1
802048d8: e7 80 c0 b0  	jalr	-1268(ra)
802048dc: 19 c5        	beqz	a0, 0x802048ea <.LBB70_5+0x24>
802048de: 05 45        	addi	a0, zero, 1
802048e0: e2 74        	ld	s1, 56(sp)
802048e2: 06 64        	ld	s0, 64(sp)
802048e4: a6 60        	ld	ra, 72(sp)
802048e6: 61 61        	addi	sp, sp, 80
802048e8: 82 80        	ret
802048ea: 13 85 84 00  	addi	a0, s1, 8
802048ee: a2 85        	mv	a1, s0
802048f0: e2 74        	ld	s1, 56(sp)
802048f2: 06 64        	ld	s0, 64(sp)
802048f4: a6 60        	ld	ra, 72(sp)
802048f6: 61 61        	addi	sp, sp, 80
802048f8: 17 23 00 00  	auipc	t1, 2
802048fc: 67 00 03 c3  	jr	-976(t1)

0000000080204900 <_ZN36_$LT$T$u20$as$u20$core..any..Any$GT$7type_id17h64b4d1347a0a9ba1E>:
80204900: 37 45 b6 ff  	lui	a0, 1047396
80204904: 1b 05 b5 33  	addiw	a0, a0, 827
80204908: 3a 05        	slli	a0, a0, 14
8020490a: 13 05 95 f7  	addi	a0, a0, -135
8020490e: 3a 05        	slli	a0, a0, 14
80204910: 13 05 d5 8f  	addi	a0, a0, -1795
80204914: 32 05        	slli	a0, a0, 12
80204916: 13 05 15 e7  	addi	a0, a0, -399
8020491a: 82 80        	ret

000000008020491c <_ZN63_$LT$core..cell..BorrowMutError$u20$as$u20$core..fmt..Debug$GT$3fmt17h6df79664f3eccef2E>:
8020491c: 90 75        	ld	a2, 40(a1)
8020491e: 88 71        	ld	a0, 32(a1)
80204920: 1c 6e        	ld	a5, 24(a2)

0000000080204922 <.LBB84_1>:
80204922: 97 55 01 00  	auipc	a1, 21
80204926: 93 85 65 95  	addi	a1, a1, -1706
8020492a: 39 46        	addi	a2, zero, 14
8020492c: 82 87        	jr	a5

000000008020492e <_ZN4core4char7methods22_$LT$impl$u20$char$GT$16escape_debug_ext17h0701e2af8f592463E>:
8020492e: 01 11        	addi	sp, sp, -32
80204930: 06 ec        	sd	ra, 24(sp)
80204932: 22 e8        	sd	s0, 16(sp)
80204934: 26 e4        	sd	s1, 8(sp)
80204936: 4a e0        	sd	s2, 0(sp)
80204938: 2e 89        	mv	s2, a1
8020493a: 2a 84        	mv	s0, a0
8020493c: 9b 84 05 00  	sext.w	s1, a1
80204940: 93 85 74 ff  	addi	a1, s1, -9
80204944: f9 46        	addi	a3, zero, 30
80204946: 09 45        	addi	a0, zero, 2
80204948: 63 ef b6 00  	bltu	a3, a1, 0x80204966 <.LBB91_2+0x6>
8020494c: 8e 05        	slli	a1, a1, 3

000000008020494e <.LBB91_20>:
8020494e: 97 46 01 00  	auipc	a3, 20
80204952: 93 86 a6 7b  	addi	a3, a3, 1978
80204956: b6 95        	add	a1, a1, a3
80204958: 9c 61        	ld	a5, 0(a1)
8020495a: 93 05 40 07  	addi	a1, zero, 116
8020495e: 82 87        	jr	a5

0000000080204960 <.LBB91_2>:
80204960: 93 05 e0 06  	addi	a1, zero, 110
80204964: 45 a8        	j	0x80204a14 <.LBB91_26+0x26>
80204966: 93 05 c0 05  	addi	a1, zero, 92
8020496a: 63 9f b4 00  	bne	s1, a1, 0x80204988 <.LBB91_8>
8020496e: 5d a0        	j	0x80204a14 <.LBB91_26+0x26>

0000000080204970 <.LBB91_4>:
80204970: 93 05 20 07  	addi	a1, zero, 114
80204974: 45 a0        	j	0x80204a14 <.LBB91_26+0x26>

0000000080204976 <.LBB91_5>:
80204976: c1 65        	lui	a1, 16
80204978: f1 8d        	and	a1, a1, a2
8020497a: 99 c5        	beqz	a1, 0x80204988 <.LBB91_8>
8020497c: 93 05 20 02  	addi	a1, zero, 34
80204980: 51 a8        	j	0x80204a14 <.LBB91_26+0x26>

0000000080204982 <.LBB91_7>:
80204982: 93 75 06 10  	andi	a1, a2, 256
80204986: c9 e5        	bnez	a1, 0x80204a10 <.LBB91_26+0x22>

0000000080204988 <.LBB91_8>:
80204988: 13 75 16 00  	andi	a0, a2, 1
8020498c: 01 c9        	beqz	a0, 0x8020499c <.LBB91_8+0x14>
8020498e: 4a 85        	mv	a0, s2
80204990: 97 20 00 00  	auipc	ra, 2
80204994: e7 80 a0 fd  	jalr	-38(ra)
80204998: 63 17 05 12  	bnez	a0, 0x80204ac6 <.LBB91_26+0xd8>
8020499c: 1b 55 09 01  	srliw	a0, s2, 16
802049a0: 05 ed        	bnez	a0, 0x802049d8 <.LBB91_23+0x26>

00000000802049a2 <.LBB91_21>:
802049a2: 97 55 01 00  	auipc	a1, 21
802049a6: 93 85 e5 fd  	addi	a1, a1, -34

00000000802049aa <.LBB91_22>:
802049aa: 97 56 01 00  	auipc	a3, 21
802049ae: 93 86 66 02  	addi	a3, a3, 38

00000000802049b2 <.LBB91_23>:
802049b2: 97 57 01 00  	auipc	a5, 21
802049b6: 93 87 e7 13  	addi	a5, a5, 318
802049ba: 13 06 80 02  	addi	a2, zero, 40
802049be: 13 07 00 12  	addi	a4, zero, 288
802049c2: 13 08 f0 12  	addi	a6, zero, 303
802049c6: 4a 85        	mv	a0, s2
802049c8: 97 20 00 00  	auipc	ra, 2
802049cc: e7 80 60 85  	jalr	-1962(ra)
802049d0: 7d c9        	beqz	a0, 0x80204ac6 <.LBB91_26+0xd8>
802049d2: 05 45        	addi	a0, zero, 1
802049d4: ca 85        	mv	a1, s2
802049d6: 3d a8        	j	0x80204a14 <.LBB91_26+0x26>
802049d8: 1b 55 19 01  	srliw	a0, s2, 17
802049dc: 0d ed        	bnez	a0, 0x80204a16 <.LBB91_26+0x28>

00000000802049de <.LBB91_24>:
802049de: 97 55 01 00  	auipc	a1, 21
802049e2: 93 85 15 24  	addi	a1, a1, 577

00000000802049e6 <.LBB91_25>:
802049e6: 97 56 01 00  	auipc	a3, 21
802049ea: 93 86 d6 28  	addi	a3, a3, 653

00000000802049ee <.LBB91_26>:
802049ee: 97 57 01 00  	auipc	a5, 21
802049f2: 93 87 57 34  	addi	a5, a5, 837
802049f6: 13 06 a0 02  	addi	a2, zero, 42
802049fa: 13 07 00 0c  	addi	a4, zero, 192
802049fe: 13 08 60 1b  	addi	a6, zero, 438
80204a02: 4a 85        	mv	a0, s2
80204a04: 97 20 00 00  	auipc	ra, 2
80204a08: e7 80 a0 81  	jalr	-2022(ra)
80204a0c: 79 f1        	bnez	a0, 0x802049d2 <.LBB91_23+0x20>
80204a0e: 65 a8        	j	0x80204ac6 <.LBB91_26+0xd8>
80204a10: 93 05 70 02  	addi	a1, zero, 39
80204a14: 41 a2        	j	0x80204b94 <.LBB91_19>
80204a16: 37 05 20 00  	lui	a0, 512
80204a1a: 01 35        	addiw	a0, a0, -32
80204a1c: b3 75 a9 00  	and	a1, s2, a0
80204a20: 37 a6 02 00  	lui	a2, 42
80204a24: 1b 06 06 6e  	addiw	a2, a2, 1760
80204a28: b1 8d        	xor	a1, a1, a2
80204a2a: b3 35 b0 00  	snez	a1, a1
80204a2e: 37 56 fd ff  	lui	a2, 1048533
80204a32: 1b 06 76 8c  	addiw	a2, a2, -1849
80204a36: 3b 06 c9 00  	addw	a2, s2, a2
80204a3a: 99 46        	addi	a3, zero, 6
80204a3c: 33 b6 c6 00  	sltu	a2, a3, a2
80204a40: f1 8d        	and	a1, a1, a2
80204a42: 13 65 e5 01  	ori	a0, a0, 30
80204a46: 33 75 a9 00  	and	a0, s2, a0
80204a4a: 37 c6 02 00  	lui	a2, 44
80204a4e: 1b 06 e6 81  	addiw	a2, a2, -2018
80204a52: 31 8d        	xor	a0, a0, a2
80204a54: 33 35 a0 00  	snez	a0, a0
80204a58: 6d 8d        	and	a0, a0, a1
80204a5a: b7 35 fd ff  	lui	a1, 1048531
80204a5e: 9b 85 e5 15  	addiw	a1, a1, 350
80204a62: bb 05 b9 00  	addw	a1, s2, a1
80204a66: 35 46        	addi	a2, zero, 13
80204a68: b3 35 b6 00  	sltu	a1, a2, a1
80204a6c: 6d 8d        	and	a0, a0, a1
80204a6e: b7 15 fd ff  	lui	a1, 1048529
80204a72: 9b 85 f5 41  	addiw	a1, a1, 1055
80204a76: bb 05 b9 00  	addw	a1, s2, a1
80204a7a: 05 66        	lui	a2, 1
80204a7c: 1b 06 e6 c1  	addiw	a2, a2, -994
80204a80: b3 35 b6 00  	sltu	a1, a2, a1
80204a84: 6d 8d        	and	a0, a0, a1
80204a86: b7 05 fd ff  	lui	a1, 1048528
80204a8a: 9b 85 25 5e  	addiw	a1, a1, 1506
80204a8e: bb 05 b9 00  	addw	a1, s2, a1
80204a92: 13 06 10 5e  	addi	a2, zero, 1505
80204a96: b3 35 b6 00  	sltu	a1, a2, a1
80204a9a: 6d 8d        	and	a0, a0, a1
80204a9c: b7 f5 fc ff  	lui	a1, 1048527
80204aa0: 9b 85 55 cb  	addiw	a1, a1, -843
80204aa4: bb 05 b9 00  	addw	a1, s2, a1
80204aa8: 37 f6 0a 00  	lui	a2, 175
80204aac: 1b 06 46 db  	addiw	a2, a2, -588
80204ab0: b3 35 b6 00  	sltu	a1, a2, a1
80204ab4: 6d 8d        	and	a0, a0, a1
80204ab6: b7 05 0e 00  	lui	a1, 224
80204aba: 9b 85 05 1f  	addiw	a1, a1, 496
80204abe: b3 b5 b4 00  	sltu	a1, s1, a1
80204ac2: 6d 8d        	and	a0, a0, a1
80204ac4: 19 f5        	bnez	a0, 0x802049d2 <.LBB91_23+0x20>
80204ac6: 13 65 19 00  	ori	a0, s2, 1
80204aca: 93 15 05 02  	slli	a1, a0, 32
80204ace: 81 91        	srli	a1, a1, 32
80204ad0: 1b 55 15 00  	srliw	a0, a0, 1
80204ad4: 4d 8d        	or	a0, a0, a1
80204ad6: 93 55 25 00  	srli	a1, a0, 2
80204ada: 4d 8d        	or	a0, a0, a1
80204adc: 93 55 45 00  	srli	a1, a0, 4
80204ae0: 4d 8d        	or	a0, a0, a1
80204ae2: 93 55 85 00  	srli	a1, a0, 8
80204ae6: 4d 8d        	or	a0, a0, a1
80204ae8: 93 55 05 01  	srli	a1, a0, 16
80204aec: 4d 8d        	or	a0, a0, a1
80204aee: 93 55 05 02  	srli	a1, a0, 32
80204af2: 4d 8d        	or	a0, a0, a1
80204af4: 13 45 f5 ff  	not	a0, a0
80204af8: 93 55 15 00  	srli	a1, a0, 1
80204afc: 37 56 55 05  	lui	a2, 21845
80204b00: 1b 06 56 55  	addiw	a2, a2, 1365
80204b04: 32 06        	slli	a2, a2, 12
80204b06: 13 06 56 55  	addi	a2, a2, 1365
80204b0a: 32 06        	slli	a2, a2, 12
80204b0c: 13 06 56 55  	addi	a2, a2, 1365
80204b10: 32 06        	slli	a2, a2, 12
80204b12: 13 06 56 55  	addi	a2, a2, 1365
80204b16: f1 8d        	and	a1, a1, a2
80204b18: 0d 8d        	sub	a0, a0, a1
80204b1a: b7 35 33 03  	lui	a1, 13107
80204b1e: 9b 85 35 33  	addiw	a1, a1, 819
80204b22: b2 05        	slli	a1, a1, 12
80204b24: 93 85 35 33  	addi	a1, a1, 819
80204b28: b2 05        	slli	a1, a1, 12
80204b2a: 93 85 35 33  	addi	a1, a1, 819
80204b2e: b2 05        	slli	a1, a1, 12
80204b30: 93 85 35 33  	addi	a1, a1, 819
80204b34: 33 76 b5 00  	and	a2, a0, a1
80204b38: 09 81        	srli	a0, a0, 2
80204b3a: 6d 8d        	and	a0, a0, a1
80204b3c: 32 95        	add	a0, a0, a2
80204b3e: 93 55 45 00  	srli	a1, a0, 4
80204b42: 2e 95        	add	a0, a0, a1
80204b44: b7 f5 f0 00  	lui	a1, 3855
80204b48: 9b 85 15 0f  	addiw	a1, a1, 241
80204b4c: b2 05        	slli	a1, a1, 12
80204b4e: 93 85 f5 f0  	addi	a1, a1, -241
80204b52: b2 05        	slli	a1, a1, 12
80204b54: 93 85 15 0f  	addi	a1, a1, 241
80204b58: b2 05        	slli	a1, a1, 12
80204b5a: 93 85 f5 f0  	addi	a1, a1, -241
80204b5e: 6d 8d        	and	a0, a0, a1
80204b60: b7 05 01 01  	lui	a1, 4112
80204b64: 9b 85 15 10  	addiw	a1, a1, 257
80204b68: c2 05        	slli	a1, a1, 16
80204b6a: 93 85 15 10  	addi	a1, a1, 257
80204b6e: c2 05        	slli	a1, a1, 16
80204b70: 93 85 15 10  	addi	a1, a1, 257
80204b74: 33 05 b5 02  	mul	a0, a0, a1
80204b78: 61 91        	srli	a0, a0, 56
80204b7a: 01 15        	addi	a0, a0, -32
80204b7c: 1b 55 25 00  	srliw	a0, a0, 2
80204b80: 93 46 75 00  	xori	a3, a0, 7
80204b84: 13 15 09 02  	slli	a0, s2, 32
80204b88: 01 91        	srli	a0, a0, 32
80204b8a: 95 45        	addi	a1, zero, 5
80204b8c: 82 15        	slli	a1, a1, 32
80204b8e: 33 67 b5 00  	or	a4, a0, a1
80204b92: 0d 45        	addi	a0, zero, 3

0000000080204b94 <.LBB91_19>:
80204b94: 08 c0        	sw	a0, 0(s0)
80204b96: 4c c0        	sw	a1, 4(s0)
80204b98: 14 e4        	sd	a3, 8(s0)
80204b9a: 18 e8        	sd	a4, 16(s0)
80204b9c: 02 69        	ld	s2, 0(sp)
80204b9e: a2 64        	ld	s1, 8(sp)
80204ba0: 42 64        	ld	s0, 16(sp)
80204ba2: e2 60        	ld	ra, 24(sp)
80204ba4: 05 61        	addi	sp, sp, 32
80204ba6: 82 80        	ret

0000000080204ba8 <_ZN4core5panic10panic_info9PanicInfo7message17hf114ac5774a16881E>:
80204ba8: 08 69        	ld	a0, 16(a0)
80204baa: 82 80        	ret

0000000080204bac <_ZN4core9panicking5panic17hd7354f430b03c620E>:
80204bac: 5d 71        	addi	sp, sp, -80
80204bae: 86 e4        	sd	ra, 72(sp)
80204bb0: 2a fc        	sd	a0, 56(sp)
80204bb2: ae e0        	sd	a1, 64(sp)
80204bb4: 28 18        	addi	a0, sp, 56
80204bb6: 2a e4        	sd	a0, 8(sp)
80204bb8: 05 45        	addi	a0, zero, 1
80204bba: 2a e8        	sd	a0, 16(sp)
80204bbc: 02 ec        	sd	zero, 24(sp)

0000000080204bbe <.LBB127_1>:
80204bbe: 17 45 01 00  	auipc	a0, 20
80204bc2: 13 05 25 6a  	addi	a0, a0, 1698
80204bc6: 2a f4        	sd	a0, 40(sp)
80204bc8: 02 f8        	sd	zero, 48(sp)
80204bca: 28 00        	addi	a0, sp, 8
80204bcc: b2 85        	mv	a1, a2
80204bce: 97 00 00 00  	auipc	ra, 0
80204bd2: e7 80 a0 04  	jalr	74(ra)
80204bd6: 00 00        	unimp	

0000000080204bd8 <_ZN4core9panicking18panic_bounds_check17h03066feb67732875E>:
80204bd8: 59 71        	addi	sp, sp, -112
80204bda: 86 f4        	sd	ra, 104(sp)
80204bdc: 2a e4        	sd	a0, 8(sp)
80204bde: 2e e8        	sd	a1, 16(sp)
80204be0: 08 08        	addi	a0, sp, 16
80204be2: aa e4        	sd	a0, 72(sp)

0000000080204be4 <.LBB130_1>:
80204be4: 17 25 00 00  	auipc	a0, 2
80204be8: 13 05 85 bb  	addi	a0, a0, -1096
80204bec: aa e8        	sd	a0, 80(sp)
80204bee: 2c 00        	addi	a1, sp, 8
80204bf0: ae ec        	sd	a1, 88(sp)
80204bf2: aa f0        	sd	a0, 96(sp)

0000000080204bf4 <.LBB130_2>:
80204bf4: 17 45 01 00  	auipc	a0, 20
80204bf8: 13 05 c5 76  	addi	a0, a0, 1900
80204bfc: 2a ec        	sd	a0, 24(sp)
80204bfe: 09 45        	addi	a0, zero, 2
80204c00: 2a f0        	sd	a0, 32(sp)
80204c02: 02 f4        	sd	zero, 40(sp)
80204c04: ac 00        	addi	a1, sp, 72
80204c06: 2e fc        	sd	a1, 56(sp)
80204c08: aa e0        	sd	a0, 64(sp)
80204c0a: 28 08        	addi	a0, sp, 24
80204c0c: b2 85        	mv	a1, a2
80204c0e: 97 00 00 00  	auipc	ra, 0
80204c12: e7 80 a0 00  	jalr	10(ra)
80204c16: 00 00        	unimp	

0000000080204c18 <_ZN4core9panicking9panic_fmt17h45fb94bbefa288a1E>:
80204c18: 79 71        	addi	sp, sp, -48
80204c1a: 06 f4        	sd	ra, 40(sp)

0000000080204c1c <.LBB132_1>:
80204c1c: 17 46 01 00  	auipc	a2, 20
80204c20: 13 06 46 64  	addi	a2, a2, 1604
80204c24: 32 e0        	sd	a2, 0(sp)

0000000080204c26 <.LBB132_2>:
80204c26: 17 46 01 00  	auipc	a2, 20
80204c2a: 13 06 26 6a  	addi	a2, a2, 1698
80204c2e: 32 e4        	sd	a2, 8(sp)
80204c30: 2a e8        	sd	a0, 16(sp)
80204c32: 2e ec        	sd	a1, 24(sp)
80204c34: 05 45        	addi	a0, zero, 1
80204c36: 23 00 a1 02  	sb	a0, 32(sp)
80204c3a: 0a 85        	mv	a0, sp
80204c3c: 97 c0 ff ff  	auipc	ra, 1048572
80204c40: e7 80 20 a5  	jalr	-1454(ra)
80204c44: 00 00        	unimp	

0000000080204c46 <_ZN4core6result13unwrap_failed17ha7517b14cec7e91bE>:
80204c46: 19 71        	addi	sp, sp, -128
80204c48: 86 fc        	sd	ra, 120(sp)
80204c4a: 2a e4        	sd	a0, 8(sp)
80204c4c: 2e e8        	sd	a1, 16(sp)
80204c4e: 32 ec        	sd	a2, 24(sp)
80204c50: 36 f0        	sd	a3, 32(sp)
80204c52: 28 00        	addi	a0, sp, 8
80204c54: aa ec        	sd	a0, 88(sp)

0000000080204c56 <.LBB137_1>:
80204c56: 17 25 00 00  	auipc	a0, 2
80204c5a: 13 05 c5 c4  	addi	a0, a0, -948
80204c5e: aa f0        	sd	a0, 96(sp)
80204c60: 28 08        	addi	a0, sp, 24
80204c62: aa f4        	sd	a0, 104(sp)

0000000080204c64 <.LBB137_2>:
80204c64: 17 25 00 00  	auipc	a0, 2
80204c68: 13 05 85 b5  	addi	a0, a0, -1192
80204c6c: aa f8        	sd	a0, 112(sp)

0000000080204c6e <.LBB137_3>:
80204c6e: 17 45 01 00  	auipc	a0, 20
80204c72: 13 05 a5 71  	addi	a0, a0, 1818
80204c76: 2a f4        	sd	a0, 40(sp)
80204c78: 09 45        	addi	a0, zero, 2
80204c7a: 2a f8        	sd	a0, 48(sp)
80204c7c: 02 fc        	sd	zero, 56(sp)
80204c7e: ac 08        	addi	a1, sp, 88
80204c80: ae e4        	sd	a1, 72(sp)
80204c82: aa e8        	sd	a0, 80(sp)
80204c84: 28 10        	addi	a0, sp, 40
80204c86: ba 85        	mv	a1, a4
80204c88: 97 00 00 00  	auipc	ra, 0
80204c8c: e7 80 00 f9  	jalr	-112(ra)
80204c90: 00 00        	unimp	

0000000080204c92 <_ZN68_$LT$core..fmt..builders..PadAdapter$u20$as$u20$core..fmt..Write$GT$9write_str17h4fe0201cceaaebb7E>:
80204c92: 59 71        	addi	sp, sp, -112
80204c94: 86 f4        	sd	ra, 104(sp)
80204c96: a2 f0        	sd	s0, 96(sp)
80204c98: a6 ec        	sd	s1, 88(sp)
80204c9a: ca e8        	sd	s2, 80(sp)
80204c9c: ce e4        	sd	s3, 72(sp)
80204c9e: d2 e0        	sd	s4, 64(sp)
80204ca0: 56 fc        	sd	s5, 56(sp)
80204ca2: 5a f8        	sd	s6, 48(sp)
80204ca4: 5e f4        	sd	s7, 40(sp)
80204ca6: 62 f0        	sd	s8, 32(sp)
80204ca8: 66 ec        	sd	s9, 24(sp)
80204caa: 6a e8        	sd	s10, 16(sp)
80204cac: 6e e4        	sd	s11, 8(sp)
80204cae: 63 08 06 1c  	beqz	a2, 0x80204e7e <.LBB139_46+0x1a>
80204cb2: b2 8c        	mv	s9, a2
80204cb4: ae 89        	mv	s3, a1
80204cb6: 03 3a 05 01  	ld	s4, 16(a0)
80204cba: 03 39 05 00  	ld	s2, 0(a0)
80204cbe: 00 65        	ld	s0, 8(a0)
80204cc0: 37 05 ff fe  	lui	a0, 1044464
80204cc4: 1b 05 f5 ef  	addiw	a0, a0, -257
80204cc8: 42 05        	slli	a0, a0, 16
80204cca: 13 05 f5 ef  	addi	a0, a0, -257
80204cce: 42 05        	slli	a0, a0, 16
80204cd0: 93 0b f5 ef  	addi	s7, a0, -257
80204cd4: 37 15 10 f0  	lui	a0, 983297
80204cd8: 12 05        	slli	a0, a0, 4
80204cda: 13 05 15 10  	addi	a0, a0, 257
80204cde: 42 05        	slli	a0, a0, 16
80204ce0: 13 05 15 10  	addi	a0, a0, 257
80204ce4: 3e 05        	slli	a0, a0, 15
80204ce6: 13 0c 05 08  	addi	s8, a0, 128
80204cea: 37 55 50 50  	lui	a0, 328965
80204cee: 12 05        	slli	a0, a0, 4
80204cf0: 13 05 55 50  	addi	a0, a0, 1285
80204cf4: 36 05        	slli	a0, a0, 13
80204cf6: 13 05 15 0a  	addi	a0, a0, 161
80204cfa: 32 05        	slli	a0, a0, 12
80204cfc: 13 0d a5 a0  	addi	s10, a0, -1526
80204d00: c1 44        	addi	s1, zero, 16
80204d02: a9 4a        	addi	s5, zero, 10
80204d04: 31 a0        	j	0x80204d10 <_ZN68_$LT$core..fmt..builders..PadAdapter$u20$as$u20$core..fmt..Write$GT$9write_str17h4fe0201cceaaebb7E+0x7e>
80204d06: b3 8c 6c 41  	sub	s9, s9, s6
80204d0a: da 99        	add	s3, s3, s6
80204d0c: 63 89 0c 16  	beqz	s9, 0x80204e7e <.LBB139_46+0x1a>
80204d10: 03 45 0a 00  	lbu	a0, 0(s4)
80204d14: 19 c9        	beqz	a0, 0x80204d2a <.LBB139_45+0x12>
80204d16: 14 6c        	ld	a3, 24(s0)

0000000080204d18 <.LBB139_45>:
80204d18: 97 45 01 00  	auipc	a1, 20
80204d1c: 93 85 e5 56  	addi	a1, a1, 1390
80204d20: 11 46        	addi	a2, zero, 4
80204d22: 4a 85        	mv	a0, s2
80204d24: 82 96        	jalr	a3
80204d26: 63 1e 05 14  	bnez	a0, 0x80204e82 <.LBB139_46+0x1e>
80204d2a: 01 4b        	mv	s6, zero
80204d2c: e6 85        	mv	a1, s9
80204d2e: 21 a0        	j	0x80204d36 <.LBB139_45+0x1e>
80204d30: b3 85 6c 41  	sub	a1, s9, s6
80204d34: 75 ed        	bnez	a0, 0x80204e30 <.LBB139_45+0x118>
80204d36: 33 86 69 01  	add	a2, s3, s6
80204d3a: 63 fe 95 00  	bgeu	a1, s1, 0x80204d56 <.LBB139_45+0x3e>
80204d3e: ed c9        	beqz	a1, 0x80204e30 <.LBB139_45+0x118>
80204d40: 81 46        	mv	a3, zero
80204d42: 33 05 d6 00  	add	a0, a2, a3
80204d46: 03 45 05 00  	lbu	a0, 0(a0)
80204d4a: 63 05 55 0b  	beq	a0, s5, 0x80204df4 <.LBB139_45+0xdc>
80204d4e: 85 06        	addi	a3, a3, 1
80204d50: e3 99 d5 fe  	bne	a1, a3, 0x80204d42 <.LBB139_45+0x2a>
80204d54: f1 a8        	j	0x80204e30 <.LBB139_45+0x118>
80204d56: 13 05 76 00  	addi	a0, a2, 7
80204d5a: 61 99        	andi	a0, a0, -8
80204d5c: b3 06 c5 40  	sub	a3, a0, a2
80204d60: 95 c6        	beqz	a3, 0x80204d8c <.LBB139_45+0x74>
80204d62: 2e 85        	mv	a0, a1
80204d64: 63 e3 d5 00  	bltu	a1, a3, 0x80204d6a <.LBB139_45+0x52>
80204d68: 36 85        	mv	a0, a3
80204d6a: 81 46        	mv	a3, zero
80204d6c: 33 07 d6 00  	add	a4, a2, a3
80204d70: 03 47 07 00  	lbu	a4, 0(a4)
80204d74: 63 00 57 09  	beq	a4, s5, 0x80204df4 <.LBB139_45+0xdc>
80204d78: 85 06        	addi	a3, a3, 1
80204d7a: e3 19 d5 fe  	bne	a0, a3, 0x80204d6c <.LBB139_45+0x54>
80204d7e: 93 86 05 ff  	addi	a3, a1, -16
80204d82: 63 f8 a6 00  	bgeu	a3, a0, 0x80204d92 <.LBB139_45+0x7a>
80204d86: 63 16 b5 04  	bne	a0, a1, 0x80204dd2 <.LBB139_45+0xba>
80204d8a: 5d a0        	j	0x80204e30 <.LBB139_45+0x118>
80204d8c: 01 45        	mv	a0, zero
80204d8e: 93 86 05 ff  	addi	a3, a1, -16
80204d92: 22 88        	mv	a6, s0
80204d94: 33 07 a6 00  	add	a4, a2, a0
80204d98: 1c 63        	ld	a5, 0(a4)
80204d9a: 18 67        	ld	a4, 8(a4)
80204d9c: 13 c4 f7 ff  	not	s0, a5
80204da0: 93 44 f7 ff  	not	s1, a4
80204da4: b3 c7 a7 01  	xor	a5, a5, s10
80204da8: de 97        	add	a5, a5, s7
80204daa: 33 74 84 01  	and	s0, s0, s8
80204dae: e1 8f        	and	a5, a5, s0
80204db0: 33 47 a7 01  	xor	a4, a4, s10
80204db4: 5e 97        	add	a4, a4, s7
80204db6: b3 f4 84 01  	and	s1, s1, s8
80204dba: 65 8f        	and	a4, a4, s1
80204dbc: 5d 8f        	or	a4, a4, a5
80204dbe: 01 e7        	bnez	a4, 0x80204dc6 <.LBB139_45+0xae>
80204dc0: 41 05        	addi	a0, a0, 16
80204dc2: e3 f9 a6 fc  	bgeu	a3, a0, 0x80204d94 <.LBB139_45+0x7c>
80204dc6: 63 eb a5 0e  	bltu	a1, a0, 0x80204ebc <.LBB139_48>
80204dca: 42 84        	mv	s0, a6
80204dcc: c1 44        	addi	s1, zero, 16
80204dce: 63 01 b5 06  	beq	a0, a1, 0x80204e30 <.LBB139_45+0x118>
80204dd2: 01 46        	mv	a2, zero
80204dd4: b3 06 65 01  	add	a3, a0, s6
80204dd8: ce 96        	add	a3, a3, s3
80204dda: 89 8d        	sub	a1, a1, a0
80204ddc: 33 87 c6 00  	add	a4, a3, a2
80204de0: 03 47 07 00  	lbu	a4, 0(a4)
80204de4: 63 06 57 01  	beq	a4, s5, 0x80204df0 <.LBB139_45+0xd8>
80204de8: 05 06        	addi	a2, a2, 1
80204dea: e3 99 c5 fe  	bne	a1, a2, 0x80204ddc <.LBB139_45+0xc4>
80204dee: 89 a0        	j	0x80204e30 <.LBB139_45+0x118>
80204df0: b3 06 c5 00  	add	a3, a0, a2
80204df4: b3 85 66 01  	add	a1, a3, s6
80204df8: 13 8b 15 00  	addi	s6, a1, 1
80204dfc: 33 36 bb 00  	sltu	a2, s6, a1
80204e00: 33 b5 6c 01  	sltu	a0, s9, s6
80204e04: 49 8e        	or	a2, a2, a0
80204e06: 0d f6        	bnez	a2, 0x80204d30 <.LBB139_45+0x18>
80204e08: ce 95        	add	a1, a1, s3
80204e0a: 83 c5 05 00  	lbu	a1, 0(a1)
80204e0e: e3 91 55 f3  	bne	a1, s5, 0x80204d30 <.LBB139_45+0x18>
80204e12: 05 45        	addi	a0, zero, 1
80204e14: 23 00 aa 00  	sb	a0, 0(s4)
80204e18: 63 62 9b 03  	bltu	s6, s9, 0x80204e3c <.LBB139_45+0x124>
80204e1c: 63 93 6c 09  	bne	s9, s6, 0x80204ea2 <.LBB139_47>
80204e20: 14 6c        	ld	a3, 24(s0)
80204e22: 4a 85        	mv	a0, s2
80204e24: ce 85        	mv	a1, s3
80204e26: 5a 86        	mv	a2, s6
80204e28: 82 96        	jalr	a3
80204e2a: e3 0e 05 ec  	beqz	a0, 0x80204d06 <_ZN68_$LT$core..fmt..builders..PadAdapter$u20$as$u20$core..fmt..Write$GT$9write_str17h4fe0201cceaaebb7E+0x74>
80204e2e: 91 a8        	j	0x80204e82 <.LBB139_46+0x1e>
80204e30: 01 45        	mv	a0, zero
80204e32: 66 8b        	mv	s6, s9
80204e34: 23 00 aa 00  	sb	a0, 0(s4)
80204e38: e3 72 9b ff  	bgeu	s6, s9, 0x80204e1c <.LBB139_45+0x104>
80204e3c: b3 8d 69 01  	add	s11, s3, s6
80204e40: 03 85 0d 00  	lb	a0, 0(s11)
80204e44: 93 05 f0 fb  	addi	a1, zero, -65
80204e48: 63 dd a5 04  	bge	a1, a0, 0x80204ea2 <.LBB139_47>
80204e4c: 14 6c        	ld	a3, 24(s0)
80204e4e: 4a 85        	mv	a0, s2
80204e50: ce 85        	mv	a1, s3
80204e52: 5a 86        	mv	a2, s6
80204e54: 82 96        	jalr	a3
80204e56: 15 e5        	bnez	a0, 0x80204e82 <.LBB139_46+0x1e>
80204e58: 03 85 0d 00  	lb	a0, 0(s11)
80204e5c: 93 05 f0 fb  	addi	a1, zero, -65
80204e60: e3 c3 a5 ea  	blt	a1, a0, 0x80204d06 <_ZN68_$LT$core..fmt..builders..PadAdapter$u20$as$u20$core..fmt..Write$GT$9write_str17h4fe0201cceaaebb7E+0x74>

0000000080204e64 <.LBB139_46>:
80204e64: 17 47 01 00  	auipc	a4, 20
80204e68: 13 07 c7 58  	addi	a4, a4, 1420
80204e6c: 4e 85        	mv	a0, s3
80204e6e: e6 85        	mv	a1, s9
80204e70: 5a 86        	mv	a2, s6
80204e72: e6 86        	mv	a3, s9
80204e74: 97 10 00 00  	auipc	ra, 1
80204e78: e7 80 e0 15  	jalr	350(ra)
80204e7c: 00 00        	unimp	
80204e7e: 01 45        	mv	a0, zero
80204e80: 11 a0        	j	0x80204e84 <.LBB139_46+0x20>
80204e82: 05 45        	addi	a0, zero, 1
80204e84: a2 6d        	ld	s11, 8(sp)
80204e86: 42 6d        	ld	s10, 16(sp)
80204e88: e2 6c        	ld	s9, 24(sp)
80204e8a: 02 7c        	ld	s8, 32(sp)
80204e8c: a2 7b        	ld	s7, 40(sp)
80204e8e: 42 7b        	ld	s6, 48(sp)
80204e90: e2 7a        	ld	s5, 56(sp)
80204e92: 06 6a        	ld	s4, 64(sp)
80204e94: a6 69        	ld	s3, 72(sp)
80204e96: 46 69        	ld	s2, 80(sp)
80204e98: e6 64        	ld	s1, 88(sp)
80204e9a: 06 74        	ld	s0, 96(sp)
80204e9c: a6 70        	ld	ra, 104(sp)
80204e9e: 65 61        	addi	sp, sp, 112
80204ea0: 82 80        	ret

0000000080204ea2 <.LBB139_47>:
80204ea2: 17 47 01 00  	auipc	a4, 20
80204ea6: 13 07 67 53  	addi	a4, a4, 1334
80204eaa: 4e 85        	mv	a0, s3
80204eac: e6 85        	mv	a1, s9
80204eae: 01 46        	mv	a2, zero
80204eb0: da 86        	mv	a3, s6
80204eb2: 97 10 00 00  	auipc	ra, 1
80204eb6: e7 80 00 12  	jalr	288(ra)
80204eba: 00 00        	unimp	

0000000080204ebc <.LBB139_48>:
80204ebc: 17 46 01 00  	auipc	a2, 20
80204ec0: 13 06 c6 6b  	addi	a2, a2, 1724
80204ec4: 97 10 00 00  	auipc	ra, 1
80204ec8: e7 80 00 d9  	jalr	-624(ra)
80204ecc: 00 00        	unimp	

0000000080204ece <_ZN4core3fmt8builders11DebugStruct5field17h89ac2ff607588f4bE>:
80204ece: 71 71        	addi	sp, sp, -176
80204ed0: 06 f5        	sd	ra, 168(sp)
80204ed2: 22 f1        	sd	s0, 160(sp)
80204ed4: 26 ed        	sd	s1, 152(sp)
80204ed6: 4a e9        	sd	s2, 144(sp)
80204ed8: 4e e5        	sd	s3, 136(sp)
80204eda: 52 e1        	sd	s4, 128(sp)
80204edc: d6 fc        	sd	s5, 120(sp)
80204ede: da f8        	sd	s6, 112(sp)
80204ee0: de f4        	sd	s7, 104(sp)
80204ee2: 2a 84        	mv	s0, a0
80204ee4: 03 45 85 00  	lbu	a0, 8(a0)
80204ee8: 85 4b        	addi	s7, zero, 1
80204eea: 85 44        	addi	s1, zero, 1
80204eec: 0d c1        	beqz	a0, 0x80204f0e <_ZN4core3fmt8builders11DebugStruct5field17h89ac2ff607588f4bE+0x40>
80204eee: 23 04 94 00  	sb	s1, 8(s0)
80204ef2: a3 04 74 01  	sb	s7, 9(s0)
80204ef6: 22 85        	mv	a0, s0
80204ef8: a6 7b        	ld	s7, 104(sp)
80204efa: 46 7b        	ld	s6, 112(sp)
80204efc: e6 7a        	ld	s5, 120(sp)
80204efe: 0a 6a        	ld	s4, 128(sp)
80204f00: aa 69        	ld	s3, 136(sp)
80204f02: 4a 69        	ld	s2, 144(sp)
80204f04: ea 64        	ld	s1, 152(sp)
80204f06: 0a 74        	ld	s0, 160(sp)
80204f08: aa 70        	ld	ra, 168(sp)
80204f0a: 4d 61        	addi	sp, sp, 176
80204f0c: 82 80        	ret
80204f0e: ba 89        	mv	s3, a4
80204f10: 36 89        	mv	s2, a3
80204f12: 32 8a        	mv	s4, a2
80204f14: ae 8a        	mv	s5, a1
80204f16: 03 3b 04 00  	ld	s6, 0(s0)
80204f1a: 03 45 0b 03  	lbu	a0, 48(s6)
80204f1e: 83 45 94 00  	lbu	a1, 9(s0)
80204f22: 11 89        	andi	a0, a0, 4
80204f24: 13 b6 15 00  	seqz	a2, a1
80204f28: 19 e5        	bnez	a0, 0x80204f36 <.LBB140_17+0xa>
80204f2a: 4d ee        	bnez	a2, 0x80204fe4 <.LBB140_22>

0000000080204f2c <.LBB140_17>:
80204f2c: 97 45 01 00  	auipc	a1, 20
80204f30: 93 85 15 4e  	addi	a1, a1, 1249
80204f34: 65 a8        	j	0x80204fec <.LBB140_22+0x8>
80204f36: 11 ce        	beqz	a2, 0x80204f52 <.LBB140_18+0x10>
80204f38: 83 35 8b 02  	ld	a1, 40(s6)
80204f3c: 03 35 0b 02  	ld	a0, 32(s6)
80204f40: 94 6d        	ld	a3, 24(a1)

0000000080204f42 <.LBB140_18>:
80204f42: 97 45 01 00  	auipc	a1, 20
80204f46: 93 85 65 4c  	addi	a1, a1, 1222
80204f4a: 0d 46        	addi	a2, zero, 3
80204f4c: 82 96        	jalr	a3
80204f4e: 85 44        	addi	s1, zero, 1
80204f50: 59 fd        	bnez	a0, 0x80204eee <_ZN4core3fmt8builders11DebugStruct5field17h89ac2ff607588f4bE+0x20>
80204f52: 85 44        	addi	s1, zero, 1
80204f54: a3 03 91 02  	sb	s1, 39(sp)
80204f58: 03 35 0b 02  	ld	a0, 32(s6)
80204f5c: 83 35 8b 02  	ld	a1, 40(s6)
80204f60: 2a e4        	sd	a0, 8(sp)
80204f62: 2e e8        	sd	a1, 16(sp)
80204f64: 13 05 71 02  	addi	a0, sp, 39
80204f68: 2a ec        	sd	a0, 24(sp)
80204f6a: 03 35 0b 03  	ld	a0, 48(s6)
80204f6e: 83 05 8b 03  	lb	a1, 56(s6)
80204f72: 03 36 0b 00  	ld	a2, 0(s6)
80204f76: 83 36 8b 00  	ld	a3, 8(s6)
80204f7a: 03 37 0b 01  	ld	a4, 16(s6)
80204f7e: 83 37 8b 01  	ld	a5, 24(s6)
80204f82: aa ec        	sd	a0, 88(sp)
80204f84: 23 00 b1 06  	sb	a1, 96(sp)
80204f88: 32 f4        	sd	a2, 40(sp)
80204f8a: 36 f8        	sd	a3, 48(sp)
80204f8c: 3a fc        	sd	a4, 56(sp)
80204f8e: be e0        	sd	a5, 64(sp)
80204f90: 28 00        	addi	a0, sp, 8
80204f92: aa e4        	sd	a0, 72(sp)

0000000080204f94 <.LBB140_19>:
80204f94: 17 45 01 00  	auipc	a0, 20
80204f98: 13 05 45 41  	addi	a0, a0, 1044
80204f9c: aa e8        	sd	a0, 80(sp)
80204f9e: 28 00        	addi	a0, sp, 8
80204fa0: d6 85        	mv	a1, s5
80204fa2: 52 86        	mv	a2, s4
80204fa4: 97 00 00 00  	auipc	ra, 0
80204fa8: e7 80 e0 ce  	jalr	-786(ra)
80204fac: 29 f1        	bnez	a0, 0x80204eee <_ZN4core3fmt8builders11DebugStruct5field17h89ac2ff607588f4bE+0x20>

0000000080204fae <.LBB140_20>:
80204fae: 97 45 01 00  	auipc	a1, 20
80204fb2: 93 85 35 3d  	addi	a1, a1, 979
80204fb6: 28 00        	addi	a0, sp, 8
80204fb8: 09 46        	addi	a2, zero, 2
80204fba: 97 00 00 00  	auipc	ra, 0
80204fbe: e7 80 80 cd  	jalr	-808(ra)
80204fc2: 15 f5        	bnez	a0, 0x80204eee <_ZN4core3fmt8builders11DebugStruct5field17h89ac2ff607588f4bE+0x20>
80204fc4: 03 b6 89 01  	ld	a2, 24(s3)
80204fc8: 2c 10        	addi	a1, sp, 40
80204fca: 4a 85        	mv	a0, s2
80204fcc: 02 96        	jalr	a2
80204fce: 05 f1        	bnez	a0, 0x80204eee <_ZN4core3fmt8builders11DebugStruct5field17h89ac2ff607588f4bE+0x20>
80204fd0: c6 65        	ld	a1, 80(sp)
80204fd2: 26 65        	ld	a0, 72(sp)
80204fd4: 94 6d        	ld	a3, 24(a1)

0000000080204fd6 <.LBB140_21>:
80204fd6: 97 45 01 00  	auipc	a1, 20
80204fda: 93 85 55 43  	addi	a1, a1, 1077
80204fde: 09 46        	addi	a2, zero, 2
80204fe0: 82 96        	jalr	a3
80204fe2: b1 a8        	j	0x8020503e <.LBB140_23+0x1c>

0000000080204fe4 <.LBB140_22>:
80204fe4: 97 45 01 00  	auipc	a1, 20
80204fe8: 93 85 b5 42  	addi	a1, a1, 1067
80204fec: 83 36 8b 02  	ld	a3, 40(s6)
80204ff0: 03 35 0b 02  	ld	a0, 32(s6)
80204ff4: 94 6e        	ld	a3, 24(a3)
80204ff6: 13 66 26 00  	ori	a2, a2, 2
80204ffa: 82 96        	jalr	a3
80204ffc: 85 44        	addi	s1, zero, 1
80204ffe: e3 18 05 ee  	bnez	a0, 0x80204eee <_ZN4core3fmt8builders11DebugStruct5field17h89ac2ff607588f4bE+0x20>
80205002: 83 35 8b 02  	ld	a1, 40(s6)
80205006: 03 35 0b 02  	ld	a0, 32(s6)
8020500a: 94 6d        	ld	a3, 24(a1)
8020500c: d6 85        	mv	a1, s5
8020500e: 52 86        	mv	a2, s4
80205010: 82 96        	jalr	a3
80205012: 85 44        	addi	s1, zero, 1
80205014: e3 1d 05 ec  	bnez	a0, 0x80204eee <_ZN4core3fmt8builders11DebugStruct5field17h89ac2ff607588f4bE+0x20>
80205018: 83 35 8b 02  	ld	a1, 40(s6)
8020501c: 03 35 0b 02  	ld	a0, 32(s6)
80205020: 94 6d        	ld	a3, 24(a1)

0000000080205022 <.LBB140_23>:
80205022: 97 45 01 00  	auipc	a1, 20
80205026: 93 85 f5 35  	addi	a1, a1, 863
8020502a: 09 46        	addi	a2, zero, 2
8020502c: 82 96        	jalr	a3
8020502e: 85 44        	addi	s1, zero, 1
80205030: e3 1f 05 ea  	bnez	a0, 0x80204eee <_ZN4core3fmt8builders11DebugStruct5field17h89ac2ff607588f4bE+0x20>
80205034: 03 b6 89 01  	ld	a2, 24(s3)
80205038: 4a 85        	mv	a0, s2
8020503a: da 85        	mv	a1, s6
8020503c: 02 96        	jalr	a2
8020503e: aa 84        	mv	s1, a0
80205040: 7d b5        	j	0x80204eee <_ZN4core3fmt8builders11DebugStruct5field17h89ac2ff607588f4bE+0x20>

0000000080205042 <_ZN4core3fmt8builders10DebugTuple5field17h307cefd9e0dd5687E>:
80205042: 35 71        	addi	sp, sp, -160
80205044: 06 ed        	sd	ra, 152(sp)
80205046: 22 e9        	sd	s0, 144(sp)
80205048: 26 e5        	sd	s1, 136(sp)
8020504a: 4a e1        	sd	s2, 128(sp)
8020504c: ce fc        	sd	s3, 120(sp)
8020504e: d2 f8        	sd	s4, 112(sp)
80205050: d6 f4        	sd	s5, 104(sp)
80205052: 2a 84        	mv	s0, a0
80205054: 03 45 05 01  	lbu	a0, 16(a0)
80205058: 09 c5        	beqz	a0, 0x80205062 <_ZN4core3fmt8builders10DebugTuple5field17h307cefd9e0dd5687E+0x20>
8020505a: 83 3a 84 00  	ld	s5, 8(s0)
8020505e: 05 4a        	addi	s4, zero, 1
80205060: d1 a0        	j	0x80205124 <.LBB143_19+0x26>
80205062: b2 89        	mv	s3, a2
80205064: 2e 89        	mv	s2, a1
80205066: 04 60        	ld	s1, 0(s0)
80205068: 03 c5 04 03  	lbu	a0, 48(s1)
8020506c: 83 3a 84 00  	ld	s5, 8(s0)
80205070: 11 89        	andi	a0, a0, 4
80205072: 13 b6 1a 00  	seqz	a2, s5
80205076: 19 e5        	bnez	a0, 0x80205084 <.LBB143_15+0xa>
80205078: 59 e2        	bnez	a2, 0x802050fe <.LBB143_19>

000000008020507a <.LBB143_15>:
8020507a: 97 45 01 00  	auipc	a1, 20
8020507e: 93 85 35 39  	addi	a1, a1, 915
80205082: 51 a0        	j	0x80205106 <.LBB143_19+0x8>
80205084: 11 ce        	beqz	a2, 0x802050a0 <.LBB143_16+0x14>
80205086: 8c 74        	ld	a1, 40(s1)
80205088: 88 70        	ld	a0, 32(s1)
8020508a: 94 6d        	ld	a3, 24(a1)

000000008020508c <.LBB143_16>:
8020508c: 97 45 01 00  	auipc	a1, 20
80205090: 93 85 95 38  	addi	a1, a1, 905
80205094: 09 46        	addi	a2, zero, 2
80205096: 82 96        	jalr	a3
80205098: 01 c5        	beqz	a0, 0x802050a0 <.LBB143_16+0x14>
8020509a: 81 4a        	mv	s5, zero
8020509c: 05 4a        	addi	s4, zero, 1
8020509e: 59 a0        	j	0x80205124 <.LBB143_19+0x26>
802050a0: 05 4a        	addi	s4, zero, 1
802050a2: a3 03 41 03  	sb	s4, 39(sp)
802050a6: 88 70        	ld	a0, 32(s1)
802050a8: 8c 74        	ld	a1, 40(s1)
802050aa: 2a e4        	sd	a0, 8(sp)
802050ac: 2e e8        	sd	a1, 16(sp)
802050ae: 13 05 71 02  	addi	a0, sp, 39
802050b2: 2a ec        	sd	a0, 24(sp)
802050b4: 88 78        	ld	a0, 48(s1)
802050b6: 83 85 84 03  	lb	a1, 56(s1)
802050ba: 90 60        	ld	a2, 0(s1)
802050bc: 94 64        	ld	a3, 8(s1)
802050be: 98 68        	ld	a4, 16(s1)
802050c0: 9c 6c        	ld	a5, 24(s1)
802050c2: aa ec        	sd	a0, 88(sp)
802050c4: 23 00 b1 06  	sb	a1, 96(sp)
802050c8: 32 f4        	sd	a2, 40(sp)
802050ca: 36 f8        	sd	a3, 48(sp)
802050cc: 3a fc        	sd	a4, 56(sp)
802050ce: be e0        	sd	a5, 64(sp)
802050d0: 28 00        	addi	a0, sp, 8
802050d2: 03 b6 89 01  	ld	a2, 24(s3)
802050d6: aa e4        	sd	a0, 72(sp)

00000000802050d8 <.LBB143_17>:
802050d8: 17 45 01 00  	auipc	a0, 20
802050dc: 13 05 05 2d  	addi	a0, a0, 720
802050e0: aa e8        	sd	a0, 80(sp)
802050e2: 2c 10        	addi	a1, sp, 40
802050e4: 4a 85        	mv	a0, s2
802050e6: 02 96        	jalr	a2
802050e8: 15 ed        	bnez	a0, 0x80205124 <.LBB143_19+0x26>
802050ea: c6 65        	ld	a1, 80(sp)
802050ec: 26 65        	ld	a0, 72(sp)
802050ee: 94 6d        	ld	a3, 24(a1)

00000000802050f0 <.LBB143_18>:
802050f0: 97 45 01 00  	auipc	a1, 20
802050f4: 93 85 b5 31  	addi	a1, a1, 795
802050f8: 09 46        	addi	a2, zero, 2
802050fa: 82 96        	jalr	a3
802050fc: 1d a0        	j	0x80205122 <.LBB143_19+0x24>

00000000802050fe <.LBB143_19>:
802050fe: 97 45 01 00  	auipc	a1, 20
80205102: 93 85 95 31  	addi	a1, a1, 793
80205106: 94 74        	ld	a3, 40(s1)
80205108: 88 70        	ld	a0, 32(s1)
8020510a: 94 6e        	ld	a3, 24(a3)
8020510c: 09 47        	addi	a4, zero, 2
8020510e: 33 06 c7 40  	sub	a2, a4, a2
80205112: 82 96        	jalr	a3
80205114: 05 4a        	addi	s4, zero, 1
80205116: 19 e5        	bnez	a0, 0x80205124 <.LBB143_19+0x26>
80205118: 03 b6 89 01  	ld	a2, 24(s3)
8020511c: 4a 85        	mv	a0, s2
8020511e: a6 85        	mv	a1, s1
80205120: 02 96        	jalr	a2
80205122: 2a 8a        	mv	s4, a0
80205124: 23 08 44 01  	sb	s4, 16(s0)
80205128: 13 85 1a 00  	addi	a0, s5, 1
8020512c: 08 e4        	sd	a0, 8(s0)
8020512e: 22 85        	mv	a0, s0
80205130: a6 7a        	ld	s5, 104(sp)
80205132: 46 7a        	ld	s4, 112(sp)
80205134: e6 79        	ld	s3, 120(sp)
80205136: 0a 69        	ld	s2, 128(sp)
80205138: aa 64        	ld	s1, 136(sp)
8020513a: 4a 64        	ld	s0, 144(sp)
8020513c: ea 60        	ld	ra, 152(sp)
8020513e: 0d 61        	addi	sp, sp, 160
80205140: 82 80        	ret

0000000080205142 <_ZN4core3fmt8builders10DebugTuple6finish17habbb78b49313e43dE>:
80205142: 01 11        	addi	sp, sp, -32
80205144: 06 ec        	sd	ra, 24(sp)
80205146: 22 e8        	sd	s0, 16(sp)
80205148: 26 e4        	sd	s1, 8(sp)
8020514a: 4a e0        	sd	s2, 0(sp)
8020514c: 2a 84        	mv	s0, a0
8020514e: 08 65        	ld	a0, 8(a0)
80205150: 83 45 04 01  	lbu	a1, 16(s0)
80205154: 31 cd        	beqz	a0, 0x802051b0 <.LBB144_9+0x14>
80205156: 85 44        	addi	s1, zero, 1
80205158: a9 e9        	bnez	a1, 0x802051aa <.LBB144_9+0xe>
8020515a: 83 45 14 01  	lbu	a1, 17(s0)
8020515e: 7d 15        	addi	a0, a0, -1
80205160: 13 35 15 00  	seqz	a0, a0
80205164: 03 39 04 00  	ld	s2, 0(s0)
80205168: b3 35 b0 00  	snez	a1, a1
8020516c: 6d 8d        	and	a0, a0, a1
8020516e: 15 c1        	beqz	a0, 0x80205192 <.LBB144_8+0x10>
80205170: 03 45 09 03  	lbu	a0, 48(s2)
80205174: 11 89        	andi	a0, a0, 4
80205176: 11 ed        	bnez	a0, 0x80205192 <.LBB144_8+0x10>
80205178: 83 35 89 02  	ld	a1, 40(s2)
8020517c: 03 35 09 02  	ld	a0, 32(s2)
80205180: 94 6d        	ld	a3, 24(a1)

0000000080205182 <.LBB144_8>:
80205182: 97 45 01 00  	auipc	a1, 20
80205186: 93 85 65 29  	addi	a1, a1, 662
8020518a: 05 46        	addi	a2, zero, 1
8020518c: 85 44        	addi	s1, zero, 1
8020518e: 82 96        	jalr	a3
80205190: 09 ed        	bnez	a0, 0x802051aa <.LBB144_9+0xe>
80205192: 83 35 89 02  	ld	a1, 40(s2)
80205196: 03 35 09 02  	ld	a0, 32(s2)
8020519a: 94 6d        	ld	a3, 24(a1)

000000008020519c <.LBB144_9>:
8020519c: 97 45 01 00  	auipc	a1, 20
802051a0: 93 85 d5 27  	addi	a1, a1, 637
802051a4: 05 46        	addi	a2, zero, 1
802051a6: 82 96        	jalr	a3
802051a8: aa 84        	mv	s1, a0
802051aa: 23 08 94 00  	sb	s1, 16(s0)
802051ae: a6 85        	mv	a1, s1
802051b0: 33 35 b0 00  	snez	a0, a1
802051b4: 02 69        	ld	s2, 0(sp)
802051b6: a2 64        	ld	s1, 8(sp)
802051b8: 42 64        	ld	s0, 16(sp)
802051ba: e2 60        	ld	ra, 24(sp)
802051bc: 05 61        	addi	sp, sp, 32
802051be: 82 80        	ret

00000000802051c0 <_ZN4core3fmt5Write10write_char17h71550e0059b57758E>:
802051c0: 41 11        	addi	sp, sp, -16
802051c2: 06 e4        	sd	ra, 8(sp)
802051c4: 1b 86 05 00  	sext.w	a2, a1
802051c8: 93 06 00 08  	addi	a3, zero, 128
802051cc: 02 c2        	sw	zero, 4(sp)
802051ce: 63 76 d6 00  	bgeu	a2, a3, 0x802051da <_ZN4core3fmt5Write10write_char17h71550e0059b57758E+0x1a>
802051d2: 23 02 b1 00  	sb	a1, 4(sp)
802051d6: 05 46        	addi	a2, zero, 1
802051d8: 41 a8        	j	0x80205268 <_ZN4core3fmt5Write10write_char17h71550e0059b57758E+0xa8>
802051da: 1b d6 b5 00  	srliw	a2, a1, 11
802051de: 19 ee        	bnez	a2, 0x802051fc <_ZN4core3fmt5Write10write_char17h71550e0059b57758E+0x3c>
802051e0: 13 d6 65 00  	srli	a2, a1, 6
802051e4: 13 66 06 0c  	ori	a2, a2, 192
802051e8: 23 02 c1 00  	sb	a2, 4(sp)
802051ec: 93 f5 f5 03  	andi	a1, a1, 63
802051f0: 93 e5 05 08  	ori	a1, a1, 128
802051f4: a3 02 b1 00  	sb	a1, 5(sp)
802051f8: 09 46        	addi	a2, zero, 2
802051fa: bd a0        	j	0x80205268 <_ZN4core3fmt5Write10write_char17h71550e0059b57758E+0xa8>
802051fc: 1b d6 05 01  	srliw	a2, a1, 16
80205200: 1d e6        	bnez	a2, 0x8020522e <_ZN4core3fmt5Write10write_char17h71550e0059b57758E+0x6e>
80205202: 1b d6 c5 00  	srliw	a2, a1, 12
80205206: 13 66 06 0e  	ori	a2, a2, 224
8020520a: 23 02 c1 00  	sb	a2, 4(sp)
8020520e: 1b d6 65 00  	srliw	a2, a1, 6
80205212: 13 76 f6 03  	andi	a2, a2, 63
80205216: 13 66 06 08  	ori	a2, a2, 128
8020521a: a3 02 c1 00  	sb	a2, 5(sp)
8020521e: 93 f5 f5 03  	andi	a1, a1, 63
80205222: 93 e5 05 08  	ori	a1, a1, 128
80205226: 23 03 b1 00  	sb	a1, 6(sp)
8020522a: 0d 46        	addi	a2, zero, 3
8020522c: 35 a8        	j	0x80205268 <_ZN4core3fmt5Write10write_char17h71550e0059b57758E+0xa8>
8020522e: 1b d6 25 01  	srliw	a2, a1, 18
80205232: 13 66 06 0f  	ori	a2, a2, 240
80205236: 23 02 c1 00  	sb	a2, 4(sp)
8020523a: 1b d6 c5 00  	srliw	a2, a1, 12
8020523e: 13 76 f6 03  	andi	a2, a2, 63
80205242: 13 66 06 08  	ori	a2, a2, 128
80205246: a3 02 c1 00  	sb	a2, 5(sp)
8020524a: 1b d6 65 00  	srliw	a2, a1, 6
8020524e: 13 76 f6 03  	andi	a2, a2, 63
80205252: 13 66 06 08  	ori	a2, a2, 128
80205256: 23 03 c1 00  	sb	a2, 6(sp)
8020525a: 93 f5 f5 03  	andi	a1, a1, 63
8020525e: 93 e5 05 08  	ori	a1, a1, 128
80205262: a3 03 b1 00  	sb	a1, 7(sp)
80205266: 11 46        	addi	a2, zero, 4
80205268: 4c 00        	addi	a1, sp, 4
8020526a: 97 00 00 00  	auipc	ra, 0
8020526e: e7 80 80 a2  	jalr	-1496(ra)
80205272: a2 60        	ld	ra, 8(sp)
80205274: 41 01        	addi	sp, sp, 16
80205276: 82 80        	ret

0000000080205278 <_ZN4core3fmt5Write9write_fmt17h5f24c6332002deb5E>:
80205278: 39 71        	addi	sp, sp, -64
8020527a: 06 fc        	sd	ra, 56(sp)
8020527c: 90 75        	ld	a2, 40(a1)
8020527e: 94 71        	ld	a3, 32(a1)
80205280: 2a e0        	sd	a0, 0(sp)
80205282: 32 f8        	sd	a2, 48(sp)
80205284: 36 f4        	sd	a3, 40(sp)
80205286: 88 6d        	ld	a0, 24(a1)
80205288: 90 69        	ld	a2, 16(a1)
8020528a: 94 65        	ld	a3, 8(a1)
8020528c: 8c 61        	ld	a1, 0(a1)
8020528e: 2a f0        	sd	a0, 32(sp)
80205290: 32 ec        	sd	a2, 24(sp)
80205292: 36 e8        	sd	a3, 16(sp)
80205294: 2e e4        	sd	a1, 8(sp)

0000000080205296 <.LBB166_1>:
80205296: 97 45 01 00  	auipc	a1, 20
8020529a: 93 85 25 2b  	addi	a1, a1, 690
8020529e: 0a 85        	mv	a0, sp
802052a0: 30 00        	addi	a2, sp, 8
802052a2: 97 00 00 00  	auipc	ra, 0
802052a6: e7 80 e0 13  	jalr	318(ra)
802052aa: e2 70        	ld	ra, 56(sp)
802052ac: 21 61        	addi	sp, sp, 64
802052ae: 82 80        	ret

00000000802052b0 <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$9write_str17hbbf41d6125de2b7bE>:
802052b0: 08 61        	ld	a0, 0(a0)
802052b2: 17 03 00 00  	auipc	t1, 0
802052b6: 67 00 03 9e  	jr	-1568(t1)

00000000802052ba <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$10write_char17h3e152b491d105373E>:
802052ba: 41 11        	addi	sp, sp, -16
802052bc: 06 e4        	sd	ra, 8(sp)
802052be: 08 61        	ld	a0, 0(a0)
802052c0: 1b 86 05 00  	sext.w	a2, a1
802052c4: 93 06 00 08  	addi	a3, zero, 128
802052c8: 02 c2        	sw	zero, 4(sp)
802052ca: 63 76 d6 00  	bgeu	a2, a3, 0x802052d6 <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$10write_char17h3e152b491d105373E+0x1c>
802052ce: 23 02 b1 00  	sb	a1, 4(sp)
802052d2: 05 46        	addi	a2, zero, 1
802052d4: 41 a8        	j	0x80205364 <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$10write_char17h3e152b491d105373E+0xaa>
802052d6: 1b d6 b5 00  	srliw	a2, a1, 11
802052da: 19 ee        	bnez	a2, 0x802052f8 <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$10write_char17h3e152b491d105373E+0x3e>
802052dc: 13 d6 65 00  	srli	a2, a1, 6
802052e0: 13 66 06 0c  	ori	a2, a2, 192
802052e4: 23 02 c1 00  	sb	a2, 4(sp)
802052e8: 93 f5 f5 03  	andi	a1, a1, 63
802052ec: 93 e5 05 08  	ori	a1, a1, 128
802052f0: a3 02 b1 00  	sb	a1, 5(sp)
802052f4: 09 46        	addi	a2, zero, 2
802052f6: bd a0        	j	0x80205364 <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$10write_char17h3e152b491d105373E+0xaa>
802052f8: 1b d6 05 01  	srliw	a2, a1, 16
802052fc: 1d e6        	bnez	a2, 0x8020532a <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$10write_char17h3e152b491d105373E+0x70>
802052fe: 1b d6 c5 00  	srliw	a2, a1, 12
80205302: 13 66 06 0e  	ori	a2, a2, 224
80205306: 23 02 c1 00  	sb	a2, 4(sp)
8020530a: 1b d6 65 00  	srliw	a2, a1, 6
8020530e: 13 76 f6 03  	andi	a2, a2, 63
80205312: 13 66 06 08  	ori	a2, a2, 128
80205316: a3 02 c1 00  	sb	a2, 5(sp)
8020531a: 93 f5 f5 03  	andi	a1, a1, 63
8020531e: 93 e5 05 08  	ori	a1, a1, 128
80205322: 23 03 b1 00  	sb	a1, 6(sp)
80205326: 0d 46        	addi	a2, zero, 3
80205328: 35 a8        	j	0x80205364 <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$10write_char17h3e152b491d105373E+0xaa>
8020532a: 1b d6 25 01  	srliw	a2, a1, 18
8020532e: 13 66 06 0f  	ori	a2, a2, 240
80205332: 23 02 c1 00  	sb	a2, 4(sp)
80205336: 1b d6 c5 00  	srliw	a2, a1, 12
8020533a: 13 76 f6 03  	andi	a2, a2, 63
8020533e: 13 66 06 08  	ori	a2, a2, 128
80205342: a3 02 c1 00  	sb	a2, 5(sp)
80205346: 1b d6 65 00  	srliw	a2, a1, 6
8020534a: 13 76 f6 03  	andi	a2, a2, 63
8020534e: 13 66 06 08  	ori	a2, a2, 128
80205352: 23 03 c1 00  	sb	a2, 6(sp)
80205356: 93 f5 f5 03  	andi	a1, a1, 63
8020535a: 93 e5 05 08  	ori	a1, a1, 128
8020535e: a3 03 b1 00  	sb	a1, 7(sp)
80205362: 11 46        	addi	a2, zero, 4
80205364: 4c 00        	addi	a1, sp, 4
80205366: 97 00 00 00  	auipc	ra, 0
8020536a: e7 80 c0 92  	jalr	-1748(ra)
8020536e: a2 60        	ld	ra, 8(sp)
80205370: 41 01        	addi	sp, sp, 16
80205372: 82 80        	ret

0000000080205374 <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$9write_fmt17h60ec40ad50748124E>:
80205374: 39 71        	addi	sp, sp, -64
80205376: 06 fc        	sd	ra, 56(sp)
80205378: 08 61        	ld	a0, 0(a0)
8020537a: 90 75        	ld	a2, 40(a1)
8020537c: 94 71        	ld	a3, 32(a1)
8020537e: 2a e0        	sd	a0, 0(sp)
80205380: 32 f8        	sd	a2, 48(sp)
80205382: 36 f4        	sd	a3, 40(sp)
80205384: 88 6d        	ld	a0, 24(a1)
80205386: 90 69        	ld	a2, 16(a1)
80205388: 94 65        	ld	a3, 8(a1)
8020538a: 8c 61        	ld	a1, 0(a1)
8020538c: 2a f0        	sd	a0, 32(sp)
8020538e: 32 ec        	sd	a2, 24(sp)
80205390: 36 e8        	sd	a3, 16(sp)
80205392: 2e e4        	sd	a1, 8(sp)

0000000080205394 <.LBB169_1>:
80205394: 97 45 01 00  	auipc	a1, 20
80205398: 93 85 45 1b  	addi	a1, a1, 436
8020539c: 0a 85        	mv	a0, sp
8020539e: 30 00        	addi	a2, sp, 8
802053a0: 97 00 00 00  	auipc	ra, 0
802053a4: e7 80 00 04  	jalr	64(ra)
802053a8: e2 70        	ld	ra, 56(sp)
802053aa: 21 61        	addi	sp, sp, 64
802053ac: 82 80        	ret

00000000802053ae <_ZN59_$LT$core..fmt..Arguments$u20$as$u20$core..fmt..Display$GT$3fmt17h714e45c75a4b7d51E>:
802053ae: 39 71        	addi	sp, sp, -64
802053b0: 06 fc        	sd	ra, 56(sp)
802053b2: 10 75        	ld	a2, 40(a0)
802053b4: 18 71        	ld	a4, 32(a0)
802053b6: 1c 6d        	ld	a5, 24(a0)
802053b8: 32 f8        	sd	a2, 48(sp)
802053ba: 94 71        	ld	a3, 32(a1)
802053bc: 3a f4        	sd	a4, 40(sp)
802053be: 3e f0        	sd	a5, 32(sp)
802053c0: 10 69        	ld	a2, 16(a0)
802053c2: 18 65        	ld	a4, 8(a0)
802053c4: 08 61        	ld	a0, 0(a0)
802053c6: 8c 75        	ld	a1, 40(a1)
802053c8: 32 ec        	sd	a2, 24(sp)
802053ca: 3a e8        	sd	a4, 16(sp)
802053cc: 2a e4        	sd	a0, 8(sp)
802053ce: 30 00        	addi	a2, sp, 8
802053d0: 36 85        	mv	a0, a3
802053d2: 97 00 00 00  	auipc	ra, 0
802053d6: e7 80 e0 00  	jalr	14(ra)
802053da: e2 70        	ld	ra, 56(sp)
802053dc: 21 61        	addi	sp, sp, 64
802053de: 82 80        	ret

00000000802053e0 <_ZN4core3fmt5write17hd5b786d4f5ab4ad3E>:
802053e0: 19 71        	addi	sp, sp, -128
802053e2: 86 fc        	sd	ra, 120(sp)
802053e4: a2 f8        	sd	s0, 112(sp)
802053e6: a6 f4        	sd	s1, 104(sp)
802053e8: ca f0        	sd	s2, 96(sp)
802053ea: ce ec        	sd	s3, 88(sp)
802053ec: d2 e8        	sd	s4, 80(sp)
802053ee: d6 e4        	sd	s5, 72(sp)
802053f0: da e0        	sd	s6, 64(sp)
802053f2: b2 89        	mv	s3, a2
802053f4: 05 46        	addi	a2, zero, 1
802053f6: 16 16        	slli	a2, a2, 37
802053f8: 32 f8        	sd	a2, 48(sp)
802053fa: 0d 46        	addi	a2, zero, 3
802053fc: 23 0c c1 02  	sb	a2, 56(sp)
80205400: 03 b6 09 01  	ld	a2, 16(s3)
80205404: 02 e0        	sd	zero, 0(sp)
80205406: 02 e8        	sd	zero, 16(sp)
80205408: 2a f0        	sd	a0, 32(sp)
8020540a: 2e f4        	sd	a1, 40(sp)
8020540c: 69 ca        	beqz	a2, 0x802054de <.LBB174_34+0xa6>
8020540e: 03 b5 89 01  	ld	a0, 24(s3)
80205412: 63 0c 05 10  	beqz	a0, 0x8020552a <.LBB174_34+0xf2>
80205416: 83 b5 09 00  	ld	a1, 0(s3)
8020541a: 93 16 35 00  	slli	a3, a0, 3
8020541e: e1 16        	addi	a3, a3, -8
80205420: 8d 82        	srli	a3, a3, 3
80205422: 13 89 16 00  	addi	s2, a3, 1
80205426: 93 84 85 00  	addi	s1, a1, 8
8020542a: 93 05 80 03  	addi	a1, zero, 56
8020542e: 33 0a b5 02  	mul	s4, a0, a1
80205432: 13 04 06 03  	addi	s0, a2, 48
80205436: 85 4a        	addi	s5, zero, 1

0000000080205438 <.LBB174_34>:
80205438: 17 fb ff ff  	auipc	s6, 1048575
8020543c: 13 0b eb 45  	addi	s6, s6, 1118
80205440: 90 60        	ld	a2, 0(s1)
80205442: 09 ca        	beqz	a2, 0x80205454 <.LBB174_34+0x1c>
80205444: a2 76        	ld	a3, 40(sp)
80205446: 02 75        	ld	a0, 32(sp)
80205448: 83 b5 84 ff  	ld	a1, -8(s1)
8020544c: 94 6e        	ld	a3, 24(a3)
8020544e: 82 96        	jalr	a3
80205450: 63 19 05 10  	bnez	a0, 0x80205562 <.LBB174_34+0x12a>
80205454: 03 25 84 ff  	lw	a0, -8(s0)
80205458: 2a da        	sw	a0, 52(sp)
8020545a: 03 05 04 00  	lb	a0, 0(s0)
8020545e: 23 0c a1 02  	sb	a0, 56(sp)
80205462: 83 25 c4 ff  	lw	a1, -4(s0)
80205466: 03 b5 09 02  	ld	a0, 32(s3)
8020546a: 2e d8        	sw	a1, 48(sp)
8020546c: 83 36 84 fe  	ld	a3, -24(s0)
80205470: 83 35 04 ff  	ld	a1, -16(s0)
80205474: 89 ce        	beqz	a3, 0x8020548e <.LBB174_34+0x56>
80205476: 01 46        	mv	a2, zero
80205478: 63 9c 56 01  	bne	a3, s5, 0x80205490 <.LBB174_34+0x58>
8020547c: 92 05        	slli	a1, a1, 4
8020547e: aa 95        	add	a1, a1, a0
80205480: 90 65        	ld	a2, 8(a1)
80205482: 63 04 66 01  	beq	a2, s6, 0x8020548a <.LBB174_34+0x52>
80205486: 01 46        	mv	a2, zero
80205488: 21 a0        	j	0x80205490 <.LBB174_34+0x58>
8020548a: 8c 61        	ld	a1, 0(a1)
8020548c: 8c 61        	ld	a1, 0(a1)
8020548e: 05 46        	addi	a2, zero, 1
80205490: 32 e0        	sd	a2, 0(sp)
80205492: 2e e4        	sd	a1, 8(sp)
80205494: 83 36 84 fd  	ld	a3, -40(s0)
80205498: 83 35 04 fe  	ld	a1, -32(s0)
8020549c: 89 ce        	beqz	a3, 0x802054b6 <.LBB174_34+0x7e>
8020549e: 01 46        	mv	a2, zero
802054a0: 63 9c 56 01  	bne	a3, s5, 0x802054b8 <.LBB174_34+0x80>
802054a4: 92 05        	slli	a1, a1, 4
802054a6: aa 95        	add	a1, a1, a0
802054a8: 90 65        	ld	a2, 8(a1)
802054aa: 63 04 66 01  	beq	a2, s6, 0x802054b2 <.LBB174_34+0x7a>
802054ae: 01 46        	mv	a2, zero
802054b0: 21 a0        	j	0x802054b8 <.LBB174_34+0x80>
802054b2: 8c 61        	ld	a1, 0(a1)
802054b4: 8c 61        	ld	a1, 0(a1)
802054b6: 05 46        	addi	a2, zero, 1
802054b8: 32 e8        	sd	a2, 16(sp)
802054ba: 2e ec        	sd	a1, 24(sp)
802054bc: 83 35 04 fd  	ld	a1, -48(s0)
802054c0: 92 05        	slli	a1, a1, 4
802054c2: 2e 95        	add	a0, a0, a1
802054c4: 10 65        	ld	a2, 8(a0)
802054c6: 08 61        	ld	a0, 0(a0)
802054c8: 8a 85        	mv	a1, sp
802054ca: 02 96        	jalr	a2
802054cc: 59 e9        	bnez	a0, 0x80205562 <.LBB174_34+0x12a>
802054ce: c1 04        	addi	s1, s1, 16
802054d0: 13 0a 8a fc  	addi	s4, s4, -56
802054d4: 13 04 84 03  	addi	s0, s0, 56
802054d8: e3 14 0a f6  	bnez	s4, 0x80205440 <.LBB174_34+0x8>
802054dc: 81 a8        	j	0x8020552c <.LBB174_34+0xf4>
802054de: 03 b5 89 02  	ld	a0, 40(s3)
802054e2: 29 cd        	beqz	a0, 0x8020553c <.LBB174_34+0x104>
802054e4: 83 b5 09 02  	ld	a1, 32(s3)
802054e8: 03 b6 09 00  	ld	a2, 0(s3)
802054ec: 12 05        	slli	a0, a0, 4
802054ee: 41 15        	addi	a0, a0, -16
802054f0: 11 81        	srli	a0, a0, 4
802054f2: 13 09 15 00  	addi	s2, a0, 1
802054f6: 13 04 86 00  	addi	s0, a2, 8
802054fa: 93 84 85 00  	addi	s1, a1, 8
802054fe: 4a 8a        	mv	s4, s2
80205500: 10 60        	ld	a2, 0(s0)
80205502: 01 ca        	beqz	a2, 0x80205512 <.LBB174_34+0xda>
80205504: a2 76        	ld	a3, 40(sp)
80205506: 02 75        	ld	a0, 32(sp)
80205508: 83 35 84 ff  	ld	a1, -8(s0)
8020550c: 94 6e        	ld	a3, 24(a3)
8020550e: 82 96        	jalr	a3
80205510: 29 e9        	bnez	a0, 0x80205562 <.LBB174_34+0x12a>
80205512: 90 60        	ld	a2, 0(s1)
80205514: 03 b5 84 ff  	ld	a0, -8(s1)
80205518: 8a 85        	mv	a1, sp
8020551a: 02 96        	jalr	a2
8020551c: 39 e1        	bnez	a0, 0x80205562 <.LBB174_34+0x12a>
8020551e: 7d 1a        	addi	s4, s4, -1
80205520: 41 04        	addi	s0, s0, 16
80205522: c1 04        	addi	s1, s1, 16
80205524: e3 1e 0a fc  	bnez	s4, 0x80205500 <.LBB174_34+0xc8>
80205528: 11 a0        	j	0x8020552c <.LBB174_34+0xf4>
8020552a: 01 49        	mv	s2, zero
8020552c: 03 b5 89 00  	ld	a0, 8(s3)
80205530: 63 6b a9 00  	bltu	s2, a0, 0x80205546 <.LBB174_34+0x10e>
80205534: 01 46        	mv	a2, zero
80205536: 63 6f a9 00  	bltu	s2, a0, 0x80205554 <.LBB174_34+0x11c>
8020553a: 35 a0        	j	0x80205566 <.LBB174_34+0x12e>
8020553c: 01 49        	mv	s2, zero
8020553e: 03 b5 89 00  	ld	a0, 8(s3)
80205542: e3 79 a9 fe  	bgeu	s2, a0, 0x80205534 <.LBB174_34+0xfc>
80205546: 83 b5 09 00  	ld	a1, 0(s3)
8020554a: 13 16 49 00  	slli	a2, s2, 4
8020554e: 2e 96        	add	a2, a2, a1
80205550: 63 7b a9 00  	bgeu	s2, a0, 0x80205566 <.LBB174_34+0x12e>
80205554: a2 76        	ld	a3, 40(sp)
80205556: 02 75        	ld	a0, 32(sp)
80205558: 0c 62        	ld	a1, 0(a2)
8020555a: 10 66        	ld	a2, 8(a2)
8020555c: 94 6e        	ld	a3, 24(a3)
8020555e: 82 96        	jalr	a3
80205560: 19 c1        	beqz	a0, 0x80205566 <.LBB174_34+0x12e>
80205562: 05 45        	addi	a0, zero, 1
80205564: 11 a0        	j	0x80205568 <.LBB174_34+0x130>
80205566: 01 45        	mv	a0, zero
80205568: 06 6b        	ld	s6, 64(sp)
8020556a: a6 6a        	ld	s5, 72(sp)
8020556c: 46 6a        	ld	s4, 80(sp)
8020556e: e6 69        	ld	s3, 88(sp)
80205570: 06 79        	ld	s2, 96(sp)
80205572: a6 74        	ld	s1, 104(sp)
80205574: 46 74        	ld	s0, 112(sp)
80205576: e6 70        	ld	ra, 120(sp)
80205578: 09 61        	addi	sp, sp, 128
8020557a: 82 80        	ret

000000008020557c <_ZN4core3fmt9Formatter12pad_integral17h4d1e73db8f536e69E>:
8020557c: 1d 71        	addi	sp, sp, -96
8020557e: 86 ec        	sd	ra, 88(sp)
80205580: a2 e8        	sd	s0, 80(sp)
80205582: a6 e4        	sd	s1, 72(sp)
80205584: ca e0        	sd	s2, 64(sp)
80205586: 4e fc        	sd	s3, 56(sp)
80205588: 52 f8        	sd	s4, 48(sp)
8020558a: 56 f4        	sd	s5, 40(sp)
8020558c: 5a f0        	sd	s6, 32(sp)
8020558e: 5e ec        	sd	s7, 24(sp)
80205590: 62 e8        	sd	s8, 16(sp)
80205592: 66 e4        	sd	s9, 8(sp)
80205594: 6a e0        	sd	s10, 0(sp)
80205596: be 89        	mv	s3, a5
80205598: 3a 89        	mv	s2, a4
8020559a: 36 8b        	mv	s6, a3
8020559c: aa 8b        	mv	s7, a0
8020559e: a1 c5        	beqz	a1, 0x802055e6 <_ZN4core3fmt9Formatter12pad_integral17h4d1e73db8f536e69E+0x6a>
802055a0: 03 e5 0b 03  	lwu	a0, 48(s7)
802055a4: 93 75 15 00  	andi	a1, a0, 1
802055a8: 37 0a 11 00  	lui	s4, 272
802055ac: 99 c1        	beqz	a1, 0x802055b2 <_ZN4core3fmt9Formatter12pad_integral17h4d1e73db8f536e69E+0x36>
802055ae: 13 0a b0 02  	addi	s4, zero, 43
802055b2: 33 84 35 01  	add	s0, a1, s3
802055b6: 93 75 45 00  	andi	a1, a0, 4
802055ba: 9d cd        	beqz	a1, 0x802055f8 <_ZN4core3fmt9Formatter12pad_integral17h4d1e73db8f536e69E+0x7c>
802055bc: 81 45        	mv	a1, zero
802055be: 63 0e 0b 00  	beqz	s6, 0x802055da <_ZN4core3fmt9Formatter12pad_integral17h4d1e73db8f536e69E+0x5e>
802055c2: 93 06 f0 fb  	addi	a3, zero, -65
802055c6: 5a 87        	mv	a4, s6
802055c8: b2 87        	mv	a5, a2
802055ca: 83 84 07 00  	lb	s1, 0(a5)
802055ce: 85 07        	addi	a5, a5, 1
802055d0: b3 a4 96 00  	slt	s1, a3, s1
802055d4: 7d 17        	addi	a4, a4, -1
802055d6: a6 95        	add	a1, a1, s1
802055d8: 6d fb        	bnez	a4, 0x802055ca <_ZN4core3fmt9Formatter12pad_integral17h4d1e73db8f536e69E+0x4e>
802055da: 2e 94        	add	s0, s0, a1
802055dc: 32 8c        	mv	s8, a2
802055de: 83 b5 0b 00  	ld	a1, 0(s7)
802055e2: 99 ed        	bnez	a1, 0x80205600 <_ZN4core3fmt9Formatter12pad_integral17h4d1e73db8f536e69E+0x84>
802055e4: a9 a0        	j	0x8020562e <_ZN4core3fmt9Formatter12pad_integral17h4d1e73db8f536e69E+0xb2>
802055e6: 03 e5 0b 03  	lwu	a0, 48(s7)
802055ea: 13 84 19 00  	addi	s0, s3, 1
802055ee: 13 0a d0 02  	addi	s4, zero, 45
802055f2: 93 75 45 00  	andi	a1, a0, 4
802055f6: f9 f1        	bnez	a1, 0x802055bc <_ZN4core3fmt9Formatter12pad_integral17h4d1e73db8f536e69E+0x40>
802055f8: 01 4c        	mv	s8, zero
802055fa: 83 b5 0b 00  	ld	a1, 0(s7)
802055fe: 85 c9        	beqz	a1, 0x8020562e <_ZN4core3fmt9Formatter12pad_integral17h4d1e73db8f536e69E+0xb2>
80205600: 83 b4 8b 00  	ld	s1, 8(s7)
80205604: 63 75 94 02  	bgeu	s0, s1, 0x8020562e <_ZN4core3fmt9Formatter12pad_integral17h4d1e73db8f536e69E+0xb2>
80205608: 21 89        	andi	a0, a0, 8
8020560a: 41 e1        	bnez	a0, 0x8020568a <_ZN4core3fmt9Formatter12pad_integral17h4d1e73db8f536e69E+0x10e>
8020560c: 83 c5 8b 03  	lbu	a1, 56(s7)
80205610: 0d 46        	addi	a2, zero, 3
80205612: 05 45        	addi	a0, zero, 1
80205614: 63 83 c5 00  	beq	a1, a2, 0x8020561a <_ZN4core3fmt9Formatter12pad_integral17h4d1e73db8f536e69E+0x9e>
80205618: 2e 85        	mv	a0, a1
8020561a: 93 75 35 00  	andi	a1, a0, 3
8020561e: 33 85 84 40  	sub	a0, s1, s0
80205622: cd c9        	beqz	a1, 0x802056d4 <_ZN4core3fmt9Formatter12pad_integral17h4d1e73db8f536e69E+0x158>
80205624: 05 46        	addi	a2, zero, 1
80205626: 63 9a c5 0a  	bne	a1, a2, 0x802056da <_ZN4core3fmt9Formatter12pad_integral17h4d1e73db8f536e69E+0x15e>
8020562a: 81 4c        	mv	s9, zero
8020562c: 65 a8        	j	0x802056e4 <_ZN4core3fmt9Formatter12pad_integral17h4d1e73db8f536e69E+0x168>
8020562e: 5e 85        	mv	a0, s7
80205630: d2 85        	mv	a1, s4
80205632: 62 86        	mv	a2, s8
80205634: da 86        	mv	a3, s6
80205636: 97 00 00 00  	auipc	ra, 0
8020563a: e7 80 a0 1a  	jalr	426(ra)
8020563e: 85 4a        	addi	s5, zero, 1
80205640: 05 c1        	beqz	a0, 0x80205660 <_ZN4core3fmt9Formatter12pad_integral17h4d1e73db8f536e69E+0xe4>
80205642: 56 85        	mv	a0, s5
80205644: 02 6d        	ld	s10, 0(sp)
80205646: a2 6c        	ld	s9, 8(sp)
80205648: 42 6c        	ld	s8, 16(sp)
8020564a: e2 6b        	ld	s7, 24(sp)
8020564c: 02 7b        	ld	s6, 32(sp)
8020564e: a2 7a        	ld	s5, 40(sp)
80205650: 42 7a        	ld	s4, 48(sp)
80205652: e2 79        	ld	s3, 56(sp)
80205654: 06 69        	ld	s2, 64(sp)
80205656: a6 64        	ld	s1, 72(sp)
80205658: 46 64        	ld	s0, 80(sp)
8020565a: e6 60        	ld	ra, 88(sp)
8020565c: 25 61        	addi	sp, sp, 96
8020565e: 82 80        	ret
80205660: 83 b5 8b 02  	ld	a1, 40(s7)
80205664: 03 b5 0b 02  	ld	a0, 32(s7)
80205668: 9c 6d        	ld	a5, 24(a1)
8020566a: ca 85        	mv	a1, s2
8020566c: 4e 86        	mv	a2, s3
8020566e: 02 6d        	ld	s10, 0(sp)
80205670: a2 6c        	ld	s9, 8(sp)
80205672: 42 6c        	ld	s8, 16(sp)
80205674: e2 6b        	ld	s7, 24(sp)
80205676: 02 7b        	ld	s6, 32(sp)
80205678: a2 7a        	ld	s5, 40(sp)
8020567a: 42 7a        	ld	s4, 48(sp)
8020567c: e2 79        	ld	s3, 56(sp)
8020567e: 06 69        	ld	s2, 64(sp)
80205680: a6 64        	ld	s1, 72(sp)
80205682: 46 64        	ld	s0, 80(sp)
80205684: e6 60        	ld	ra, 88(sp)
80205686: 25 61        	addi	sp, sp, 96
80205688: 82 87        	jr	a5
8020568a: 83 ec 4b 03  	lwu	s9, 52(s7)
8020568e: 13 05 00 03  	addi	a0, zero, 48
80205692: 03 cd 8b 03  	lbu	s10, 56(s7)
80205696: 23 aa ab 02  	sw	a0, 52(s7)
8020569a: 85 4a        	addi	s5, zero, 1
8020569c: 23 8c 5b 03  	sb	s5, 56(s7)
802056a0: 5e 85        	mv	a0, s7
802056a2: d2 85        	mv	a1, s4
802056a4: 62 86        	mv	a2, s8
802056a6: da 86        	mv	a3, s6
802056a8: 97 00 00 00  	auipc	ra, 0
802056ac: e7 80 80 13  	jalr	312(ra)
802056b0: 49 f9        	bnez	a0, 0x80205642 <_ZN4core3fmt9Formatter12pad_integral17h4d1e73db8f536e69E+0xc6>
802056b2: 83 c5 8b 03  	lbu	a1, 56(s7)
802056b6: 0d 46        	addi	a2, zero, 3
802056b8: 05 45        	addi	a0, zero, 1
802056ba: 63 83 c5 00  	beq	a1, a2, 0x802056c0 <_ZN4core3fmt9Formatter12pad_integral17h4d1e73db8f536e69E+0x144>
802056be: 2e 85        	mv	a0, a1
802056c0: 93 75 35 00  	andi	a1, a0, 3
802056c4: 33 85 84 40  	sub	a0, s1, s0
802056c8: d9 c5        	beqz	a1, 0x80205756 <_ZN4core3fmt9Formatter12pad_integral17h4d1e73db8f536e69E+0x1da>
802056ca: 05 46        	addi	a2, zero, 1
802056cc: 63 98 c5 08  	bne	a1, a2, 0x8020575c <_ZN4core3fmt9Formatter12pad_integral17h4d1e73db8f536e69E+0x1e0>
802056d0: 01 4a        	mv	s4, zero
802056d2: 51 a8        	j	0x80205766 <_ZN4core3fmt9Formatter12pad_integral17h4d1e73db8f536e69E+0x1ea>
802056d4: aa 8c        	mv	s9, a0
802056d6: 01 45        	mv	a0, zero
802056d8: 31 a0        	j	0x802056e4 <_ZN4core3fmt9Formatter12pad_integral17h4d1e73db8f536e69E+0x168>
802056da: 93 05 15 00  	addi	a1, a0, 1
802056de: 05 81        	srli	a0, a0, 1
802056e0: 93 dc 15 00  	srli	s9, a1, 1
802056e4: 83 ba 0b 02  	ld	s5, 32(s7)
802056e8: 03 b4 8b 02  	ld	s0, 40(s7)
802056ec: 03 ed 4b 03  	lwu	s10, 52(s7)
802056f0: 93 04 15 00  	addi	s1, a0, 1
802056f4: fd 14        	addi	s1, s1, -1
802056f6: 99 c4        	beqz	s1, 0x80205704 <_ZN4core3fmt9Formatter12pad_integral17h4d1e73db8f536e69E+0x188>
802056f8: 10 70        	ld	a2, 32(s0)
802056fa: 56 85        	mv	a0, s5
802056fc: ea 85        	mv	a1, s10
802056fe: 02 96        	jalr	a2
80205700: 75 d9        	beqz	a0, 0x802056f4 <_ZN4core3fmt9Formatter12pad_integral17h4d1e73db8f536e69E+0x178>
80205702: 49 a0        	j	0x80205784 <_ZN4core3fmt9Formatter12pad_integral17h4d1e73db8f536e69E+0x208>
80205704: 1b 05 0d 00  	sext.w	a0, s10
80205708: b7 05 11 00  	lui	a1, 272
8020570c: 85 4a        	addi	s5, zero, 1
8020570e: e3 0a b5 f2  	beq	a0, a1, 0x80205642 <_ZN4core3fmt9Formatter12pad_integral17h4d1e73db8f536e69E+0xc6>
80205712: 5e 85        	mv	a0, s7
80205714: d2 85        	mv	a1, s4
80205716: 62 86        	mv	a2, s8
80205718: da 86        	mv	a3, s6
8020571a: 97 00 00 00  	auipc	ra, 0
8020571e: e7 80 60 0c  	jalr	198(ra)
80205722: 05 f1        	bnez	a0, 0x80205642 <_ZN4core3fmt9Formatter12pad_integral17h4d1e73db8f536e69E+0xc6>
80205724: 83 b5 8b 02  	ld	a1, 40(s7)
80205728: 03 b5 0b 02  	ld	a0, 32(s7)
8020572c: 94 6d        	ld	a3, 24(a1)
8020572e: ca 85        	mv	a1, s2
80205730: 4e 86        	mv	a2, s3
80205732: 82 96        	jalr	a3
80205734: 19 f5        	bnez	a0, 0x80205642 <_ZN4core3fmt9Formatter12pad_integral17h4d1e73db8f536e69E+0xc6>
80205736: 03 b9 0b 02  	ld	s2, 32(s7)
8020573a: 03 b4 8b 02  	ld	s0, 40(s7)
8020573e: 81 44        	mv	s1, zero
80205740: 63 8c 9c 08  	beq	s9, s1, 0x802057d8 <_ZN4core3fmt9Formatter12pad_integral17h4d1e73db8f536e69E+0x25c>
80205744: 10 70        	ld	a2, 32(s0)
80205746: 85 04        	addi	s1, s1, 1
80205748: 4a 85        	mv	a0, s2
8020574a: ea 85        	mv	a1, s10
8020574c: 02 96        	jalr	a2
8020574e: 6d d9        	beqz	a0, 0x80205740 <_ZN4core3fmt9Formatter12pad_integral17h4d1e73db8f536e69E+0x1c4>
80205750: 13 85 f4 ff  	addi	a0, s1, -1
80205754: 59 a0        	j	0x802057da <_ZN4core3fmt9Formatter12pad_integral17h4d1e73db8f536e69E+0x25e>
80205756: 2a 8a        	mv	s4, a0
80205758: 01 45        	mv	a0, zero
8020575a: 31 a0        	j	0x80205766 <_ZN4core3fmt9Formatter12pad_integral17h4d1e73db8f536e69E+0x1ea>
8020575c: 93 05 15 00  	addi	a1, a0, 1
80205760: 05 81        	srli	a0, a0, 1
80205762: 13 da 15 00  	srli	s4, a1, 1
80205766: 83 ba 0b 02  	ld	s5, 32(s7)
8020576a: 03 b4 8b 02  	ld	s0, 40(s7)
8020576e: 03 eb 4b 03  	lwu	s6, 52(s7)
80205772: 93 04 15 00  	addi	s1, a0, 1
80205776: fd 14        	addi	s1, s1, -1
80205778: 81 c8        	beqz	s1, 0x80205788 <_ZN4core3fmt9Formatter12pad_integral17h4d1e73db8f536e69E+0x20c>
8020577a: 10 70        	ld	a2, 32(s0)
8020577c: 56 85        	mv	a0, s5
8020577e: da 85        	mv	a1, s6
80205780: 02 96        	jalr	a2
80205782: 75 d9        	beqz	a0, 0x80205776 <_ZN4core3fmt9Formatter12pad_integral17h4d1e73db8f536e69E+0x1fa>
80205784: 85 4a        	addi	s5, zero, 1
80205786: 75 bd        	j	0x80205642 <_ZN4core3fmt9Formatter12pad_integral17h4d1e73db8f536e69E+0xc6>
80205788: 1b 05 0b 00  	sext.w	a0, s6
8020578c: b7 05 11 00  	lui	a1, 272
80205790: 85 4a        	addi	s5, zero, 1
80205792: e3 08 b5 ea  	beq	a0, a1, 0x80205642 <_ZN4core3fmt9Formatter12pad_integral17h4d1e73db8f536e69E+0xc6>
80205796: 83 b5 8b 02  	ld	a1, 40(s7)
8020579a: 03 b5 0b 02  	ld	a0, 32(s7)
8020579e: 94 6d        	ld	a3, 24(a1)
802057a0: ca 85        	mv	a1, s2
802057a2: 4e 86        	mv	a2, s3
802057a4: 82 96        	jalr	a3
802057a6: e3 1e 05 e8  	bnez	a0, 0x80205642 <_ZN4core3fmt9Formatter12pad_integral17h4d1e73db8f536e69E+0xc6>
802057aa: 03 b9 0b 02  	ld	s2, 32(s7)
802057ae: 03 b4 8b 02  	ld	s0, 40(s7)
802057b2: 81 44        	mv	s1, zero
802057b4: 63 0c 9a 00  	beq	s4, s1, 0x802057cc <_ZN4core3fmt9Formatter12pad_integral17h4d1e73db8f536e69E+0x250>
802057b8: 10 70        	ld	a2, 32(s0)
802057ba: 85 04        	addi	s1, s1, 1
802057bc: 4a 85        	mv	a0, s2
802057be: da 85        	mv	a1, s6
802057c0: 02 96        	jalr	a2
802057c2: 6d d9        	beqz	a0, 0x802057b4 <_ZN4core3fmt9Formatter12pad_integral17h4d1e73db8f536e69E+0x238>
802057c4: 13 85 f4 ff  	addi	a0, s1, -1
802057c8: e3 6d 45 e7  	bltu	a0, s4, 0x80205642 <_ZN4core3fmt9Formatter12pad_integral17h4d1e73db8f536e69E+0xc6>
802057cc: 81 4a        	mv	s5, zero
802057ce: 23 aa 9b 03  	sw	s9, 52(s7)
802057d2: 23 8c ab 03  	sb	s10, 56(s7)
802057d6: b5 b5        	j	0x80205642 <_ZN4core3fmt9Formatter12pad_integral17h4d1e73db8f536e69E+0xc6>
802057d8: 66 85        	mv	a0, s9
802057da: b3 3a 95 01  	sltu	s5, a0, s9
802057de: 95 b5        	j	0x80205642 <_ZN4core3fmt9Formatter12pad_integral17h4d1e73db8f536e69E+0xc6>

00000000802057e0 <_ZN4core3fmt9Formatter12pad_integral12write_prefix17hed8547a6ae703abcE>:
802057e0: 01 11        	addi	sp, sp, -32
802057e2: 06 ec        	sd	ra, 24(sp)
802057e4: 22 e8        	sd	s0, 16(sp)
802057e6: 26 e4        	sd	s1, 8(sp)
802057e8: 4a e0        	sd	s2, 0(sp)
802057ea: 1b 87 05 00  	sext.w	a4, a1
802057ee: b7 07 11 00  	lui	a5, 272
802057f2: 36 89        	mv	s2, a3
802057f4: b2 84        	mv	s1, a2
802057f6: 2a 84        	mv	s0, a0
802057f8: 63 09 f7 00  	beq	a4, a5, 0x8020580a <_ZN4core3fmt9Formatter12pad_integral12write_prefix17hed8547a6ae703abcE+0x2a>
802057fc: 10 74        	ld	a2, 40(s0)
802057fe: 08 70        	ld	a0, 32(s0)
80205800: 10 72        	ld	a2, 32(a2)
80205802: 02 96        	jalr	a2
80205804: aa 85        	mv	a1, a0
80205806: 05 45        	addi	a0, zero, 1
80205808: 91 ed        	bnez	a1, 0x80205824 <_ZN4core3fmt9Formatter12pad_integral12write_prefix17hed8547a6ae703abcE+0x44>
8020580a: 81 cc        	beqz	s1, 0x80205822 <_ZN4core3fmt9Formatter12pad_integral12write_prefix17hed8547a6ae703abcE+0x42>
8020580c: 0c 74        	ld	a1, 40(s0)
8020580e: 08 70        	ld	a0, 32(s0)
80205810: 9c 6d        	ld	a5, 24(a1)
80205812: a6 85        	mv	a1, s1
80205814: 4a 86        	mv	a2, s2
80205816: 02 69        	ld	s2, 0(sp)
80205818: a2 64        	ld	s1, 8(sp)
8020581a: 42 64        	ld	s0, 16(sp)
8020581c: e2 60        	ld	ra, 24(sp)
8020581e: 05 61        	addi	sp, sp, 32
80205820: 82 87        	jr	a5
80205822: 01 45        	mv	a0, zero
80205824: 02 69        	ld	s2, 0(sp)
80205826: a2 64        	ld	s1, 8(sp)
80205828: 42 64        	ld	s0, 16(sp)
8020582a: e2 60        	ld	ra, 24(sp)
8020582c: 05 61        	addi	sp, sp, 32
8020582e: 82 80        	ret

0000000080205830 <_ZN4core3fmt9Formatter3pad17h2ad8f1fda7c6bd10E>:
80205830: 5d 71        	addi	sp, sp, -80
80205832: 86 e4        	sd	ra, 72(sp)
80205834: a2 e0        	sd	s0, 64(sp)
80205836: 26 fc        	sd	s1, 56(sp)
80205838: 4a f8        	sd	s2, 48(sp)
8020583a: 4e f4        	sd	s3, 40(sp)
8020583c: 52 f0        	sd	s4, 32(sp)
8020583e: 56 ec        	sd	s5, 24(sp)
80205840: 5a e8        	sd	s6, 16(sp)
80205842: 5e e4        	sd	s7, 8(sp)
80205844: 18 69        	ld	a4, 16(a0)
80205846: 14 61        	ld	a3, 0(a0)
80205848: b2 89        	mv	s3, a2
8020584a: 2e 89        	mv	s2, a1
8020584c: 93 05 f7 ff  	addi	a1, a4, -1
80205850: 05 46        	addi	a2, zero, 1
80205852: 93 b5 15 00  	seqz	a1, a1
80205856: 63 94 c6 00  	bne	a3, a2, 0x8020585e <_ZN4core3fmt9Formatter3pad17h2ad8f1fda7c6bd10E+0x2e>
8020585a: 81 e5        	bnez	a1, 0x80205862 <_ZN4core3fmt9Formatter3pad17h2ad8f1fda7c6bd10E+0x32>
8020585c: 21 a2        	j	0x80205964 <_ZN4core3fmt9Formatter3pad17h2ad8f1fda7c6bd10E+0x134>
8020585e: 63 85 05 14  	beqz	a1, 0x802059a8 <_ZN4core3fmt9Formatter3pad17h2ad8f1fda7c6bd10E+0x178>
80205862: 18 6d        	ld	a4, 24(a0)
80205864: 93 85 f6 ff  	addi	a1, a3, -1
80205868: 93 b8 15 00  	seqz	a7, a1
8020586c: b3 06 39 01  	add	a3, s2, s3
80205870: 01 46        	mv	a2, zero
80205872: 35 cb        	beqz	a4, 0x802058e6 <_ZN4core3fmt9Formatter3pad17h2ad8f1fda7c6bd10E+0xb6>
80205874: 13 03 00 0e  	addi	t1, zero, 224
80205878: 93 02 00 0f  	addi	t0, zero, 240
8020587c: 37 08 11 00  	lui	a6, 272
80205880: 4a 84        	mv	s0, s2
80205882: 01 a8        	j	0x80205892 <_ZN4core3fmt9Formatter3pad17h2ad8f1fda7c6bd10E+0x62>
80205884: 93 05 14 00  	addi	a1, s0, 1
80205888: 01 8e        	sub	a2, a2, s0
8020588a: 7d 17        	addi	a4, a4, -1
8020588c: 2e 96        	add	a2, a2, a1
8020588e: 2e 84        	mv	s0, a1
80205890: 21 cf        	beqz	a4, 0x802058e8 <_ZN4core3fmt9Formatter3pad17h2ad8f1fda7c6bd10E+0xb8>
80205892: 63 07 d4 0c  	beq	s0, a3, 0x80205960 <_ZN4core3fmt9Formatter3pad17h2ad8f1fda7c6bd10E+0x130>
80205896: 83 05 04 00  	lb	a1, 0(s0)
8020589a: e3 d5 05 fe  	bgez	a1, 0x80205884 <_ZN4core3fmt9Formatter3pad17h2ad8f1fda7c6bd10E+0x54>
8020589e: 93 f5 f5 0f  	andi	a1, a1, 255
802058a2: 63 ec 65 02  	bltu	a1, t1, 0x802058da <_ZN4core3fmt9Formatter3pad17h2ad8f1fda7c6bd10E+0xaa>
802058a6: 63 ed 55 02  	bltu	a1, t0, 0x802058e0 <_ZN4core3fmt9Formatter3pad17h2ad8f1fda7c6bd10E+0xb0>
802058aa: 83 44 14 00  	lbu	s1, 1(s0)
802058ae: 83 47 24 00  	lbu	a5, 2(s0)
802058b2: 93 f4 f4 03  	andi	s1, s1, 63
802058b6: 93 f7 f7 03  	andi	a5, a5, 63
802058ba: 83 43 34 00  	lbu	t2, 3(s0)
802058be: f6 15        	slli	a1, a1, 61
802058c0: ad 91        	srli	a1, a1, 43
802058c2: b2 04        	slli	s1, s1, 12
802058c4: 9a 07        	slli	a5, a5, 6
802058c6: c5 8f        	or	a5, a5, s1
802058c8: 93 f4 f3 03  	andi	s1, t2, 63
802058cc: c5 8f        	or	a5, a5, s1
802058ce: dd 8d        	or	a1, a1, a5
802058d0: 63 88 05 09  	beq	a1, a6, 0x80205960 <_ZN4core3fmt9Formatter3pad17h2ad8f1fda7c6bd10E+0x130>
802058d4: 93 05 44 00  	addi	a1, s0, 4
802058d8: 45 bf        	j	0x80205888 <_ZN4core3fmt9Formatter3pad17h2ad8f1fda7c6bd10E+0x58>
802058da: 93 05 24 00  	addi	a1, s0, 2
802058de: 6d b7        	j	0x80205888 <_ZN4core3fmt9Formatter3pad17h2ad8f1fda7c6bd10E+0x58>
802058e0: 93 05 34 00  	addi	a1, s0, 3
802058e4: 55 b7        	j	0x80205888 <_ZN4core3fmt9Formatter3pad17h2ad8f1fda7c6bd10E+0x58>
802058e6: ca 85        	mv	a1, s2
802058e8: 63 8c d5 06  	beq	a1, a3, 0x80205960 <_ZN4core3fmt9Formatter3pad17h2ad8f1fda7c6bd10E+0x130>
802058ec: 83 c6 05 00  	lbu	a3, 0(a1)
802058f0: 13 07 00 0f  	addi	a4, zero, 240
802058f4: 63 e9 e6 02  	bltu	a3, a4, 0x80205926 <_ZN4core3fmt9Formatter3pad17h2ad8f1fda7c6bd10E+0xf6>
802058f8: 03 c7 15 00  	lbu	a4, 1(a1)
802058fc: 83 c7 25 00  	lbu	a5, 2(a1)
80205900: 13 77 f7 03  	andi	a4, a4, 63
80205904: 93 f7 f7 03  	andi	a5, a5, 63
80205908: 83 c5 35 00  	lbu	a1, 3(a1)
8020590c: f6 16        	slli	a3, a3, 61
8020590e: ad 92        	srli	a3, a3, 43
80205910: 32 07        	slli	a4, a4, 12
80205912: 9a 07        	slli	a5, a5, 6
80205914: 5d 8f        	or	a4, a4, a5
80205916: 93 f5 f5 03  	andi	a1, a1, 63
8020591a: d9 8d        	or	a1, a1, a4
8020591c: d5 8d        	or	a1, a1, a3
8020591e: b7 06 11 00  	lui	a3, 272
80205922: 63 8f d5 02  	beq	a1, a3, 0x80205960 <_ZN4core3fmt9Formatter3pad17h2ad8f1fda7c6bd10E+0x130>
80205926: 05 c2        	beqz	a2, 0x80205946 <_ZN4core3fmt9Formatter3pad17h2ad8f1fda7c6bd10E+0x116>
80205928: 63 74 36 03  	bgeu	a2, s3, 0x80205950 <_ZN4core3fmt9Formatter3pad17h2ad8f1fda7c6bd10E+0x120>
8020592c: b3 05 c9 00  	add	a1, s2, a2
80205930: 83 85 05 00  	lb	a1, 0(a1)
80205934: 93 06 00 fc  	addi	a3, zero, -64
80205938: 63 cd d5 0e  	blt	a1, a3, 0x80205a32 <_ZN4core3fmt9Formatter3pad17h2ad8f1fda7c6bd10E+0x202>
8020593c: b2 85        	mv	a1, a2
8020593e: 2e 86        	mv	a2, a1
80205940: ca 85        	mv	a1, s2
80205942: 99 cd        	beqz	a1, 0x80205960 <_ZN4core3fmt9Formatter3pad17h2ad8f1fda7c6bd10E+0x130>
80205944: 21 a8        	j	0x8020595c <_ZN4core3fmt9Formatter3pad17h2ad8f1fda7c6bd10E+0x12c>
80205946: 81 45        	mv	a1, zero
80205948: 2e 86        	mv	a2, a1
8020594a: ca 85        	mv	a1, s2
8020594c: 91 c9        	beqz	a1, 0x80205960 <_ZN4core3fmt9Formatter3pad17h2ad8f1fda7c6bd10E+0x130>
8020594e: 39 a0        	j	0x8020595c <_ZN4core3fmt9Formatter3pad17h2ad8f1fda7c6bd10E+0x12c>
80205950: ce 85        	mv	a1, s3
80205952: 63 10 36 0f  	bne	a2, s3, 0x80205a32 <_ZN4core3fmt9Formatter3pad17h2ad8f1fda7c6bd10E+0x202>
80205956: 2e 86        	mv	a2, a1
80205958: ca 85        	mv	a1, s2
8020595a: 99 c1        	beqz	a1, 0x80205960 <_ZN4core3fmt9Formatter3pad17h2ad8f1fda7c6bd10E+0x130>
8020595c: 2e 89        	mv	s2, a1
8020595e: b2 89        	mv	s3, a2
80205960: 63 84 08 04  	beqz	a7, 0x802059a8 <_ZN4core3fmt9Formatter3pad17h2ad8f1fda7c6bd10E+0x178>
80205964: 0c 65        	ld	a1, 8(a0)
80205966: 01 46        	mv	a2, zero
80205968: 63 8e 09 00  	beqz	s3, 0x80205984 <_ZN4core3fmt9Formatter3pad17h2ad8f1fda7c6bd10E+0x154>
8020596c: 93 06 f0 fb  	addi	a3, zero, -65
80205970: 4e 87        	mv	a4, s3
80205972: ca 87        	mv	a5, s2
80205974: 83 84 07 00  	lb	s1, 0(a5)
80205978: 85 07        	addi	a5, a5, 1
8020597a: b3 a4 96 00  	slt	s1, a3, s1
8020597e: 7d 17        	addi	a4, a4, -1
80205980: 26 96        	add	a2, a2, s1
80205982: 6d fb        	bnez	a4, 0x80205974 <_ZN4core3fmt9Formatter3pad17h2ad8f1fda7c6bd10E+0x144>
80205984: 63 72 b6 02  	bgeu	a2, a1, 0x802059a8 <_ZN4core3fmt9Formatter3pad17h2ad8f1fda7c6bd10E+0x178>
80205988: 83 46 85 03  	lbu	a3, 56(a0)
8020598c: 8d 47        	addi	a5, zero, 3
8020598e: 01 47        	mv	a4, zero
80205990: 63 83 f6 00  	beq	a3, a5, 0x80205996 <_ZN4core3fmt9Formatter3pad17h2ad8f1fda7c6bd10E+0x166>
80205994: 36 87        	mv	a4, a3
80205996: 93 76 37 00  	andi	a3, a4, 3
8020599a: 91 8d        	sub	a1, a1, a2
8020599c: 95 c6        	beqz	a3, 0x802059c8 <_ZN4core3fmt9Formatter3pad17h2ad8f1fda7c6bd10E+0x198>
8020599e: 05 46        	addi	a2, zero, 1
802059a0: 63 97 c6 02  	bne	a3, a2, 0x802059ce <_ZN4core3fmt9Formatter3pad17h2ad8f1fda7c6bd10E+0x19e>
802059a4: 81 4a        	mv	s5, zero
802059a6: 0d a8        	j	0x802059d8 <_ZN4core3fmt9Formatter3pad17h2ad8f1fda7c6bd10E+0x1a8>
802059a8: 0c 75        	ld	a1, 40(a0)
802059aa: 08 71        	ld	a0, 32(a0)
802059ac: 9c 6d        	ld	a5, 24(a1)
802059ae: ca 85        	mv	a1, s2
802059b0: 4e 86        	mv	a2, s3
802059b2: a2 6b        	ld	s7, 8(sp)
802059b4: 42 6b        	ld	s6, 16(sp)
802059b6: e2 6a        	ld	s5, 24(sp)
802059b8: 02 7a        	ld	s4, 32(sp)
802059ba: a2 79        	ld	s3, 40(sp)
802059bc: 42 79        	ld	s2, 48(sp)
802059be: e2 74        	ld	s1, 56(sp)
802059c0: 06 64        	ld	s0, 64(sp)
802059c2: a6 60        	ld	ra, 72(sp)
802059c4: 61 61        	addi	sp, sp, 80
802059c6: 82 87        	jr	a5
802059c8: ae 8a        	mv	s5, a1
802059ca: 81 45        	mv	a1, zero
802059cc: 31 a0        	j	0x802059d8 <_ZN4core3fmt9Formatter3pad17h2ad8f1fda7c6bd10E+0x1a8>
802059ce: 13 86 15 00  	addi	a2, a1, 1
802059d2: 85 81        	srli	a1, a1, 1
802059d4: 93 5a 16 00  	srli	s5, a2, 1
802059d8: 03 3b 05 02  	ld	s6, 32(a0)
802059dc: 83 3b 85 02  	ld	s7, 40(a0)
802059e0: 03 64 45 03  	lwu	s0, 52(a0)
802059e4: 93 84 15 00  	addi	s1, a1, 1
802059e8: fd 14        	addi	s1, s1, -1
802059ea: 89 c8        	beqz	s1, 0x802059fc <_ZN4core3fmt9Formatter3pad17h2ad8f1fda7c6bd10E+0x1cc>
802059ec: 03 b6 0b 02  	ld	a2, 32(s7)
802059f0: 5a 85        	mv	a0, s6
802059f2: a2 85        	mv	a1, s0
802059f4: 02 96        	jalr	a2
802059f6: 6d d9        	beqz	a0, 0x802059e8 <_ZN4core3fmt9Formatter3pad17h2ad8f1fda7c6bd10E+0x1b8>
802059f8: 05 4a        	addi	s4, zero, 1
802059fa: 91 a0        	j	0x80205a3e <_ZN4core3fmt9Formatter3pad17h2ad8f1fda7c6bd10E+0x20e>
802059fc: 1b 05 04 00  	sext.w	a0, s0
80205a00: b7 05 11 00  	lui	a1, 272
80205a04: 05 4a        	addi	s4, zero, 1
80205a06: 63 0c b5 02  	beq	a0, a1, 0x80205a3e <_ZN4core3fmt9Formatter3pad17h2ad8f1fda7c6bd10E+0x20e>
80205a0a: 83 b6 8b 01  	ld	a3, 24(s7)
80205a0e: 5a 85        	mv	a0, s6
80205a10: ca 85        	mv	a1, s2
80205a12: 4e 86        	mv	a2, s3
80205a14: 82 96        	jalr	a3
80205a16: 05 e5        	bnez	a0, 0x80205a3e <_ZN4core3fmt9Formatter3pad17h2ad8f1fda7c6bd10E+0x20e>
80205a18: 81 44        	mv	s1, zero
80205a1a: 63 8f 9a 00  	beq	s5, s1, 0x80205a38 <_ZN4core3fmt9Formatter3pad17h2ad8f1fda7c6bd10E+0x208>
80205a1e: 03 b6 0b 02  	ld	a2, 32(s7)
80205a22: 85 04        	addi	s1, s1, 1
80205a24: 5a 85        	mv	a0, s6
80205a26: a2 85        	mv	a1, s0
80205a28: 02 96        	jalr	a2
80205a2a: 65 d9        	beqz	a0, 0x80205a1a <_ZN4core3fmt9Formatter3pad17h2ad8f1fda7c6bd10E+0x1ea>
80205a2c: 13 85 f4 ff  	addi	a0, s1, -1
80205a30: 29 a0        	j	0x80205a3a <_ZN4core3fmt9Formatter3pad17h2ad8f1fda7c6bd10E+0x20a>
80205a32: 81 45        	mv	a1, zero
80205a34: 95 d5        	beqz	a1, 0x80205960 <_ZN4core3fmt9Formatter3pad17h2ad8f1fda7c6bd10E+0x130>
80205a36: 1d b7        	j	0x8020595c <_ZN4core3fmt9Formatter3pad17h2ad8f1fda7c6bd10E+0x12c>
80205a38: 56 85        	mv	a0, s5
80205a3a: 33 3a 55 01  	sltu	s4, a0, s5
80205a3e: 52 85        	mv	a0, s4
80205a40: a2 6b        	ld	s7, 8(sp)
80205a42: 42 6b        	ld	s6, 16(sp)
80205a44: e2 6a        	ld	s5, 24(sp)
80205a46: 02 7a        	ld	s4, 32(sp)
80205a48: a2 79        	ld	s3, 40(sp)
80205a4a: 42 79        	ld	s2, 48(sp)
80205a4c: e2 74        	ld	s1, 56(sp)
80205a4e: 06 64        	ld	s0, 64(sp)
80205a50: a6 60        	ld	ra, 72(sp)
80205a52: 61 61        	addi	sp, sp, 80
80205a54: 82 80        	ret

0000000080205a56 <_ZN57_$LT$core..fmt..Formatter$u20$as$u20$core..fmt..Write$GT$9write_str17h8744e0ea0db29488E>:
80205a56: 14 75        	ld	a3, 40(a0)
80205a58: 08 71        	ld	a0, 32(a0)
80205a5a: 9c 6e        	ld	a5, 24(a3)
80205a5c: 82 87        	jr	a5

0000000080205a5e <_ZN4core3fmt9Formatter11debug_tuple17h97a2466d9faa7d3dE>:
80205a5e: 01 11        	addi	sp, sp, -32
80205a60: 06 ec        	sd	ra, 24(sp)
80205a62: 22 e8        	sd	s0, 16(sp)
80205a64: 26 e4        	sd	s1, 8(sp)
80205a66: 4a e0        	sd	s2, 0(sp)
80205a68: 2e 84        	mv	s0, a1
80205a6a: 98 75        	ld	a4, 40(a1)
80205a6c: 8c 71        	ld	a1, 32(a1)
80205a6e: 18 6f        	ld	a4, 24(a4)
80205a70: 36 89        	mv	s2, a3
80205a72: aa 84        	mv	s1, a0
80205a74: 2e 85        	mv	a0, a1
80205a76: b2 85        	mv	a1, a2
80205a78: 36 86        	mv	a2, a3
80205a7a: 02 97        	jalr	a4
80205a7c: 93 35 19 00  	seqz	a1, s2
80205a80: 80 e0        	sd	s0, 0(s1)
80205a82: 23 88 a4 00  	sb	a0, 16(s1)
80205a86: 23 b4 04 00  	sd	zero, 8(s1)
80205a8a: a3 88 b4 00  	sb	a1, 17(s1)
80205a8e: 02 69        	ld	s2, 0(sp)
80205a90: a2 64        	ld	s1, 8(sp)
80205a92: 42 64        	ld	s0, 16(sp)
80205a94: e2 60        	ld	ra, 24(sp)
80205a96: 05 61        	addi	sp, sp, 32
80205a98: 82 80        	ret

0000000080205a9a <_ZN42_$LT$str$u20$as$u20$core..fmt..Display$GT$3fmt17h3dfd0ec49ce6bec3E>:
80205a9a: ae 86        	mv	a3, a1
80205a9c: aa 85        	mv	a1, a0
80205a9e: 32 85        	mv	a0, a2
80205aa0: 36 86        	mv	a2, a3
80205aa2: 17 03 00 00  	auipc	t1, 0
80205aa6: 67 00 e3 d8  	jr	-626(t1)

0000000080205aaa <_ZN41_$LT$char$u20$as$u20$core..fmt..Debug$GT$3fmt17hb07b5469a44c8634E>:
80205aaa: 19 71        	addi	sp, sp, -128
80205aac: 86 fc        	sd	ra, 120(sp)
80205aae: a2 f8        	sd	s0, 112(sp)
80205ab0: a6 f4        	sd	s1, 104(sp)
80205ab2: ca f0        	sd	s2, 96(sp)
80205ab4: ce ec        	sd	s3, 88(sp)
80205ab6: d2 e8        	sd	s4, 80(sp)
80205ab8: d6 e4        	sd	s5, 72(sp)
80205aba: da e0        	sd	s6, 64(sp)
80205abc: 5e fc        	sd	s7, 56(sp)
80205abe: 62 f8        	sd	s8, 48(sp)
80205ac0: 66 f4        	sd	s9, 40(sp)
80205ac2: 90 75        	ld	a2, 40(a1)
80205ac4: 03 ba 05 02  	ld	s4, 32(a1)
80205ac8: 1c 72        	ld	a5, 32(a2)
80205aca: aa 84        	mv	s1, a0
80205acc: 93 05 70 02  	addi	a1, zero, 39
80205ad0: 52 85        	mv	a0, s4
80205ad2: 3e e4        	sd	a5, 8(sp)
80205ad4: 82 97        	jalr	a5
80205ad6: 19 cd        	beqz	a0, 0x80205af4 <_ZN41_$LT$char$u20$as$u20$core..fmt..Debug$GT$3fmt17hb07b5469a44c8634E+0x4a>
80205ad8: 05 45        	addi	a0, zero, 1
80205ada: a2 7c        	ld	s9, 40(sp)
80205adc: 42 7c        	ld	s8, 48(sp)
80205ade: e2 7b        	ld	s7, 56(sp)
80205ae0: 06 6b        	ld	s6, 64(sp)
80205ae2: a6 6a        	ld	s5, 72(sp)
80205ae4: 46 6a        	ld	s4, 80(sp)
80205ae6: e6 69        	ld	s3, 88(sp)
80205ae8: 06 79        	ld	s2, 96(sp)
80205aea: a6 74        	ld	s1, 104(sp)
80205aec: 46 74        	ld	s0, 112(sp)
80205aee: e6 70        	ld	ra, 120(sp)
80205af0: 09 61        	addi	sp, sp, 128
80205af2: 82 80        	ret
80205af4: 8c 40        	lw	a1, 0(s1)
80205af6: 08 08        	addi	a0, sp, 16
80205af8: 13 06 10 10  	addi	a2, zero, 257
80205afc: 97 f0 ff ff  	auipc	ra, 1048575
80205b00: e7 80 20 e3  	jalr	-462(ra)
80205b04: 83 64 01 01  	lwu	s1, 16(sp)
80205b08: 83 6a 41 01  	lwu	s5, 20(sp)
80205b0c: e2 69        	ld	s3, 24(sp)
80205b0e: 03 69 01 02  	lwu	s2, 32(sp)
80205b12: 03 44 41 02  	lbu	s0, 36(sp)
80205b16: 37 05 11 00  	lui	a0, 272
80205b1a: 63 94 aa 08  	bne	s5, a0, 0x80205ba2 <.LBB205_15+0x8>
80205b1e: 89 4a        	addi	s5, zero, 2
80205b20: 0d 4b        	addi	s6, zero, 3

0000000080205b22 <.LBB205_33>:
80205b22: 97 3b 01 00  	auipc	s7, 19
80205b26: 93 8b eb 70  	addi	s7, s7, 1806
80205b2a: 29 4c        	addi	s8, zero, 10
80205b2c: 09 a8        	j	0x80205b3e <.LBB205_5+0x8>

0000000080205b2e <.LBB205_4>:
80205b2e: 8d 44        	addi	s1, zero, 3
80205b30: 93 05 50 07  	addi	a1, zero, 117
80205b34: 0d 44        	addi	s0, zero, 3

0000000080205b36 <.LBB205_5>:
80205b36: 52 85        	mv	a0, s4
80205b38: a2 67        	ld	a5, 8(sp)
80205b3a: 82 97        	jalr	a5
80205b3c: 51 fd        	bnez	a0, 0x80205ad8 <_ZN41_$LT$char$u20$as$u20$core..fmt..Debug$GT$3fmt17hb07b5469a44c8634E+0x2e>
80205b3e: 1b 85 04 00  	sext.w	a0, s1
80205b42: 85 44        	addi	s1, zero, 1
80205b44: 93 05 c0 05  	addi	a1, zero, 92
80205b48: e3 07 55 ff  	beq	a0, s5, 0x80205b36 <.LBB205_5>
80205b4c: 63 13 65 0f  	bne	a0, s6, 0x80205c32 <.LBB205_32>
80205b50: 13 75 f4 0f  	andi	a0, s0, 255
80205b54: 0e 05        	slli	a0, a0, 3
80205b56: 5e 95        	add	a0, a0, s7
80205b58: 08 61        	ld	a0, 0(a0)
80205b5a: 8d 44        	addi	s1, zero, 3
80205b5c: 93 05 d0 07  	addi	a1, zero, 125
80205b60: 01 44        	mv	s0, zero
80205b62: 02 85        	jr	a0

0000000080205b64 <.LBB205_9>:
80205b64: 13 95 29 00  	slli	a0, s3, 2
80205b68: 3b 55 a9 00  	srlw	a0, s2, a0
80205b6c: 3d 89        	andi	a0, a0, 15
80205b6e: 93 05 00 03  	addi	a1, zero, 48
80205b72: 63 64 85 01  	bltu	a0, s8, 0x80205b7a <.LBB205_9+0x16>
80205b76: 93 05 70 05  	addi	a1, zero, 87
80205b7a: 01 46        	mv	a2, zero
80205b7c: 63 84 09 00  	beqz	s3, 0x80205b84 <.LBB205_9+0x20>
80205b80: 13 86 f9 ff  	addi	a2, s3, -1
80205b84: aa 95        	add	a1, a1, a0
80205b86: 13 b5 19 00  	seqz	a0, s3
80205b8a: 33 84 aa 40  	sub	s0, s5, a0
80205b8e: b2 89        	mv	s3, a2
80205b90: 5d b7        	j	0x80205b36 <.LBB205_5>

0000000080205b92 <.LBB205_14>:
80205b92: 09 44        	addi	s0, zero, 2
80205b94: 93 05 b0 07  	addi	a1, zero, 123
80205b98: 79 bf        	j	0x80205b36 <.LBB205_5>

0000000080205b9a <.LBB205_15>:
80205b9a: 11 44        	addi	s0, zero, 4
80205b9c: 93 05 c0 05  	addi	a1, zero, 92
80205ba0: 59 bf        	j	0x80205b36 <.LBB205_5>
80205ba2: 05 4b        	addi	s6, zero, 1
80205ba4: 89 4b        	addi	s7, zero, 2

0000000080205ba6 <.LBB205_34>:
80205ba6: 17 3c 01 00  	auipc	s8, 19
80205baa: 13 0c ac 65  	addi	s8, s8, 1626
80205bae: a9 4c        	addi	s9, zero, 10
80205bb0: 31 a0        	j	0x80205bbc <.LBB205_18+0x8>
80205bb2: 85 44        	addi	s1, zero, 1

0000000080205bb4 <.LBB205_18>:
80205bb4: 52 85        	mv	a0, s4
80205bb6: a2 67        	ld	a5, 8(sp)
80205bb8: 82 97        	jalr	a5
80205bba: 19 fd        	bnez	a0, 0x80205ad8 <_ZN41_$LT$char$u20$as$u20$core..fmt..Debug$GT$3fmt17hb07b5469a44c8634E+0x2e>
80205bbc: 1b 85 04 00  	sext.w	a0, s1
80205bc0: 63 57 ab 04  	bge	s6, a0, 0x80205c0e <.LBB205_22+0x2e>
80205bc4: 93 05 c0 05  	addi	a1, zero, 92
80205bc8: e3 05 75 ff  	beq	a0, s7, 0x80205bb2 <.LBB205_34+0xc>
80205bcc: 13 75 f4 0f  	andi	a0, s0, 255
80205bd0: 0e 05        	slli	a0, a0, 3
80205bd2: 62 95        	add	a0, a0, s8
80205bd4: 08 61        	ld	a0, 0(a0)
80205bd6: 8d 44        	addi	s1, zero, 3
80205bd8: 93 05 d0 07  	addi	a1, zero, 125
80205bdc: 01 44        	mv	s0, zero
80205bde: 02 85        	jr	a0

0000000080205be0 <.LBB205_22>:
80205be0: 13 95 29 00  	slli	a0, s3, 2
80205be4: 3b 55 a9 00  	srlw	a0, s2, a0
80205be8: 3d 89        	andi	a0, a0, 15
80205bea: 93 05 00 03  	addi	a1, zero, 48
80205bee: 63 64 95 01  	bltu	a0, s9, 0x80205bf6 <.LBB205_22+0x16>
80205bf2: 93 05 70 05  	addi	a1, zero, 87
80205bf6: 01 46        	mv	a2, zero
80205bf8: 63 84 09 00  	beqz	s3, 0x80205c00 <.LBB205_22+0x20>
80205bfc: 13 86 f9 ff  	addi	a2, s3, -1
80205c00: aa 95        	add	a1, a1, a0
80205c02: 13 b5 19 00  	seqz	a0, s3
80205c06: 33 84 ab 40  	sub	s0, s7, a0
80205c0a: b2 89        	mv	s3, a2
80205c0c: 65 b7        	j	0x80205bb4 <.LBB205_18>
80205c0e: 63 12 65 03  	bne	a0, s6, 0x80205c32 <.LBB205_32>
80205c12: 81 44        	mv	s1, zero
80205c14: d6 85        	mv	a1, s5
80205c16: 79 bf        	j	0x80205bb4 <.LBB205_18>

0000000080205c18 <.LBB205_29>:
80205c18: 09 44        	addi	s0, zero, 2
80205c1a: 93 05 b0 07  	addi	a1, zero, 123
80205c1e: 59 bf        	j	0x80205bb4 <.LBB205_18>

0000000080205c20 <.LBB205_30>:
80205c20: 8d 44        	addi	s1, zero, 3
80205c22: 93 05 50 07  	addi	a1, zero, 117
80205c26: 0d 44        	addi	s0, zero, 3
80205c28: 71 b7        	j	0x80205bb4 <.LBB205_18>

0000000080205c2a <.LBB205_31>:
80205c2a: 11 44        	addi	s0, zero, 4
80205c2c: 93 05 c0 05  	addi	a1, zero, 92
80205c30: 51 b7        	j	0x80205bb4 <.LBB205_18>

0000000080205c32 <.LBB205_32>:
80205c32: 93 05 70 02  	addi	a1, zero, 39
80205c36: 52 85        	mv	a0, s4
80205c38: a2 67        	ld	a5, 8(sp)
80205c3a: a2 7c        	ld	s9, 40(sp)
80205c3c: 42 7c        	ld	s8, 48(sp)
80205c3e: e2 7b        	ld	s7, 56(sp)
80205c40: 06 6b        	ld	s6, 64(sp)
80205c42: a6 6a        	ld	s5, 72(sp)
80205c44: 46 6a        	ld	s4, 80(sp)
80205c46: e6 69        	ld	s3, 88(sp)
80205c48: 06 79        	ld	s2, 96(sp)
80205c4a: a6 74        	ld	s1, 104(sp)
80205c4c: 46 74        	ld	s0, 112(sp)
80205c4e: e6 70        	ld	ra, 120(sp)
80205c50: 09 61        	addi	sp, sp, 128
80205c52: 82 87        	jr	a5

0000000080205c54 <_ZN4core5slice5index26slice_start_index_len_fail17hca80252e820fb2a8E>:
80205c54: 59 71        	addi	sp, sp, -112
80205c56: 86 f4        	sd	ra, 104(sp)
80205c58: 2a e4        	sd	a0, 8(sp)
80205c5a: 2e e8        	sd	a1, 16(sp)
80205c5c: 28 00        	addi	a0, sp, 8
80205c5e: aa e4        	sd	a0, 72(sp)

0000000080205c60 <.LBB218_1>:
80205c60: 17 15 00 00  	auipc	a0, 1
80205c64: 13 05 c5 b3  	addi	a0, a0, -1220
80205c68: aa e8        	sd	a0, 80(sp)
80205c6a: 0c 08        	addi	a1, sp, 16
80205c6c: ae ec        	sd	a1, 88(sp)
80205c6e: aa f0        	sd	a0, 96(sp)

0000000080205c70 <.LBB218_2>:
80205c70: 17 45 01 00  	auipc	a0, 20
80205c74: 13 05 85 95  	addi	a0, a0, -1704
80205c78: 2a ec        	sd	a0, 24(sp)
80205c7a: 09 45        	addi	a0, zero, 2
80205c7c: 2a f0        	sd	a0, 32(sp)
80205c7e: 02 f4        	sd	zero, 40(sp)
80205c80: ac 00        	addi	a1, sp, 72
80205c82: 2e fc        	sd	a1, 56(sp)
80205c84: aa e0        	sd	a0, 64(sp)
80205c86: 28 08        	addi	a0, sp, 24
80205c88: b2 85        	mv	a1, a2
80205c8a: 97 f0 ff ff  	auipc	ra, 1048575
80205c8e: e7 80 e0 f8  	jalr	-114(ra)
80205c92: 00 00        	unimp	

0000000080205c94 <_ZN4core5slice5index24slice_end_index_len_fail17h871a267f43d53e59E>:
80205c94: 59 71        	addi	sp, sp, -112
80205c96: 86 f4        	sd	ra, 104(sp)
80205c98: 2a e4        	sd	a0, 8(sp)
80205c9a: 2e e8        	sd	a1, 16(sp)
80205c9c: 28 00        	addi	a0, sp, 8
80205c9e: aa e4        	sd	a0, 72(sp)

0000000080205ca0 <.LBB219_1>:
80205ca0: 17 15 00 00  	auipc	a0, 1
80205ca4: 13 05 c5 af  	addi	a0, a0, -1284
80205ca8: aa e8        	sd	a0, 80(sp)
80205caa: 0c 08        	addi	a1, sp, 16
80205cac: ae ec        	sd	a1, 88(sp)
80205cae: aa f0        	sd	a0, 96(sp)

0000000080205cb0 <.LBB219_2>:
80205cb0: 17 45 01 00  	auipc	a0, 20
80205cb4: 13 05 85 93  	addi	a0, a0, -1736
80205cb8: 2a ec        	sd	a0, 24(sp)
80205cba: 09 45        	addi	a0, zero, 2
80205cbc: 2a f0        	sd	a0, 32(sp)
80205cbe: 02 f4        	sd	zero, 40(sp)
80205cc0: ac 00        	addi	a1, sp, 72
80205cc2: 2e fc        	sd	a1, 56(sp)
80205cc4: aa e0        	sd	a0, 64(sp)
80205cc6: 28 08        	addi	a0, sp, 24
80205cc8: b2 85        	mv	a1, a2
80205cca: 97 f0 ff ff  	auipc	ra, 1048575
80205cce: e7 80 e0 f4  	jalr	-178(ra)
80205cd2: 00 00        	unimp	

0000000080205cd4 <_ZN4core5slice5index22slice_index_order_fail17hfa5b32f3ae7c6778E>:
80205cd4: 59 71        	addi	sp, sp, -112
80205cd6: 86 f4        	sd	ra, 104(sp)
80205cd8: 2a e4        	sd	a0, 8(sp)
80205cda: 2e e8        	sd	a1, 16(sp)
80205cdc: 28 00        	addi	a0, sp, 8
80205cde: aa e4        	sd	a0, 72(sp)

0000000080205ce0 <.LBB220_1>:
80205ce0: 17 15 00 00  	auipc	a0, 1
80205ce4: 13 05 c5 ab  	addi	a0, a0, -1348
80205ce8: aa e8        	sd	a0, 80(sp)
80205cea: 0c 08        	addi	a1, sp, 16
80205cec: ae ec        	sd	a1, 88(sp)
80205cee: aa f0        	sd	a0, 96(sp)

0000000080205cf0 <.LBB220_2>:
80205cf0: 17 45 01 00  	auipc	a0, 20
80205cf4: 13 05 05 94  	addi	a0, a0, -1728
80205cf8: 2a ec        	sd	a0, 24(sp)
80205cfa: 09 45        	addi	a0, zero, 2
80205cfc: 2a f0        	sd	a0, 32(sp)
80205cfe: 02 f4        	sd	zero, 40(sp)
80205d00: ac 00        	addi	a1, sp, 72
80205d02: 2e fc        	sd	a1, 56(sp)
80205d04: aa e0        	sd	a0, 64(sp)
80205d06: 28 08        	addi	a0, sp, 24
80205d08: b2 85        	mv	a1, a2
80205d0a: 97 f0 ff ff  	auipc	ra, 1048575
80205d0e: e7 80 e0 f0  	jalr	-242(ra)
80205d12: 00 00        	unimp	

0000000080205d14 <_ZN4core5slice29_$LT$impl$u20$$u5b$T$u5d$$GT$15copy_from_slice17len_mismatch_fail17hf16cd66568d16da8E>:
80205d14: 59 71        	addi	sp, sp, -112
80205d16: 86 f4        	sd	ra, 104(sp)
80205d18: 2a e4        	sd	a0, 8(sp)
80205d1a: 2e e8        	sd	a1, 16(sp)
80205d1c: 08 08        	addi	a0, sp, 16
80205d1e: aa e4        	sd	a0, 72(sp)

0000000080205d20 <.LBB227_1>:
80205d20: 17 15 00 00  	auipc	a0, 1
80205d24: 13 05 c5 a7  	addi	a0, a0, -1412
80205d28: aa e8        	sd	a0, 80(sp)
80205d2a: 2c 00        	addi	a1, sp, 8
80205d2c: ae ec        	sd	a1, 88(sp)
80205d2e: aa f0        	sd	a0, 96(sp)

0000000080205d30 <.LBB227_2>:
80205d30: 17 45 01 00  	auipc	a0, 20
80205d34: 13 05 05 96  	addi	a0, a0, -1696
80205d38: 2a ec        	sd	a0, 24(sp)
80205d3a: 0d 45        	addi	a0, zero, 3
80205d3c: 2a f0        	sd	a0, 32(sp)
80205d3e: 02 f4        	sd	zero, 40(sp)
80205d40: a8 00        	addi	a0, sp, 72
80205d42: 2a fc        	sd	a0, 56(sp)
80205d44: 09 45        	addi	a0, zero, 2
80205d46: aa e0        	sd	a0, 64(sp)
80205d48: 28 08        	addi	a0, sp, 24
80205d4a: b2 85        	mv	a1, a2
80205d4c: 97 f0 ff ff  	auipc	ra, 1048575
80205d50: e7 80 c0 ec  	jalr	-308(ra)
80205d54: 00 00        	unimp	

0000000080205d56 <_ZN4core3str8converts9from_utf817hfd2450fc461c6f2fE>:
80205d56: 1d 71        	addi	sp, sp, -96
80205d58: a2 ec        	sd	s0, 88(sp)
80205d5a: a6 e8        	sd	s1, 80(sp)
80205d5c: ca e4        	sd	s2, 72(sp)
80205d5e: ce e0        	sd	s3, 64(sp)
80205d60: 52 fc        	sd	s4, 56(sp)
80205d62: 56 f8        	sd	s5, 48(sp)
80205d64: 5a f4        	sd	s6, 40(sp)
80205d66: 5e f0        	sd	s7, 32(sp)
80205d68: 62 ec        	sd	s8, 24(sp)
80205d6a: 66 e8        	sd	s9, 16(sp)
80205d6c: 6a e4        	sd	s10, 8(sp)
80205d6e: 6e e0        	sd	s11, 0(sp)
80205d70: 93 06 16 ff  	addi	a3, a2, -15
80205d74: 01 4d        	mv	s10, zero
80205d76: 63 63 d6 00  	bltu	a2, a3, 0x80205d7c <_ZN4core3str8converts9from_utf817hfd2450fc461c6f2fE+0x26>
80205d7a: 36 8d        	mv	s10, a3
80205d7c: 63 0a 06 1e  	beqz	a2, 0x80205f70 <.LBB228_49+0x1dc>
80205d80: 81 46        	mv	a3, zero
80205d82: 13 87 75 00  	addi	a4, a1, 7
80205d86: 61 9b        	andi	a4, a4, -8
80205d88: 33 08 b7 40  	sub	a6, a4, a1
80205d8c: 13 07 18 00  	addi	a4, a6, 1
80205d90: 93 3c 17 00  	seqz	s9, a4

0000000080205d94 <.LBB228_49>:
80205d94: 97 48 01 00  	auipc	a7, 20
80205d98: 93 88 f8 94  	addi	a7, a7, -1713
80205d9c: 91 42        	addi	t0, zero, 4
80205d9e: 13 03 00 0f  	addi	t1, zero, 240
80205da2: 93 03 00 03  	addi	t2, zero, 48
80205da6: 13 0e f0 fb  	addi	t3, zero, -65
80205daa: 93 0e 40 0f  	addi	t4, zero, 244
80205dae: 7d 5f        	addi	t5, zero, -1
80205db0: 93 0f f0 08  	addi	t6, zero, 143
80205db4: 0d 4c        	addi	s8, zero, 3
80205db6: 13 0b 00 0e  	addi	s6, zero, 224
80205dba: 13 09 00 0a  	addi	s2, zero, 160
80205dbe: 93 09 d0 0e  	addi	s3, zero, 237
80205dc2: 31 4a        	addi	s4, zero, 12
80205dc4: 93 0a f0 0b  	addi	s5, zero, 191
80205dc8: 89 4b        	addi	s7, zero, 2
80205dca: 37 17 10 f0  	lui	a4, 983297
80205dce: 12 07        	slli	a4, a4, 4
80205dd0: 13 07 17 10  	addi	a4, a4, 257
80205dd4: 42 07        	slli	a4, a4, 16
80205dd6: 13 07 17 10  	addi	a4, a4, 257
80205dda: 3e 07        	slli	a4, a4, 15
80205ddc: 93 04 07 08  	addi	s1, a4, 128
80205de0: 21 a0        	j	0x80205de8 <.LBB228_49+0x54>
80205de2: 85 06        	addi	a3, a3, 1
80205de4: 63 f6 c6 18  	bgeu	a3, a2, 0x80205f70 <.LBB228_49+0x1dc>
80205de8: 33 87 d5 00  	add	a4, a1, a3
80205dec: 83 47 07 00  	lbu	a5, 0(a4)
80205df0: 13 97 87 03  	slli	a4, a5, 56
80205df4: 13 54 87 43  	srai	s0, a4, 56
80205df8: 63 40 04 04  	bltz	s0, 0x80205e38 <.LBB228_49+0xa4>
80205dfc: e3 93 0c fe  	bnez	s9, 0x80205de2 <.LBB228_49+0x4e>
80205e00: 33 07 d8 40  	sub	a4, a6, a3
80205e04: 1d 8b        	andi	a4, a4, 7
80205e06: 71 ff        	bnez	a4, 0x80205de2 <.LBB228_49+0x4e>
80205e08: 63 fc a6 01  	bgeu	a3, s10, 0x80205e20 <.LBB228_49+0x8c>
80205e0c: 33 87 d5 00  	add	a4, a1, a3
80205e10: 1c 63        	ld	a5, 0(a4)
80205e12: 18 67        	ld	a4, 8(a4)
80205e14: 5d 8f        	or	a4, a4, a5
80205e16: 65 8f        	and	a4, a4, s1
80205e18: 01 e7        	bnez	a4, 0x80205e20 <.LBB228_49+0x8c>
80205e1a: c1 06        	addi	a3, a3, 16
80205e1c: e3 e8 a6 ff  	bltu	a3, s10, 0x80205e0c <.LBB228_49+0x78>
80205e20: 63 f6 c6 14  	bgeu	a3, a2, 0x80205f6c <.LBB228_49+0x1d8>
80205e24: 33 87 d5 00  	add	a4, a1, a3
80205e28: 03 07 07 00  	lb	a4, 0(a4)
80205e2c: 63 40 07 14  	bltz	a4, 0x80205f6c <.LBB228_49+0x1d8>
80205e30: 85 06        	addi	a3, a3, 1
80205e32: e3 19 d6 fe  	bne	a2, a3, 0x80205e24 <.LBB228_49+0x90>
80205e36: 2d aa        	j	0x80205f70 <.LBB228_49+0x1dc>
80205e38: 33 87 17 01  	add	a4, a5, a7
80205e3c: 03 47 07 00  	lbu	a4, 0(a4)
80205e40: 63 01 57 02  	beq	a4, t0, 0x80205e62 <.LBB228_49+0xce>
80205e44: 63 04 87 05  	beq	a4, s8, 0x80205e8c <.LBB228_49+0xf8>
80205e48: 63 1b 77 13  	bne	a4, s7, 0x80205f7e <.LBB228_49+0x1ea>
80205e4c: 13 87 16 00  	addi	a4, a3, 1
80205e50: 63 74 c7 12  	bgeu	a4, a2, 0x80205f78 <.LBB228_49+0x1e4>
80205e54: b3 87 e5 00  	add	a5, a1, a4
80205e58: 83 87 07 00  	lb	a5, 0(a5)
80205e5c: 63 56 fe 10  	bge	t3, a5, 0x80205f68 <.LBB228_49+0x1d4>
80205e60: 39 aa        	j	0x80205f7e <.LBB228_49+0x1ea>
80205e62: 13 87 16 00  	addi	a4, a3, 1
80205e66: 63 79 c7 10  	bgeu	a4, a2, 0x80205f78 <.LBB228_49+0x1e4>
80205e6a: 2e 97        	add	a4, a4, a1
80205e6c: 03 47 07 00  	lbu	a4, 0(a4)
80205e70: 63 84 67 04  	beq	a5, t1, 0x80205eb8 <.LBB228_49+0x124>
80205e74: 63 99 d7 05  	bne	a5, t4, 0x80205ec6 <.LBB228_49+0x132>
80205e78: 93 17 87 03  	slli	a5, a4, 56
80205e7c: e1 97        	srai	a5, a5, 56
80205e7e: b3 27 ff 00  	slt	a5, t5, a5
80205e82: 33 b7 ef 00  	sltu	a4, t6, a4
80205e86: 5d 8f        	or	a4, a4, a5
80205e88: 39 cf        	beqz	a4, 0x80205ee6 <.LBB228_49+0x152>
80205e8a: d5 a8        	j	0x80205f7e <.LBB228_49+0x1ea>
80205e8c: 13 87 16 00  	addi	a4, a3, 1
80205e90: 63 74 c7 0e  	bgeu	a4, a2, 0x80205f78 <.LBB228_49+0x1e4>
80205e94: 2e 97        	add	a4, a4, a1
80205e96: 03 47 07 00  	lbu	a4, 0(a4)
80205e9a: 63 8b 67 07  	beq	a5, s6, 0x80205f10 <.LBB228_49+0x17c>
80205e9e: 93 1d 87 03  	slli	s11, a4, 56
80205ea2: 63 9c 37 07  	bne	a5, s3, 0x80205f1a <.LBB228_49+0x186>
80205ea6: 93 d7 8d 43  	srai	a5, s11, 56
80205eaa: 93 a7 07 00  	slti	a5, a5, 0
80205eae: 13 37 07 0a  	sltiu	a4, a4, 160
80205eb2: 7d 8f        	and	a4, a4, a5
80205eb4: 45 e3        	bnez	a4, 0x80205f54 <.LBB228_49+0x1c0>
80205eb6: e1 a0        	j	0x80205f7e <.LBB228_49+0x1ea>
80205eb8: 13 07 07 07  	addi	a4, a4, 112
80205ebc: 13 77 f7 0f  	andi	a4, a4, 255
80205ec0: 63 63 77 02  	bltu	a4, t2, 0x80205ee6 <.LBB228_49+0x152>
80205ec4: 6d a8        	j	0x80205f7e <.LBB228_49+0x1ea>
80205ec6: 93 07 f4 00  	addi	a5, s0, 15
80205eca: 93 f7 f7 0f  	andi	a5, a5, 255
80205ece: 93 b7 37 00  	sltiu	a5, a5, 3
80205ed2: 13 14 87 03  	slli	s0, a4, 56
80205ed6: 61 94        	srai	s0, s0, 56
80205ed8: 13 24 04 00  	slti	s0, s0, 0
80205edc: e1 8f        	and	a5, a5, s0
80205ede: 13 37 07 0c  	sltiu	a4, a4, 192
80205ee2: 7d 8f        	and	a4, a4, a5
80205ee4: 49 cf        	beqz	a4, 0x80205f7e <.LBB228_49+0x1ea>
80205ee6: 13 87 26 00  	addi	a4, a3, 2
80205eea: 63 77 c7 08  	bgeu	a4, a2, 0x80205f78 <.LBB228_49+0x1e4>
80205eee: 2e 97        	add	a4, a4, a1
80205ef0: 03 07 07 00  	lb	a4, 0(a4)
80205ef4: 05 44        	addi	s0, zero, 1
80205ef6: 63 47 ee 0c  	blt	t3, a4, 0x80205fc4 <.LBB228_49+0x230>
80205efa: 13 87 36 00  	addi	a4, a3, 3
80205efe: 63 7d c7 06  	bgeu	a4, a2, 0x80205f78 <.LBB228_49+0x1e4>
80205f02: b3 87 e5 00  	add	a5, a1, a4
80205f06: 83 87 07 00  	lb	a5, 0(a5)
80205f0a: 63 5f fe 04  	bge	t3, a5, 0x80205f68 <.LBB228_49+0x1d4>
80205f0e: 6d a8        	j	0x80205fc8 <.LBB228_49+0x234>
80205f10: 13 77 07 0e  	andi	a4, a4, 224
80205f14: 63 00 27 05  	beq	a4, s2, 0x80205f54 <.LBB228_49+0x1c0>
80205f18: 9d a0        	j	0x80205f7e <.LBB228_49+0x1ea>
80205f1a: 93 07 f4 01  	addi	a5, s0, 31
80205f1e: 93 f7 f7 0f  	andi	a5, a5, 255
80205f22: 63 fb 47 01  	bgeu	a5, s4, 0x80205f38 <.LBB228_49+0x1a4>
80205f26: 93 d7 8d 43  	srai	a5, s11, 56
80205f2a: b3 27 ff 00  	slt	a5, t5, a5
80205f2e: 33 b7 ea 00  	sltu	a4, s5, a4
80205f32: 5d 8f        	or	a4, a4, a5
80205f34: 05 c3        	beqz	a4, 0x80205f54 <.LBB228_49+0x1c0>
80205f36: a1 a0        	j	0x80205f7e <.LBB228_49+0x1ea>
80205f38: 93 77 e4 ff  	andi	a5, s0, -2
80205f3c: c9 07        	addi	a5, a5, 18
80205f3e: 93 b7 17 00  	seqz	a5, a5
80205f42: 13 d4 8d 43  	srai	s0, s11, 56
80205f46: 13 24 04 00  	slti	s0, s0, 0
80205f4a: e1 8f        	and	a5, a5, s0
80205f4c: 13 37 07 0c  	sltiu	a4, a4, 192
80205f50: 7d 8f        	and	a4, a4, a5
80205f52: 15 c7        	beqz	a4, 0x80205f7e <.LBB228_49+0x1ea>
80205f54: 13 87 26 00  	addi	a4, a3, 2
80205f58: 63 70 c7 02  	bgeu	a4, a2, 0x80205f78 <.LBB228_49+0x1e4>
80205f5c: b3 87 e5 00  	add	a5, a1, a4
80205f60: 83 87 07 00  	lb	a5, 0(a5)
80205f64: 63 44 fe 06  	blt	t3, a5, 0x80205fcc <.LBB228_49+0x238>
80205f68: 93 06 17 00  	addi	a3, a4, 1
80205f6c: e3 ee c6 e6  	bltu	a3, a2, 0x80205de8 <.LBB228_49+0x54>
80205f70: 81 46        	mv	a3, zero
80205f72: 0c e5        	sd	a1, 8(a0)
80205f74: 10 e9        	sd	a2, 16(a0)
80205f76: 05 a8        	j	0x80205fa6 <.LBB228_49+0x212>
80205f78: 81 45        	mv	a1, zero
80205f7a: 01 44        	mv	s0, zero
80205f7c: 19 a0        	j	0x80205f82 <.LBB228_49+0x1ee>
80205f7e: 85 45        	addi	a1, zero, 1
80205f80: 05 44        	addi	s0, zero, 1
80205f82: 14 e5        	sd	a3, 8(a0)
80205f84: 23 08 85 00  	sb	s0, 16(a0)
80205f88: 23 0b 05 00  	sb	zero, 22(a0)
80205f8c: a3 0a 05 00  	sb	zero, 21(a0)
80205f90: a3 0b 05 00  	sb	zero, 23(a0)
80205f94: 23 0a 05 00  	sb	zero, 20(a0)
80205f98: a3 09 05 00  	sb	zero, 19(a0)
80205f9c: 23 09 05 00  	sb	zero, 18(a0)
80205fa0: a3 08 b5 00  	sb	a1, 17(a0)
80205fa4: 85 46        	addi	a3, zero, 1
80205fa6: 14 e1        	sd	a3, 0(a0)
80205fa8: 82 6d        	ld	s11, 0(sp)
80205faa: 22 6d        	ld	s10, 8(sp)
80205fac: c2 6c        	ld	s9, 16(sp)
80205fae: 62 6c        	ld	s8, 24(sp)
80205fb0: 82 7b        	ld	s7, 32(sp)
80205fb2: 22 7b        	ld	s6, 40(sp)
80205fb4: c2 7a        	ld	s5, 48(sp)
80205fb6: 62 7a        	ld	s4, 56(sp)
80205fb8: 86 69        	ld	s3, 64(sp)
80205fba: 26 69        	ld	s2, 72(sp)
80205fbc: c6 64        	ld	s1, 80(sp)
80205fbe: 66 64        	ld	s0, 88(sp)
80205fc0: 25 61        	addi	sp, sp, 96
80205fc2: 82 80        	ret
80205fc4: 89 45        	addi	a1, zero, 2
80205fc6: 75 bf        	j	0x80205f82 <.LBB228_49+0x1ee>
80205fc8: 8d 45        	addi	a1, zero, 3
80205fca: 65 bf        	j	0x80205f82 <.LBB228_49+0x1ee>
80205fcc: 05 44        	addi	s0, zero, 1
80205fce: 89 45        	addi	a1, zero, 2
80205fd0: 4d bf        	j	0x80205f82 <.LBB228_49+0x1ee>

0000000080205fd2 <_ZN4core3str16slice_error_fail17h6e9a4145ee0b8909E>:
80205fd2: 15 71        	addi	sp, sp, -224
80205fd4: 86 ed        	sd	ra, 216(sp)
80205fd6: 32 e4        	sd	a2, 8(sp)
80205fd8: 93 07 10 10  	addi	a5, zero, 257
80205fdc: 36 e8        	sd	a3, 16(sp)
80205fde: 63 fb f5 00  	bgeu	a1, a5, 0x80205ff4 <.LBB244_43+0x10>
80205fe2: 01 48        	mv	a6, zero

0000000080205fe4 <.LBB244_43>:
80205fe4: 97 37 01 00  	auipc	a5, 19
80205fe8: 93 87 c7 27  	addi	a5, a5, 636
80205fec: 3e f4        	sd	a5, 40(sp)
80205fee: 2a ec        	sd	a0, 24(sp)
80205ff0: 2e f0        	sd	a1, 32(sp)
80205ff2: 3d a8        	j	0x80206030 <.LBB244_44+0xc>
80205ff4: 93 08 00 10  	addi	a7, zero, 256
80205ff8: 13 08 00 fc  	addi	a6, zero, -64
80205ffc: b3 07 15 01  	add	a5, a0, a7
80206000: 83 87 07 00  	lb	a5, 0(a5)
80206004: 63 d7 07 01  	bge	a5, a6, 0x80206012 <.LBB244_43+0x2e>
80206008: fd 18        	addi	a7, a7, -1
8020600a: e3 99 08 fe  	bnez	a7, 0x80205ffc <.LBB244_43+0x18>
8020600e: 01 48        	mv	a6, zero
80206010: 01 a8        	j	0x80206020 <.LBB244_43+0x3c>
80206012: 63 f4 b8 00  	bgeu	a7, a1, 0x8020601a <.LBB244_43+0x36>
80206016: 46 88        	mv	a6, a7
80206018: 21 a0        	j	0x80206020 <.LBB244_43+0x3c>
8020601a: 2e 88        	mv	a6, a1
8020601c: 63 96 15 0d  	bne	a1, a7, 0x802060e8 <.LBB244_51>
80206020: 2a ec        	sd	a0, 24(sp)
80206022: 42 f0        	sd	a6, 32(sp)

0000000080206024 <.LBB244_44>:
80206024: 97 37 01 00  	auipc	a5, 19
80206028: 93 87 c7 7d  	addi	a5, a5, 2012
8020602c: 3e f4        	sd	a5, 40(sp)
8020602e: 15 48        	addi	a6, zero, 5
80206030: b3 b8 c5 00  	sltu	a7, a1, a2
80206034: b3 b7 d5 00  	sltu	a5, a1, a3
80206038: b3 e7 f8 00  	or	a5, a7, a5
8020603c: 42 f8        	sd	a6, 48(sp)
8020603e: 8d cf        	beqz	a5, 0x80206078 <.LBB244_47+0xe>
80206040: 63 93 08 00  	bnez	a7, 0x80206046 <.LBB244_44+0x22>
80206044: 36 86        	mv	a2, a3
80206046: b2 e4        	sd	a2, 72(sp)
80206048: a8 00        	addi	a0, sp, 72
8020604a: 2a e5        	sd	a0, 136(sp)

000000008020604c <.LBB244_45>:
8020604c: 17 05 00 00  	auipc	a0, 0
80206050: 13 05 05 75  	addi	a0, a0, 1872
80206054: 2a e9        	sd	a0, 144(sp)
80206056: 28 08        	addi	a0, sp, 24
80206058: 2a ed        	sd	a0, 152(sp)

000000008020605a <.LBB244_46>:
8020605a: 17 15 00 00  	auipc	a0, 1
8020605e: 13 05 85 84  	addi	a0, a0, -1976
80206062: 2a f1        	sd	a0, 160(sp)
80206064: 2c 10        	addi	a1, sp, 40
80206066: 2e f5        	sd	a1, 168(sp)
80206068: 2a f9        	sd	a0, 176(sp)

000000008020606a <.LBB244_47>:
8020606a: 17 35 01 00  	auipc	a0, 19
8020606e: 13 05 e5 7b  	addi	a0, a0, 1982
80206072: aa ec        	sd	a0, 88(sp)
80206074: 0d 45        	addi	a0, zero, 3
80206076: 41 aa        	j	0x80206206 <.LBB244_57+0xc>
80206078: 63 fd c6 02  	bgeu	a3, a2, 0x802060b2 <.LBB244_50+0xe>
8020607c: 28 00        	addi	a0, sp, 8
8020607e: 2a e5        	sd	a0, 136(sp)

0000000080206080 <.LBB244_48>:
80206080: 17 05 00 00  	auipc	a0, 0
80206084: 13 05 c5 71  	addi	a0, a0, 1820
80206088: 2a e9        	sd	a0, 144(sp)
8020608a: 0c 08        	addi	a1, sp, 16
8020608c: 2e ed        	sd	a1, 152(sp)
8020608e: 2a f1        	sd	a0, 160(sp)
80206090: 28 08        	addi	a0, sp, 24
80206092: 2a f5        	sd	a0, 168(sp)

0000000080206094 <.LBB244_49>:
80206094: 17 15 00 00  	auipc	a0, 1
80206098: 13 05 e5 80  	addi	a0, a0, -2034
8020609c: 2a f9        	sd	a0, 176(sp)
8020609e: 2c 10        	addi	a1, sp, 40
802060a0: 2e fd        	sd	a1, 184(sp)
802060a2: aa e1        	sd	a0, 192(sp)

00000000802060a4 <.LBB244_50>:
802060a4: 17 35 01 00  	auipc	a0, 19
802060a8: 13 05 45 7c  	addi	a0, a0, 1988
802060ac: aa ec        	sd	a0, 88(sp)
802060ae: 11 45        	addi	a0, zero, 4
802060b0: 99 aa        	j	0x80206206 <.LBB244_57+0xc>
802060b2: 05 e2        	bnez	a2, 0x802060d2 <.LBB244_50+0x2e>
802060b4: 36 fc        	sd	a3, 56(sp)
802060b6: a1 ea        	bnez	a3, 0x80206106 <.LBB244_51+0x1e>
802060b8: 81 46        	mv	a3, zero
802060ba: 63 85 b6 06  	beq	a3, a1, 0x80206124 <.LBB244_52>
802060be: 36 95        	add	a0, a0, a3
802060c0: 03 06 05 00  	lb	a2, 0(a0)
802060c4: 93 75 f6 0f  	andi	a1, a2, 255
802060c8: 63 4a 06 06  	bltz	a2, 0x8020613c <.LBB244_52+0x18>
802060cc: ae c2        	sw	a1, 68(sp)
802060ce: 85 45        	addi	a1, zero, 1
802060d0: d5 a0        	j	0x802061b4 <.LBB244_52+0x90>
802060d2: 63 76 b6 02  	bgeu	a2, a1, 0x802060fe <.LBB244_51+0x16>
802060d6: b3 07 c5 00  	add	a5, a0, a2
802060da: 03 88 07 00  	lb	a6, 0(a5)
802060de: 93 07 f0 fb  	addi	a5, zero, -65
802060e2: e3 c9 07 fd  	blt	a5, a6, 0x802060b4 <.LBB244_50+0x10>
802060e6: 31 a8        	j	0x80206102 <.LBB244_51+0x1a>

00000000802060e8 <.LBB244_51>:
802060e8: 17 37 01 00  	auipc	a4, 19
802060ec: 13 07 07 70  	addi	a4, a4, 1792
802060f0: 01 46        	mv	a2, zero
802060f2: c6 86        	mv	a3, a7
802060f4: 97 00 00 00  	auipc	ra, 0
802060f8: e7 80 e0 ed  	jalr	-290(ra)
802060fc: 00 00        	unimp	
802060fe: e3 8b c5 fa  	beq	a1, a2, 0x802060b4 <.LBB244_50+0x10>
80206102: 32 fc        	sd	a2, 56(sp)
80206104: b2 86        	mv	a3, a2
80206106: 13 06 f0 fb  	addi	a2, zero, -65
8020610a: 09 a8        	j	0x8020611c <.LBB244_51+0x34>
8020610c: b3 07 d5 00  	add	a5, a0, a3
80206110: 83 87 07 00  	lb	a5, 0(a5)
80206114: e3 43 f6 fa  	blt	a2, a5, 0x802060ba <.LBB244_50+0x16>
80206118: fd 16        	addi	a3, a3, -1
8020611a: d9 de        	beqz	a3, 0x802060b8 <.LBB244_50+0x14>
8020611c: e3 e8 b6 fe  	bltu	a3, a1, 0x8020610c <.LBB244_51+0x24>
80206120: e3 9c d5 fe  	bne	a1, a3, 0x80206118 <.LBB244_51+0x30>

0000000080206124 <.LBB244_52>:
80206124: 17 35 01 00  	auipc	a0, 19
80206128: 13 05 25 17  	addi	a0, a0, 370
8020612c: 93 05 b0 02  	addi	a1, zero, 43
80206130: 3a 86        	mv	a2, a4
80206132: 97 f0 ff ff  	auipc	ra, 1048575
80206136: e7 80 a0 a7  	jalr	-1414(ra)
8020613a: 00 00        	unimp	
8020613c: 83 47 15 00  	lbu	a5, 1(a0)
80206140: 13 f6 f5 01  	andi	a2, a1, 31
80206144: 13 08 f0 0d  	addi	a6, zero, 223
80206148: 93 f7 f7 03  	andi	a5, a5, 63
8020614c: 63 7e b8 02  	bgeu	a6, a1, 0x80206188 <.LBB244_52+0x64>
80206150: 03 48 25 00  	lbu	a6, 2(a0)
80206154: 93 98 67 00  	slli	a7, a5, 6
80206158: 93 77 f8 03  	andi	a5, a6, 63
8020615c: 13 08 00 0f  	addi	a6, zero, 240
80206160: b3 e7 f8 00  	or	a5, a7, a5
80206164: 63 e6 05 03  	bltu	a1, a6, 0x80206190 <.LBB244_52+0x6c>
80206168: 03 45 35 00  	lbu	a0, 3(a0)
8020616c: 93 15 d6 03  	slli	a1, a2, 61
80206170: ad 91        	srli	a1, a1, 43
80206172: 13 96 67 00  	slli	a2, a5, 6
80206176: 13 75 f5 03  	andi	a0, a0, 63
8020617a: 51 8d        	or	a0, a0, a2
8020617c: 4d 8d        	or	a0, a0, a1
8020617e: b7 05 11 00  	lui	a1, 272
80206182: e3 01 b5 fa  	beq	a0, a1, 0x80206124 <.LBB244_52>
80206186: 01 a8        	j	0x80206196 <.LBB244_52+0x72>
80206188: 13 15 66 00  	slli	a0, a2, 6
8020618c: 5d 8d        	or	a0, a0, a5
8020618e: 21 a0        	j	0x80206196 <.LBB244_52+0x72>
80206190: 13 15 c6 00  	slli	a0, a2, 12
80206194: 5d 8d        	or	a0, a0, a5
80206196: aa c2        	sw	a0, 68(sp)
80206198: 13 06 00 08  	addi	a2, zero, 128
8020619c: 85 45        	addi	a1, zero, 1
8020619e: 63 6b c5 00  	bltu	a0, a2, 0x802061b4 <.LBB244_52+0x90>
802061a2: 13 56 b5 00  	srli	a2, a0, 11
802061a6: 89 45        	addi	a1, zero, 2
802061a8: 11 c6        	beqz	a2, 0x802061b4 <.LBB244_52+0x90>
802061aa: 41 81        	srli	a0, a0, 16
802061ac: 13 35 15 00  	seqz	a0, a0
802061b0: 91 45        	addi	a1, zero, 4
802061b2: 89 8d        	sub	a1, a1, a0
802061b4: 33 85 d5 00  	add	a0, a1, a3
802061b8: b6 e4        	sd	a3, 72(sp)
802061ba: aa e8        	sd	a0, 80(sp)
802061bc: 28 18        	addi	a0, sp, 56
802061be: 2a e5        	sd	a0, 136(sp)

00000000802061c0 <.LBB244_53>:
802061c0: 17 05 00 00  	auipc	a0, 0
802061c4: 13 05 c5 5d  	addi	a0, a0, 1500
802061c8: 2a e9        	sd	a0, 144(sp)
802061ca: c8 00        	addi	a0, sp, 68
802061cc: 2a ed        	sd	a0, 152(sp)

00000000802061ce <.LBB244_54>:
802061ce: 17 05 00 00  	auipc	a0, 0
802061d2: 13 05 c5 8d  	addi	a0, a0, -1828
802061d6: 2a f1        	sd	a0, 160(sp)
802061d8: a8 00        	addi	a0, sp, 72
802061da: 2a f5        	sd	a0, 168(sp)

00000000802061dc <.LBB244_55>:
802061dc: 17 e5 ff ff  	auipc	a0, 1048574
802061e0: 13 05 05 6c  	addi	a0, a0, 1728
802061e4: 2a f9        	sd	a0, 176(sp)
802061e6: 28 08        	addi	a0, sp, 24
802061e8: 2a fd        	sd	a0, 184(sp)

00000000802061ea <.LBB244_56>:
802061ea: 17 05 00 00  	auipc	a0, 0
802061ee: 13 05 85 6b  	addi	a0, a0, 1720
802061f2: aa e1        	sd	a0, 192(sp)
802061f4: 2c 10        	addi	a1, sp, 40
802061f6: ae e5        	sd	a1, 200(sp)
802061f8: aa e9        	sd	a0, 208(sp)

00000000802061fa <.LBB244_57>:
802061fa: 17 35 01 00  	auipc	a0, 19
802061fe: 13 05 e5 6d  	addi	a0, a0, 1758
80206202: aa ec        	sd	a0, 88(sp)
80206204: 15 45        	addi	a0, zero, 5
80206206: aa f0        	sd	a0, 96(sp)
80206208: 82 f4        	sd	zero, 104(sp)
8020620a: 2c 01        	addi	a1, sp, 136
8020620c: ae fc        	sd	a1, 120(sp)
8020620e: 2a e1        	sd	a0, 128(sp)
80206210: a8 08        	addi	a0, sp, 88
80206212: ba 85        	mv	a1, a4
80206214: 97 f0 ff ff  	auipc	ra, 1048575
80206218: e7 80 40 a0  	jalr	-1532(ra)
8020621c: 00 00        	unimp	

000000008020621e <_ZN4core7unicode9printable5check17h54a0551efb95020eE>:
8020621e: 41 11        	addi	sp, sp, -16
80206220: 06 e4        	sd	ra, 8(sp)
80206222: 39 ce        	beqz	a2, 0x80206280 <_ZN4core7unicode9printable5check17h54a0551efb95020eE+0x62>
80206224: 81 42        	mv	t0, zero
80206226: 93 18 05 03  	slli	a7, a0, 48
8020622a: 13 d3 88 03  	srli	t1, a7, 56
8020622e: 06 06        	slli	a2, a2, 1
80206230: b3 83 c5 00  	add	t2, a1, a2
80206234: 13 7e f5 0f  	andi	t3, a0, 255
80206238: 19 a8        	j	0x8020624e <_ZN4core7unicode9printable5check17h54a0551efb95020eE+0x30>
8020623a: b3 32 d3 01  	sltu	t0, t1, t4
8020623e: 33 c6 75 00  	xor	a2, a1, t2
80206242: 13 36 16 00  	seqz	a2, a2
80206246: 33 e6 c2 00  	or	a2, t0, a2
8020624a: c6 82        	mv	t0, a7
8020624c: 15 ea        	bnez	a2, 0x80206280 <_ZN4core7unicode9printable5check17h54a0551efb95020eE+0x62>
8020624e: 83 ce 05 00  	lbu	t4, 0(a1)
80206252: 03 c6 15 00  	lbu	a2, 1(a1)
80206256: 89 05        	addi	a1, a1, 2
80206258: b3 88 c2 00  	add	a7, t0, a2
8020625c: e3 9f 6e fc  	bne	t4, t1, 0x8020623a <_ZN4core7unicode9printable5check17h54a0551efb95020eE+0x1c>
80206260: 63 e2 58 0a  	bltu	a7, t0, 0x80206304 <.LBB263_25>
80206264: 63 6b 17 0b  	bltu	a4, a7, 0x8020631a <.LBB263_26>
80206268: b6 92        	add	t0, t0, a3
8020626a: 01 ca        	beqz	a2, 0x8020627a <_ZN4core7unicode9printable5check17h54a0551efb95020eE+0x5c>
8020626c: 83 ce 02 00  	lbu	t4, 0(t0)
80206270: 85 02        	addi	t0, t0, 1
80206272: 7d 16        	addi	a2, a2, -1
80206274: e3 9b ce ff  	bne	t4, t3, 0x8020626a <_ZN4core7unicode9printable5check17h54a0551efb95020eE+0x4c>
80206278: a9 a8        	j	0x802062d2 <_ZN4core7unicode9printable5check17h54a0551efb95020eE+0xb4>
8020627a: c6 82        	mv	t0, a7
8020627c: e3 99 75 fc  	bne	a1, t2, 0x8020624e <_ZN4core7unicode9printable5check17h54a0551efb95020eE+0x30>
80206280: 63 0e 08 04  	beqz	a6, 0x802062dc <_ZN4core7unicode9printable5check17h54a0551efb95020eE+0xbe>
80206284: b3 85 07 01  	add	a1, a5, a6
80206288: 41 66        	lui	a2, 16
8020628a: 7d 36        	addiw	a2, a2, -1
8020628c: 69 8e        	and	a2, a2, a0
8020628e: 05 45        	addi	a0, zero, 1
80206290: 83 86 07 00  	lb	a3, 0(a5)
80206294: 13 87 17 00  	addi	a4, a5, 1
80206298: 63 c9 06 00  	bltz	a3, 0x802062aa <_ZN4core7unicode9printable5check17h54a0551efb95020eE+0x8c>
8020629c: 93 f6 f6 0f  	andi	a3, a3, 255
802062a0: ba 87        	mv	a5, a4
802062a2: 15 9e        	subw	a2, a2, a3
802062a4: 63 5f 06 00  	bgez	a2, 0x802062c2 <_ZN4core7unicode9printable5check17h54a0551efb95020eE+0xa4>
802062a8: 0d a0        	j	0x802062ca <_ZN4core7unicode9printable5check17h54a0551efb95020eE+0xac>
802062aa: 63 0e b7 02  	beq	a4, a1, 0x802062e6 <.LBB263_23>
802062ae: 03 c7 17 00  	lbu	a4, 1(a5)
802062b2: 93 f6 f6 07  	andi	a3, a3, 127
802062b6: a2 06        	slli	a3, a3, 8
802062b8: 89 07        	addi	a5, a5, 2
802062ba: d9 8e        	or	a3, a3, a4
802062bc: 15 9e        	subw	a2, a2, a3
802062be: 63 46 06 00  	bltz	a2, 0x802062ca <_ZN4core7unicode9printable5check17h54a0551efb95020eE+0xac>
802062c2: 13 45 15 00  	xori	a0, a0, 1
802062c6: e3 95 b7 fc  	bne	a5, a1, 0x80206290 <_ZN4core7unicode9printable5check17h54a0551efb95020eE+0x72>
802062ca: 05 89        	andi	a0, a0, 1
802062cc: a2 60        	ld	ra, 8(sp)
802062ce: 41 01        	addi	sp, sp, 16
802062d0: 82 80        	ret
802062d2: 01 45        	mv	a0, zero
802062d4: 05 89        	andi	a0, a0, 1
802062d6: a2 60        	ld	ra, 8(sp)
802062d8: 41 01        	addi	sp, sp, 16
802062da: 82 80        	ret
802062dc: 05 45        	addi	a0, zero, 1
802062de: 05 89        	andi	a0, a0, 1
802062e0: a2 60        	ld	ra, 8(sp)
802062e2: 41 01        	addi	sp, sp, 16
802062e4: 82 80        	ret

00000000802062e6 <.LBB263_23>:
802062e6: 17 35 01 00  	auipc	a0, 19
802062ea: 13 05 05 fb  	addi	a0, a0, -80

00000000802062ee <.LBB263_24>:
802062ee: 17 36 01 00  	auipc	a2, 19
802062f2: 13 06 a6 67  	addi	a2, a2, 1658
802062f6: 93 05 b0 02  	addi	a1, zero, 43
802062fa: 97 f0 ff ff  	auipc	ra, 1048575
802062fe: e7 80 20 8b  	jalr	-1870(ra)
80206302: 00 00        	unimp	

0000000080206304 <.LBB263_25>:
80206304: 17 36 01 00  	auipc	a2, 19
80206308: 13 06 c6 64  	addi	a2, a2, 1612
8020630c: 16 85        	mv	a0, t0
8020630e: c6 85        	mv	a1, a7
80206310: 97 00 00 00  	auipc	ra, 0
80206314: e7 80 40 9c  	jalr	-1596(ra)
80206318: 00 00        	unimp	

000000008020631a <.LBB263_26>:
8020631a: 17 36 01 00  	auipc	a2, 19
8020631e: 13 06 66 63  	addi	a2, a2, 1590
80206322: 46 85        	mv	a0, a7
80206324: ba 85        	mv	a1, a4
80206326: 97 00 00 00  	auipc	ra, 0
8020632a: e7 80 e0 96  	jalr	-1682(ra)
8020632e: 00 00        	unimp	

0000000080206330 <_ZN4core3fmt3num53_$LT$impl$u20$core..fmt..UpperHex$u20$for$u20$u32$GT$3fmt17h108140f6993daab6E>:
80206330: 75 71        	addi	sp, sp, -144
80206332: 06 e5        	sd	ra, 136(sp)
80206334: 2e 88        	mv	a6, a1
80206336: 81 45        	mv	a1, zero
80206338: 03 67 05 00  	lwu	a4, 0(a0)
8020633c: 93 08 81 00  	addi	a7, sp, 8
80206340: a9 42        	addi	t0, zero, 10
80206342: 3d 43        	addi	t1, zero, 15
80206344: 29 a8        	j	0x8020635e <_ZN4core3fmt3num53_$LT$impl$u20$core..fmt..UpperHex$u20$for$u20$u32$GT$3fmt17h108140f6993daab6E+0x2e>
80206346: 33 86 b8 00  	add	a2, a7, a1
8020634a: 9b 06 07 00  	sext.w	a3, a4
8020634e: 1b 57 47 00  	srliw	a4, a4, 4
80206352: 3e 95        	add	a0, a0, a5
80206354: a3 0f a6 06  	sb	a0, 127(a2)
80206358: fd 15        	addi	a1, a1, -1
8020635a: 63 7b d3 00  	bgeu	t1, a3, 0x80206370 <_ZN4core3fmt3num53_$LT$impl$u20$core..fmt..UpperHex$u20$for$u20$u32$GT$3fmt17h108140f6993daab6E+0x40>
8020635e: 93 77 f7 00  	andi	a5, a4, 15
80206362: 13 05 00 03  	addi	a0, zero, 48
80206366: e3 e0 57 fe  	bltu	a5, t0, 0x80206346 <_ZN4core3fmt3num53_$LT$impl$u20$core..fmt..UpperHex$u20$for$u20$u32$GT$3fmt17h108140f6993daab6E+0x16>
8020636a: 13 05 70 03  	addi	a0, zero, 55
8020636e: e1 bf        	j	0x80206346 <_ZN4core3fmt3num53_$LT$impl$u20$core..fmt..UpperHex$u20$for$u20$u32$GT$3fmt17h108140f6993daab6E+0x16>
80206370: 13 85 05 08  	addi	a0, a1, 128
80206374: 13 06 10 08  	addi	a2, zero, 129
80206378: 63 76 c5 02  	bgeu	a0, a2, 0x802063a4 <.LBB472_8>
8020637c: b3 07 b0 40  	neg	a5, a1
80206380: 28 00        	addi	a0, sp, 8
80206382: 2e 95        	add	a0, a0, a1
80206384: 13 07 05 08  	addi	a4, a0, 128

0000000080206388 <.LBB472_7>:
80206388: 17 36 01 00  	auipc	a2, 19
8020638c: 13 06 06 0f  	addi	a2, a2, 240
80206390: 85 45        	addi	a1, zero, 1
80206392: 89 46        	addi	a3, zero, 2
80206394: 42 85        	mv	a0, a6
80206396: 97 f0 ff ff  	auipc	ra, 1048575
8020639a: e7 80 60 1e  	jalr	486(ra)
8020639e: aa 60        	ld	ra, 136(sp)
802063a0: 49 61        	addi	sp, sp, 144
802063a2: 82 80        	ret

00000000802063a4 <.LBB472_8>:
802063a4: 17 36 01 00  	auipc	a2, 19
802063a8: 13 06 c6 0b  	addi	a2, a2, 188
802063ac: 93 05 00 08  	addi	a1, zero, 128
802063b0: 97 00 00 00  	auipc	ra, 0
802063b4: e7 80 40 8a  	jalr	-1884(ra)
802063b8: 00 00        	unimp	

00000000802063ba <_ZN4core3fmt3num55_$LT$impl$u20$core..fmt..LowerHex$u20$for$u20$usize$GT$3fmt17hac15fa8a94913a23E>:
802063ba: 75 71        	addi	sp, sp, -144
802063bc: 06 e5        	sd	ra, 136(sp)
802063be: 2e 88        	mv	a6, a1
802063c0: 81 45        	mv	a1, zero
802063c2: 18 61        	ld	a4, 0(a0)
802063c4: 93 08 81 00  	addi	a7, sp, 8
802063c8: a9 42        	addi	t0, zero, 10
802063ca: 3d 43        	addi	t1, zero, 15
802063cc: 19 a8        	j	0x802063e2 <_ZN4core3fmt3num55_$LT$impl$u20$core..fmt..LowerHex$u20$for$u20$usize$GT$3fmt17hac15fa8a94913a23E+0x28>
802063ce: b3 86 b8 00  	add	a3, a7, a1
802063d2: 13 57 45 00  	srli	a4, a0, 4
802063d6: 3e 96        	add	a2, a2, a5
802063d8: a3 8f c6 06  	sb	a2, 127(a3)
802063dc: fd 15        	addi	a1, a1, -1
802063de: 63 7c a3 00  	bgeu	t1, a0, 0x802063f6 <_ZN4core3fmt3num55_$LT$impl$u20$core..fmt..LowerHex$u20$for$u20$usize$GT$3fmt17hac15fa8a94913a23E+0x3c>
802063e2: 3a 85        	mv	a0, a4
802063e4: 93 77 f7 00  	andi	a5, a4, 15
802063e8: 13 06 00 03  	addi	a2, zero, 48
802063ec: e3 e1 57 fe  	bltu	a5, t0, 0x802063ce <_ZN4core3fmt3num55_$LT$impl$u20$core..fmt..LowerHex$u20$for$u20$usize$GT$3fmt17hac15fa8a94913a23E+0x14>
802063f0: 13 06 70 05  	addi	a2, zero, 87
802063f4: e9 bf        	j	0x802063ce <_ZN4core3fmt3num55_$LT$impl$u20$core..fmt..LowerHex$u20$for$u20$usize$GT$3fmt17hac15fa8a94913a23E+0x14>
802063f6: 13 85 05 08  	addi	a0, a1, 128
802063fa: 13 06 10 08  	addi	a2, zero, 129
802063fe: 63 76 c5 02  	bgeu	a0, a2, 0x8020642a <.LBB475_8>
80206402: b3 07 b0 40  	neg	a5, a1
80206406: 28 00        	addi	a0, sp, 8
80206408: 2e 95        	add	a0, a0, a1
8020640a: 13 07 05 08  	addi	a4, a0, 128

000000008020640e <.LBB475_7>:
8020640e: 17 36 01 00  	auipc	a2, 19
80206412: 13 06 a6 06  	addi	a2, a2, 106
80206416: 85 45        	addi	a1, zero, 1
80206418: 89 46        	addi	a3, zero, 2
8020641a: 42 85        	mv	a0, a6
8020641c: 97 f0 ff ff  	auipc	ra, 1048575
80206420: e7 80 00 16  	jalr	352(ra)
80206424: aa 60        	ld	ra, 136(sp)
80206426: 49 61        	addi	sp, sp, 144
80206428: 82 80        	ret

000000008020642a <.LBB475_8>:
8020642a: 17 36 01 00  	auipc	a2, 19
8020642e: 13 06 66 03  	addi	a2, a2, 54
80206432: 93 05 00 08  	addi	a1, zero, 128
80206436: 97 00 00 00  	auipc	ra, 0
8020643a: e7 80 e0 81  	jalr	-2018(ra)
8020643e: 00 00        	unimp	

0000000080206440 <_ZN4core3fmt3num49_$LT$impl$u20$core..fmt..Debug$u20$for$u20$u8$GT$3fmt17h959c03c2251bca82E>:
80206440: 75 71        	addi	sp, sp, -144
80206442: 06 e5        	sd	ra, 136(sp)
80206444: 2e 88        	mv	a6, a1
80206446: 83 e5 05 03  	lwu	a1, 48(a1)
8020644a: 13 f6 05 01  	andi	a2, a1, 16
8020644e: 11 ee        	bnez	a2, 0x8020646a <_ZN4core3fmt3num49_$LT$impl$u20$core..fmt..Debug$u20$for$u20$u8$GT$3fmt17h959c03c2251bca82E+0x2a>
80206450: 93 f5 05 02  	andi	a1, a1, 32
80206454: a1 e9        	bnez	a1, 0x802064a4 <_ZN4core3fmt3num49_$LT$impl$u20$core..fmt..Debug$u20$for$u20$u8$GT$3fmt17h959c03c2251bca82E+0x64>
80206456: 03 45 05 00  	lbu	a0, 0(a0)
8020645a: 85 45        	addi	a1, zero, 1
8020645c: 42 86        	mv	a2, a6
8020645e: aa 60        	ld	ra, 136(sp)
80206460: 49 61        	addi	sp, sp, 144
80206462: 17 03 00 00  	auipc	t1, 0
80206466: 67 00 43 1a  	jr	420(t1)
8020646a: 81 45        	mv	a1, zero
8020646c: 83 46 05 00  	lbu	a3, 0(a0)
80206470: 93 08 81 00  	addi	a7, sp, 8
80206474: a9 42        	addi	t0, zero, 10
80206476: 3d 43        	addi	t1, zero, 15
80206478: 29 a8        	j	0x80206492 <_ZN4core3fmt3num49_$LT$impl$u20$core..fmt..Debug$u20$for$u20$u8$GT$3fmt17h959c03c2251bca82E+0x52>
8020647a: 33 86 b8 00  	add	a2, a7, a1
8020647e: 13 f7 f6 0f  	andi	a4, a3, 255
80206482: 93 56 47 00  	srli	a3, a4, 4
80206486: 3e 95        	add	a0, a0, a5
80206488: a3 0f a6 06  	sb	a0, 127(a2)
8020648c: fd 15        	addi	a1, a1, -1
8020648e: 63 78 e3 04  	bgeu	t1, a4, 0x802064de <_ZN4core3fmt3num49_$LT$impl$u20$core..fmt..Debug$u20$for$u20$u8$GT$3fmt17h959c03c2251bca82E+0x9e>
80206492: 93 f7 f6 00  	andi	a5, a3, 15
80206496: 13 05 00 03  	addi	a0, zero, 48
8020649a: e3 e0 57 fe  	bltu	a5, t0, 0x8020647a <_ZN4core3fmt3num49_$LT$impl$u20$core..fmt..Debug$u20$for$u20$u8$GT$3fmt17h959c03c2251bca82E+0x3a>
8020649e: 13 05 70 05  	addi	a0, zero, 87
802064a2: e1 bf        	j	0x8020647a <_ZN4core3fmt3num49_$LT$impl$u20$core..fmt..Debug$u20$for$u20$u8$GT$3fmt17h959c03c2251bca82E+0x3a>
802064a4: 81 45        	mv	a1, zero
802064a6: 83 46 05 00  	lbu	a3, 0(a0)
802064aa: 93 08 81 00  	addi	a7, sp, 8
802064ae: a9 42        	addi	t0, zero, 10
802064b0: 3d 43        	addi	t1, zero, 15
802064b2: 29 a8        	j	0x802064cc <_ZN4core3fmt3num49_$LT$impl$u20$core..fmt..Debug$u20$for$u20$u8$GT$3fmt17h959c03c2251bca82E+0x8c>
802064b4: 33 86 b8 00  	add	a2, a7, a1
802064b8: 13 f7 f6 0f  	andi	a4, a3, 255
802064bc: 93 56 47 00  	srli	a3, a4, 4
802064c0: 3e 95        	add	a0, a0, a5
802064c2: a3 0f a6 06  	sb	a0, 127(a2)
802064c6: fd 15        	addi	a1, a1, -1
802064c8: 63 7b e3 00  	bgeu	t1, a4, 0x802064de <_ZN4core3fmt3num49_$LT$impl$u20$core..fmt..Debug$u20$for$u20$u8$GT$3fmt17h959c03c2251bca82E+0x9e>
802064cc: 93 f7 f6 00  	andi	a5, a3, 15
802064d0: 13 05 00 03  	addi	a0, zero, 48
802064d4: e3 e0 57 fe  	bltu	a5, t0, 0x802064b4 <_ZN4core3fmt3num49_$LT$impl$u20$core..fmt..Debug$u20$for$u20$u8$GT$3fmt17h959c03c2251bca82E+0x74>
802064d8: 13 05 70 03  	addi	a0, zero, 55
802064dc: e1 bf        	j	0x802064b4 <_ZN4core3fmt3num49_$LT$impl$u20$core..fmt..Debug$u20$for$u20$u8$GT$3fmt17h959c03c2251bca82E+0x74>
802064de: 13 85 05 08  	addi	a0, a1, 128
802064e2: 13 06 10 08  	addi	a2, zero, 129
802064e6: 63 76 c5 02  	bgeu	a0, a2, 0x80206512 <.LBB485_15>
802064ea: b3 07 b0 40  	neg	a5, a1
802064ee: 28 00        	addi	a0, sp, 8
802064f0: 2e 95        	add	a0, a0, a1
802064f2: 13 07 05 08  	addi	a4, a0, 128

00000000802064f6 <.LBB485_14>:
802064f6: 17 36 01 00  	auipc	a2, 19
802064fa: 13 06 26 f8  	addi	a2, a2, -126
802064fe: 85 45        	addi	a1, zero, 1
80206500: 89 46        	addi	a3, zero, 2
80206502: 42 85        	mv	a0, a6
80206504: 97 f0 ff ff  	auipc	ra, 1048575
80206508: e7 80 80 07  	jalr	120(ra)
8020650c: aa 60        	ld	ra, 136(sp)
8020650e: 49 61        	addi	sp, sp, 144
80206510: 82 80        	ret

0000000080206512 <.LBB485_15>:
80206512: 17 36 01 00  	auipc	a2, 19
80206516: 13 06 e6 f4  	addi	a2, a2, -178
8020651a: 93 05 00 08  	addi	a1, zero, 128
8020651e: 97 f0 ff ff  	auipc	ra, 1048575
80206522: e7 80 60 73  	jalr	1846(ra)
80206526: 00 00        	unimp	

0000000080206528 <_ZN4core3fmt3num52_$LT$impl$u20$core..fmt..Debug$u20$for$u20$usize$GT$3fmt17hef45292248b47874E>:
80206528: 75 71        	addi	sp, sp, -144
8020652a: 06 e5        	sd	ra, 136(sp)
8020652c: 2e 88        	mv	a6, a1
8020652e: 83 e5 05 03  	lwu	a1, 48(a1)
80206532: 13 f6 05 01  	andi	a2, a1, 16
80206536: 09 ee        	bnez	a2, 0x80206550 <_ZN4core3fmt3num52_$LT$impl$u20$core..fmt..Debug$u20$for$u20$usize$GT$3fmt17hef45292248b47874E+0x28>
80206538: 93 f5 05 02  	andi	a1, a1, 32
8020653c: a9 e5        	bnez	a1, 0x80206586 <_ZN4core3fmt3num52_$LT$impl$u20$core..fmt..Debug$u20$for$u20$usize$GT$3fmt17hef45292248b47874E+0x5e>
8020653e: 08 61        	ld	a0, 0(a0)
80206540: 85 45        	addi	a1, zero, 1
80206542: 42 86        	mv	a2, a6
80206544: aa 60        	ld	ra, 136(sp)
80206546: 49 61        	addi	sp, sp, 144
80206548: 17 03 00 00  	auipc	t1, 0
8020654c: 67 00 e3 0b  	jr	190(t1)
80206550: 81 45        	mv	a1, zero
80206552: 18 61        	ld	a4, 0(a0)
80206554: 93 08 81 00  	addi	a7, sp, 8
80206558: a9 42        	addi	t0, zero, 10
8020655a: 3d 43        	addi	t1, zero, 15
8020655c: 19 a8        	j	0x80206572 <_ZN4core3fmt3num52_$LT$impl$u20$core..fmt..Debug$u20$for$u20$usize$GT$3fmt17hef45292248b47874E+0x4a>
8020655e: b3 86 b8 00  	add	a3, a7, a1
80206562: 13 57 45 00  	srli	a4, a0, 4
80206566: 3e 96        	add	a2, a2, a5
80206568: a3 8f c6 06  	sb	a2, 127(a3)
8020656c: fd 15        	addi	a1, a1, -1
8020656e: 63 77 a3 04  	bgeu	t1, a0, 0x802065bc <_ZN4core3fmt3num52_$LT$impl$u20$core..fmt..Debug$u20$for$u20$usize$GT$3fmt17hef45292248b47874E+0x94>
80206572: 3a 85        	mv	a0, a4
80206574: 93 77 f7 00  	andi	a5, a4, 15
80206578: 13 06 00 03  	addi	a2, zero, 48
8020657c: e3 e1 57 fe  	bltu	a5, t0, 0x8020655e <_ZN4core3fmt3num52_$LT$impl$u20$core..fmt..Debug$u20$for$u20$usize$GT$3fmt17hef45292248b47874E+0x36>
80206580: 13 06 70 05  	addi	a2, zero, 87
80206584: e9 bf        	j	0x8020655e <_ZN4core3fmt3num52_$LT$impl$u20$core..fmt..Debug$u20$for$u20$usize$GT$3fmt17hef45292248b47874E+0x36>
80206586: 81 45        	mv	a1, zero
80206588: 18 61        	ld	a4, 0(a0)
8020658a: 93 08 81 00  	addi	a7, sp, 8
8020658e: a9 42        	addi	t0, zero, 10
80206590: 3d 43        	addi	t1, zero, 15
80206592: 19 a8        	j	0x802065a8 <_ZN4core3fmt3num52_$LT$impl$u20$core..fmt..Debug$u20$for$u20$usize$GT$3fmt17hef45292248b47874E+0x80>
80206594: b3 86 b8 00  	add	a3, a7, a1
80206598: 13 57 45 00  	srli	a4, a0, 4
8020659c: 3e 96        	add	a2, a2, a5
8020659e: a3 8f c6 06  	sb	a2, 127(a3)
802065a2: fd 15        	addi	a1, a1, -1
802065a4: 63 7c a3 00  	bgeu	t1, a0, 0x802065bc <_ZN4core3fmt3num52_$LT$impl$u20$core..fmt..Debug$u20$for$u20$usize$GT$3fmt17hef45292248b47874E+0x94>
802065a8: 3a 85        	mv	a0, a4
802065aa: 93 77 f7 00  	andi	a5, a4, 15
802065ae: 13 06 00 03  	addi	a2, zero, 48
802065b2: e3 e1 57 fe  	bltu	a5, t0, 0x80206594 <_ZN4core3fmt3num52_$LT$impl$u20$core..fmt..Debug$u20$for$u20$usize$GT$3fmt17hef45292248b47874E+0x6c>
802065b6: 13 06 70 03  	addi	a2, zero, 55
802065ba: e9 bf        	j	0x80206594 <_ZN4core3fmt3num52_$LT$impl$u20$core..fmt..Debug$u20$for$u20$usize$GT$3fmt17hef45292248b47874E+0x6c>
802065bc: 13 85 05 08  	addi	a0, a1, 128
802065c0: 13 06 10 08  	addi	a2, zero, 129
802065c4: 63 76 c5 02  	bgeu	a0, a2, 0x802065f0 <.LBB489_15>
802065c8: b3 07 b0 40  	neg	a5, a1
802065cc: 28 00        	addi	a0, sp, 8
802065ce: 2e 95        	add	a0, a0, a1
802065d0: 13 07 05 08  	addi	a4, a0, 128

00000000802065d4 <.LBB489_14>:
802065d4: 17 36 01 00  	auipc	a2, 19
802065d8: 13 06 46 ea  	addi	a2, a2, -348
802065dc: 85 45        	addi	a1, zero, 1
802065de: 89 46        	addi	a3, zero, 2
802065e0: 42 85        	mv	a0, a6
802065e2: 97 f0 ff ff  	auipc	ra, 1048575
802065e6: e7 80 a0 f9  	jalr	-102(ra)
802065ea: aa 60        	ld	ra, 136(sp)
802065ec: 49 61        	addi	sp, sp, 144
802065ee: 82 80        	ret

00000000802065f0 <.LBB489_15>:
802065f0: 17 36 01 00  	auipc	a2, 19
802065f4: 13 06 06 e7  	addi	a2, a2, -400
802065f8: 93 05 00 08  	addi	a1, zero, 128
802065fc: 97 f0 ff ff  	auipc	ra, 1048575
80206600: e7 80 80 65  	jalr	1624(ra)
80206604: 00 00        	unimp	

0000000080206606 <_ZN4core3fmt3num3imp7fmt_u6417h9d0928484a3eb2efE>:
80206606: 39 71        	addi	sp, sp, -64
80206608: 06 fc        	sd	ra, 56(sp)
8020660a: 22 f8        	sd	s0, 48(sp)
8020660c: 26 f4        	sd	s1, 40(sp)
8020660e: 32 88        	mv	a6, a2
80206610: 13 56 45 00  	srli	a2, a0, 4
80206614: 13 07 70 02  	addi	a4, zero, 39
80206618: 93 06 10 27  	addi	a3, zero, 625

000000008020661c <.LBB490_10>:
8020661c: 97 38 01 00  	auipc	a7, 19
80206620: 93 88 e8 e5  	addi	a7, a7, -418
80206624: 63 73 d6 02  	bgeu	a2, a3, 0x8020664a <.LBB490_10+0x2e>
80206628: 13 06 30 06  	addi	a2, zero, 99
8020662c: 63 4f a6 0a  	blt	a2, a0, 0x802066ea <.LBB490_10+0xce>
80206630: 29 46        	addi	a2, zero, 10
80206632: 63 5d c5 0e  	bge	a0, a2, 0x8020672c <.LBB490_10+0x110>
80206636: 13 06 f7 ff  	addi	a2, a4, -1
8020663a: 93 06 11 00  	addi	a3, sp, 1
8020663e: b2 96        	add	a3, a3, a2
80206640: 13 05 05 03  	addi	a0, a0, 48
80206644: 23 80 a6 00  	sb	a0, 0(a3)
80206648: 09 a2        	j	0x8020674a <.LBB490_10+0x12e>
8020664a: 01 47        	mv	a4, zero
8020664c: 37 36 1a 00  	lui	a2, 419
80206650: 1b 06 36 6e  	addiw	a2, a2, 1763
80206654: 3a 06        	slli	a2, a2, 14
80206656: 13 06 76 ac  	addi	a2, a2, -1337
8020665a: 3a 06        	slli	a2, a2, 14
8020665c: 13 06 36 43  	addi	a2, a2, 1075
80206660: 36 06        	slli	a2, a2, 13
80206662: 93 03 b6 94  	addi	t2, a2, -1717
80206666: 09 66        	lui	a2, 2
80206668: 1b 0e 06 71  	addiw	t3, a2, 1808
8020666c: 05 66        	lui	a2, 1
8020666e: 9b 0e b6 47  	addiw	t4, a2, 1147
80206672: 93 02 40 06  	addi	t0, zero, 100
80206676: 13 03 11 00  	addi	t1, sp, 1
8020667a: b7 e7 f5 05  	lui	a5, 24414
8020667e: 1b 8f f7 0f  	addiw	t5, a5, 255
80206682: aa 86        	mv	a3, a0
80206684: 33 35 75 02  	mulhu	a0, a0, t2
80206688: 2d 81        	srli	a0, a0, 11
8020668a: 33 06 c5 03  	mul	a2, a0, t3
8020668e: 33 86 c6 40  	sub	a2, a3, a2
80206692: 93 17 06 03  	slli	a5, a2, 48
80206696: c9 93        	srli	a5, a5, 50
80206698: b3 87 d7 03  	mul	a5, a5, t4
8020669c: c5 83        	srli	a5, a5, 17
8020669e: 93 9f 17 00  	slli	t6, a5, 1
802066a2: b3 87 57 02  	mul	a5, a5, t0
802066a6: 1d 8e        	sub	a2, a2, a5
802066a8: 46 16        	slli	a2, a2, 49
802066aa: 13 54 06 03  	srli	s0, a2, 48
802066ae: b3 87 1f 01  	add	a5, t6, a7
802066b2: 33 06 e3 00  	add	a2, t1, a4
802066b6: 83 cf 07 00  	lbu	t6, 0(a5)
802066ba: 83 87 17 00  	lb	a5, 1(a5)
802066be: 46 94        	add	s0, s0, a7
802066c0: 83 04 14 00  	lb	s1, 1(s0)
802066c4: 03 44 04 00  	lbu	s0, 0(s0)
802066c8: 23 02 f6 02  	sb	a5, 36(a2)
802066cc: a3 01 f6 03  	sb	t6, 35(a2)
802066d0: 23 03 96 02  	sb	s1, 38(a2)
802066d4: a3 02 86 02  	sb	s0, 37(a2)
802066d8: 71 17        	addi	a4, a4, -4
802066da: e3 64 df fa  	bltu	t5, a3, 0x80206682 <.LBB490_10+0x66>
802066de: 13 07 77 02  	addi	a4, a4, 39
802066e2: 13 06 30 06  	addi	a2, zero, 99
802066e6: e3 55 a6 f4  	bge	a2, a0, 0x80206630 <.LBB490_10+0x14>
802066ea: 13 16 05 03  	slli	a2, a0, 48
802066ee: 49 92        	srli	a2, a2, 50
802066f0: 85 66        	lui	a3, 1
802066f2: 9b 86 b6 47  	addiw	a3, a3, 1147
802066f6: 33 06 d6 02  	mul	a2, a2, a3
802066fa: 45 82        	srli	a2, a2, 17
802066fc: 93 06 40 06  	addi	a3, zero, 100
80206700: b3 06 d6 02  	mul	a3, a2, a3
80206704: 15 8d        	sub	a0, a0, a3
80206706: 46 15        	slli	a0, a0, 49
80206708: 41 91        	srli	a0, a0, 48
8020670a: 79 17        	addi	a4, a4, -2
8020670c: 46 95        	add	a0, a0, a7
8020670e: 83 06 15 00  	lb	a3, 1(a0)
80206712: 03 45 05 00  	lbu	a0, 0(a0)
80206716: 93 07 11 00  	addi	a5, sp, 1
8020671a: ba 97        	add	a5, a5, a4
8020671c: a3 80 d7 00  	sb	a3, 1(a5)
80206720: 23 80 a7 00  	sb	a0, 0(a5)
80206724: 32 85        	mv	a0, a2
80206726: 29 46        	addi	a2, zero, 10
80206728: e3 47 c5 f0  	blt	a0, a2, 0x80206636 <.LBB490_10+0x1a>
8020672c: 06 05        	slli	a0, a0, 1
8020672e: 13 06 e7 ff  	addi	a2, a4, -2
80206732: 46 95        	add	a0, a0, a7
80206734: 83 06 15 00  	lb	a3, 1(a0)
80206738: 03 45 05 00  	lbu	a0, 0(a0)
8020673c: 13 07 11 00  	addi	a4, sp, 1
80206740: 32 97        	add	a4, a4, a2
80206742: a3 00 d7 00  	sb	a3, 1(a4)
80206746: 23 00 a7 00  	sb	a0, 0(a4)
8020674a: 13 05 11 00  	addi	a0, sp, 1
8020674e: 33 07 c5 00  	add	a4, a0, a2
80206752: 13 05 70 02  	addi	a0, zero, 39
80206756: b3 07 c5 40  	sub	a5, a0, a2

000000008020675a <.LBB490_11>:
8020675a: 17 36 01 00  	auipc	a2, 19
8020675e: 13 06 66 b0  	addi	a2, a2, -1274
80206762: 42 85        	mv	a0, a6
80206764: 81 46        	mv	a3, zero
80206766: 97 f0 ff ff  	auipc	ra, 1048575
8020676a: e7 80 60 e1  	jalr	-490(ra)
8020676e: a2 74        	ld	s1, 40(sp)
80206770: 42 74        	ld	s0, 48(sp)
80206772: e2 70        	ld	ra, 56(sp)
80206774: 21 61        	addi	sp, sp, 64
80206776: 82 80        	ret

0000000080206778 <_ZN4core3fmt3num3imp52_$LT$impl$u20$core..fmt..Display$u20$for$u20$i32$GT$3fmt17h14511140bcccfa96E>:
80206778: 03 65 05 00  	lwu	a0, 0(a0)
8020677c: 2e 86        	mv	a2, a1
8020677e: 9b 06 05 00  	sext.w	a3, a0
80206782: fd 55        	addi	a1, zero, -1
80206784: b3 a5 d5 00  	slt	a1, a1, a3
80206788: 63 d6 06 00  	bgez	a3, 0x80206794 <_ZN4core3fmt3num3imp52_$LT$impl$u20$core..fmt..Display$u20$for$u20$i32$GT$3fmt17h14511140bcccfa96E+0x1c>
8020678c: 13 45 f5 ff  	not	a0, a0
80206790: 01 25        	sext.w	a0, a0
80206792: 05 05        	addi	a0, a0, 1
80206794: 17 03 00 00  	auipc	t1, 0
80206798: 67 00 23 e7  	jr	-398(t1)

000000008020679c <_ZN4core3fmt3num3imp54_$LT$impl$u20$core..fmt..Display$u20$for$u20$usize$GT$3fmt17hcde333cef30ac927E>:
8020679c: 08 61        	ld	a0, 0(a0)
8020679e: 2e 86        	mv	a2, a1
802067a0: 85 45        	addi	a1, zero, 1
802067a2: 17 03 00 00  	auipc	t1, 0
802067a6: 67 00 43 e6  	jr	-412(t1)

00000000802067aa <_ZN53_$LT$core..fmt..Error$u20$as$u20$core..fmt..Debug$GT$3fmt17h1384fef572934361E>:
802067aa: 90 75        	ld	a2, 40(a1)
802067ac: 88 71        	ld	a0, 32(a1)
802067ae: 1c 6e        	ld	a5, 24(a2)

00000000802067b0 <.LBB522_1>:
802067b0: 97 35 01 00  	auipc	a1, 19
802067b4: 93 85 05 7d  	addi	a1, a1, 2000
802067b8: 15 46        	addi	a2, zero, 5
802067ba: 82 87        	jr	a5

00000000802067bc <_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17h2497224e07b15692E>:
802067bc: 10 65        	ld	a2, 8(a0)
802067be: 08 61        	ld	a0, 0(a0)
802067c0: 1c 6e        	ld	a5, 24(a2)
802067c2: 82 87        	jr	a5

00000000802067c4 <_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17hb7881b8e6b15c2acE>:
802067c4: 08 61        	ld	a0, 0(a0)
802067c6: 17 03 00 00  	auipc	t1, 0
802067ca: 67 00 23 d6  	jr	-670(t1)

00000000802067ce <_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17hd15d80a3efa3ed01E>:
802067ce: 39 71        	addi	sp, sp, -64
802067d0: 06 fc        	sd	ra, 56(sp)
802067d2: 22 f8        	sd	s0, 48(sp)
802067d4: 26 f4        	sd	s1, 40(sp)
802067d6: 10 61        	ld	a2, 0(a0)
802067d8: 03 45 06 00  	lbu	a0, 0(a2)
802067dc: 85 46        	addi	a3, zero, 1
802067de: 2e 84        	mv	s0, a1
802067e0: 63 1f d5 08  	bne	a0, a3, 0x8020687e <.LBB587_13+0x1e>
802067e4: 0c 74        	ld	a1, 40(s0)
802067e6: 08 70        	ld	a0, 32(s0)
802067e8: 94 6d        	ld	a3, 24(a1)
802067ea: 93 04 16 00  	addi	s1, a2, 1

00000000802067ee <.LBB587_10>:
802067ee: 97 35 01 00  	auipc	a1, 19
802067f2: 93 85 c5 a9  	addi	a1, a1, -1380
802067f6: 11 46        	addi	a2, zero, 4
802067f8: 82 96        	jalr	a3
802067fa: 22 e4        	sd	s0, 8(sp)
802067fc: 23 0c a1 00  	sb	a0, 24(sp)
80206800: 02 e8        	sd	zero, 16(sp)
80206802: a3 0c 01 00  	sb	zero, 25(sp)
80206806: 26 f0        	sd	s1, 32(sp)

0000000080206808 <.LBB587_11>:
80206808: 17 36 01 00  	auipc	a2, 19
8020680c: 13 06 86 c1  	addi	a2, a2, -1000
80206810: 28 00        	addi	a0, sp, 8
80206812: 0c 10        	addi	a1, sp, 32
80206814: 97 f0 ff ff  	auipc	ra, 1048575
80206818: e7 80 e0 82  	jalr	-2002(ra)
8020681c: 42 65        	ld	a0, 16(sp)
8020681e: 83 45 81 01  	lbu	a1, 24(sp)
80206822: 39 c5        	beqz	a0, 0x80206870 <.LBB587_13+0x10>
80206824: 05 44        	addi	s0, zero, 1
80206826: a1 e5        	bnez	a1, 0x8020686e <.LBB587_13+0xe>
80206828: 83 45 91 01  	lbu	a1, 25(sp)
8020682c: 7d 15        	addi	a0, a0, -1
8020682e: 13 35 15 00  	seqz	a0, a0
80206832: a2 64        	ld	s1, 8(sp)
80206834: b3 35 b0 00  	snez	a1, a1
80206838: 6d 8d        	and	a0, a0, a1
8020683a: 05 c1        	beqz	a0, 0x8020685a <.LBB587_12+0x10>
8020683c: 03 c5 04 03  	lbu	a0, 48(s1)
80206840: 11 89        	andi	a0, a0, 4
80206842: 01 ed        	bnez	a0, 0x8020685a <.LBB587_12+0x10>
80206844: 8c 74        	ld	a1, 40(s1)
80206846: 88 70        	ld	a0, 32(s1)
80206848: 94 6d        	ld	a3, 24(a1)

000000008020684a <.LBB587_12>:
8020684a: 97 35 01 00  	auipc	a1, 19
8020684e: 93 85 e5 bc  	addi	a1, a1, -1074
80206852: 05 46        	addi	a2, zero, 1
80206854: 05 44        	addi	s0, zero, 1
80206856: 82 96        	jalr	a3
80206858: 19 e9        	bnez	a0, 0x8020686e <.LBB587_13+0xe>
8020685a: 8c 74        	ld	a1, 40(s1)
8020685c: 88 70        	ld	a0, 32(s1)
8020685e: 94 6d        	ld	a3, 24(a1)

0000000080206860 <.LBB587_13>:
80206860: 97 35 01 00  	auipc	a1, 19
80206864: 93 85 95 bb  	addi	a1, a1, -1095
80206868: 05 46        	addi	a2, zero, 1
8020686a: 82 96        	jalr	a3
8020686c: 2a 84        	mv	s0, a0
8020686e: a2 85        	mv	a1, s0
80206870: 33 35 b0 00  	snez	a0, a1
80206874: a2 74        	ld	s1, 40(sp)
80206876: 42 74        	ld	s0, 48(sp)
80206878: e2 70        	ld	ra, 56(sp)
8020687a: 21 61        	addi	sp, sp, 64
8020687c: 82 80        	ret
8020687e: 0c 74        	ld	a1, 40(s0)
80206880: 08 70        	ld	a0, 32(s0)
80206882: 9c 6d        	ld	a5, 24(a1)

0000000080206884 <.LBB587_14>:
80206884: 97 35 01 00  	auipc	a1, 19
80206888: 93 85 e5 a0  	addi	a1, a1, -1522
8020688c: 11 46        	addi	a2, zero, 4
8020688e: a2 74        	ld	s1, 40(sp)
80206890: 42 74        	ld	s0, 48(sp)
80206892: e2 70        	ld	ra, 56(sp)
80206894: 21 61        	addi	sp, sp, 64
80206896: 82 87        	jr	a5

0000000080206898 <_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17hf3b1e8d8c3e4450bE>:
80206898: 08 61        	ld	a0, 0(a0)
8020689a: 17 03 00 00  	auipc	t1, 0
8020689e: 67 00 63 ba  	jr	-1114(t1)

00000000802068a2 <_ZN44_$LT$$RF$T$u20$as$u20$core..fmt..Display$GT$3fmt17ha2dbfcc8b52117caE>:
802068a2: 14 61        	ld	a3, 0(a0)
802068a4: 10 65        	ld	a2, 8(a0)
802068a6: 2e 85        	mv	a0, a1
802068a8: b6 85        	mv	a1, a3
802068aa: 17 f3 ff ff  	auipc	t1, 1048575
802068ae: 67 00 63 f8  	jr	-122(t1)

00000000802068b2 <_ZN64_$LT$core..str..error..Utf8Error$u20$as$u20$core..fmt..Debug$GT$3fmt17h4a5236f50738e9ddE>:
802068b2: 39 71        	addi	sp, sp, -64
802068b4: 06 fc        	sd	ra, 56(sp)
802068b6: 22 f8        	sd	s0, 48(sp)
802068b8: 26 f4        	sd	s1, 40(sp)
802068ba: 4a f0        	sd	s2, 32(sp)
802068bc: 2e 84        	mv	s0, a1
802068be: 8c 75        	ld	a1, 40(a1)
802068c0: 14 70        	ld	a3, 32(s0)
802068c2: 98 6d        	ld	a4, 24(a1)
802068c4: aa 84        	mv	s1, a0
802068c6: 13 09 85 00  	addi	s2, a0, 8

00000000802068ca <.LBB614_8>:
802068ca: 97 35 01 00  	auipc	a1, 19
802068ce: 93 85 b5 6b  	addi	a1, a1, 1723
802068d2: 25 46        	addi	a2, zero, 9
802068d4: 36 85        	mv	a0, a3
802068d6: 02 97        	jalr	a4
802068d8: 2a e4        	sd	a0, 8(sp)
802068da: 22 e0        	sd	s0, 0(sp)
802068dc: 26 ec        	sd	s1, 24(sp)

00000000802068de <.LBB614_9>:
802068de: 97 35 01 00  	auipc	a1, 19
802068e2: 93 85 05 6b  	addi	a1, a1, 1712

00000000802068e6 <.LBB614_10>:
802068e6: 17 37 01 00  	auipc	a4, 19
802068ea: 13 07 a7 67  	addi	a4, a4, 1658
802068ee: 0a 85        	mv	a0, sp
802068f0: 2d 46        	addi	a2, zero, 11
802068f2: 34 08        	addi	a3, sp, 24
802068f4: 97 e0 ff ff  	auipc	ra, 1048574
802068f8: e7 80 a0 5d  	jalr	1498(ra)
802068fc: 4a ec        	sd	s2, 24(sp)

00000000802068fe <.LBB614_11>:
802068fe: 97 35 01 00  	auipc	a1, 19
80206902: 93 85 b5 69  	addi	a1, a1, 1691

0000000080206906 <.LBB614_12>:
80206906: 17 37 01 00  	auipc	a4, 19
8020690a: 13 07 27 6a  	addi	a4, a4, 1698
8020690e: 0a 85        	mv	a0, sp
80206910: 25 46        	addi	a2, zero, 9
80206912: 34 08        	addi	a3, sp, 24
80206914: 97 e0 ff ff  	auipc	ra, 1048574
80206918: e7 80 a0 5b  	jalr	1466(ra)
8020691c: 03 45 91 00  	lbu	a0, 9(sp)
80206920: 83 45 81 00  	lbu	a1, 8(sp)
80206924: 1d c9        	beqz	a0, 0x8020695a <.LBB614_14+0xe>
80206926: 05 45        	addi	a0, zero, 1
80206928: 85 e9        	bnez	a1, 0x80206958 <.LBB614_14+0xc>
8020692a: 02 65        	ld	a0, 0(sp)
8020692c: 83 45 05 03  	lbu	a1, 48(a0)
80206930: 91 89        	andi	a1, a1, 4
80206932: 91 e9        	bnez	a1, 0x80206946 <.LBB614_13+0xc>
80206934: 0c 75        	ld	a1, 40(a0)
80206936: 08 71        	ld	a0, 32(a0)
80206938: 94 6d        	ld	a3, 24(a1)

000000008020693a <.LBB614_13>:
8020693a: 97 35 01 00  	auipc	a1, 19
8020693e: 93 85 95 ad  	addi	a1, a1, -1319
80206942: 09 46        	addi	a2, zero, 2
80206944: 09 a8        	j	0x80206956 <.LBB614_14+0xa>
80206946: 0c 75        	ld	a1, 40(a0)
80206948: 08 71        	ld	a0, 32(a0)
8020694a: 94 6d        	ld	a3, 24(a1)

000000008020694c <.LBB614_14>:
8020694c: 97 35 01 00  	auipc	a1, 19
80206950: 93 85 65 ac  	addi	a1, a1, -1338
80206954: 05 46        	addi	a2, zero, 1
80206956: 82 96        	jalr	a3
80206958: aa 85        	mv	a1, a0
8020695a: 33 35 b0 00  	snez	a0, a1
8020695e: 02 79        	ld	s2, 32(sp)
80206960: a2 74        	ld	s1, 40(sp)
80206962: 42 74        	ld	s0, 48(sp)
80206964: e2 70        	ld	ra, 56(sp)
80206966: 21 61        	addi	sp, sp, 64
80206968: 82 80        	ret

000000008020696a <_ZN4core7unicode12unicode_data15grapheme_extend6lookup17h8651aa89d5dfc36cE>:
8020696a: 41 11        	addi	sp, sp, -16
8020696c: 06 e4        	sd	ra, 8(sp)
8020696e: 01 47        	mv	a4, zero
80206970: 93 15 b5 00  	slli	a1, a0, 11
80206974: 93 07 00 02  	addi	a5, zero, 32

0000000080206978 <.LBB644_25>:
80206978: 17 38 01 00  	auipc	a6, 19
8020697c: 13 08 08 65  	addi	a6, a6, 1616
80206980: 9b 88 05 00  	sext.w	a7, a1
80206984: 93 06 00 02  	addi	a3, zero, 32
80206988: 39 a0        	j	0x80206996 <.LBB644_25+0x1e>
8020698a: 13 87 17 00  	addi	a4, a5, 1
8020698e: b3 87 e6 40  	sub	a5, a3, a4
80206992: 63 7a d7 02  	bgeu	a4, a3, 0x802069c6 <.LBB644_25+0x4e>
80206996: 93 d5 17 00  	srli	a1, a5, 1
8020699a: b3 87 e5 00  	add	a5, a1, a4
8020699e: 93 95 27 00  	slli	a1, a5, 2
802069a2: c2 95        	add	a1, a1, a6
802069a4: 8c 41        	lw	a1, 0(a1)
802069a6: 1b 96 b5 00  	slliw	a2, a1, 11
802069aa: e3 60 16 ff  	bltu	a2, a7, 0x8020698a <.LBB644_25+0x12>
802069ae: ae 05        	slli	a1, a1, 11
802069b0: 81 25        	sext.w	a1, a1
802069b2: 63 88 15 01  	beq	a1, a7, 0x802069c2 <.LBB644_25+0x4a>
802069b6: be 86        	mv	a3, a5
802069b8: b3 87 e6 40  	sub	a5, a3, a4
802069bc: e3 6d d7 fc  	bltu	a4, a3, 0x80206996 <.LBB644_25+0x1e>
802069c0: 19 a0        	j	0x802069c6 <.LBB644_25+0x4e>
802069c2: 13 87 17 00  	addi	a4, a5, 1
802069c6: fd 46        	addi	a3, zero, 31
802069c8: 63 e9 e6 0a  	bltu	a3, a4, 0x80206a7a <.LBB644_28>
802069cc: 93 17 27 00  	slli	a5, a4, 2
802069d0: 13 06 30 2c  	addi	a2, zero, 707
802069d4: 63 08 d7 00  	beq	a4, a3, 0x802069e4 <.LBB644_25+0x6c>
802069d8: b3 05 f8 00  	add	a1, a6, a5
802069dc: 83 e5 45 00  	lwu	a1, 4(a1)
802069e0: 13 d6 55 01  	srli	a2, a1, 21
802069e4: 93 06 f7 ff  	addi	a3, a4, -1
802069e8: 63 74 d7 00  	bgeu	a4, a3, 0x802069f0 <.LBB644_25+0x78>
802069ec: 01 47        	mv	a4, zero
802069ee: 39 a8        	j	0x80206a0c <.LBB644_25+0x94>
802069f0: 93 05 00 02  	addi	a1, zero, 32
802069f4: 63 ff b6 08  	bgeu	a3, a1, 0x80206a92 <.LBB644_29>
802069f8: 93 95 26 00  	slli	a1, a3, 2
802069fc: c2 95        	add	a1, a1, a6
802069fe: 83 e5 05 00  	lwu	a1, 0(a1)
80206a02: b7 06 20 00  	lui	a3, 512
80206a06: fd 36        	addiw	a3, a3, -1
80206a08: 33 f7 d5 00  	and	a4, a1, a3
80206a0c: b3 85 07 01  	add	a1, a5, a6
80206a10: 83 e5 05 00  	lwu	a1, 0(a1)
80206a14: d5 81        	srli	a1, a1, 21
80206a16: 93 86 15 00  	addi	a3, a1, 1
80206a1a: 63 0f d6 02  	beq	a2, a3, 0x80206a58 <.LBB644_26+0x22>
80206a1e: 93 07 30 2c  	addi	a5, zero, 707
80206a22: 2e 88        	mv	a6, a1
80206a24: 63 e4 b7 00  	bltu	a5, a1, 0x80206a2c <.LBB644_25+0xb4>
80206a28: 13 08 30 2c  	addi	a6, zero, 707
80206a2c: 81 47        	mv	a5, zero
80206a2e: 3b 07 e5 40  	subw	a4, a0, a4
80206a32: 13 05 f6 ff  	addi	a0, a2, -1

0000000080206a36 <.LBB644_26>:
80206a36: 17 36 01 00  	auipc	a2, 19
80206a3a: 13 06 26 61  	addi	a2, a2, 1554
80206a3e: 63 02 b8 02  	beq	a6, a1, 0x80206a62 <.LBB644_27>
80206a42: b3 86 c5 00  	add	a3, a1, a2
80206a46: 83 c6 06 00  	lbu	a3, 0(a3)
80206a4a: b5 9f        	addw	a5, a5, a3
80206a4c: 63 66 f7 00  	bltu	a4, a5, 0x80206a58 <.LBB644_26+0x22>
80206a50: 85 05        	addi	a1, a1, 1
80206a52: e3 16 b5 fe  	bne	a0, a1, 0x80206a3e <.LBB644_26+0x8>
80206a56: aa 85        	mv	a1, a0
80206a58: 13 f5 15 00  	andi	a0, a1, 1
80206a5c: a2 60        	ld	ra, 8(sp)
80206a5e: 41 01        	addi	sp, sp, 16
80206a60: 82 80        	ret

0000000080206a62 <.LBB644_27>:
80206a62: 17 36 01 00  	auipc	a2, 19
80206a66: 13 06 e6 4c  	addi	a2, a2, 1230
80206a6a: 93 05 30 2c  	addi	a1, zero, 707
80206a6e: 42 85        	mv	a0, a6
80206a70: 97 e0 ff ff  	auipc	ra, 1048574
80206a74: e7 80 80 16  	jalr	360(ra)
80206a78: 00 00        	unimp	

0000000080206a7a <.LBB644_28>:
80206a7a: 17 36 01 00  	auipc	a2, 19
80206a7e: 13 06 e6 49  	addi	a2, a2, 1182
80206a82: 93 05 00 02  	addi	a1, zero, 32
80206a86: 3a 85        	mv	a0, a4
80206a88: 97 e0 ff ff  	auipc	ra, 1048574
80206a8c: e7 80 00 15  	jalr	336(ra)
80206a90: 00 00        	unimp	

0000000080206a92 <.LBB644_29>:
80206a92: 17 36 01 00  	auipc	a2, 19
80206a96: 13 06 66 4b  	addi	a2, a2, 1206
80206a9a: 93 05 00 02  	addi	a1, zero, 32
80206a9e: 36 85        	mv	a0, a3
80206aa0: 97 e0 ff ff  	auipc	ra, 1048574
80206aa4: e7 80 80 13  	jalr	312(ra)
80206aa8: 00 00        	unimp	

0000000080206aaa <memcpy>:
80206aaa: bd 46        	addi	a3, zero, 15
80206aac: 63 fc c6 06  	bgeu	a3, a2, 0x80206b24 <memcpy+0x7a>
80206ab0: b3 06 a0 40  	neg	a3, a0
80206ab4: 13 f8 76 00  	andi	a6, a3, 7
80206ab8: b3 03 05 01  	add	t2, a0, a6
80206abc: 63 0c 08 00  	beqz	a6, 0x80206ad4 <memcpy+0x2a>
80206ac0: aa 87        	mv	a5, a0
80206ac2: ae 86        	mv	a3, a1
80206ac4: 03 87 06 00  	lb	a4, 0(a3)
80206ac8: 23 80 e7 00  	sb	a4, 0(a5)
80206acc: 85 07        	addi	a5, a5, 1
80206ace: 85 06        	addi	a3, a3, 1
80206ad0: e3 ea 77 fe  	bltu	a5, t2, 0x80206ac4 <memcpy+0x1a>
80206ad4: b3 88 05 01  	add	a7, a1, a6
80206ad8: 33 08 06 41  	sub	a6, a2, a6
80206adc: 93 72 88 ff  	andi	t0, a6, -8
80206ae0: 93 f5 78 00  	andi	a1, a7, 7
80206ae4: b3 86 53 00  	add	a3, t2, t0
80206ae8: b1 c1        	beqz	a1, 0x80206b2c <memcpy+0x82>
80206aea: 63 5b 50 04  	blez	t0, 0x80206b40 <memcpy+0x96>
80206aee: 93 95 38 00  	slli	a1, a7, 3
80206af2: 13 f3 85 03  	andi	t1, a1, 56
80206af6: 13 f7 88 ff  	andi	a4, a7, -8
80206afa: 10 63        	ld	a2, 0(a4)
80206afc: b3 05 b0 40  	neg	a1, a1
80206b00: 13 fe 85 03  	andi	t3, a1, 56
80206b04: 93 07 87 00  	addi	a5, a4, 8
80206b08: 98 63        	ld	a4, 0(a5)
80206b0a: 33 56 66 00  	srl	a2, a2, t1
80206b0e: b3 15 c7 01  	sll	a1, a4, t3
80206b12: d1 8d        	or	a1, a1, a2
80206b14: 23 b0 b3 00  	sd	a1, 0(t2)
80206b18: a1 03        	addi	t2, t2, 8
80206b1a: a1 07        	addi	a5, a5, 8
80206b1c: 3a 86        	mv	a2, a4
80206b1e: e3 e5 d3 fe  	bltu	t2, a3, 0x80206b08 <memcpy+0x5e>
80206b22: 39 a8        	j	0x80206b40 <memcpy+0x96>
80206b24: aa 86        	mv	a3, a0
80206b26: 63 43 c0 02  	bgtz	a2, 0x80206b4c <memcpy+0xa2>
80206b2a: 15 a8        	j	0x80206b5e <memcpy+0xb4>
80206b2c: 63 5a 50 00  	blez	t0, 0x80206b40 <memcpy+0x96>
80206b30: c6 85        	mv	a1, a7
80206b32: 90 61        	ld	a2, 0(a1)
80206b34: 23 b0 c3 00  	sd	a2, 0(t2)
80206b38: a1 03        	addi	t2, t2, 8
80206b3a: a1 05        	addi	a1, a1, 8
80206b3c: e3 eb d3 fe  	bltu	t2, a3, 0x80206b32 <memcpy+0x88>
80206b40: b3 85 58 00  	add	a1, a7, t0
80206b44: 13 76 78 00  	andi	a2, a6, 7
80206b48: 63 5b c0 00  	blez	a2, 0x80206b5e <memcpy+0xb4>
80206b4c: 36 96        	add	a2, a2, a3
80206b4e: 03 87 05 00  	lb	a4, 0(a1)
80206b52: 23 80 e6 00  	sb	a4, 0(a3)
80206b56: 85 06        	addi	a3, a3, 1
80206b58: 85 05        	addi	a1, a1, 1
80206b5a: e3 ea c6 fe  	bltu	a3, a2, 0x80206b4e <memcpy+0xa4>
80206b5e: 82 80        	ret

0000000080206b60 <memset>:
80206b60: bd 46        	addi	a3, zero, 15
80206b62: 63 fb c6 04  	bgeu	a3, a2, 0x80206bb8 <memset+0x58>
80206b66: b3 06 a0 40  	neg	a3, a0
80206b6a: 9d 8a        	andi	a3, a3, 7
80206b6c: 33 07 d5 00  	add	a4, a0, a3
80206b70: 99 c6        	beqz	a3, 0x80206b7e <memset+0x1e>
80206b72: aa 87        	mv	a5, a0
80206b74: 23 80 b7 00  	sb	a1, 0(a5)
80206b78: 85 07        	addi	a5, a5, 1
80206b7a: e3 ed e7 fe  	bltu	a5, a4, 0x80206b74 <memset+0x14>
80206b7e: 15 8e        	sub	a2, a2, a3
80206b80: 93 77 86 ff  	andi	a5, a2, -8
80206b84: b3 06 f7 00  	add	a3, a4, a5
80206b88: 63 54 f0 02  	blez	a5, 0x80206bb0 <memset+0x50>
80206b8c: 13 f8 f5 0f  	andi	a6, a1, 255
80206b90: b7 07 01 01  	lui	a5, 4112
80206b94: 9b 87 17 10  	addiw	a5, a5, 257
80206b98: c2 07        	slli	a5, a5, 16
80206b9a: 93 87 17 10  	addi	a5, a5, 257
80206b9e: c2 07        	slli	a5, a5, 16
80206ba0: 93 87 17 10  	addi	a5, a5, 257
80206ba4: b3 07 f8 02  	mul	a5, a6, a5
80206ba8: 1c e3        	sd	a5, 0(a4)
80206baa: 21 07        	addi	a4, a4, 8
80206bac: e3 6e d7 fe  	bltu	a4, a3, 0x80206ba8 <memset+0x48>
80206bb0: 1d 8a        	andi	a2, a2, 7
80206bb2: 63 46 c0 00  	bgtz	a2, 0x80206bbe <memset+0x5e>
80206bb6: 11 a8        	j	0x80206bca <memset+0x6a>
80206bb8: aa 86        	mv	a3, a0
80206bba: 63 58 c0 00  	blez	a2, 0x80206bca <memset+0x6a>
80206bbe: 36 96        	add	a2, a2, a3
80206bc0: 23 80 b6 00  	sb	a1, 0(a3)
80206bc4: 85 06        	addi	a3, a3, 1
80206bc6: e3 ed c6 fe  	bltu	a3, a2, 0x80206bc0 <memset+0x60>
80206bca: 82 80        	ret
