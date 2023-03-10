import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"

local gfx <const> = playdate.graphics
local safeMode = playdate.getReduceFlashing()

--chess board coord shortcuts
local boardCoords = {}
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

--chess piece object/class
class('piece').extends(gfx.sprite)

--some vars i'll need later
local APressedYet = false
local dot = {}
local piecePosTable = {}

function piece:init(column, row, image, color)
    self:setImage(image)
    self:moveTo(boardCoords[column], boardCoords[row])
    self:setZIndex(1)
	self:setCenter(0.0, 1.0)
    self.color = color
	self.posX = self.x
	self.posY = self.y
	self.pos = self.x .. " " .. self.y
	piecePosTable[self] = self.pos
end

--setup func
local function init()

	selDots = nil
	dot1 = nil
	dot2 = nil

	gfx.setDrawOffset(0, 240)

	--selector
	selectorImage = gfx.image.new("images/selector")
	selectorSprite = gfx.sprite.new(selectorImage)
	selectorSprite:moveTo(boardCoords["a"], boardCoords["2"])
	selectorSprite:setZIndex(2)
	selectorSprite:setCenter(0, 1)
	selectorSprite:add()

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

	selDotImage = gfx.image.new("images/selDot")
	class('selDots').extends(gfx.sprite)

	function selDots:init(relPosX, relPosY)
		self:setImage(selDotImage)
	    self:setZIndex(1)
	    self:setCenter(0.0, 1.0)
	    self:moveTo(selectorSprite.x + relPosX, selectorSprite.y + relPosY)
	    self.relPosX = relPosX
	    self.relPosY = relPosY
	    self.relPos = relPosX .. " " .. relPosY
	end


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

--movement of the selector sprite
local function selectorMovement()
	if playdate.buttonIsPressed(playdate.kButtonUp) then
		if playdate.buttonJustPressed(playdate.kButtonUp) == true then
			if selectorSprite.y ~= -350 then
				selectorSprite:moveBy(0, -50)
			end
		end
	end

	if playdate.buttonIsPressed(playdate.kButtonDown) then
		if playdate.buttonJustPressed(playdate.kButtonDown) == true then
			if selectorSprite.y ~= 0 then
				selectorSprite:moveBy(0, 50)
			end
		end
	end

	if playdate.buttonIsPressed(playdate.kButtonLeft) then
		if playdate.buttonJustPressed(playdate.kButtonLeft) == true then
			if selectorSprite.x ~= 0 then
				selectorSprite:moveBy(-50, 0)
			end
		end
	end

	if playdate.buttonIsPressed(playdate.kButtonRight) then
		if playdate.buttonJustPressed(playdate.kButtonRight) == true then
			if selectorSprite.x ~= 350 then
				selectorSprite:moveBy(50, 0)	
			end
		end
	end
end

local function pawnMovementPreview()
	for i = 1, 2 do
		local posYUp = i * -50
		dot[i] = selDots(0, posYUp)
		dot[i]:add()
	end
end


function playdate.AButtonDown()
	local selectorPos = selectorSprite.x .. " " .. selectorSprite.y
	if APressedYet then
		for k, v in pairs(dot) do
			dot[k]:remove()
		end
	end

	if selectorPos == wPawnA.pos or wPawnB.pos == selectorPos or wPawnC.pos == selectorPos or wPawnD.pos == selectorPos or wPawnE.pos == selectorPos or wPawnF.pos == selectorPos or wPawnG.pos == selectorPos or wPawnH.pos == selectorPos then
		pawnMovementPreview()
	elseif wPawnH.pos == selectorPos then
		pawnMovementPreview()
	elseif wRookA.pos == selectorPos then
		--if wRookA.x == 0 then 
		
		--[[note to self, limit the drawing of preview dots based 
		on their pos to make sure dots aren't unnecesarily drawn offscreen--]]

		for i = 1, 8 do
			local posYUp = i * -50
			dot[i] = selDots(0, posYUp)
			dot[i]:add()
		end

	end
	APressedYet = true
end


init()

--update display update
function playdate.update()
	gfx.sprite.update()

	scrollBoard()

	selectorMovement()
	
	playdate.drawFPS(0, 0)

print("hello!")
end