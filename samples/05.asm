	      INT   0, 68
	      SUP   0, main
	      RET   0, 0
func:
	      INT   0, 16
	      LOD   1, 12
	     LITI   0, 1
	     EQLI   0, 0
	      JPC   0, L1
	      INT   0, 0
	     ADDR   0, printf
	      INT   0, 8
	      LDA   0, 12
	      POP   0, 3
	      CAL   0, 0
	      JMP   0, L2
L1:
	      INT   0, 0
	     ADDR   0, printf
	      INT   0, 8
	      LDA   0, 28
	      POP   0, 3
	      CAL   0, 0
L2:
	      RET   0, 0
main:
	      INT   0, 16
	      LDA   1, 12
	     ADDR   0, func
	      STX   0, 1
	      POP   0, 1
	      INT   0, 0
	     ADDR   0, printf
	      INT   0, 8
	      LDA   0, 44
	      POP   0, 3
	      CAL   0, 0
	      INT   0, 0
	     ADDR   0, func
	      INT   0, 8
	     LITI   0, 0
	      POP   0, 3
	      CAL   0, 0
	      INT   0, 0
	     ADDR   0, printf
	      INT   0, 8
	      LDA   0, 52
	      POP   0, 3
	      CAL   0, 0
	      INT   0, 0
	      LOD   1, 12
	      INT   0, 8
	     LITI   0, 0
	      POP   0, 3
	      CAL   0, 0
	      INT   0, 0
	     ADDR   0, printf
	      INT   0, 8
	      LDA   0, 60
	      POP   0, 3
	      CAL   0, 0
	      INT   0, 0
	      LOD   1, 12
	     LITI   0, 0
	     LITI   0, 0
	     LITI   0, 1
	     ADDI   0, 0
	     LITI   0, 1
	     SUBI   0, 0
	     ADDI   0, 0
	     LITI   0, 0
	     MULI   0, 0
	     ADDI   0, 0
	      INT   0, 8
	     LITI   0, 0
	      POP   0, 3
	      CAL   0, 0
	      RET   0, 0
.literal    12  "x is 1!!\n"
.literal    28  "x is not 1.\n"
.literal    44  "1: "
.literal    52  "2: "
.literal    60  "3: "
