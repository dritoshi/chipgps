require 'helper'

class Test_Chipgps < Test::Unit::TestCase

  def setup
    @gps_out_file = Dir.pwd + "/sample/Demo_2_GPS_significant.txt"
    @gps = Chipgps.new(@gps_out_file)

    @event_c0_e0 = nil
    @gps.each_by_condition(0) do |event|
      @event_c0_e0 = event
      break
    end

    @event_c2_e0 = nil
    @gps.each_by_condition(2) do |event|
      @event_c2_e0 = event
      break
    end
  end

  def test_open_gps_out_file
    assert(FileTest.exist?(@gps_out_file))
  end

  def test_gps_num_of_conditions
    assert_equal(5, @gps.num_of_conditions)
  end

  def test_gps_num_of_events
    assert_equal(11-1, @gps.num_of_events)
  end

  # event = 0, condition = 0
  def test_gps_each_by_condition_with_c0_e0
    assert_equal("1",     @event_c0_e0.chr)
    assert_equal(3390040, @event_c0_e0.bp)
    assert_equal(19.0,    @event_c0_e0.ip)
    assert_equal(0,       @event_c0_e0.ip_binding_present)
    assert_equal(1.0,     @event_c0_e0.ip_binding_strength)
    assert_equal(1.4,     @event_c0_e0.control_binding_strength)
    assert_equal(0.7,     @event_c0_e0.fold_enrichment)
    assert_equal(-0.07,   @event_c0_e0.mlog10_qvalue) 
    assert_equal(999.00,  @event_c0_e0.mlog10_pvalue)
    assert_equal(-4.00,   @event_c0_e0.ipvsEMP_KLD)
    assert_equal(0.00,    @event_c0_e0.ipvsCTR_KLD)
  end

  # event = 0, condition = 2
  def test_gps_each_by_condition_with_c2_e0
    assert_equal("1",     @event_c2_e0.chr)
    assert_equal(3390040, @event_c2_e0.bp)
    assert_equal(19.0,    @event_c2_e0.ip)
    assert_equal(0,       @event_c2_e0.ip_binding_present)
    assert_equal(2.0,     @event_c2_e0.ip_binding_strength)
    assert_equal(2.1,     @event_c2_e0.control_binding_strength)
    assert_equal(1.0,     @event_c2_e0.fold_enrichment)
    assert_equal(-0.06,   @event_c2_e0.mlog10_qvalue) 
    assert_equal(999.00,  @event_c2_e0.mlog10_pvalue)
    assert_equal(-3.59,   @event_c2_e0.ipvsEMP_KLD)
    assert_equal(0.00,    @event_c2_e0.ipvsCTR_KLD)
  end

end

class Test_Chipgps::Event < Test::Unit::TestCase
  def setup
    @gps_out_file = Dir.pwd + "/sample/Demo_2_GPS_significant.txt"
    @line = File.open(@gps_out_file).readlines[1]
    @event = Chipgps::Event.new(@line)
  end
end

class Test_Chipgps::Search < Test::Unit::TestCase
  def setup
    @gps_out_file = Dir.pwd + "/sample/Demo_2_GPS_significant.txt"
    @line  = File.open(@gps_out_file).readlines[1]

    event_number     = 0
    condition_number = 0
    @event = Chipgps::Search.new(@line, {:event => event_number, :condition => condition_number})

    event_number     = 0
    condition_number = 2
    @event_0_2 = Chipgps::Search.new(@line, {:event => event_number, :condition => condition_number})
  end

  # start: event = 0, condition = 0
  def test_gps_search_search_chr
    assert_equal("1", @event.chr)
  end
  def test_gps_search_search_bp
    assert_equal(3390040, @event.bp)
  end
  def test_gps_search_search_ip
    assert_equal(19.0, @event.ip)
  end

  def test_gps_search_search_ip_binding_present
    assert_equal(0,      @event.ip_binding_present)
  end

  def test_gps_search_search_ip_binding_strength
    assert_equal(1.0,    @event.ip_binding_strength)
  end

  def test_gps_search_search_control_binding_strength
    assert_equal(1.4,    @event.control_binding_strength)
  end

  def test_gps_search_search_fold_enrichment
    assert_equal(0.7,    @event.fold_enrichment)
  end

  def test_gps_search_search_mlog10_qvalue 
    assert_equal(-0.07,  @event.mlog10_qvalue) 
  end

  def test_gps_search_search_mlog10_pvalue
    assert_equal(999.00, @event.mlog10_pvalue)
  end

  def test_gps_search_search_ipvsEMP_KLD
    assert_equal(-4.00,  @event.ipvsEMP_KLD)
  end

  def test_gps_search_search_ipvsCTR_KLD
    assert_equal(0.00,   @event.ipvsCTR_KLD)
  end
  # end: event = 0, condition = 0


  # start: event = 0, condition = 2
  def test_gps_search_search_chr_by_evnet_0_2
    assert_equal("1", @event_0_2.chr)
  end
  def test_gps_search_search_bp_by_evnet_0_2
    assert_equal(3390040, @event_0_2.bp)
  end
  def test_gps_search_search_ip_by_evnet_0_2
    assert_equal(19.0, @event_0_2.ip)
  end

  def test_gps_search_search_ip_binding_present_by_evnet_0_2
    assert_equal(0,      @event_0_2.ip_binding_present)
  end

  def test_gps_search_search_ip_binding_strength_by_evnet_0_2
    assert_equal(2.0,    @event_0_2.ip_binding_strength)
  end

  def test_gps_search_search_control_binding_strength_by_evnet_0_2
    assert_equal(2.1,    @event_0_2.control_binding_strength)
  end

  def test_gps_search_search_fold_enrichment_by_evnet_0_2
    assert_equal(1.0,    @event_0_2.fold_enrichment)
  end

  def test_gps_search_search_mlog10_qvalue_by_evnet_0_2
    assert_equal(-0.06,  @event_0_2.mlog10_qvalue) 
  end

  def test_gps_search_search_mlog10_pvalue_by_evnet_0_2
    assert_equal(999.00, @event_0_2.mlog10_pvalue)
  end

  def test_gps_search_search_ipvsEMP_KLD_by_evnet_0_2
    assert_equal(-3.59,  @event_0_2.ipvsEMP_KLD)
  end

  def test_gps_search_search_ipvsCTR_KLD_by_evnet_0_2
    assert_equal(0.00,   @event_0_2.ipvsCTR_KLD)
  end
  # end: event = 0, condition = 2

end
