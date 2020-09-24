;NOTE: This works by preventing mario's collision points
;from being outside the level itself, not limiting the
;actual player. So if anything is placed on the edge of
;the level, they will extend to infinity (not really,
;as long the position values don't overflow).

;The same thing applies to sprite's interaction,
;they too will interact with "off-level" blocks.

;This also includes layer 2; if moving layer 2 gets
;anywhere within mario's collision points at the edge
;of the level, mario will interact with it.

!Setting_LevelConstrain_RAM_Based = 1
;^0 = Apply level constrain permanently at all times.
; 1 = Only apply the boundaries if !Freeram_LevelConstrain
;  is set to nonzero.

!Freeram_LevelConstrain = $61
 ;^[1 byte] (not used if !Setting_LevelConstrain_RAM_Based = 0)
 ; RAM address that applies the level constrain (block interaction
 ; applies off-level) when nonzero. Format: %0000TBLR
 ;  -T: Apply block interactions above level, 0 = no, 1 = yes...
 ;  -B: ...same as above, but below level...
 ;  -L: left side...
 ;  -R: ...and right side.
 ; This will apply both Mario and Sprite.
 ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Don't touch these
;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;LM v3.00 check

	assert read1($05d9a1) == $22, "Please patch Lunar Magic version 3.00."

;Sa-1 handling
	!dp = $0000
	!addr = $0000
	!bank = $800000
	!sa1 = 0
	!gsu = 0
	
	if read1($00FFD6) == $15
		sfxrom
		!dp = $6000
		!addr = !dp
		!bank = $000000
		!gsu = 1
	elseif read1($00FFD5) == $23
		sa1rom
		!dp = $3000
		!addr = $6000
		!bank = $000000
		!sa1 = 1
	endif
	macro define_sprite_table(name, name2, addr, addr_sa1)
	if !sa1 == 0
	    !<name> = <addr>
	else
	    !<name> = <addr_sa1>
	endif
	    !<name2> = !<name>
	endmacro

	; Regular sprite tables
	%define_sprite_table(sprite_num, "9E", $9E, $3200)
	%define_sprite_table(sprite_speed_y, "AA", $AA, $9E)
	%define_sprite_table(sprite_speed_x, "B6", $B6, $B6)
	%define_sprite_table(sprite_misc_c2, "C2", $C2, $D8)
	%define_sprite_table(sprite_y_low, "D8", $D8, $3216)
	%define_sprite_table(sprite_x_low, "E4", $E4, $322C)
	%define_sprite_table(sprite_status, "14C8", $14C8, $3242)
	%define_sprite_table(sprite_y_high, "14D4", $14D4, $3258)
	%define_sprite_table(sprite_x_high, "14E0", $14E0, $326E)
	%define_sprite_table(sprite_speed_y_frac, "14EC", $14EC, $74C8)
	%define_sprite_table(sprite_speed_x_frac, "14F8", $14F8, $74DE)
	%define_sprite_table(sprite_misc_1504, "1504", $1504, $74F4)
	%define_sprite_table(sprite_misc_1510, "1510", $1510, $750A)
	%define_sprite_table(sprite_misc_151c, "151C", $151C, $3284)
	%define_sprite_table(sprite_misc_1528, "1528", $1528, $329A)
	%define_sprite_table(sprite_misc_1534, "1534", $1534, $32B0)
	%define_sprite_table(sprite_misc_1540, "1540", $1540, $32C6)
	%define_sprite_table(sprite_misc_154c, "154C", $154C, $32DC)
	%define_sprite_table(sprite_misc_1558, "1558", $1558, $32F2)
	%define_sprite_table(sprite_misc_1564, "1564", $1564, $3308)
	%define_sprite_table(sprite_misc_1570, "1570", $1570, $331E)
	%define_sprite_table(sprite_misc_157c, "157C", $157C, $3334)
	%define_sprite_table(sprite_blocked_status, "1588", $1588, $334A)
	%define_sprite_table(sprite_misc_1594, "1594", $1594, $3360)
	%define_sprite_table(sprite_off_screen_horz, "15A0", $15A0, $3376)
	%define_sprite_table(sprite_misc_15ac, "15AC", $15AC, $338C)
	%define_sprite_table(sprite_slope, "15B8", $15B8, $7520)
	%define_sprite_table(sprite_off_screen, "15C4", $15C4, $7536)
	%define_sprite_table(sprite_being_eaten, "15D0", $15D0, $754C)
	%define_sprite_table(sprite_obj_interact, "15DC", $15DC, $7562)
	%define_sprite_table(sprite_oam_index, "15EA", $15EA, $33A2)
	%define_sprite_table(sprite_oam_properties, "15F6", $15F6, $33B8)
	%define_sprite_table(sprite_misc_1602, "1602", $1602, $33CE)
	%define_sprite_table(sprite_misc_160e, "160E", $160E, $33E4)
	%define_sprite_table(sprite_index_in_level, "161A", $161A, $7578)
	%define_sprite_table(sprite_misc_1626, "1626", $1626, $758E)
	%define_sprite_table(sprite_behind_scenery, "1632", $1632, $75A4)
	%define_sprite_table(sprite_misc_163e, "163E", $163E, $33FA)
	%define_sprite_table(sprite_in_water, "164A", $164A, $75BA)
	%define_sprite_table(sprite_tweaker_1656, "1656", $1656, $75D0)
	%define_sprite_table(sprite_tweaker_1662, "1662", $1662, $75EA)
	%define_sprite_table(sprite_tweaker_166e, "166E", $166E, $7600)
	%define_sprite_table(sprite_tweaker_167a, "167A", $167A, $7616)
	%define_sprite_table(sprite_tweaker_1686, "1686", $1686, $762C)
	%define_sprite_table(sprite_off_screen_vert, "186C", $186C, $7642)
	%define_sprite_table(sprite_misc_187b, "187B", $187B, $3410)
	%define_sprite_table(sprite_tweaker_190f, "190F", $190F, $7658)
	%define_sprite_table(sprite_misc_1fd6, "1FD6", $1FD6, $766E)
	%define_sprite_table(sprite_cape_disable_time, "1FE2", $1FE2, $7FD6)
;hijacks
	org $00F451|!bank
	autoclean JML ConstrainMarioCollisionPoints

	org $0194D4|!bank
	autoclean JML Sprite_HorizLvl_blk_interYPos

	org $0194EE|!bank
	autoclean JML Sprite_HorizLvl_blk_interXPos

;CODE_019461:        BD D4 14      LDA.W RAM_SpriteYHi,X      ;\Get carry if Y pos exceeds #$FF
;CODE_019464:        69 00         ADC.B #$00                 ;/
;CODE_019466:        C5 5D         CMP RAM_ScreensInLvl       ;\Hijack to be 4 nops so that sprites no longer ignore extended block hitboxes
;CODE_019468:        B0 4A         BCS CODE_0194B4            ;/when top/bottom bits of freeram are set.
;CODE_01946A:        85 0D         STA $0D                    ;
;CODE_01946C:        B5 E4         LDA RAM_SpriteXLo,X        ;\Hijack, once done, jumps to $019481 or $0194B4.
;CODE_01946E:        18            CLC                        ;|
;CODE_01946F:        79 BA 90      ADC.W SpriteObjClippingX,Y ;/
;CODE_019472:        85 0A         STA $0A                    ;\This place is skipped entirely.
;CODE_019474:        85 01         STA $01                    ;|
;CODE_019476:        BD E0 14      LDA.W RAM_SpriteXHi,X      ;|
;CODE_019479:        69 00         ADC.B #$00                 ;|
;CODE_01947B:        C9 02         CMP.B #$02                 ;|
;CODE_01947D:        B0 35         BCS CODE_0194B4            ;|
;CODE_01947F:        85 0B         STA $0B                    ;/
;CODE_019481:        A5 01         LDA $01                    ;
;...
;CODE_0194B4:        A4 0F         LDY $0F                   ;>???
;CODE_0194B6:        A9 00         LDA.B #$00                ;\Set behavor?


	org $019466
	nop #4

	org $01946C|!bank
	autoclean JML Sprite_VertLvl_Blk_interXPos
		;^You may be thinking, why not just have a hijack at $019466 to jump to [Sprite_VertLvl_Blk_interXPos]?
		; Well, it is better to have shorter distance between the ORG hijack and the "destination address" (as
		; in the JML from the freespace back to SMW code) to lower the chance of hijack conflicts with other patches.
	
	freecode

ConstrainMarioCollisionPoints: ;>JML from $00F451
;A is 16-bit
;X is currently the index of which collision point
	if !Setting_LevelConstrain_RAM_Based != 0
		;This code is here may seems useless (there are checks for each individual sides),
		;however saves a bit of performance when set to all zeroes.
		LDA !Freeram_LevelConstrain	;\>If any constrain flags are ON, run custom code.
		AND.w #$00FF			;|>Rid high byte
		BNE +				;/
		
		LDA $94			;\Restore
		CLC			;|
		ADC.w $00E830,x		;|
		JML $00F457		;/
		
		+
	endif
	
	.XPositon ;>Handle left and right side of stage.
		..LeftSide ;>X's leftmost position is ALWAYS X=$0000 regardless of level format.
			if !Setting_LevelConstrain_RAM_Based != 0
				SEP #$20		;>8-bit A
				LDA !Freeram_LevelConstrain
				AND.b #%00000010
				BEQ ..CheckLevelIsVertical
				REP #$20		;>16-bit A
			endif
			LDA #$0000			;>Left boundary.
			CMP $94				;\Check if left boundary is right of mario
			BPL ..SetXPosCollisPoint	;/(mario is too far left)
		..CheckLevelIsVertical
			SEP #$20				;>8-bit A
			LDA $5B					;\Right edge of level varies based on
			LSR					;|if the level is vertical or horizontal
			BCC ...HorizontalLvl			;/
	
			...VerticalLvl
				....RightSide
					if !Setting_LevelConstrain_RAM_Based != 0
						LDA !Freeram_LevelConstrain
						AND.b #%00000001
						BEQ ..NormalXPosition
					endif
					REP #$20			;>16-bit A
					LDA #$01F0			;>Right edge of vertical level is ALWAYS #$01F0.
					CMP $94				;\Check if right boundary is left of mario
					BMI ..SetXPosCollisPoint	;/(mario is too far right)
					BRA ..NormalXPosition
	
			...HorizontalLvl
				....RightSide
					if !Setting_LevelConstrain_RAM_Based != 0
						LDA !Freeram_LevelConstrain
						AND.b #%00000001
						BEQ ..NormalXPosition
					endif
					LDA $5E				;\Number of screens (horizontal)
					DEC				;/
					XBA				;>high byte position
					LDA #$F0			;>Low byte x position that touches right edge of horizontal level
					REP #$20			;>8-bit A
					CMP $94				;\check if right boundary is to the left of mario
					BMI ..SetXPosCollisPoint	;/(mario too far to the right).

		..NormalXPosition
			REP #$20
			LDA $94			;>Technically, restore X position, when within level boundaries.

		..SetXPosCollisPoint
			CLC
			ADC.w $00E830,x
			STA $9A			;>Set collision point X position.
	
	.YPosition
		..TopBoundary ;>Y top position is always Y=$FFD8 (when riding yoshi) or $FFE8 (when off yoshi).
			SEP #$20
			if !Setting_LevelConstrain_RAM_Based != 0
				LDA !Freeram_LevelConstrain
				AND.b #%00001000
				BEQ ..CheckLevelIsVertical
			endif
			LDA $187A|!addr			;>Riding yoshi (this check allows proper interacion if interacting blocks 1 block below the top).
			BEQ ...NotRidingYoshi
		
			...RidingYoshi
				REP #$20
				LDA #$FFD8
				BRA ..YoshiDone
		
			...NotRidingYoshi
				REP #$20
				LDA #$FFE8			;>Top boundary of level (would be when super mario is halfway of his body)

		..YoshiDone
			CMP $96				;\Check if top boundary is lower than mario (mario too far above.)
			BPL ..SetYPosCollisPoint	;/
			SEP #$20			;>8-bit A
		..CheckLevelIsVertical
			LDA $5B				;\Determine level type (vertical or horizontal)
			LSR				;|
			BCC ..HorizontalLvl		;/

	..VerticalLvl
		...BottomBoundary
			if !Setting_LevelConstrain_RAM_Based != 0
				LDA !Freeram_LevelConstrain
				AND.b #%00000100
				BEQ ..NormalYPosition
			endif
			LDA $5F				;\Number of screens (vertical)
			DEC				;|
			XBA				;/
			LDA #$E0			;>Low byte Y position
			REP #$20			;>16-bit A
			CMP $96				;\check if bottom boundary is above mario (mario is too far below)
			BMI ..SetYPosCollisPoint	;/
			BRA ..NormalYPosition

	..HorizontalLvl
		...BottomBoundary
			if !Setting_LevelConstrain_RAM_Based != 0
				LDA !Freeram_LevelConstrain
				AND.b #%00000100
				BEQ ..NormalYPosition
			endif
			PHX
			LDX #$00
			LDA $19
			BEQ ....Normal
			LDA $73
			BNE ....Normal
			LDA $187A|!addr
			BNE ....Normal
			
			....Abnormal
				INX #2
			
			....Normal
			REP #$20
			;LDA #$0190
			LDA $13D7|!addr					;>Level height, determines the bottom border position.
			SEC						;\Use this for Small Mario. It is issues with Big non-crouching Mario.
			SBC.l .OffsetHitboxYPositionBottomBorder,x	;/
			PLX
			CMP $96						;\Check if bottom boundary is is above mario
			BMI ..SetYPosCollisPoint			;/(mario is too far below)
	
	..NormalYPosition
		REP #$20
		LDA $96

	..SetYPosCollisPoint
		CLC
		ADC.w $00E89C,x
		STA $98
	
	.Done
		JML $00F461			;>Jump to the end of the positioning of collision points code.
		
	.OffsetHitboxYPositionBottomBorder
		dw $0020
		dw $0010
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Since vertical and horizontal level codes are separate,
;I don't need to check if it is, since it's already done.

;Unlike limiting collision points position by checking the
;mario position altogether itself, this code checks and limits
;the individual collision points position, since each sprite
;have different clipping points relative to sprite position.

;$00 = Block being touched Y position.
;$01 = Block being touched X position.
;$0C-$0D = Collision point Y position.

Sprite_HorizLvl_blk_interYPos:		;>JML from $0194D4
	if !Setting_LevelConstrain_RAM_Based != 0
		;Again, this may seem pointless, but will save performance.
		;SEP #$20
		LDA !Freeram_LevelConstrain
		AND.w %0000000000001100
		BNE +
	endif
	.CheckIfYPosInLevel
	;REP #$20		;\Restore
	LDA $0C			;|
	CMP.W $13D7|!addr	;|>LM hijack to no longer always use YPos=$01B0
	JML $0194D9		;/>Jump to where it checks if Y position is outside the level not to load block IDs outside the level (prevent freeze via loading invalid blocks)
	
	if !Setting_LevelConstrain_RAM_Based != 0
		+
	endif
	.Top
		if !Setting_LevelConstrain_RAM_Based != 0
			LDA !Freeram_LevelConstrain
			AND.w #%0000000000001000
			BEQ .Bottom
		endif
		LDA #$0000			;>Top of level
		CMP $0C				;>Collision point Y position
		BPL .Exceed			;>If top of level below collision point (collision is above)
	.Bottom
		if !Setting_LevelConstrain_RAM_Based != 0
			LDA !Freeram_LevelConstrain
			AND.w #%0000000000000100
			BEQ .NotExceed
		endif
		;LDA #$01AF			;>Bottom of level
		LDA $13D7|!addr			;\LM v3's level height
		DEC				;/
		CMP $0C				;>Collision point Y position
		BMI .Exceed			;>If bottom of level is above collision point (collision is under)
	.NotExceed
		;SEP #$20
		;JML $0194DD			;>Continue on with code
		BRA .CheckIfYPosInLevel

	.Exceed
		STA $0C

		..Align16x16
			SEP #$20
			AND #$F0			;\So it doesn't glitch out with blocks ($0194C5)
			STA $00				;/that need 16x16 alignment
			;JML $0194DD			;>Continue on with code
			REP #$20			;\Failsafe should this can cause a game freeze.
			BRA .CheckIfYPosInLevel		;/

Sprite_HorizLvl_blk_interXPos:		;>JML from $0194EE, 8-bit A from here.
	;$0A-$0B = Sprite Collision point X position.
	if !Setting_LevelConstrain_RAM_Based != 0
		LDA !Freeram_LevelConstrain
		AND.b #%00000011
		BNE +
	endif
	.CheckIfXPosInLevel
	LDA $0B			;\Restore
	BMI .CODE_0194B4		;|>Check if sprite is beyond the left edge of level.
	CMP $5D			;|\Check if sprite is beyond the right edge of level.
	JML $0194F2		;|/
	
	.CODE_0194B4
	JML $0194B4		;/>Code that executes to ignore "blocks" outside the level.
	
	if !Setting_LevelConstrain_RAM_Based != 0
		+
	endif
	.LeftSide
		if !Setting_LevelConstrain_RAM_Based != 0
			LDA !Freeram_LevelConstrain
			AND.b #%00000010
			BEQ .RightSide
		endif
		REP #$20
		LDA #$0000			;>Left edge of level
		CMP $0A				;>Collision point X position.
		BPL .Exceed			;>If left edge is right of mario (mario too far left)
	.RightSide
		SEP #$20
		if !Setting_LevelConstrain_RAM_Based != 0
			LDA !Freeram_LevelConstrain
			AND.b #%00000001
			BEQ .NotExceed
		endif
		LDA $5E				;\Right edge of level
		DEC				;|
		XBA				;|
		LDA #$FF			;/
		REP #$20
		CMP $0A				;>Compare with collision point x position
		BMI .Exceed			;>If right edge is left of point (or point is to the right), limit it.
	.NotExceed
		SEP #$20
		;JML $0194F4			;>Continue on with code
		BRA .CheckIfXPosInLevel


	.Exceed
		STA $0A				;\So edge blocks don't glitch out when hit off screen 
		SEP #$20
		STA $01				;/($0194E3)
		;JML $0194F4			;>Continue on with code
		BRA .CheckIfXPosInLevel


Sprite_VertLvl_Blk_interXPos:		;>$JML from $01946C
	;$0C-$0D = sprite collision point Y position.
	;$00 = block Y position.
	;$01 = block X position.
	;Hijacked a part of code that writes the X position to $0A-$0B.
	
	.GetXPosition
		LDA !E4,x				;\Restore for $01946C-$019480 (without the BCS... yet)
		CLC
		ADC.w $0190BA,y
		STA $0A
		STA $01
		LDA !14E0,x
		ADC #$00
		STA $0B					;/
		;Now $0A-$0B contains the collision point X position.
	.CheckSides
		REP #$20
		if !Setting_LevelConstrain_RAM_Based != 0
			LDA !Freeram_LevelConstrain
			AND.w #%0000000000000011
			BEQ ..GetBlockXPosition
		endif
		..Left
			if !Setting_LevelConstrain_RAM_Based != 0
				LDA !Freeram_LevelConstrain
				AND.w #%0000000000000010
				BEQ ..Right
			endif
			LDA #$0000			;>Top border
			CMP $0A				;>Collision point Y Position
			BPL ..Exceed			;>If top edge is below collision point (collision point above)
		..Right
			if !Setting_LevelConstrain_RAM_Based != 0
				LDA !Freeram_LevelConstrain
				AND.w #%0000000000000001
				BEQ ..GetBlockXPosition
			endif
			LDA #$01FF
			CMP $0A
			;BMI ..Exceed			;>check if right edge is to the left of collision point (or collision point to far to the right)
			BPL ..GetBlockXPosition
		..Exceed
			STA $0A				;>Clamp X position
		..GetBlockXPosition
			SEP #$20
			LDA $0A				;\Restore for $019472-$019475
			STA $01				;/
			
	.CheckTopBottom
		REP #$20
		if !Setting_LevelConstrain_RAM_Based != 0
			LDA !Freeram_LevelConstrain
			AND.w #%0000000000001100
			BEQ ..GetBlockYPosition
		endif
		..Top
			if !Setting_LevelConstrain_RAM_Based != 0
				LDA !Freeram_LevelConstrain
				AND.w #%0000000000001000
				BEQ ..Bottom
			endif
			LDA #$0000			;\If top of level is below collision point (or collision point above top)
			CMP $0C				;|clamp it
			BPL ..Exceed			;/
		..Bottom
			if !Setting_LevelConstrain_RAM_Based != 0
				LDA !Freeram_LevelConstrain
				AND.w #%0000000000000100
				BEQ ..GetBlockYPosition
			endif
			SEP #$20
			LDA $5F				;\Bottom edge of level
			DEC				;|
			XBA				;|
			LDA #$FF			;/
			REP #$20
			CMP $0C				;>Collision point Y position
			;BMI ..Exceed			;>If bottom of level is above collision point (or collision point below bottom), clamp Y pos
			BPL ..GetBlockYPosition
		..Exceed
			STA $0C
		..GetBlockYPosition
			SEP #$20
			LDA $0C
			AND #$F0
			STA $00
	.IgnoreInvalidDataOutsideLevel
		;Failsafe measures to prevent treating outside level "blocks" and crashing the game.
		.HorizontalIgnore
			LDA $0B
			CMP #$02
			BCS .Out
		.VerticalIgnore
			LDA $0D
			CMP $5D
			BCS .Out
		.In
			JML $019481
		.Out
			JML $0194B4