module MarsGeo
  class Point
    attr_accessor :lat,:lng


    def initialize(lat,lng)
      self.lat, self.lng = lat, lng
    end



    def offset
        temp_lat = self.lat * 3686400
        temp_lng = self.lng * 3686400
        converter = Converter.new
        hash_point = converter.wgtochina_lb(1,temp_lat.to_i,temp_lng.to_i,0,0,0)
        temp_lat = hash_point[:lat] / 3686400.0
        temp_lng = hash_point[:lng] / 3686400.0
        Point.new(temp_lat,temp_lng)
    end
  end
end
