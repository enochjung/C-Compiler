	      INT   0, 76
	      JMP   0, L1
one:
	      INT   0, 12
	      INT   0, 0
	     ADDR   0, printf
	      INT   0, 8
	      LDA   0, 12
	      POP   0, 3
	      CAL   0, 0
	      LDA   1, -4
	     LITI   0, 1
	      STO   0, 1
	      RET   0, 0
	      RET   0, 0
two:
	      INT   0, 12
	      INT   0, 0
	     ADDR   0, printf
	      INT   0, 8
	      LDA   0, 20
	      POP   0, 3
	      CAL   0, 0
	      LDA   1, -4
	     LITI   0, 2
	      STO   0, 1
	      RET   0, 0
	      RET   0, 0
main:
	      INT   0, 12
	      INT   0, 4
	     ADDR   0, one
	      INT   0, 8
	      POP   0, 2
	      CAL   0, 0
	     JPTR   0, L2
	      INT   0, 4
	     ADDR   0, two
	      INT   0, 8
	      POP   0, 2
	      CAL   0, 0
L2:
	      JPC   0, L3
	      INT   0, 0
	     ADDR   0, printf
	      INT   0, 8
	      LDA   0, 28
	      POP   0, 3
	      CAL   0, 0
L3:
	      INT   0, 4
	     ADDR   0, one
	      INT   0, 8
	      POP   0, 2
	      CAL   0, 0
	      NOT   0, 0
	     JPCR   0, L4
	      INT   0, 4
	     ADDR   0, two
	      INT   0, 8
	      POP   0, 2
	      CAL   0, 0
L4:
	      JPC   0, L5
	      INT   0, 0
	     ADDR   0, printf
	      INT   0, 8
	      LDA   0, 52
	      POP   0, 3
	      CAL   0, 0
L5:
	      RET   0, 0
L1:
	      SUP   0, main
	      RET   0, 0
.literal    12  "-one-"
.literal    20  "-two-"
.literal    28  "\n1. result is true\n"
.literal    52  "\n2. result is true\n"
