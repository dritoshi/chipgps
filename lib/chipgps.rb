class Chipgps

  class Event
    def initialize(line)
      @line = line
    end
    attr_reader   :line
    attr_accessor :chr, :bp, :ip
    attr_accessor :ip_binding_present, :ip_binding_strength, :control_binding_strength,
      :fold_enrichment, :mlog10_qvalue, :mlog10_pvalue, :ipvsEMP_KLD, :ipvsCTR_KLD

  end  # End of Event class

  class Search < Event
    def initialize(line, options = {})
      @line = line
      @event_number     = options[:event]
      @condition_number = options[:condition]

      parse
    end

    def cleanup(line)
      new_line = line.strip
      new_line.chomp!
      new_line.gsub!(/ +/, "")
      return new_line
    end

    def parse
      # condition_number start from 0.

      line = cleanup(@line)
      f = line.split(/\t/)

      @chr = f[0].split(/:/)[0]
      @bp  = f[0].split(/:/)[1].to_i
      @ip  = f[1].to_f

      @ip_binding_present       = f[(@condition_number * 9 + 2) + 0].to_i 
      @ip_binding_strength      = f[(@condition_number * 9 + 2) + 1].to_f  
      @control_binding_strength = f[(@condition_number * 9 + 2) + 2].to_f  
      @fold_enrichment          = f[(@condition_number * 9 + 2) + 3].to_f  
      @mlog10_qvalue            = f[(@condition_number * 9 + 2) + 4].to_f  
      @mlog10_pvalue            = f[(@condition_number * 9 + 2) + 5].to_f  
      @ipvsEMP_KLD              = f[(@condition_number * 9 + 2) + 6].to_f  
      @ipvsCTR_KLD              = f[(@condition_number * 9 + 2) + 7].to_f  
    end

  end  # End of Search class

  def initialize(file)
    @gps_out_file = file
    @lines = File.open(@gps_out_file).readlines
    @header = @lines.shift

    @num_of_conditions = num_of_conditions
    @num_of_events     = num_of_events
  end
  attr_reader :header

  def num_of_conditions
    f = @lines[0].split(/\t/)
    num_of_conditions = (f.size - 2) / 9  # each condition has 9 cols
    # pp f.size
    return num_of_conditions
  end

  def num_of_events
    return @lines.size
  end

  def each_by_condition(condition_id) # condition_id starts from 0
    @lines.each_with_index do |line, idx|
      yield Chipgps::Search.new(line, {:condition => condition_id, :event => idx})
    end
  end

end
