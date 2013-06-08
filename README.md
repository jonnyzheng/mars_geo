# MarsGeo

这是一个将真实经纬度转换成火星地址的Gem. 我们在做手机App开发时经常会用到地图，通常手机获得的经纬度放到
Google地图的时候会有几百米的偏差，这是因为某些原因国内地图都做了偏移加密，这个俗称火星坐标系。MarsGeo是
根据网上的一段Java代码翻译过来的，目的是把真实经纬度转换成火星坐标系好和Google地图匹配，至于准确性如何
我没有全面测试过，不过我自己使用的情况还是可以滴。


## Installation

Add this line to your application's Gemfile:

    gem 'mars_geo'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mars_geo

## Usage

在要使用的文件中 include MarsGeo Moudle

```
class HomeController < ApplicationController
    include MarsGeo

    def index
        point = Point.new(31.108949, 121.333383)
        offset_point = point.offset
        p offset_point.lat 
        p offset_point.lng 
    end

end

```




## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
