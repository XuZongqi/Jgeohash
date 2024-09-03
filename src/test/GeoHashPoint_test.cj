package jgeohash.test

import jgeohash.main_files.cangjie.xuzongqi_jgeohash.GeoHashExtensions
import jgeohash.main_files.cangjie.xuzongqi_jgeohash.Point
import jgeohash.main_files.cangjie.xuzongqi_jgeohash.GeoHashPoint
import std.unittest.*
import std.unittest.testmacro.*
import encoding.json.*
import serialization.serialization.*

@Test
public class GeoHashPointTest
{

	@TestCase
	func testCompareTo()
	{
		var expected:Bool
		var actual:Int64
		var geohash:String
		var o1:GeoHashPoint
		var o2:GeoHashPoint

		geohash = GeoHashExtensions.encode(53.5526394, 10.0067103)

		o1 = GeoHashPoint(geohash)
		o2 = GeoHashPoint(geohash)
		actual = o1.compareTo(o2)
		expected = actual == 0
		@Assert(expected,true)
	}
}