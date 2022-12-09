require_relative 'main.rb'
require 'test/unit'
require 'json'

class TestMain < Test::Unit::TestCase
      multilinestring1 = MultiLineString.new

  def test_multiline_string
    multilinestring1 = MultiLineString.new
    multilinestring1.add_coordinates([[ 45, -122 ], [ 46, -122 ], [ 46, -121 ]])
    multilinestring1.add_coordinates([[ 45, -121 ], [ 46, -121 ]])
    expected = JSON.parse('{"type": "MultiLineString","coordinates": [[[45,-122],[46,-122],[46,-121]],[[45,-121],[46,-121]]]}'.to_json)
    result = JSON.parse(multilinestring1.to_json)
    assert_equal(expected, result)
  end

  def test_point
    point1 = Point.new(-122, 45, 30)
    expected = JSON.parse('{"type":"Point", "coordinates":[-122, 45, 30]}')
    result = JSON.parse(point1.to_s)
    assert_equal(expected, result)
  end

  def test_feature
    feature = Feature.new
    feature.add_property("title", "store")
    feature.add_property("icon", "flag")
    feature.add_geometry("geometry", Point.new(-121.5, 45.6))
    expected = JSON.parse('{"type": "Feature","properties": {"title": "store","icon": "flag"},"geometry":{"type":"Point","coordinates":[-121.5,45.6]}}'.to_json)
    result = JSON.parse(feature.to_json)
    assert_equal(expected, result)
  end

  # def test_feature_collection
  #   expected = "{"type":"FeatureCollection","features":[{"type": "Feature","properties":
  #   {"title": "home","icon": "flag"},"geometry":{"type":"Point","coordinates
  #   ":[-121.5,45.5,30]}},{"type": "Feature","properties": {"title": "store",
  #   "icon": "dot"},"geometry":{"type":"Point","coordinates":[-121.5,45.6]}},
  #   {"type": "Feature","properties": {"title": "track 1"},"geometry": {"type
  #   ": "MultiLineString","coordinates": [[[45,-122],[46,-122],[46,-121]],[[4
  #   5,-121],[46,-121]]]}},{"type": "Feature","properties": {"title": "track 
  #   2"},"geometry": {"type": "MultiLineString","coordinates": [[[45.5,-121],
  #   [45.5,-122]]]}}]}"
  # end

end