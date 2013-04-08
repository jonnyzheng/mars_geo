require 'mars_geo'

include MarsGeo

describe MarsGeo::Converter do

  it 'method yj_sin2 should correct' do 
    converter = Converter.new
    value = converter.yj_sin2(31.5566)
    value.should eq(0.14020995787539087)
  end

  it 'method transform_yj5 should correct' do 
    converter = Converter.new
    value = converter.transform_yj5(31.5566,121.77887615)
    value.should eq(1116.0853927686755)
  end

  it 'method transform_yjy5 should correct' do 
    converter = Converter.new
    value = converter.transform_yjy5(31.5566,121.77887615)
    value.should eq(3767.9839409629326)
  end


  it 'method transform_jy5 should correct' do
    converter = Converter.new
    value = converter.transform_jy5(31.5566,121.77887615)
    value.should eq(0.0012826033424097633)
  end

  it 'method transform_jyj5 should correct' do
    converter = Converter.new
    value = converter.transform_jyj5(31.5566,121.77887615)
    value.should eq(0.0010982842446974356)
  end

  it 'method wgtochina_lb should correct' do
      point = Point.new(31.208949, 121.533383)
      offset_point = point.offset
      offset_point.lat.should eq(31.2068310546875)
      offset_point.lng.should eq(121.53770209418403)
  end


end
