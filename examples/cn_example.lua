-- cn_example.lu)
-- Custom Number hud example

dofile("sys/lua/cn.lua")

CustomNumber.Numbers["combonumber_red"]={
	Path=function(n)
		return "gfx/combonumber/06"..n..".png"
	end,
	SizeX=48,
	SizeY=48
}

local is_start=false

addhook("startround","test_startround")
function test_startround()
	if is_start then return end
	cn_var=CustomNumber.New("combonumber_red",0,100)
	addhook("second","test_second")
	is_start=true
end

function test_second()
	cn_var.Value=cn_var.Value+1
	cn_var:Update()
end

test_startround()