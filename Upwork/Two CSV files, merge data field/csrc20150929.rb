# CSRC / Capital Systems Research Corp
# Dev: Gerard Gold 2015/09/29 ggtechguru@gmail.com
# Merges BINS.ASC on S_PAGE & IMPCPAGE.TXT on PAGE equal
# Result file name is "mrg.csv"
# If no S_PAGE == PAGE, nil ("") is the field for BINS in file "mrg.csv"
#
# To run
#     ruby <this_script_name>.rb

require 'csv'

F1 = 'BINS.ASC'
F2 = 'IMPCPAGE.TXT'


d1 = CSV.read( F1, :headers=>true)
sp_to_b = {}
h1 = d1.map{ |d|
    h_elem = d.to_hash
    sp_to_b[h_elem["S_PAGE"].to_i] = h_elem["BINS"]
    h_elem
}

d2 = CSV.read( F2, :headers=>true)
m = {}
h2 = d2.map{ |d|
    h_elem = d.to_hash
    p_ref = h_elem["PAGE"].to_i

    b = sp_to_b[p_ref]
    h_elem[ "BINS" ] = b.to_s

    h_elem
}

TARG_CSV = "mrg.csv"
CSV.open( TARG_CSV, "wb" ) do |csv|
  csv << h2[1].keys
  h2.each do |hrow|
    csv << hrow.values
  end
end

puts "Merging into:  #{TARG_CSV}"
