import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"

local gfx <const> = playdate.graphics
local safeMode = playdate.getReduceFlashing()

boardCoords = {}
boardCoords["a"] = 0
boardCoords["b"] = 50
boardCoords["c"] = 100
boardCoords["d"] = 150
boardCoords["e"] = 200
boardCoords["f"] = 250
boardCoords["g"] = 300
boardCoords["h"] = 350
boardCoords["1"] = 0
boardCoords["2"] = -50
boardCoords["3"] = -100
boardCoords["4"] = -150
boardCoords["5"] = -200
boardCoords["6"] = -250
boardCoords["7"] = -300
boardCoords["8"] = -350

class('piece').extends(gfx.sprite)

function piece:init(column, row, image, color)
    self:setImage(image)
    self:moveTo(boardCoords[column], boardCoords[row])
    self:setZIndex(1)
	self:setCenter(0.0, 1.0)
    self.color = color
	self.posX = self.x
	self.posY = self.y
end

local function selector()
	selectorSprite:add()
end

--setup func
local function setup()
	gfx.setDrawOffset(0, 240)

	--selector
	selectorImage = gfx.image.new("images/selector")
	selectorSprite = gfx.sprite.new(selectorImage)
	selectorSprite:moveTo(boardCoords["a"], boardCoords["2"])
	selectorSprite:setZIndex(2)
	selectorSprite:setCenter(0, 1)

	--board sprite
	backgroundImage = gfx.image.new("images/background")
	backgroundImageSafe = gfx.image.new("images/backgroundSafe")

	if safeMode then
		backgroundSprite = gfx.sprite.new(backgroundImageSafe)
	else
		backgroundSprite = gfx.sprite.new(backgroundImage)
	end

	backgroundSprite:setZIndex(0)
	backgroundSprite:setCenter(0.0, 1.0)
	backgroundSprite:add()
	assert(backgroundImage)

	local wPawnImage = gfx.image.new("images/wPawn")
	local wRookImage = gfx.image.new("images/wRook")
	local wKnightImage = gfx.image.new("images/wKnight")
	local wBishopImage = gfx.image.new("images/wBishop")
	local wQueenImage = gfx.image.new("images/wQueen")
	local wKingImage = gfx.image.new("images/wKing")

	wPawnA = piece("a", "2", wPawnImage, "white")
	wPawnA:add()

	wPawnB = piece("b", "2", wPawnImage, "white")
	wPawnB:add()
	
	wPawnC = piece("c", "2", wPawnImage, "white")
	wPawnC:add()

	wPawnD = piece("d", "2", wPawnImage, "white")
	wPawnD:add()
	
	wPawnE = piece("e", "2", wPawnImage, "white")
	wPawnE:add()

	wPawnF = piece("f", "2", wPawnImage, "white")
	wPawnF:add()

	wPawnG = piece("g", "2", wPawnImage, "white")
	wPawnG:add()

	wPawnH = piece("h", "2", wPawnImage, "white")
	wPawnH:add()

	wRookA = piece("a", "1", wRookImage, "white")
	wRookA:add()

	wRookH = piece("h", "1", wRookImage, "white")
	wRookH:add()

	wKnightB = piece("b", "1", wKnightImage, "white")
	wKnightB:add()

	wKnightG = piece("g", "1", wKnightImage, "white")
	wKnightG:add()

	wBishopC = piece("c", "1", wBishopImage, "white")
	wBishopC:add()

	wBishopF = piece("f", "1", wBishopImage, "white")
	wBishopF:add()

	wQueenD = piece("d", "1", wQueenImage, "white")
	wQueenD:add()

	wKingE = piece("e", "1", wKingImage, "white")
	wKingE:add()
	--coords of where theyre supposed(???) to be (this might become necessary once the pieces are moved around the board by the players.)
	selectorPos = {}
	selectorPos[1] = selectorSprite.x
	selectorPos[2] = selectorSprite.y
	
	--[[wPawnA2Pos = {}
	wPawnA2Pos[1] = wPawnA2.x
	wPawnA2Pos[2] = wPawnA2.y
--]]

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

	local offsetY = 0

	offsetX, offsetY = gfx.getDrawOffset()
	offsetY += baseY

	gfx.setDrawOffset(0, offsetY)

	if offsetY > 400 then
		gfx.setDrawOffset(0, 400)
	elseif offsetY < 240 then
		gfx.setDrawOffset(0, 240)
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