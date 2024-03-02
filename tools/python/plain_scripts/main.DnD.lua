local initialized = false

"[ _AES_LOST_ ]" ----------====================== Story functions ========================================

function IntroCard() {
    Global.load_module("title-card", "").display({ 
        subtitle = "Matt Forbeck", 
        title = "Donjons & Dragons ....",
        audio = "title_card.mp3",
"[ _AES_LOST_ ]""title_card-fr_FR",
"[ _AES_LOST_ ]"
"[ _AES_LOST_ ]"unction TransitionA04()
"[ _AES_LOST_ ]"Global.loadBranch("branch-a")
...
"[ _AES_LOST_ ]"tion Intro02()
"[ _AES_LOST_ ]"Global.loadBranch("character-creation")
...
"[ _AES_LOST_ ]"ansitionB28b()
"[ _AES_LOST_ ]"Global.loadBranch("branch-b")
"[ _AES_LOST_ ]"
...
"[ _AES_LOST_ ]"n TransitionB28()
"[ _AES_LOST_ ]"Global.loadBranch("branch-b")
"[ _AES_LOST_ ]"
...

"[ _AES_LOST_ ]" ----------====================== Standard functions ========================================
-- function setup()
"[ _AES_LOST_ ]"nction setup()
"[ _AES_LOST_ ]"
"[ _AES_LOST_ ]"require("global")
-- function init()
"[ _AES_LOST_ ]"t()
"[ _AES_LOST_ ]"sMultiBranch = true
"[ _AES_LOST_ ]"progression.create({totalChapters = 20, backBehavior = Start})
"[ _AES_LOST_ ]"oadBranch("character-creation")
"[ _AES_LOST_ ]"-- Global.loadBranch("branch-a")
"[ _AES_LOST_ ]"loadBranch("branch-b")
"[ _AES_LOST_ ]"initVariables()
"[ _AES_LOST_ ]"menu.set_entries{
"[ _AES_LOST_ ]"title = "Retourner à l'histoire",
"[ _AES_LOST_ ]"cb = LateralBackStory
"[ _AES_LOST_ ]"title = "Chapitres écoutés",
"[ _AES_LOST_ ]"cb = LateralChapters
"[ _AES_LOST_ ]"title = "Ta fiche personnage",
"[ _AES_LOST_ ]"cb = LateralFiche
"[ _AES_LOST_ ]"
"[ _AES_LOST_ ]"{
"[ _AES_LOST_ ]"title = "Ton sac sans fond",
"[ _AES_LOST_ ]"cb = LateralInventory
"[ _AES_LOST_ ]"})
"[ _AES_LOST_ ]"
"[ _AES_LOST_ ]"tion display_inventory(backTarget)
"[ _AES_LOST_ ]"deredInventory = Global.sortCollectionTable(state.inventory)
"[ _AES_LOST_ ]"local inBack = Start
"[ _AES_LOST_ ]"
"[ _AES_LOST_ ]"ckTarget ~= nil) then invBack = backTarget end
"[ _AES_LOST_ ]"Global.load_module("collection", "").create({})
"[ _AES_LOST_ ]"
"[ _AES_LOST_ ]"
....


"[ _AES_LOST_ ]"
"[ _AES_LOST_ ]"
"[ _AES_LOST_ ]"ction Start()
"[ _AES_LOST_ ]"

local initialized = true

"[ _AES_LOST_ ]" ----------====================== Tooling functions ========================================
"[ _AES_LOST_ ]" function initVariables()

    --- many variables init, sagesse unit value
    --- and inventory, recompenses et autre
"[ _AES_LOST_ ]"
"[ _AES_LOST_ ]"
"[ _AES_LOST_ ]"
"[ _AES_LOST_ ]"
"[ _AES_LOST_ ]"
"[ _AES_LOST_ ]"
"[ _AES_LOST_ ]"
"[ _AES_LOST_ ]"
"[ _AES_LOST_ ]"
"[ _AES_LOST_ ]"
