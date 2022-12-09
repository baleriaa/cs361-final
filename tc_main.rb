require_relative 'main.rb'
require 'test/unit'
require 'json'

class TestMain < Test::Unit::TestCase

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
    expected = '{"type": "Feature","properties": {"title": "store","icon": "flag"},"geometry":{"type":"Point","coordinates":[-121.5,45.6]}}'
    result = JSON.parse(feature.to_json)
    assert_equal(expected, result)
  end

  # def test_feature_collection
  #   expected = JSON.parse('{"type": "FeatureCollection","features": [{"type": "Feature","properties": {"title": "home","icon": "flag"},"geometry": {"type": "Point","coordinates": [-121.5,45.5,30]}},{"type": "Feature","properties": {"title": "store","icon": "dot"},"geometry": {"type": "Point","coordinates": [-121.5,45.6]}},{"type": "Feature", "properties": {"title": "track 1"},"geometry": {"type": "MultiLineString","coordinates": [[[-122,45],[-122,46],[-121,46]],[[-121,45],[-121,46]]]}},{"type": "Feature", "properties": {"title": "track 2"},"geometry": {"type": "MultiLineString","coordinates": [[[-121,45.5],[-122,45.5]]]}}]}'.to_json)
  #   featurecollection = FeatureCollection.new
  #   feature1 = Feature.new
  #   feature2 = Feature.new
  #   feature3 = Feature.new
  #   feature4 = Feature.new
  #   point2 = Point.new(-121.5, 45.6)
  #   multilinestring1 = MultiLineString.new
  #   multilinestring1.add_coordinates([[ -122, 45 ], [ -122, 46 ], [ -121, 46 ]])
  #   multilinestring1.add_coordinates([[ -121, 45 ], [ -121, 46 ]])
  #   multilinestring2 = MultiLineString.new
  #   multilinestring2.add_coordinates([[ -121, 45.5 ], [ -122, 45.5 ]])
  #   feature1.add_property("title", "home")
  #   feature1.add_property("icon", "flag")
  #   feature1.add_geometry("geometry", Point.new(-122, 45, 30))
  #   feature2.add_property("title", "store")
  #   feature2.add_property("icon", "dot")
  #   feature2.add_geometry("geometry", point2)
  #   feature3.add_property("title", "track 1")
  #   feature3.add_geometry("geometry", multilinestring1)
  #   feature4.add_property("title", "track 2")
  #   feature4.add_geometry("geometry", multilinestring2)
  #   featurecollection.add_feature(feature1)
  #   featurecollection.add_feature(feature2)
  #   featurecollection.add_feature(feature3)
  #   featurecollection.add_feature(feature4)
  #   result = JSON.parse(featurecollection.to_json)
  #   # expected = expected.to_s
  #   assert_equal(expected, result)
  # end

end