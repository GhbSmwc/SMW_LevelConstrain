Should be 2 items in main folder.

This patch will cause mario and sprite's interaction with the blocks to be constrained within
the level, maintaining interaction with blocks while inside the level boundaries. Unlike
screen constrain, this truly fixes a bug where even if the RAM is set to constrain within
level, it still constrain within the screen, (demonstrated in a gif showing an autoscroll
with screen boundary disabled; if the player is offscreen and a solid block ends up on the edge
of the screen where the player is at, he'll be crushed).

Notes:
-Be careful not to have any block that looks like it doesn't extend beyond the level placed
 on the edge of the level (such as coins, throw blocks, bouncable blocks (? or turn blocks)
 etc), they too will also be interactable when the player or sprite is off the level.

-Also don't put slopes and/or ledges at the top edge of the level, the player can infinitely
 ascend by jumping repeatedly.

-Custom blocks will work with this as well, you can also make them react when the player is
 far enough off level.
 
-The blocks treat as if the player's XY coordinate is on the borders of the level, meaning
 if you have layer 2 blocks, be careful not to make it possible for the player to be in between
 the layer 2 objects and the edge of the level and get "crushed" by it (mainly the top and
 bottom of the stage). Should you have situations like this, you'll be better make it RAM-based
 and have it switched off for these levels.
 
-This patch does not work with SMW's mode 7 bosses (Morton, Roy, Bowser, and Reznor). The barriers
 are still present regardless if you have this patch installed with the barriers permanently removed
 or have it RAM based when the RAM is nonzero. However, you probably wouldn't use these vanilla bosses
 in a chocolate hack due to lack of customizability.
 
-The way collision points (how SMW's sprites interact with blocks) are constrained behaves differently
 between the player and the sprites:

--For the player, when out of bounds, will treat as if the player is on the edge of the stage, all collision points
  aren't constrained to a specific X or Y position, rather take the player's pos, clamp that (without writing back
  to $94/$96), and use that number to offset from that to get the collision points locations (if Mario is past the
  left edge of the level, it isn't true that all his collision points's position are X=$0000).
  
--For sprites, when out of bounds, clamps each collision points individually instead of together. Meaning that collision points CAN
  be constrained to a specific X or Y position (so if a sprite is past the left edge of stage, all collision points's X pos are all $0000).
  This is largely because each sprite can have drastically different hitboxes.

This is a good alternative to my pitfix or level ceiling patch, instead of raising the
death boundary or adding a limit above level, it simply make the blocks' interaction extends
outwards from the level, making it impossible circumvent them outside the level (unless you
disable the screen barrier (https://www.smwcentral.net/?p=section&a=details&id=14978 ) and
go REALLY far and over/underflow the player's Y position).

Version history (M/D/Y oldest to newest):
7/3/2017 1.0
 -First release

7/5/2017 2.0
 -Fix the bottom boundary issue that the player can pass under solid blocks with small mario
  riding yoshi.
 -Included sprite interaction boundary.

7/21/2017 2.1
 -Added a notice about placing ledges, and about custom blocks too.

12/29/2018 3.0
 -Updated to use LM v3.00's new dynamic level patch.

12/30/2018 3.0 (minor change)
 -Added a assert check to require a LM hijack at $05d9a1 in order to patch.

3/3/2020 3.1
 -Added an option to "soft-disable" the patch in-game based on RAM. This is by a request from
  DeGenerator: https://www.smwcentral.net/?p=profile&id=28538 he wanted some levels to behave
  normal while other levels have the hitboxes extended.
 -Added a new note on this Readme of newer potential bugs
5/30/2020 3.2
 -Freeram is now individual sides-based flags, meaning you can enable/disable top, bottom, left
  and right side individually.
 -Fixed a bug with [ConstrainMarioCollisionPoints] which loaded the freeram in 16-bit instead of 8.
 -Fixed a SA-1 issue at [Sprite_HorizLvl_blk_interYPos]
 -Slightly improved the insert size - $00E830 and $00E89C indexed now uses word-addressing because
  long jumps (JSL/JML) don't affect the data bank register.