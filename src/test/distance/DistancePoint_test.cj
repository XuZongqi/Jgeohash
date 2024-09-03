package jgeohash.test.distance

// import jgeohash.*
import jgeohash.main_files.cangjie.xuzongqi_jgeohash.distance.DistanceCalculator
import jgeohash.main_files.cangjie.xuzongqi_jgeohash.distance.DistancePoint
import jgeohash.main_files.cangjie.xuzongqi_jgeohash.GeoHashPoint
import jgeohash.main_files.cangjie.xuzongqi_jgeohash.Point
import jgeohash.main_files.cangjie.xuzongqi_jgeohash.GeoHashExtensions
import jgeohash.main_files.cangjie.xuzongqi_jgeohash.Adjacent
import jgeohash.main_files.cangjie.xuzongqi_jgeohash.api.Position

// import std.unittest.mock.*
import std.unittest.*
import std.unittest.testmacro.*
import std.collection.*
import encoding.json.*
import serialization.serialization.*


@Test
public class DistancePointTest
{

	@TestCase
	func testCompareTo()
	{
		var expected:Bool
		var actual:Int
		var distance:Float64

        var point1 =Point(20.0,0.1)
		distance = 1000.0
		let distancePoint:DistancePoint = DistancePoint(distance,point1)
		var point2 = Point(3.5,0.2)
		distance = 20.0
		let anotherPoint:DistancePoint= DistancePoint(distance,point2)

		actual = distancePoint.compareTo(anotherPoint)
		expected = 0 < actual
		@Assert(expected,true)
	}

	@TestCase
	func testConstructors()
	{
		var model:DistancePoint = DistancePoint(Point(0.0,0.0), 1.0)

        let judge:Bool=model is DistancePoint
        @Assert(judge,true)
	}

	@TestCase
	func testEqualsObject()
	{
		var point:Position
		var distance:Float64

		var expected:DistancePoint = DistancePoint(Point(20.0,0.1),1000.0)
		var actual:DistancePoint = DistancePoint(Point(3.5,0.2), 20.0)

		var judge:Int64=expected.compareTo(actual)
		@Assert(judge, 1)

		point = Point(20.0,0.1)
		distance = 1000.0
		let distancePoint:DistancePoint = DistancePoint(point, distance)
		var judge2:Int64=expected.compareTo(distancePoint)
		@Assert(judge2, 0)
	}
}