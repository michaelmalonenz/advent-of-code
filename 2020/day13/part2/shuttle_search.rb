input = File.readlines('input').map(&:strip)

TIMETABLE = input[1].split(',')

def ext_gcd(a, b)
    x = 1
    y = 0
    x1 = 0
    y1 = 1
    a1 = a
    b1 = b

    while b1 > 0
        q = a1 / b1
        x, x1 = x1, x - q*x1
        y, y1 = y1, y - q*y1
        a1, b1 = b1, a1 - q*b1
    end

    return x, y
end

    
divs = []
mx = [-1, -1]
lcm = 1
TIMETABLE.length.times do |i|
    next if TIMETABLE[i] == 'x'

    TIMETABLE[i] = TIMETABLE[i].to_i

    k = i
    k %= TIMETABLE[i]
    k = TIMETABLE[i] - k
    k %= TIMETABLE[i]

    divs.append([TIMETABLE[i], k])
    lcm *= TIMETABLE[i]
    if mx[0] == -1 || divs[-1][0] > mx[0]
        mx = divs[-1]
    end
    puts divs
end
    
while divs.length > 1
    n1, a1 = divs[-1]
    n2, a2 = divs[-2]

    divs.pop()
    divs.pop()
    m1, m2 = ext_gcd(n1, n2)
    x = a1*m2*n2 + a2*m1*n1
    x %= n1*n2

    if x < 0
        x += n1*n2
    end
    divs.append([n1*n2, x])
    puts divs
end

puts divs[0][1]