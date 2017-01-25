pointinglib = {}

-- Define corresponding cardinal directions
pointinglib.yaw = {}
pointinglib.yaw.WEST = math.pi / 2
pointinglib.yaw.SOUTH = math.pi
pointinglib.yaw.EAST = 3*math.pi / 2
pointinglib.yaw.NORTH = 0

--[[ Definition of a view

	ViewDirection = {
		yaw = yawvalue,
		pitch = pitchvalue,
	}

--]]

function pointinglib.degrees(degree_value)
	-- Do NOT use modulo to reduce the value into "normal" range
	-- The viewpoint animation for the player from 350 deg to 370 deg
	--   is NOT the same as 350 deg to 10 deg ...!!
	return (degree_value / 360) * (2*math.pi)
end

function pointinglib.yaw_progression(oldyaw, newyaw, rotation, steps)	
end

function pointinglib.pitch_progression(oldpitch, newpitch, steps)
end

function pointinglib.look_progression(viewd1, viewd2, steps)
end

function pointinglib.get_viewdirection(looker, target)
	-- looker and target are two positions
end

minetest.register_chatcommand("yaw",{
	func = function(playername, args)
		local p = minetest.get_player_by_name(playername)
		local pyaw = 0
		if tonumber(args) then
			pyaw = pointinglib.degrees(tonumber(args) )
		else
			pyaw = pointinglib.yaw[args]
		end
		p:set_look_horizontal(pyaw)
		lpyaw = p:get_look_horizontal()
		minetest.chat_send_player(playername, "New yaw: "..tostring(lpyaw).." after setting "..tostring(pyaw) )
	end
})

minetest.register_chatcommand("roll",{
	func = function(playername, args)
		local n = tonumber(args)
		if not n then return end

		player = minetest.get_player_by_name(playername)

		local playeryaw = player:get_look_horizontal()

		pointinglib.yaw_progression(playeryaw, playeryaw + pointinglib.degrees(n) )
	end
})
