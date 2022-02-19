	      INT   0, 36
	      SUP   0, main
	      RET   0, 0
fibonacci:
	      INT   0, 16
	      LOD   1, 12
	     LITI   0, 1
	     LEQI   0, 0
	      JPC   0, L1
	      LDA   1, -4
	     LITI   0, 1
	      STO   0, 1
	      RET   0, 0
L1:
	      LDA   1, -4
	      INT   0, 4
	     ADDR   0, fibonacci
	      INT   0, 8
	      LOD   1, 12
	     LITI   0, 1
	     SUBI   0, 0
	      POP   0, 3
	      CAL   0, 0
	      INT   0, 4
	     ADDR   0, fibonacci
	      INT   0, 8
	      LOD   1, 12
	     LITI   0, 2
	     SUBI   0, 0
	      POP   0, 3
	      CAL   0, 0
	     ADDI   0, 0
	      STO   0, 1
	      RET   0, 0
	      RET   0, 0
main:
	      INT   0, 16
L3:
	      LOD   1, 12
	     LITI   0, 10
	     LEQI   0, 0
	      JPC   0, L4
	      INT   0, 0
	     ADDR   0, printf
	      INT   0, 8
	      LDA   0, 12
	      LOD   1, 12
	      INT   0, 4
	     ADDR   0, fibonacci
	      INT   0, 8
	      LOD   1, 12
	      POP   0, 3
	      CAL   0, 0
	      POP   0, 5
	      CAL   0, 0
	      LOD   1, 12
	      LDA   1, 12
	      LDX   0, 1
	     INCI   0, 0
	      STO   0, 1
	      POP   0, 1
L2:
	      JMP   0, L3
L4:
	      RET   0, 0
.literal    12  "fibonacci(%d) = %d\n"
