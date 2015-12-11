-- Custom Number hud by Miku AuahDark <auahdark687291@gmail.com>

local function initializeTableOnce(name)
	loadstring(name.."="..name.." or {}")()
end

initializeTableOnce("CustomNumber")
initializeTableOnce("CustomNumber.Numbers")	-- [Name: string]={Path: function(number 0-9) returns string to path; SizeX: number; SizeY: number}
initializeTableOnce("CustomNumber.Methods")	-- Used for OOP-style

function CustomNumber.New(name,x,y,value--[[=0]],id--[[=0]])
	value=value or 0
	id=id or 0

	local images={}
	local out={
		Name=name,
		PosX=x,
		PosY=y,
		Images=images,
		Value=value
	}

	if id>0 then out.Player=id end

	setmetatable(out,{
		__index=function(_,var)
			return CustomNumber.Methods[var] or rawget(_,var)
		end
	})

	out:Update()	-- This is an expensive call. Use it wisely!
	return out
end

function CustomNumber.Methods.Delete(_)
	for n,v in pairs(_.Images) do
		freeimage(v)
	end
end

function CustomNumber.Methods.Update(_)
	local value=_.Value
	local numbers=CustomNumber.Numbers[_.Name]

	assert(tonumber(value),"specificed value is not a number")
	assert(numbers,"invalid custom number hud name")

	for n,v in pairs(_.Images) do
		freeimage(v)
		_.Images[n]=nil
	end

	local i=0
	local sx=numbers.SizeX
	for w in tostring(value):gmatch("%d") do
		table.insert(_.Images,image(numbers.Path(tonumber(w)),i*sx+_.PosX+sx/2,_.PosY+numbers.SizeY/2,2,_.Player))
		i=i+1
	end
end

function CustomNumber.Methods.Move(_,x,y)
	local num=CustomNumber.Numbers[_.Name]
	local sx=num.SizeX
	_.PosX=x
	_.PosY=y
	for n,v in pairs(_.Images) do
		imagepos(v,(n-1)*sx+x+sx/2,y+num.SizeY/2,0)
	end
end

setmetatable(CustomNumber,{
	__index=function(_,var)
		return CustomNumber.Methods[var] or rawget(_,var)
	end
})