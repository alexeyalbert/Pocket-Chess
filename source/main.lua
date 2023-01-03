import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"

local gfx <const> = playdate.graphics
local safeMode = playdate.getReduceFlashing()
print("REDUCE FLASHING MODE IS: " .. tostring(safeMode))

boardCoords = {}
boardCoords["aX"] = 0
boardCoords["bX"] = 50
boardCoords["cX"] = 100
boardCoords["dX"] = 150
boardCoords["eX"] = 200
boardCoords["fX"] = 250
boardCoords["gX"] = 300
boardCoords["hX"] = 350
boardCoords["1Y"] = 240
boardCoords["2Y"] = 190
boardCoords["3Y"] = 140
boardCoords["4Y"] = 90
boardCoords["5Y"] = 40
boardCoords["6Y"] = -10
boardCoords["7Y"] = -60
boardCoords["8Y"] = -110

function spriteSetup(sprite)
	sprite:setZIndex(32767)
	sprite:setCenter(0.0, 1.0)

end

local function selector()
	selectorSprite:add()
end

--setup func
local function setup()
	
	selectorImage = gfx.image.new("images/selector")
	selectorSprite = gfx.sprite.new(selectorImage)
	selectorSprite:moveTo(boardCoords["aX"], boardCoords["2Y"])
	selectorSprite:setZIndex(32767)
	selectorSprite:setCenter(0, 1)

	--board sprite
	backgroundImage = gfx.image.new("images/background")
	backgroundImageSafe = gfx.image.new("images/backgroundSafe")

	if safeMode then
		backgroundSprite = gfx.sprite.new(backgroundImageSafe)
	else
		backgroundSprite = gfx.sprite.new(backgroundImage)
	end

	backgroundSprite:setZIndex(-32768)
	backgroundSprite:setCenter(0.0, 1.0)
	backgroundSprite:moveTo(0, 240)
	backgroundSprite:add()
	assert(backgroundImage)

	--white pieces images
	local wPawnImage = gfx.image.new("images/wPawn")
	local wRookImage = gfx.image.new("images/wRook")
	local wKnightImage = gfx.image.new("images/wKnight")
	local wBishopImage = gfx.image.new("images/wBishop")
	local wQueenImage = gfx.image.new("images/wQueen")
	local wKingImage = gfx.image.new("images/wKing")
	
	--white sprites
	wPawnA2 = gfx.sprite.new(wPawnImage)
	wPawnB2 = gfx.sprite.new(wPawnImage)
	wPawnC2 = gfx.sprite.new(wPawnImage)
	wPawnD2 = gfx.sprite.new(wPawnImage)
	wPawnE2 = gfx.sprite.new(wPawnImage)
	wPawnF2 = gfx.sprite.new(wPawnImage)
	wPawnG2 = gfx.sprite.new(wPawnImage)
	wPawnH2 = gfx.sprite.new(wPawnImage)

	wRookA1 = gfx.sprite.new(wRookImage)
	wRookH1 = gfx.sprite.new(wRookImage)

	wKnightB1 = gfx.sprite.new(wKnightImage)
	wKnightG1 = gfx.sprite.new(wKnightImage)

	wBishopC1 = gfx.sprite.new(wBishopImage)
	wBishopF1 = gfx.sprite.new(wBishopImage)

	wQueen = gfx.sprite.new(wQueenImage)

	wKing = gfx.sprite.new(wKingImage)

	spriteSetup(wPawnA2)
	spriteSetup(wPawnB2)
	spriteSetup(wPawnC2)
	spriteSetup(wPawnD2)
	spriteSetup(wPawnE2)
	spriteSetup(wPawnF2)
	spriteSetup(wPawnG2)
	spriteSetup(wPawnH2)

	spriteSetup(wRookA1)
	spriteSetup(wRookH1)

	spriteSetup(wKnightB1)
	spriteSetup(wKnightG1)

	spriteSetup(wBishopC1)
	spriteSetup(wBishopF1)

	spriteSetup(wQueen)

	spriteSetup(wKing)

	wPawnA2:moveTo(boardCoords["aX"], boardCoords["2Y"])
	wPawnB2:moveTo(boardCoords["bX"], boardCoords["2Y"])
	wPawnC2:moveTo(boardCoords["cX"], boardCoords["2Y"])
	wPawnD2:moveTo(boardCoords["dX"], boardCoords["2Y"])
	wPawnE2:moveTo(boardCoords["eX"], boardCoords["2Y"])
	wPawnF2:moveTo(boardCoords["fX"], boardCoords["2Y"])
	wPawnG2:moveTo(boardCoords["gX"], boardCoords["2Y"])
	wPawnH2:moveTo(boardCoords["hX"], boardCoords["2Y"])

	wRookA1:moveTo(boardCoords["aX"], boardCoords["1Y"])
	wRookH1:moveTo(boardCoords["hX"], boardCoords["1Y"])

	wKnightB1:moveTo(boardCoords["bX"], boardCoords["1Y"])
	wKnightG1:moveTo(boardCoords["gX"], boardCoords["1Y"])

	wBishopC1:moveTo(boardCoords["cX"], boardCoords["1Y"])
	wBishopF1:moveTo(boardCoords["fX"], boardCoords["1Y"])

	wQueen:moveTo(boardCoords["dX"], boardCoords["1Y"])

	wKing:moveTo(boardCoords["eX"], boardCoords["1Y"])

	wPawnA2:add()
	wPawnB2:add()
	wPawnC2:add()
	wPawnD2:add()
	wPawnE2:add()
	wPawnF2:add()
	wPawnG2:add()
	wPawnH2:add()

	wRookA1:add()
	wRookH1:add()

	wKnightB1:add()
	wKnightG1:add()

	wBishopC1:add()
	wBishopF1:add()

	wQueen:add()

	wKing:add()

	--coords of where theyre supposed(???) to be (this might become necessary once the pieces are moved around the board by the players.)
	selectorPos = {}
	selectorPos[1] = selectorSprite.x
	selectorPos[2] = selectorSprite.y
	
	wPawnA2Pos = {}
	wPawnA2Pos[1] = wPawnA2.x
	wPawnA2Pos[2] = wPawnA2.y

	--position details
	defaultBoardToPieceDistance_selectorPos = backgroundSprite.y - selectorSprite.y
	defaultBoardToPieceDistance_wPawnA2Pos = backgroundSprite.y - wPawnA2.y
	defaultBoardToPieceDistance_wPawnB2Pos = backgroundSprite.y - wPawnB2.y
	defaultBoardToPieceDistance_wPawnC2Pos = backgroundSprite.y - wPawnC2.y
	defaultBoardToPieceDistance_wPawnD2Pos = backgroundSprite.y - wPawnD2.y
	defaultBoardToPieceDistance_wPawnE2Pos = backgroundSprite.y - wPawnE2.y
	defaultBoardToPieceDistance_wPawnF2Pos = backgroundSprite.y - wPawnF2.y
	defaultBoardToPieceDistance_wPawnG2Pos = backgroundSprite.y - wPawnG2.y
	defaultBoardToPieceDistance_wPawnH2Pos = backgroundSprite.y - wPawnH2.y

	defaultBoardToPieceDistance_wRookA1Pos = backgroundSprite.y - wRookA1.y
	defaultBoardToPieceDistance_wRookH1Pos = backgroundSprite.y - wRookH1.y

	defaultBoardToPieceDistance_wKnightB1Pos = backgroundSprite.y - wKnightB1.y
	defaultBoardToPieceDistance_wKnightG1Pos = backgroundSprite.y - wKnightG1.y

	defaultBoardToPieceDistance_wBishopC1Pos = backgroundSprite.y - wBishopC1.y
	defaultBoardToPieceDistance_wBishopF1Pos = backgroundSprite.y - wBishopF1.y

	defaultBoardToPieceDistance_wQueenPos = backgroundSprite.y - wQueen.y

	defaultBoardToPieceDistance_wKingPos = backgroundSprite.y - wKing.y

	--selector menu item
	menu = playdate.getSystemMenu()

	local menuItem, error = menu:addMenuItem("selector", selector)

end

--scrolling along using the crank
function scrollBoard()
	local baseY = 0
	local change, acceleratedChange = playdate.getCrankChange()

	baseY += change
	
	--limits scroll speed
	if acceleratedChange > 10 then
		acceleratedChange = 10
	end
	if acceleratedChange < -10 then
		acceleratedChange = -10
	end

	baseY += acceleratedChange
	
	backgroundSprite:moveBy(0, baseY)
	selectorSprite:moveBy(0, baseY)
	wPawnA2:moveBy(0, baseY)
	wPawnB2:moveBy(0, baseY)
	wPawnC2:moveBy(0, baseY)
	wPawnD2:moveBy(0, baseY)
	wPawnE2:moveBy(0, baseY)
	wPawnF2:moveBy(0, baseY)
	wPawnG2:moveBy(0, baseY)
	wPawnH2:moveBy(0, baseY)
	wRookA1:moveBy(0, baseY)
	wRookH1:moveBy(0, baseY)
	wKnightB1:moveBy(0, baseY)
	wKnightG1:moveBy(0, baseY)
	wBishopC1:moveBy(0, baseY)
	wBishopF1:moveBy(0, baseY)
	wQueen:moveBy(0, baseY)
	wKing:moveBy(0, baseY)

	--limits top and bottom of board view
	if backgroundSprite.y > 400 then
		backgroundSprite:moveTo(0, 400)
	elseif backgroundSprite.y < 240 then
		backgroundSprite:moveTo(0, 240)
	end

--PIECES vvvv
	
	--selectorSprite
	local boardToPieceDistance_selector = backgroundSprite.y - selectorSprite.y
	local movementDistance_selector = boardToPieceDistance_selector - defaultBoardToPieceDistance_selectorPos

	if boardToPieceDistance_selector > defaultBoardToPieceDistance_selectorPos then
		selectorSprite:moveBy(0, movementDistance_selector)
	elseif boardToPieceDistance_selector < defaultBoardToPieceDistance_selectorPos then
		selectorSprite:moveBy(0, movementDistance_selector)
	end

	--wPawnA2
	local boardToPieceDistance_wPawnA2 = backgroundSprite.y - wPawnA2.y
	local movementDistance_wPawnA2 = boardToPieceDistance_wPawnA2 - defaultBoardToPieceDistance_wPawnA2Pos

	if boardToPieceDistance_wPawnA2 > defaultBoardToPieceDistance_wPawnA2Pos then
		wPawnA2:moveBy(0, movementDistance_wPawnA2)
	elseif boardToPieceDistance_wPawnA2 < defaultBoardToPieceDistance_wPawnA2Pos then
		wPawnA2:moveBy(0, movementDistance_wPawnA2)
	end

	--wPawnB2
	boardToPieceDistance_wPawnB2 = backgroundSprite.y - wPawnB2.y
	movementDistance_wPawnB2 = boardToPieceDistance_wPawnB2 - defaultBoardToPieceDistance_wPawnB2Pos

	if boardToPieceDistance_wPawnB2 > defaultBoardToPieceDistance_wPawnB2Pos then
		wPawnB2:moveBy(0, movementDistance_wPawnB2)
	elseif boardToPieceDistance_wPawnB2 < defaultBoardToPieceDistance_wPawnB2Pos then
		wPawnB2:moveBy(0, movementDistance_wPawnB2)
	end

	--wPawnC2
	boardToPieceDistance_wPawnC2 = backgroundSprite.y - wPawnC2.y
	movementDistance_wPawnC2 = boardToPieceDistance_wPawnC2 - defaultBoardToPieceDistance_wPawnC2Pos

	if boardToPieceDistance_wPawnC2 > defaultBoardToPieceDistance_wPawnC2Pos then
		wPawnC2:moveBy(0, movementDistance_wPawnC2)
	elseif boardToPieceDistance_wPawnC2 < defaultBoardToPieceDistance_wPawnC2Pos then
		wPawnC2:moveBy(0, movementDistance_wPawnC2)
	end
	
	--wPawnD2
	boardToPieceDistance_wPawnD2 = backgroundSprite.y - wPawnD2.y
	movementDistance_wPawnD2 = boardToPieceDistance_wPawnD2 - defaultBoardToPieceDistance_wPawnD2Pos

	if boardToPieceDistance_wPawnD2 > defaultBoardToPieceDistance_wPawnD2Pos then
		wPawnD2:moveBy(0, movementDistance_wPawnD2)
	elseif boardToPieceDistance_wPawnD2 < defaultBoardToPieceDistance_wPawnD2Pos then
		wPawnD2:moveBy(0, movementDistance_wPawnD2)
	end

	--wPawnE2
	boardToPieceDistance_wPawnE2 = backgroundSprite.y - wPawnE2.y
	movementDistance_wPawnE2 = boardToPieceDistance_wPawnE2 - defaultBoardToPieceDistance_wPawnE2Pos

	if boardToPieceDistance_wPawnE2 > defaultBoardToPieceDistance_wPawnE2Pos then
		wPawnE2:moveBy(0, movementDistance_wPawnE2)
	elseif boardToPieceDistance_wPawnE2 < defaultBoardToPieceDistance_wPawnE2Pos then
		wPawnE2:moveBy(0, movementDistance_wPawnE2)
	end

	--wPawnF2
	boardToPieceDistance_wPawnF2 = backgroundSprite.y - wPawnF2.y
	movementDistance_wPawnF2 = boardToPieceDistance_wPawnF2 - defaultBoardToPieceDistance_wPawnF2Pos

	if boardToPieceDistance_wPawnF2 > defaultBoardToPieceDistance_wPawnF2Pos then
		wPawnF2:moveBy(0, movementDistance_wPawnF2)
	elseif boardToPieceDistance_wPawnF2 < defaultBoardToPieceDistance_wPawnF2Pos then
		wPawnF2:moveBy(0, movementDistance_wPawnF2)
	end
	
	--wPawnG2
	boardToPieceDistance_wPawnG2 = backgroundSprite.y - wPawnG2.y
	movementDistance_wPawnG2 = boardToPieceDistance_wPawnG2 - defaultBoardToPieceDistance_wPawnG2Pos

	if boardToPieceDistance_wPawnG2 > defaultBoardToPieceDistance_wPawnG2Pos then
		wPawnG2:moveBy(0, movementDistance_wPawnG2)
	elseif boardToPieceDistance_wPawnG2 < defaultBoardToPieceDistance_wPawnG2Pos then
		wPawnG2:moveBy(0, movementDistance_wPawnG2)
	end

	--wPawnH2
	boardToPieceDistance_wPawnH2 = backgroundSprite.y - wPawnH2.y
	movementDistance_wPawnH2 = boardToPieceDistance_wPawnH2 - defaultBoardToPieceDistance_wPawnH2Pos

	if boardToPieceDistance_wPawnH2 > defaultBoardToPieceDistance_wPawnH2Pos then
		wPawnH2:moveBy(0, movementDistance_wPawnH2)
	elseif boardToPieceDistance_wPawnH2 < defaultBoardToPieceDistance_wPawnH2Pos then
		wPawnH2:moveBy(0, movementDistance_wPawnH2)
	end

	--wRookA1
	boardToPieceDistance_wRookA1 = backgroundSprite.y - wRookA1.y
	movementDistance_wRookA1 = boardToPieceDistance_wRookA1 - defaultBoardToPieceDistance_wRookA1Pos

	if boardToPieceDistance_wRookA1 > defaultBoardToPieceDistance_wRookA1Pos then
		wRookA1:moveBy(0, movementDistance_wRookA1)
	elseif boardToPieceDistance_wRookA1 < defaultBoardToPieceDistance_wRookA1Pos then
		wRookA1:moveBy(0, movementDistance_wRookA1)
	end

	--WRookH1
	boardToPieceDistance_wRookH1 = backgroundSprite.y - wRookH1.y
	movementDistance_wRookH1 = boardToPieceDistance_wRookH1 - defaultBoardToPieceDistance_wRookH1Pos

	if boardToPieceDistance_wRookH1 > defaultBoardToPieceDistance_wRookH1Pos then
		wRookH1:moveBy(0, movementDistance_wRookH1)
	elseif boardToPieceDistance_wRookH1 < defaultBoardToPieceDistance_wRookH1Pos then
		wRookH1:moveBy(0, movementDistance_wRookH1)
	end

	--wKnightB1
	boardToPieceDistance_wKnightB1 = backgroundSprite.y - wKnightB1.y
	movementDistance_wKnightB1 = boardToPieceDistance_wKnightB1 - defaultBoardToPieceDistance_wKnightB1Pos

	if boardToPieceDistance_wKnightB1 > defaultBoardToPieceDistance_wKnightB1Pos then
		wKnightB1:moveBy(0, movementDistance_wKnightB1)
	elseif boardToPieceDistance_wKnightB1 < defaultBoardToPieceDistance_wKnightB1Pos then
		wKnightB1:moveBy(0, movementDistance_wKnightB1)
	end
	
	--wKnightG1
	boardToPieceDistance_wKnightG1 = backgroundSprite.y - wKnightG1.y
	movementDistance_wKnightG1 = boardToPieceDistance_wKnightG1 - defaultBoardToPieceDistance_wKnightG1Pos

	if boardToPieceDistance_wKnightG1 > defaultBoardToPieceDistance_wKnightG1Pos then
		wKnightG1:moveBy(0, movementDistance_wKnightG1)
	elseif boardToPieceDistance_wKnightG1 < defaultBoardToPieceDistance_wKnightG1Pos then
		wKnightG1:moveBy(0, movementDistance_wKnightG1)
	end

	--wBishopC1
	boardToPieceDistance_wBishopC1 = backgroundSprite.y - wBishopC1.y
	movementDistance_wBishopC1 = boardToPieceDistance_wBishopC1 - defaultBoardToPieceDistance_wBishopC1Pos

	if boardToPieceDistance_wBishopC1 > defaultBoardToPieceDistance_wBishopC1Pos then
		wBishopC1:moveBy(0, movementDistance_wBishopC1)
	elseif boardToPieceDistance_wBishopC1 < defaultBoardToPieceDistance_wBishopC1Pos then
		wBishopC1:moveBy(0, movementDistance_wBishopC1)
	end

	--wBishopF1
	boardToPieceDistance_wBishopF1 = backgroundSprite.y - wBishopF1.y
	movementDistance_wBishopF1 = boardToPieceDistance_wBishopF1 - defaultBoardToPieceDistance_wBishopF1Pos

	if boardToPieceDistance_wBishopF1 > defaultBoardToPieceDistance_wBishopF1Pos then
		wBishopF1:moveBy(0, movementDistance_wBishopF1)
	elseif boardToPieceDistance_wBishopF1 < defaultBoardToPieceDistance_wBishopF1Pos then
		wBishopF1:moveBy(0, movementDistance_wBishopF1)
	end

	--wQueen
	boardToPieceDistance_wQueen = backgroundSprite.y - wQueen.y
	movementDistance_wQueen = boardToPieceDistance_wQueen - defaultBoardToPieceDistance_wQueenPos

	if boardToPieceDistance_wQueen > defaultBoardToPieceDistance_wQueenPos then
		wQueen:moveBy(0, movementDistance_wQueen)
	elseif boardToPieceDistance_wQueen < defaultBoardToPieceDistance_wQueenPos then
		wQueen:moveBy(0, movementDistance_wQueen)
	end

	--wKing
	boardToPieceDistance_wKing = backgroundSprite.y - wKing.y
	movementDistance_wKing = boardToPieceDistance_wKing - defaultBoardToPieceDistance_wKingPos

	if boardToPieceDistance_wKing > defaultBoardToPieceDistance_wKingPos then
		wKing:moveBy(0, movementDistance_wKing)
	elseif boardToPieceDistance_wKing < defaultBoardToPieceDistance_wKingPos then
		wKing:moveBy(0, movementDistance_wKing)
	end

end	

local function selectorMovement()
	if playdate.buttonIsPressed(playdate.kButtonUp) then
		if playdate.buttonJustPressed(playdate.kButtonUp) == true then
			selectorSprite:moveBy(0, -50)
			defaultBoardToPieceDistance_selectorPos = backgroundSprite.y - selectorSprite.y
		end
	end

	if playdate.buttonIsPressed(playdate.kButtonDown) then
		if playdate.buttonJustPressed(playdate.kButtonDown) == true then
			selectorSprite:moveBy(0, 50)
			defaultBoardToPieceDistance_selectorPos = backgroundSprite.y - selectorSprite.y
		end
		
	end

	if playdate.buttonIsPressed(playdate.kButtonLeft) then
		if playdate.buttonJustPressed(playdate.kButtonLeft) == true then
			selectorSprite:moveBy(-50, 0)
		end
	end

	if playdate.buttonIsPressed(playdate.kButtonRight) then
		if playdate.buttonJustPressed(playdate.kButtonRight) == true then
			selectorSprite:moveBy(50, 0)	
		end
	end
end

--why even make setup a function if theres only one thing to call at launch and you only call it once ?
setup()

--update display update
function playdate.update()

	gfx.sprite.update()

	scrollBoard()

	selectorMovement()
	
	playdate.drawFPS(0, 0)
end