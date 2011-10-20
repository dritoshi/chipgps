#!/usr/bin/env ruby

$LOAD_PATH.push("../lib")

require 'pp'
require 'chipgps'

#gps_out_file = ARGV.shift
gps_out_file = "Demo_2_GPS_significant.txt"
gps = Chipgps.new(gps_out_file)

for condition_id in 0..(gps.num_of_conditions-1)

  exp_name = "Demo_Day" + condition_id.to_s
  header = "track name=#{exp_name} description=\"GPS: #{exp_name}\" useScore=0"
  puts header
  gps.each_by_condition(condition_id) do |event|

    # output (bed format)
    puts [
      "chr" + event.chr,                # chr
      event.bp,                         # start
      event.bp + 1,                     # end
      [exp_name, event.chr, event.bp.to_s].join(":"),  # name
      event.fold_enrichment             # score
    ].join("\t")

  end
end
