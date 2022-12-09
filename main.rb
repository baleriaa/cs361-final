require 'json'

class FeatureCollection
  attr_accessor :type, :features
  
  def initialize
    @type = "FeatureCollection"
    @features = []
  end

  def add_feature(feature)
    @features.append(feature)
  end

  def to_s
    %Q[{"type":#{JSON.generate(@type)}, "features": #{JSON.generate(@features)}]
  end

end

class Feature
  attr_accessor :type, :properties, :geometry

  def initialize()
    @type = "Feature"
    @properties = {} 
    @geometry = {}
  end

  def add_property(key, value)
    @properties[key] = value
  end

  def add_geometry(key, value)
    @geometry[key] = value
  end

  def to_s
    %Q[{"type": #{JSON.generate(@type)},"properties": #{JSON.generate(@properties)},#{JSON.generate(@geometry)}]
  end
end

class Point
  attr_accessor :coordinates, :latitude, :longitude, :elevation

  def initialize(latitude, longitude, elevation=nil)
    @type = "Point"
    if elevation == nil
      @coordinates = [latitude, longitude]
    else
      @coordinates = [latitude, longitude, elevation]
    end
  end

  def to_s
    %Q[{"type":#{JSON.generate(@type)}, "coordinates":#{JSON.generate(@coordinates)}}]
  end

end

class MultiLineString 
  attr_accessor :type, :coordinates

  def initialize()
    @type = "MultiLineString"
    @coordinates = []
  end
  
  def add_coordinates(coordinate)
    @coordinates.append(coordinate)
  end

  def to_s
    %Q[{"type": #{JSON.generate(@type)},"coordinates": #{JSON.generate(@coordinates)}}]
  end

end

featurecollection = FeatureCollection.new
feature1 = Feature.new
feature2 = Feature.new
feature3 = Feature.new
feature4 = Feature.new
point1 = Point.new(-121.5, 45.5, 30)
multilinestring1 = MultiLineString.new
multilinestring1.add_coordinates([[ -122, 45 ], [ -122, 46 ], [ -121, 46 ]])
multilinestring1.add_coordinates([[ -121, 45 ], [ -121, 46 ]])
multilinestring2 = MultiLineString.new
multilinestring2.add_coordinates([[ -121, 45.5 ], [ -122, 45.5 ]])
feature1.add_property("title", "home")
feature1.add_property("icon", "flag")
feature1.add_geometry("geometry", point1)
feature2.add_property("title", "store")
feature2.add_property("icon", "dot")
feature2.add_geometry("geometry", Point.new(-121.5, 45.6))
feature3.add_property("title", "track 1")
feature3.add_geometry("geometry", multilinestring1)
feature4.add_property("title", "track 2")
feature4.add_geometry("geometry", multilinestring2)
featurecollection.add_feature(feature1)
featurecollection.add_feature(feature2)
featurecollection.add_feature(feature3)
featurecollection.add_feature(feature4)