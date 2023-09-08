-- front faces = 1,2,3,4, top left cw
-- back faces = 5,6,7,8, top left cw
die3d = {}

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
        die.pts[i] = {die.pts[i][1] * 10, die.pts[i][2] * 10, die.pts[i][3] * 0.5 + 2}
    end
end

function draw_die3d(die)
    local i = 0
    for face in all(die.faces) do
        color(12)
        local pts = die.pts
        local p1,p2,p3,p4 = pts[face[1]],pts[face[2]],pts[face[3]],pts[face[4]]
        if p1[3] < 2 or p2[3] < 2 or p3[3] < 2 or p4[3] < 2 then
            line(p1[1] / p1[3] + die.x, p1[2] / p1[3] + die.y, p2[1] / p2[3] + die.x, p2[2] / p2[3] + die.y)
            line(p3[1] / p3[3] + die.x, p3[2] / p3[3] + die.y)
            line(p4[1] / p4[3] + die.x, p4[2] / p4[3] + die.y)
            line(p1[1] / p1[3] + die.x, p1[2] / p1[3] + die.y)
        end
        i += 1
    end
end