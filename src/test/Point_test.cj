package jgeohash.test

import jgeohash.main_files.cangjie.xuzongqi_jgeohash.GeoHashExtensions
import jgeohash.main_files.cangjie.xuzongqi_jgeohash.Point
import jgeohash.main_files.cangjie.xuzongqi_jgeohash.GeoHashPoint
import std.unittest.*
import std.unittest.testmacro.*
import encoding.json.*
import serialization.serialization.*

@Test
public class PointTest
{

	@TestCase
	func testCompareTo()
	{
		var expected:Bool
		
		var actual:Int64
		var geohash:String
		var o1:Point
		var o2:Point

		geohash = GeoHashExtensions.encode(53.5526394, 10.0067103)

		o1 = GeoHashPoint(geohash)
		o2 = GeoHashPoint(geohash)
		actual = o1.compareTo(o2)
		expected = actual == 0
		@Assert(expected,true)
		actual = o1.compareTo(o1)
		expected = actual == 0
		@Assert(expected,true)

		geohash = GeoHashExtensions.encode(30.0, -90.0)
		o2 = GeoHashPoint(geohash)
		actual = o1.compareTo(o2)
		expected = 0 < actual
		@Assert(expected,true)

		actual = o2.compareTo(o1)
		expected = actual < 0
		@Assert(expected,true)
	}

	@TestCase
	func testConstructorsWithUnappropriatedLatitudeNumber()
	{
		@ExpectThrows[IllegalArgumentException](Point(153.5526394, 10.0067103))
        //弹出 Assert Failed: `(The given coordinates 153.552639 are out of range.)`即成功
	}

	@TestCase
	func testConstructorsWithUnappropriatedLongitudeNumber()
	{
        //弹出 Assert Failed: `(The given coordinates 190.006710  are out of range.)`即成功
		@ExpectThrows[IllegalArgumentException](Point(53.5526394, 190.0067103))
	}

	@TestCase
	func testSetLatitude()
	{
		var actual:Float64
		var expected:Float64
		var o1:Point
		o1 = GeoHashPoint(GeoHashExtensions.encode(53.5526394, 10.0067103))
		o1.setLatitude(52.0)
        println("o1.lat = ${o1.getLatitude()}")
		actual = o1.getLatitude()
		expected = 52.0
		@Assert(expected, actual)
	}

	@TestCase
	func testSetLatitudeUnappropriateLatitudeNumber()
	{
		var o1:Point = GeoHashPoint(GeoHashExtensions.encode(53.5526394, 10.0067103))
		@ExpectThrows[IllegalArgumentException](o1.setLatitude(100.0))
	}

	@TestCase
	func testSetLongitude()
	{
		var actual:Float64
		var expected:Float64
		var geohash:String
		var o1:Point
		geohash = GeoHashExtensions.encode(53.5526394, 10.0067103)

		o1 = GeoHashPoint(geohash)
		o1.setLongitude(9.8)
		actual = o1.getLongitude()
		expected = 9.8
		@Assert(expected, actual)
	}

	@TestCase
	func testSetLongitudeWithUnappropriatedNumber()
	{
		var geohash:String
		var o1:Point
		geohash = GeoHashExtensions.encode(53.5526394, 10.0067103)
		o1 = GeoHashPoint(geohash)
        //出现Assert Failed: `(The given coordinates 190.000000  are out of range.)`报错说明检验成功
		@ExpectThrows[IllegalArgumentException](o1.setLongitude(190.0))
	}

}
