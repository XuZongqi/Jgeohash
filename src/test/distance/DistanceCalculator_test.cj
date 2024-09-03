package jgeohash.test.distance

// import jgeohash.*
import jgeohash.main_files.cangjie.xuzongqi_jgeohash.distance.DistanceCalculator
import jgeohash.main_files.cangjie.xuzongqi_jgeohash.GeoHashPoint
import jgeohash.main_files.cangjie.xuzongqi_jgeohash.Point
import jgeohash.main_files.cangjie.xuzongqi_jgeohash.GeoHashExtensions
import jgeohash.main_files.cangjie.xuzongqi_jgeohash.Adjacent
import jgeohash.main_files.cangjie.xuzongqi_jgeohash.api.Position

import std.unittest.*
import std.unittest.testmacro.*
import std.format.*
import std.collection.*
import encoding.json.*
import serialization.serialization.*


@Test
class TestDistanceCalculator {

	@TestCase
	func distance_test()
	{
		let actual:Float64
		let expected:Float64

		let alterTeichwegGeohash:String = "u1x0v54rmjwej"
		let coordinates:Array<Float64> = GeoHashExtensions.decodeAndRound(alterTeichwegGeohash)
		let alterTeichweg:Position = Point(coordinates[0], coordinates[1])
		let ludwigsburg:Position = GeoHashPoint(48.889380,9.190459)

		actual = DistanceCalculator.distanceBetweenPoints(ludwigsburg, alterTeichweg,
			"KILOMETER")
		//Float64 的精度约为小数点后 15 位，Float32 的精度约为小数点后 6 位，Float16 的精度约为小数点后 3 位。
		expected = 525.900819206552910146
		var actual_bool:Bool = DistanceCalculator.precision_convert(expected, actual, "KILOMETER")
		@Assert(true, actual_bool)
	}
    @TestCase
    func distanceBetweenPoints_test() {
        var actual:Float64
		var expected:Float64

		let alterTeichwegGeohash:String = "u1x0v54rmjwej"
        let a:Array<Rune>=alterTeichwegGeohash.toRuneArray()
        let subGeohash_pre:Rune=a[0]
		let subGeohash:String = subGeohash_pre.toString()
        //初始化的问题，把初始化写在函数里面
		var firstRingCells:HashMap<String, String> = GeoHashExtensions.getAllAdjacentAreasMap(subGeohash)
		var ludwigsburg:Position = GeoHashPoint(48.889380,9.190459)
		
        var ludwigsburg_geo:GeoHashPoint=GeoHashPoint(ludwigsburg)
        var ludwigsburgGeohash:String  = (ludwigsburg_geo).getGeohash()
		
		actual = DistanceCalculator.distanceBetweenPoints(ludwigsburgGeohash, alterTeichwegGeohash,
			"KILOMETER")
		expected=525.900819206552910146
		var actual_bool:Bool = DistanceCalculator.precision_convert(expected, actual, "KILOMETER")
		@Assert(true, actual_bool)

		actual = DistanceCalculator.distanceBetweenPoints(ludwigsburgGeohash, alterTeichwegGeohash,
			"MILE")
		expected = 846.3532256774345
		actual_bool = DistanceCalculator.precision_convert(expected, actual, "MILE")
		@Assert(true, actual_bool)

		actual = DistanceCalculator.distanceBetweenPoints(ludwigsburgGeohash, alterTeichwegGeohash,
			"METER")
		expected = 525900.819206552910146
		actual_bool = DistanceCalculator.precision_convert(expected, actual, "METER")
		@Assert(true, actual_bool)
    }

}