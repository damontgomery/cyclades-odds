require 'rubygems'
require 'json'

results = {};

unitRange = 1..10
sampleSize = 1..100000
die = [0, 1, 1, 2, 2, 3]

unitRange.each do |unitCount|
  results[unitCount] = {}

  unitRange.each do |enemyCount|
    results[unitCount][enemyCount] = {
      'wins' => 0,
      'loses' => 0,
      'totalCasualties' => 0,
      'totalEnemyCasualties' => 0
    }

    sampleSize.each do
      units = unitCount
      enemy = enemyCount

      while units != 0 && enemy != 0 do
        roll = (units + die.sample) - (enemy + die.sample)

        if roll > 0
          # won
          enemy -= 1
        elsif roll < 0
          # enemy wins
          units -= 1
        else
          # tie
          units -= 1
          enemy -= 1
        end

      end
      
      if units >= enemy
        results[unitCount][enemyCount]['wins'] += 1
      else
        results[unitCount][enemyCount]['loses'] += 1
      end

      results[unitCount][enemyCount]['totalCasualties'] += unitCount - units
      results[unitCount][enemyCount]['totalEnemyCasualties'] += enemyCount - enemy

    end

    results[unitCount][enemyCount]['winPercent'] = results[unitCount][enemyCount]['wins'].to_f / sampleSize.max

    results[unitCount][enemyCount]['expectedLoses'] = results[unitCount][enemyCount]['totalCasualties'].to_f / sampleSize.max

    results[unitCount][enemyCount]['expectedEnemyLoses'] = results[unitCount][enemyCount]['totalEnemyCasualties'].to_f / sampleSize.max

  end
end

# Output the file.
#puts JSON.pretty_generate(results)

puts '<!DOCTYPE html><html><head>'

puts '<style>
td {
    border: 1px solid gray;
    padding: 1em;
}

th {
    padding: 0.5em 1em;
}

table {
    border-collapse: collapse;
    font-family: verdana;
    font-size: 10px;
    text-align: center;
}

.win {
  color: rgb(49, 168, 55);
  font-weight: bold;
}

.total-win {
  color: black;
}

.loss {
  color: rgb(242, 157, 0);
  font-weight: bold;
}

.total-loss {
  color: red;
}

h1 {
  font-family: verdana;
  font-size: 24px;
  margin: 0.5em 1.3em;
}

body {
  font-family: verdana;
}

p {
  margin-left: 25em;
}

</style>'

puts '</head><body><h1>Cyclades Battle Odds</h1><table>'

puts '<thead><tr><th></th>'

unitRange.each do |unitCount|
  puts '<th>' + unitCount.to_s + ' enemy</th>' if unitCount == 1
  puts '<th>' + unitCount.to_s + ' enemies</th>' if unitCount > 1
end

puts '</tr></thead>'

puts '<tbody>'

unitRange.each do |unitCount|
  puts '<tr>'

  puts '<th>' + unitCount.to_s + '</th>'
  
  unitRange.each do |enemyCount|
    if results[unitCount][enemyCount]['winPercent'] == 0
      tdClass = 'total-loss'
    elsif results[unitCount][enemyCount]['winPercent'] < 0.5
      tdClass = 'loss'
    elsif results[unitCount][enemyCount]['winPercent'] == 1
      tdClass = 'total-win'
    else
      tdClass = 'win'
    end

    puts '<td class="' + tdClass + '">'

    puts (results[unitCount][enemyCount]['winPercent'] * 100).to_i.to_s + '% ( ' + results[unitCount][enemyCount]['expectedLoses'].to_s + ' : ' + results[unitCount][enemyCount]['expectedEnemyLoses'].to_s + ' )'

    #puts JSON.pretty_generate(results[unitCount][enemyCount])[2..-2]

    puts '</pre>'
  end
  
  puts '</tr>'
end

puts '</tbody></table><p>* Chance of winning (expected loses : expected enemy loses)</p></body></html>'
