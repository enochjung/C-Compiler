	      INT   0, 36
	      SUP   0, main
	      RET   0, 0
swap:
	      INT   0, 24
	      LDA   1, 20
	      LOD   1, 12
	      LDI   0, 1
	      STO   0, 1
	      LOD   1, 12
	      LOD   1, 16
	      LDI   0, 1
	      STX   0, 1
	      POP   0, 1
	      LOD   1, 16
	      LOD   1, 20
	      STX   0, 1
	      POP   0, 1
	      RET   0, 0
sort:
	      INT   0, 28
	      LDA   1, 20
	     LITI   0, 0
	      STX   0, 1
	      POP   0, 1
L2:
	      LOD   1, 20
	      LOD   1, 16
	     LSSI   0, 0
	      JPC   0, L3
	      LDA   1, 24
	      LOD   1, 20
	     LITI   0, 1
	     ADDI   0, 0
	      STX   0, 1
	      POP   0, 1
L5:
	      LOD   1, 24
	      LOD   1, 16
	     LSSI   0, 0
	      JPC   0, L6
	      LOD   1, 12
	      LOD   1, 20
	     LITI   0, 4
	     MULI   0, 0
	   OFFSET   0, 0
	      LDI   0, 1
	      LOD   1, 12
	      LOD   1, 24
	     LITI   0, 4
	     MULI   0, 0
	   OFFSET   0, 0
	      LDI   0, 1
	     GTRI   0, 0
	      JPC   0, L7
	      INT   0, 12
	      LOD   1, 12
	      LOD   1, 20
	     LITI   0, 4
	     MULI   0, 0
	     ADDI   0, 0
	      LOD   1, 12
	      LOD   1, 24
	     LITI   0, 4
	     MULI   0, 0
	     ADDI   0, 0
	      POP   0, 5
	     ADDR   0, swap
	      CAL   0, 0
L7:
L4:
	      LDA   1, 24
	      LDX   0, 1
	     INCI   0, 0
	      STX   0, 1
	      POP   0, 1
	      JMP   0, L5
L6:
L1:
	      LDA   1, 20
	      LDX   0, 1
	     INCI   0, 0
	      STX   0, 1
	      POP   0, 1
	      JMP   0, L2
L3:
	      RET   0, 0
	      RET   0, 0
main:
	      INT   0, 420
	      INT   0, 12
	      LDA   0, 12
	      LDA   1, 12
	      POP   0, 5
	     ADDR   0, scanf
	      CAL   0, 0
	      LDA   1, 416
	     LITI   0, 0
	      STX   0, 1
	      POP   0, 1
L9:
	      LOD   1, 416
	      LOD   1, 12
	     LSSI   0, 0
	      JPC   0, L10
	      INT   0, 12
	      LDA   0, 20
	      LDA   1, 16
	      LOD   1, 416
	     LITI   0, 4
	     MULI   0, 0
	     ADDI   0, 0
	      POP   0, 5
	     ADDR   0, scanf
	      CAL   0, 0
L8:
	      LDA   1, 416
	      LDX   0, 1
	     INCI   0, 0
	      STX   0, 1
	      POP   0, 1
	      JMP   0, L9
L10:
	      INT   0, 12
	      LDA   1, 16
	      LOD   1, 12
	      POP   0, 5
	     ADDR   0, sort
	      CAL   0, 0
	      LDA   1, 416
	     LITI   0, 0
	      STX   0, 1
	      POP   0, 1
L12:
	      LOD   1, 416
	      LOD   1, 12
	     LSSI   0, 0
	      JPC   0, L13
	      INT   0, 12
	      LDA   0, 28
	      LDA   1, 16
	      LOD   1, 416
	     LITI   0, 4
	     MULI   0, 0
	   OFFSET   0, 0
	      LDI   0, 1
	      POP   0, 5
	     ADDR   0, printf
	      CAL   0, 0
L11:
	      LDA   1, 416
	      LDX   0, 1
	     INCI   0, 0
	      STX   0, 1
	      POP   0, 1
	      JMP   0, L12
L13:
	      LDA   1, -4
	     LITI   0, 0
	      STO   0, 1
	      RET   0, 0
	      RET   0, 0
.literal    12  "%d"
.literal    20  "%d"
.literal    28  "%d "
