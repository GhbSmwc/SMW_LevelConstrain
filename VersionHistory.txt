Should be 6 items (including hidden folders) in main folder.

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
7/28/2020 3.3 - Removal and then re-released with fixes
 -Was removed by MarioFanGamer: https://www.smwcentral.net/?p=viewthread&t=102900 because the patch
  fails to check if sprites are outside the level, causing a game crash if Freeram use is on and
  certain bits are SET when the sprite is offlevel in a certain direction.
 -Overhaul the vertical level handling since it was awful.
 -The readme is now HTML and how object interaction being clamped works being explained using GIFs improved.
 -Several REP/SEP #$20 are removed because they are unnecessary as the freeram check just checks only specific
  bit(s).