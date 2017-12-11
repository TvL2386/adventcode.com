require 'csv'

checksum = 0
CSV.foreach('input', col_sep: "\t") do |row|
  row.map!(&:to_i)

  checksum += (row.max - row.min)
end

puts checksum
