ShamoutiShrineRuins_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 2 ; warp events
	warp_event  2, 18, NOISY_FOREST, 3
	warp_event  2, 19, NOISY_FOREST, 4

	db 0 ; coord events

	db 1 ; bg events
	bg_event  7, 10, SIGNPOST_ITEM + MAX_REVIVE, EVENT_SHAMOUTI_SHRINE_RUINS_HIDDEN_MAX_REVIVE

	db 4 ; object events
	object_event  8, 11, SPRITE_LAWRENCE, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, ShamoutiShrineRuinsLawrenceScript, EVENT_LAWRENCE_SHAMOUTI_SHRINE_RUINS
	object_event 10, 17, SPRITE_GRAMPS, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BROWN, PERSONTYPE_COMMAND, jumptextfaceplayer, ShamoutiShrineRuinsGrampsText, -1
	object_event 14, 13, SPRITE_LADY, SPRITEMOVEDATA_WALK_UP_DOWN, 2, 0, -1, -1, PAL_NPC_BLUE, PERSONTYPE_COMMAND, jumptextfaceplayer, ShamoutiShrineRuinsLadyText, -1
	itemball_event  4, 27, RARE_CANDY, 1, EVENT_SHAMOUTI_SHRINE_RUINS_RARE_CANDY

	const_def 1 ; object constants
	const SHAMOUTISHRINERUINS_LAWRENCE

ShamoutiShrineRuinsLawrenceScript:
	special Special_FadeOutMusic
	pause 15
	playmusic MUSIC_ZINNIA_ENCOUNTER_ORAS
	showtextfaceplayer .SeenText
	winlosstext .BeatenText, 0
	setlasttalked SHAMOUTISHRINERUINS_LAWRENCE
	loadtrainer LAWRENCE, 1
	startbattle
	dontrestartmapmusic
	reloadmapafterbattle
	special DeleteSavedMusic
	playmusic MUSIC_ZINNIA_ENCOUNTER_ORAS
	opentext
	writetext .AfterText
	buttonsound
	verbosegiveitem SILVER_WING
	writetext .SilverWingText
	waitbutton
	closetext
	checkcode VAR_FACING
	if_equal UP, .up
	if_equal DOWN, .down
	if_equal LEFT, .left
.right
	spriteface SHAMOUTISHRINERUINS_LAWRENCE, RIGHT
	jump .continue
.up
	spriteface SHAMOUTISHRINERUINS_LAWRENCE, UP
	jump .continue
.down
	spriteface SHAMOUTISHRINERUINS_LAWRENCE, DOWN
	jump .continue
.left
	spriteface SHAMOUTISHRINERUINS_LAWRENCE, LEFT
.continue
	pause 40
	showtextfaceplayer .GoodbyeText
	playsound SFX_WARP_TO
	special Special_FadeBlackQuickly
	special Special_ReloadSpritesNoPalettes
	disappear SHAMOUTISHRINERUINS_LAWRENCE
	waitsfx
	special Special_FadeInQuickly
	setevent EVENT_BEAT_LAWRENCE
	playmapmusic
	end

.SeenText:
	text "Lawrence: I sought"
	line "across many"

	para "regions to catch"
	line "Articuno, Zapdos,"
	cont "and Moltres."

	para "Without the"
	line "complete set, I"

	para "cannot awaken the"
	line "guardian of the"
	cont "sea…"

	para "You're going to"
	line "help me complete"
	cont "my collection!"
	done

.BeatenText:
	text "Unbelievable."
	line "You beat my legen-"
	cont "dary collection…"
	done

.AfterText:
	text "Lawrence: Your"
	line "#mon aren't"

	para "just a collection"
	line "to you, are they?"

	para "You treat them"
	line "almost like"
	cont "friends."

	para "Could that be how"
	line "you defeated my"
	cont "legendary #mon?"

	para "Well, I think you"
	line "earned this."
	done

.SilverWingText:
	text "That Silver Wing"
	line "feather comes from"

	para "the guardian of"
	line "the sea."

	para "The scent should"
	line "attract it, but"

	para "only if you've"
	line "mastered the three"

	para "winged mirages--"
	line "the birds of fire,"

	para "ice, and light-"
	line "ning."

	para "Or so the legends"
	line "say."
	done

.GoodbyeText:
	text "My dream was to"
	line "own that Pokemon,"

	para "but you've proven"
	line "yourself worthy."
	cont "Take it."

	para "I'll begin my"
	line "collection anew."

	para "Farewell."
	done

ShamoutiShrineRuinsGrampsText:
	text "This shrine was"
	line "magnificent when"
	cont "I was a child."

	para "But alas, it was"
	line "wrecked by a storm"
	cont "many years ago."

	para "The storm threat-"
	line "ened the entire"
	cont "island, but we"

	para "were protected by"
	line "the Guardian of"
	cont "the Seas."

	para "Every year, I give"
	line "thanks in honor"

	para "of the great"
	line "#mon who kept"
	cont "us safe."
	done

ShamoutiShrineRuinsLadyText:
	text "I simply had to"
	line "stop at Shamouti"

	para "Island on my"
	line "world tour."

	para "Apparently there's"
	line "a talking #mon"
	cont "here somewhere."
	done
