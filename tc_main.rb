require_relative 'main.rb'
require 'test/unit'
require 'json'

class TestMain < Test::Unit::TestCase

  def test_multiline_string
    multilinestring1 = MultiLineString.new
    multilinestring1.add_coordinates([[ -122, 45 ], [ -122, 46 ], [ -121, 46 ]])
    multilinestring1.add_coordinates([[ -121, 45 ], [ -121, 46 ]])
    expected = '{"type":"MultiLineString", "coordinates": [[[-122, 45], [-122, 46], [-121, 46]], [[-121, 45], [-121, 46]]]}'
    result = multilinestring1.to_s
    assert_equal(expected, result)
  end

  def test_point
    point1 = Point.new(-122, 45, 30)
    expected = '{"type":"Point", "coordinates":[-122, 45, 30]}'
    result = point1.to_s
    assert_equal(expected, result)
  end

  def test_feature
    feature = Feature.new
    feature.add_property("title", "home")
    feature.add_property("icon", "flag")
    feature.add_geometry("geometry", Point.new(-122, 45, 30))
    expected = JSON.generate('{"type":"Feature", "properties":{"title":"home", "icon":"flag"}, "geometry":{"type":"Point", "coordinates":[-122, 45, 30]}}')
    result = JSON.generate(feature.to_s)
    assert_equal(expected, result)
  end

  # def test_feature_collection

  # end

end