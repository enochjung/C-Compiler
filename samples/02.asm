	      INT   0, 60
	      SUP   0, main
	      RET   0, 0
main:
	      INT   0, 32
	      LDA   1, 12
	     LITI   0, 1
	      STO   0, 1
	      LDA   1, 16
	     LITI   0, 2
	      STO   0, 1
	      LDA   1, 20
	     LITI   0, 3
	      STO   0, 1
	      LDA   1, 24
	      LOD   0, 12
	      STO   0, 1
	      LDA   1, 28
	      LDA   1, 12
	     LITI   0, 2
	     LITI   0, 4
	     MULI   0, 0
	     ADDI   0, 0
	      STO   0, 1
	      LDA   1, 12
	     LITI   0, 0
	     LITI   0, 4
	     MULI   0, 0
	   OFFSET   0, 0
	      LDA   1, 12
	     LITI   0, 1
	     LITI   0, 4
	     MULI   0, 0
	   OFFSET   0, 0
	      LDI   0, 1
	      LDA   1, 12
	     LITI   0, 2
	     LITI   0, 4
	     MULI   0, 0
	   OFFSET   0, 0
	      LDI   0, 1
	     MULI   0, 0
	      LDA   1, 12
	     LITI   0, 0
	     LITI   0, 4
	     MULI   0, 0
	   OFFSET   0, 0
	      LDI   0, 1
	     SUBI   0, 0
	      STX   0, 1
	      POP   0, 1
	      LDA   1, 24
	     LITI   0, 10
	     CVTF   0, 0
	      LOD   1, 24
	   MINUSF   0, 0
	     LITI   0, 2
	     CVTF   0, 0
	     MULF   0, 0
	     SUBF   0, 0
	      STX   0, 1
	      POP   0, 1
	      LOD   1, 28
	     LITI   0, 99
	      STX   0, 1
	      POP   0, 1
	      INT   0, 12
	      LDA   0, 16
	      LOD   1, 24
	      POP   0, 5
	     ADDR   0, printf
	      CAL   0, 0
	      INT   0, 12
	      LDA   0, 28
	      LDA   1, 12
	     LITI   0, 0
	     LITI   0, 4
	     MULI   0, 0
	   OFFSET   0, 0
	      LDI   0, 1
	      LDA   1, 12
	     LITI   0, 1
	     LITI   0, 4
	     MULI   0, 0
	   OFFSET   0, 0
	      LDI   0, 1
	      LDA   1, 12
	     LITI   0, 2
	     LITI   0, 4
	     MULI   0, 0
	   OFFSET   0, 0
	      LDI   0, 1
	      POP   0, 7
	     ADDR   0, printf
	      CAL   0, 0
	      RET   0, 0
.literal    12  5.000000
.literal    16  "f:%f\n"
.literal    28  "a[0]:%d, a[1]:%d, a[2]:%d\n"
