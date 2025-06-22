function draw_die2d(die,x,y, die2, upgrade)
    local d1 = true
    if die2 and upgrade.kind != "hp" then
        d1 = (tf \ 14) % 2 == 0
    end
    --local locs = {{0,18},{18,18},{36,18},{54,18},{18,0},{18,36}}
    local locs = {{0,15},{15,15},{30,15},{45,15},{15,0},{15,30}}
    for i = 1, 6 do
        temp_camera(-locs[i][1] - x, -locs[i][2] - y, function()
            if upgrade and not d1 and upgrade.faces[i] then
                rectfill(-2, -1, 11, 10, 12)
                rectfill(-1, -2, 10, 11, 12)
                die2[i].draw_face(0,0)
            else
                die[i].draw_face(0,0)
            end
        end)
    end
    --[[
    if d1 then
        die[1].draw_face(x,y + 18)
        die[2].draw_face(x + 18,y + 18)
        die[3].draw_face(x + 36,y + 18)
        die[4].draw_face(x + 54,y + 18)
        die[5].draw_face(x + 18,y)
        die[6].draw_face(x + 18,y + 36)
    else
        die2[1].draw_face(x,y + 18)
        if upgrade.faces[1] then rect(x-1,y+17,x+16,y+34,7) end
        die2[2].draw_face(x + 18,y + 18)
        if upgrade.faces[2] then rect(x+17,y+17,x+34,y+34,7) end
        die2[3].draw_face(x + 36,y + 18)
        if upgrade.faces[3] then rect(x+35,y+17,x+52,y+34,7) end
        die2[4].draw_face(x + 54,y + 18)
        if upgrade.faces[4] then rect(x+53,y+17,x+70,y+34,7) end
        die2[5].draw_face(x + 18,y)
        if upgrade.faces[5] then rect(x+17,y-1,x+34,y+16,7) end
        die2[6].draw_face(x + 18,y + 36)        
        if upgrade.faces[6] then rect(x+17,y+35,x+34,y+52,7) end
    end
    ]]
end

-- front faces = 1,2,3,4, top left cw
-- back faces = 5,6,7,8, top left cw
die3d = {}
--[[
function polyfill(p,col)
	color(col)
	local p0,nodes=p[#p],{}
	local x0,y0=p0[1],p0[2]

	for i=1,#p do
		local p1=p[i]
		local x1,y1=p1[1],p1[2]
		local _x1,_y1=x1,y1
		if(y0>y1) x0,y0,x1,y1=x1,y1,x0,y0
		local cy0,cy1,dx=y0\1+1,y1\1,(x1-x0)/(y1-y0)
		if(y0<0) x0-=y0*dx y0=0
	   	x0+=(-y0+cy0)*dx
		for y=cy0,min(cy1,127) do
			local x=nodes[y]
			if x then
				local x,x0=x,x0
				if(x0>x) x,x0=x0,x
				rectfill(x0+1,y,x,y)
			else
			 nodes[y]=x0
			end
			x0+=dx					
		end			
		x0,y0=_x1,_y1
	end
end
function v_sub(a,b) return {a[1] - b[1], a[2] - b[2], a[3] - b[3], 1} end
function v_mag(v)
    local d=max(max(abs(v[1]),abs(v[2])),abs(v[3]))
    local x,y,z=v[1]/d,v[2]/d,v[3]/d
    return (x*x+y*y+z*z)^0.5*d
end
function v_norm(v)
	local d = v_mag(v)
	return {v[1] / d, v[2] / d, v[3] / d, 1}
end
function v_cross(a,b)
	return {a[2] * b[3] - b[2] * a[3], a[3] * b[1] - b[3] * a[1], a[1] * b[2] - b[1] * a[2], 1}
end
function v_dot(a,b) return a[1]*b[1] + a[2] * b[2] + a[3] * b[3] end
]]
function mv4(m, v)
    return {
        m[1] * v[1] +    m[2] * v[2] +    m[3] * v[3] +    m[4] * v[4],
        m[5] * v[1] +    m[6] * v[2] +    m[7] * v[3] +    m[8] * v[4],
        m[9] * v[1] +    m[10] * v[2] +   m[11] * v[3] +   m[12] * v[4],
        m[13] * v[1] +   m[14] * v[2] +   m[15] * v[3] +   m[16] * v[4]
    }
end

function gen_die(die, a,b,c)
    local sina, cosa, sinb, cosb, sinc, cosc = sin(a), cos(a), sin(b), cos(b), sin(c), cos(c)
    m = {
        cosb * cosa, sinc * sinb * cosa - cosc * sina, cosc * sinb * cosa + sinc * sina, 0,
        cosb * sina, sinc * sinb * sina + cosc * cosa, cosc * sinb * sina - sinc * cosa, 0,
        -sinb, sinc * cosb, cosc * cosb, 0,
        0,0,0,1
    }
    die.pts[1] = mv4(m, {-1,-1,-1,1})
    die.pts[2] = mv4(m, {1,-1,-1,1})
    die.pts[3] = mv4(m, {1,1,-1,1})
    die.pts[4] = mv4(m, {-1,1,-1,1})
    die.pts[5] = mv4(m, {-1,-1,1,1})
    die.pts[6] = mv4(m, {1,-1,1,1})
    die.pts[7] = mv4(m, {1,1,1,1})
    die.pts[8] = mv4(m, {-1,1,1,1})
    for i = 1, #die.pts do
        die.pts[i] = {die.pts[i][1] * 10, die.pts[i][2] * 10, die.pts[i][3] * 0.7 + 2.3}
    end
end

function draw_die3d(die)
    local i = 0
    --local sun = v_norm({0.25, -0.5, -1})
    --local cam = v_norm({0,0,-1})
    color(1)
    for face in all(die.faces) do
        
        local pts = die.pts
        local p1,p2,p3,p4 = pts[face[1]],pts[face[2]],pts[face[3]],pts[face[4]]
        if p1[3] < 2 or p2[3] < 2 or p3[3] < 2 or p4[3] < 2 then
            --[[local norm = v_cross(v_norm(v_sub(p2, p1)), v_norm(v_sub(p3, p2)))
            local dp = v_dot(sun, norm)
            local cdp = v_dot(cam, norm)
            if cdp > 0 then
                polyfill({
                    {p1[1] / p1[3] + die.x, p1[2] / p1[3] + die.y},
                    {p2[1] / p2[3] + die.x, p2[2] / p2[3] + die.y},
                    {p3[1] / p3[3] + die.x, p3[2] / p3[3] + die.y},
                    {p4[1] / p4[3] + die.x, p4[2] / p4[3] + die.y},
                }, (dp * 8 + 8) \ 1
                )
            end]]
            line(p1[1] / p1[3] + die.x, p1[2] / p1[3] + die.y, p2[1] / p2[3] + die.x, p2[2] / p2[3] + die.y)
            line(p3[1] / p3[3] + die.x, p3[2] / p3[3] + die.y)
            line(p4[1] / p4[3] + die.x, p4[2] / p4[3] + die.y)
            line(p1[1] / p1[3] + die.x, p1[2] / p1[3] + die.y)
            
        end
        i += 1
    end
end