#!/usr/bin/env ruby
require 'json'

class Track
  def initialize(segments, name=nil)
    @name = name
    segment_objects = []
    segments.each do |segment|
      segment_objects.append(TrackSegment.new(segment))
    end
    # set segments to segment_objects
    @segments = segment_objects
  end

  def get_track_json()
    text = '{ "type": "Feature", '
    if @name != nil
      text+= '"properties": {"title": "' + @name + '"},'
    end
    text += '"geometry": {"type": "MultiLineString","coordinates": ['
    @segments.each_with_index do |segment, index|
      if index > 0
        text += ","
      end
      text += '['
      # Loop through all the coordinates in the segment
      tsj = ''
      segment.coordinates.each do |c|
        if tsj != ''
          tsj += ','
        end
        # Add the coordinate
        tsj += "[#{c.lon},#{c.lat}"
        if c.ele != nil
          tsj += ",#{c.ele}"
        end
        tsj += ']'
      end
      text+=tsj
      text+=']'
    end
    text + ']}}'
  end
end

class TrackSegment
  attr_reader :coordinates
  def initialize(coordinates)
    @coordinates = coordinates
  end

  def to_s
    
  end
end

class Point
  attr_reader :lat, :lon, :ele

  def initialize(lon, lat, ele=nil)
    @lon = lon
    @lat = lat
    @ele = ele
  end
end

class Waypoint < Point
attr_reader :lat, :lon, :ele, :name, :type

  def initialize(lon, lat, ele=nil, name=nil, type=nil)
    @lat = lat
    @lon = lon
    @ele = ele
    @name = name
    @type = type
  end

  def get_waypoint_json(indent=0)
    text = '{"type": "Feature",'
    # if name is not nil or type is not nil
    text += '"geometry": {"type": "Point","coordinates": '
    text += "[#{@lon},#{@lat}"
    if ele != nil
      text += ",#{@ele}"
    end
    text += ']},'
    if name != nil or type != nil
      text += '"properties": {'
      if name != nil
        text += '"title": "' + @name + '"'
      end
      if type != nil  # if type is not nil
        if name != nil
          text += ','
        end
        text += '"icon": "' + @type + '"'  # type is the icon
      end
      text += '}'
    end
    text += "}"
    return text
  end
end

class World
def initialize(name, things)
  @name = name
  @features = things
end

def add_feature(f)
  @features.append(t)
end

def to_geojson(indent=0)
    # Write stuff
    s = '{"type": "FeatureCollection","features": ['
    @features.each_with_index do |f,i|
      if i != 0
        s +=","
      end
        if f.class == Track
            s += f.get_track_json
        elsif f.class == Waypoint
            s += f.get_waypoint_json
      end
    end
    s + "]}"
  end
end

def main()
  w = Waypoint.new(-121.5, 45.5, 30, "home", "flag")
  w2 = Waypoint.new(-121.5, 45.6, nil, "store", "dot")
  ts1 = [Point.new(-122, 45), Point.new(-122, 46), Point.new(-121, 46), ]
  ts2 = [ Point.new(-121, 45), Point.new(-121, 46), ]
  ts3 = [Point.new(-121, 45.5), Point.new(-122, 45.5),]
  t = Track.new([ts1, ts2], "track 1")
  t2 = Track.new([ts3], "track 2")
  world = World.new("My Data", [w, w2, t, t2])
  puts world.to_geojson()
end
if File.identical?(__FILE__, $0)
  main()
end
