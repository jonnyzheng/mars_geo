#encoding: utf-8

module MarsGeo
  class Converter
    attr_accessor :casm_rr,:casm_t1,:casm_t2,:casm_x1,:casm_y1, :casm_x2,:casm_y2,:casm_f

    def initialize
      self.casm_rr = 0
    end

    def yj_sin2(x)
      ff = 0

      if x<0
        x = -x
        ff = 1
      end

      cc = (x / 6.28318530717959).to_i
      tt = x - cc * 6.28318530717959

      if tt > 3.1415926535897932 
        tt = tt - 3.1415926535897932
        if ff == 1
          ff = 0
        elsif ff == 0
          ff = 1
        end
      end
      x = tt
      ss = x
      s2 = x
      tt = tt * tt
      s2 = s2 * tt
      ss = ss - s2 * 0.166666666666667
      s2 = s2 * tt
      ss = ss + s2 * 8.33333333333333E-03
      s2 = s2 * tt
      ss = ss - s2 * 1.98412698412698E-04
      s2 = s2 * tt
      ss = ss + s2 * 2.75573192239859E-06
      s2 = s2 * tt
      ss = ss - s2 * 2.50521083854417E-08
      ss = -ss if (ff == 1)

      return ss;
    end


    def transform_yj5(x, y)
      tt = 300 + 1 * x + 2 * y + 0.1 * x * x + 0.1 * x * y + 0.1 * Math.sqrt(Math.sqrt(x * x))
      tt = tt + (20 * yj_sin2(18.849555921538764 * x) + 20 * yj_sin2(6.283185307179588 * x)) * 0.6667
      tt = tt + (20 * yj_sin2(3.141592653589794 * x) + 40 * yj_sin2(1.047197551196598 * x)) * 0.6667
      tt = tt + (150 * yj_sin2(0.2617993877991495 * x) + 300 * yj_sin2(0.1047197551196598 * x)) * 0.6667
      tt
    end

    def transform_yjy5(x,y)
      tt = -100 + 2 * x + 3 * y + 0.2 * y * y + 0.1 * x * y + 0.2 * Math.sqrt(Math.sqrt(x * x))
      tt = tt + (20 * yj_sin2(18.849555921538764 * x) + 20 * yj_sin2(6.283185307179588 * x)) * 0.6667
      tt = tt + (20 * yj_sin2(3.141592653589794 * y) + 40 * yj_sin2(1.047197551196598 * y)) * 0.6667
      tt = tt + (160 * yj_sin2(0.2617993877991495 * y) + 320 * yj_sin2(0.1047197551196598 * y)) * 0.6667
    end

    def transform_jy5(x, xx)
      a = 6378245
      e = 0.00669342
      n = Math.sqrt(1 - e * yj_sin2(x * 0.0174532925199433) * yj_sin2(x * 0.0174532925199433))
      n = (xx * 180) / (a / n * Math.cos(x * 0.0174532925199433) * 3.1415926)
    end

    def transform_jyj5(x,yy)
      a = 6378245
      e = 0.00669342
      mm = 1 - e * yj_sin2(x * 0.0174532925199433) * yj_sin2(x * 0.0174532925199433)
      m = (a * (1 - e)) / (mm * Math.sqrt(mm))
      return (yy * 180) / (m * 3.1415926)
    end

    def random_yj
      casm_a = 314159269
      casm_c = 453806245
      self.casm_rr = casm_a * self.casm_rr + casm_c
      t =  (self.casm_rr / 2).to_i
      self.casm_rr = self.casm_rr - t * 2
      self.casm_rr = self.casm_rr.to_f / 2
    end

    def ini_casm(w_time, w_lng,  w_lat)
      self.casm_t1 = w_time
      self.casm_t2 = w_time
      tt = (w_time / 0.357).to_i
      self.casm_rr = w_time - tt * 0.357
      self.casm_rr = 0.3 if (w_time == 0)
      self.casm_x1 = w_lng
      self.casm_y1 = w_lat
      self.casm_x2 = w_lng
      self.casm_y2 = w_lat
      self.casm_f = 3
    end



    def wgtochina_lb(wg_flag,wg_lat,wg_lng,wg_heit,wg_week,wg_time)

      point = {lat:0.0,lng:0.0}

      return nil if (wg_heit > 5000) 
      x_l = wg_lng;
      x_l = x_l / 3686400.0;
      y_l = wg_lat;
      y_l = y_l / 3686400.0;

      return nil if (x_l < 72.004)
      return nil if (x_l > 137.8347)
      return nil if (y_l < 0.8293)
      return nil if (y_l > 55.8271)

      if (wg_flag == 0) 
        ini_casm(wg_time, wg_lng, wg_lat)
        point[:lat] = wg_lng
        point[:lng] = wg_lat
        return point;
      end

      casm_t2 = wg_time
      casm_t1,casm_f = 0,0
      t1_t2 = (casm_t2 - casm_t1) / 1000.0
      if (t1_t2 <= 0) 
        casm_t1 = casm_t2
        casm_f = casm_f + 1
        casm_x1 = casm_x2
        casm_f = casm_f + 1
        casm_y1 = casm_y2
        casm_f = casm_f + 1
      else 
        if t1_t2 > 120
            if casm_f == 3
                casm_f = 0
                casm_x2 = wg_lng
                casm_y2 = wg_lat
                x1_x2 = casm_x2 - casm_x1
                y1_y2 = casm_y2 - casm_y1
                casm_v = Math.sqrt(x1_x2 * x1_x2 + y1_y2 * y1_y2) / t1_t2
                return point if (casm_v > 3185) 
            end
            casm_t1 = casm_t2
            casm_f = casm_f + 1
            casm_x1 = casm_x2
            casm_f = casm_f + 1
            casm_y1 = casm_y2
            casm_f = casm_f + 1
        end
      end
      x_add = transform_yj5(x_l - 105, y_l - 35)
      y_add = transform_yjy5(x_l - 105, y_l - 35)
      h_add = wg_heit


      x_add = x_add + h_add * 0.001 + yj_sin2(wg_time * 0.0174532925199433) + random_yj()
      y_add = y_add + h_add * 0.001 + yj_sin2(wg_time * 0.0174532925199433) + random_yj()
      point[:lng] =  ((x_l + transform_jy5(y_l, x_add)) * 3686400).to_i
      point[:lat] = ((y_l + transform_jyj5(y_l, y_add)) * 3686400).to_i
      return point
    end
  end
end
