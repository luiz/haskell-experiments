def closing(csv)
    readPrice csv.split(',')[4]
end

def readPrice(str)
    matches = str.match /(\d+)\.(\d{2})/
    if matches
        dollars, cents = matches[1,2].map { |n| n.to_i }
        dollars * 100 + cents
    else
        0
    end
end

def highestClose(wholeFile)
    lines = wholeFile.split /\n/
    closings = lines.map { |l| closing(l) }
    closings << 0
    closings.max
end

puts highestClose(File.open(ARGV[0], 'rb').read)
