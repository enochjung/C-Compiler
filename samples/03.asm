	      INT   0, 28
	      SUP   0, main
	      RET   0, 0
main:
	      INT   0, 60
	      INT   0, 12
	      LDA   0, 12
	      LDA   1, 12
	      POP   0, 5
	     ADDR   0, scanf
	      CAL   0, 0
	      LDA   1, 16
	     LITI   0, 0
	      STX   0, 1
	      POP   0, 1
L2:
	      LOD   1, 16
	      LOD   1, 12
	     LSSI   0, 0
	      JPC   0, L3
	      INT   0, 12
	      LDA   0, 20
	      LDA   1, 20
	      LOD   1, 16
	     LITI   0, 4
	     MULI   0, 0
	     ADDI   0, 0
	      POP   0, 5
	     ADDR   0, scanf
	      CAL   0, 0
L1:
	      LDA   1, 16
	      LDX   0, 1
	     INCI   0, 0
	      STX   0, 1
	      POP   0, 1
	      JMP   0, L2
L3:
	      RET   0, 0
.literal    12  "%d"
.literal    20  "%d"
