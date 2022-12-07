class FeatureCollection

end

class TrackSegment
  attr_reader :coordinates

  def initialize(coordinates)
    @coordinates = coordinates
  end
end

class Waypoint
  attr_reader :lat, :lon, :ele, :name, :type
  
  def initialize(lon, lat, ele=nil, name=nil, type=nil)
    @latitude = latitude
    @longitude = lon
    @ele = ele
    @name = name
    @type = type
  end

end

class Type

end

class Property

end

class Geometry
  def initialize(type, coordinates)
    @type = type
    @coordinates = coordinates
  end

end

class Point
  def initialize(latitude, longitude, ele=nil)
    super("Point", [longitude, latitude, ele])
  end

end

class MultiLineString < Geometry
  def initialize(coordinates)
    super("MultiLineString", coordinates)
  end

end