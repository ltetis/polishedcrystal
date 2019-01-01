IcePathB1F_MapScriptHeader:
	db 0 ; scene scripts

	db 1 ; callbacks
	callback MAPCALLBACK_CMDQUEUE, IcePathB1FSetUpStoneTable

	db 8 ; warp events
	warp_event  3, 15, ICE_PATH_1F, 3
	warp_event 17,  3, ICE_PATH_B2F_MAHOGANY_SIDE, 1
	warp_event 11,  2, ICE_PATH_B2F_MAHOGANY_SIDE, 3 ; hole
	warp_event  4,  7, ICE_PATH_B2F_MAHOGANY_SIDE, 4 ; hole
	warp_event  5, 12, ICE_PATH_B2F_MAHOGANY_SIDE, 5 ; hole
	warp_event 12, 13, ICE_PATH_B2F_MAHOGANY_SIDE, 6 ; hole
	warp_event  5, 25, ICE_PATH_1F, 4
	warp_event 11, 27, ICE_PATH_B2F_BLACKTHORN_SIDE, 1

	db 0 ; coord events

	db 1 ; bg events
	bg_event 17, 30, SIGNPOST_ITEM + MAX_POTION, EVENT_ICE_PATH_B1F_HIDDEN_MAX_POTION

	db 8 ; object events
	strengthboulder_event 11,  7, EVENT_BOULDER_IN_ICE_PATH_1
	strengthboulder_event  7,  8, EVENT_BOULDER_IN_ICE_PATH_2
	strengthboulder_event  8,  9, EVENT_BOULDER_IN_ICE_PATH_3
	strengthboulder_event 17,  7, EVENT_BOULDER_IN_ICE_PATH_4
	object_event  2,  1, SPRITE_SKIER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, PERSONTYPE_SCRIPT, 0, IcePathB1FSkierScript, -1
	object_event  4, 23, SPRITE_BOARDER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, PERSONTYPE_GENERICTRAINER, 3, GenericTrainerBoarderMax, -1
	object_event 14, 24, SPRITE_SKIER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, PERSONTYPE_GENERICTRAINER, 2, GenericTrainerSkierBecky, -1
	itemball_event  5, 35, IRON, 1, EVENT_ICE_PATH_B1F_IRON

	const_def 1 ; object constants
	const ICEPATHB1F_BOULDER1
	const ICEPATHB1F_BOULDER2
	const ICEPATHB1F_BOULDER3
	const ICEPATHB1F_BOULDER4

IcePathB1FSetUpStoneTable:
	writecmdqueue .CommandQueue
	return

.CommandQueue:
	dbw CMDQUEUE_STONETABLE, .StoneTable ; check if any stones are sitting on a warp
	dw 0 ; filler

.StoneTable:
	stonetable 3, ICEPATHB1F_BOULDER1, .Boulder1
	stonetable 4, ICEPATHB1F_BOULDER2, .Boulder2
	stonetable 5, ICEPATHB1F_BOULDER3, .Boulder3
	stonetable 6, ICEPATHB1F_BOULDER4, .Boulder4
	db -1

.Boulder1:
	disappear ICEPATHB1F_BOULDER1
	clearevent EVENT_BOULDER_IN_ICE_PATH_1A
	jump .FinishBoulder

.Boulder2:
	disappear ICEPATHB1F_BOULDER2
	clearevent EVENT_BOULDER_IN_ICE_PATH_2A
	jump .FinishBoulder

.Boulder3:
	disappear ICEPATHB1F_BOULDER3
	clearevent EVENT_BOULDER_IN_ICE_PATH_3A
	jump .FinishBoulder

.Boulder4:
	disappear ICEPATHB1F_BOULDER4
	clearevent EVENT_BOULDER_IN_ICE_PATH_4A
	jump .FinishBoulder

.FinishBoulder:
	pause 30
	scall .BoulderFallsThrough
	jumptext IcePathBoulderFellThroughText

.BoulderFallsThrough:
	playsound SFX_STRENGTH
	earthquake 80
	end

IcePathB1FSkierScript:
	faceplayer
	opentext
	checkevent EVENT_LISTENED_TO_ICY_WIND_INTRO
	iftrue IcePathB1FTutorIcyWindScript
	writetext IcePathB1FSkierText
	waitbutton
	setevent EVENT_LISTENED_TO_ICY_WIND_INTRO
IcePathB1FTutorIcyWindScript:
	writetext Text_IcePathB1FTutorIcyWind
	waitbutton
	checkitem SILVER_LEAF
	iffalse .NoSilverLeaf
	writetext Text_IcePathB1FTutorQuestion
	yesorno
	iffalse .TutorRefused
	writebyte ICY_WIND
	writetext Text_IcePathB1FTutorClear
	special Special_MoveTutor
	if_equal $0, .TeachMove
.TutorRefused
	jumpopenedtext Text_IcePathB1FTutorRefused

.NoSilverLeaf
	jumpopenedtext Text_IcePathB1FTutorNoSilverLeaf

.TeachMove
	takeitem SILVER_LEAF
	jumpopenedtext Text_IcePathB1FTutorTaught

GenericTrainerBoarderMax:
	generictrainer BOARDER, MAX, EVENT_BEAT_BOARDER_MAX, BoarderMaxSeenText, BoarderMaxBeatenText

	text "I'm not giving up!"
	done

GenericTrainerSkierBecky:
	generictrainer SKIER, BECKY, EVENT_BEAT_SKIER_BECKY, SkierBeckySeenText, SkierBeckyBeatenText

	text "Don't forget to"
	line "wear a scarf!"
	done

IcePathB1FSkierText:
	text "It's really cold"
	line "in here!"

	para "The pits in the"
	line "ground let cold"

	para "air blow through"
	line "this cavern."

	para "It actually seems"
	line "like a good tech-"

	para "nique for a"
	line "#mon!"
	done

Text_IcePathB1FTutorIcyWind:
	text "I'll teach a #-"
	line "mon of yours to"

	para "use Icy Wind if"
	line "you trade me a"
	cont "Silver Leaf."
	done

Text_IcePathB1FTutorNoSilverLeaf:
	text "Oh, but you don't"
	line "have a Silver"
	cont "Leaf."
	done

Text_IcePathB1FTutorQuestion:
	text "Should I teach"
	line "your #mon"
	cont "Icy Wind?"
	done

Text_IcePathB1FTutorRefused:
	text "Brr…"
	done

Text_IcePathB1FTutorClear:
	text ""
	done

Text_IcePathB1FTutorTaught:
	text "OK! Now your"
	line "#mon knows"
	cont "Icy Wind!"
	done

BoarderMaxSeenText:
	text "Blackthorn can't be"
	line "much farther…"
	done

BoarderMaxBeatenText:
	text "Wiped out!"
	done

SkierBeckySeenText:
	text "I can see my"
	line "breath freezing!"
	done

SkierBeckyBeatenText:
	text "Achoo!"
	done

IcePathBoulderFellThroughText:
	text "The boulder fell"
	line "through."
	done
