	      INT   0, 24
	      JMP   0, L1
main:
	      INT   0, 20
	      LDA   1, 12
	     LITI   0, 0
	      STX   0, 1
	      POP   0, 1
	      LDA   1, 16
	     LITI   0, 10
	      STX   0, 1
	      POP   0, 1
L4:
	      INT   0, 0
	     ADDR   0, printf
	      INT   0, 8
	      LDA   0, 12
	      POP   0, 3
	      CAL   0, 0
	      LDA   1, 12
	      LDX   0, 1
	     INCI   0, 0
	      STX   0, 1
	      LOD   1, 16
	     LSSI   0, 0
	      JPC   0, L5
	      JMP   0, L3
L5:
	      INT   0, 0
	     ADDR   0, printf
	      INT   0, 8
	      LDA   0, 16
	      POP   0, 3
	      CAL   0, 0
	      LDA   1, 12
	     LITI   0, 0
	      STX   0, 1
	      POP   0, 1
	      LDA   1, 16
	      LDX   0, 1
	     DECI   0, 0
	      STX   0, 1
	     LITI   0, 0
	     EQLI   0, 0
	      JPC   0, L6
	      JMP   0, L2
L6:
L3:
	     LITI   0, 1
	      JPT   0, L4
L2:
	      RET   0, 0
L1:
	      SUP   0, main
	      RET   0, 0
.literal    12  "*"
.literal    16  "\n"
