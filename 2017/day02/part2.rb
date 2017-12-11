require 'csv'

checksum = 0
CSV.foreach('input', col_sep: "\t") do |row|
  row.map!(&:to_i)

  row.each_index do |i|
    row.each_index do |j|
      next if i==j # skip same item

      if (row[i] % row[j]) == 0
        checksum += row[i] / row[j]
        break
      end
    end
  end
end

puts checksum
