package jgeohash.test

import jgeohash.main_files.cangjie.xuzongqi_jgeohash.distance.DistanceCalculator
import jgeohash.main_files.cangjie.xuzongqi_jgeohash.GeoHashExtensions
import jgeohash.main_files.cangjie.xuzongqi_jgeohash.Adjacent
import jgeohash.main_files.cangjie.xuzongqi_jgeohash.FirstRingRegion
import jgeohash.main_files.cangjie.xuzongqi_jgeohash.FirstAndSecondRingRegion

import std.collection.*
import std.unittest.*
import std.unittest.testmacro.*
import encoding.json.*
import serialization.serialization.*

@Test
public class GeoHashExtensionsTest
{

	@TestCase
	func testDecode()
	{
		var actual:Array<Float64>
		var geohash:String
        var expected = ArrayList<Float64>()//ArrayList初始化时可以固定长度，Array不行

		geohash = GeoHashExtensions.encode(53.5526394, 10.0067103)
		expected.append(53.55263943783939)
		expected.append(10.006710458546877)
		actual = GeoHashExtensions.decode(geohash)
		@Assert(expected[0], actual[0])
		@Assert(expected[1], actual[1])

		geohash = GeoHashExtensions.encode(30.0, -90.0)
		expected[0] = 29.999999972060323
		expected[1] = -90.00000016763806
		actual = GeoHashExtensions.decode(geohash)
		@Assert(expected[0], actual[0])
		@Assert(expected[1], actual[1])

		geohash = GeoHashExtensions.encode(51.4797, -0.0124)
		expected[0] = 51.47970006801188
		expected[1] = -0.01240001991391182
		actual = GeoHashExtensions.decode(geohash)
		@Assert(expected[0], actual[0])
		@Assert(expected[1], actual[1])
	}


	@TestCase
	func testDecodeAndRound()
	{
		var actual:Array<Float64>
		var geohash:String
        var expected = ArrayList<Float64>()

		geohash = GeoHashExtensions.encode(53.5526394, 10.0067103)
		expected.append(53.552639)
		expected.append(10.006710)
		actual = GeoHashExtensions.decodeAndRound(geohash)
        
		var judge1:Bool=DistanceCalculator.precision_convert(expected[0], actual[0],"PRECISION")
		var judge2:Bool=DistanceCalculator.precision_convert(expected[1], actual[1],"PRECISION")

		@Assert(true, judge1)
		@Assert(true, judge2)

		geohash = GeoHashExtensions.encode(30.0, -90.0)
		expected[0] = 29.999999
		expected[1] = -90.0
		actual = GeoHashExtensions.decodeAndRound(geohash)

		judge1=DistanceCalculator.precision_convert(expected[0], actual[0],"PRECISION")
		judge2=DistanceCalculator.precision_convert(expected[1], actual[1],"PRECISION")

		@Assert(true, judge1)
		@Assert(true, judge2)

		geohash = GeoHashExtensions.encode(51.4797, -0.0124)
		expected[0] = 51.4797
		expected[1] = -0.0124
		actual = GeoHashExtensions.decodeAndRound(geohash)
        
		judge1=DistanceCalculator.precision_convert(expected[0], actual[0],"PRECISION")
		judge2=DistanceCalculator.precision_convert(expected[1], actual[1],"PRECISION")

		@Assert(true, judge1)
		@Assert(true, judge2)
	}

	@TestCase
	func testDecodeWithEmptyValue()
	{
		@ExpectThrows[IllegalArgumentException](GeoHashExtensions.decode(""))
	}
    
	@TestCase
	func testEncode()
	{
		var expected:String
		var actual:String

		actual = GeoHashExtensions.encode(53.5526394, 10.0067103)
		expected = "u1x0esywtr81"
		@Assert(expected, actual)

		actual = GeoHashExtensions.encode(30.0, -90.0)
		expected = "9vrfxvrfxvrf"
		@Assert(expected, actual)

		actual = GeoHashExtensions.encode(51.4797, -0.0124)
		expected = "gcpuzewfzp9u"
		@Assert(expected, actual)
	}

	@TestCase
	func testGetAdjacentStringString()
	{
		var expected:String
		var actual:String
		var alterTeichwegGeohash:String
		var geohash:String
		var right:String
		var left:String

		alterTeichwegGeohash = "u1x0v54rmjwej"
		geohash = alterTeichwegGeohash

		expected = "h"
		actual = GeoHashExtensions.getAdjacent("u", Adjacent.TOP)
		@Assert(expected, actual)

		expected = "v"
		actual = GeoHashExtensions.getAdjacent("u", Adjacent.RIGHT)
		@Assert(expected, actual)

		expected = "s"
		actual = GeoHashExtensions.getAdjacent("u", Adjacent.BOTTOM)
		@Assert(expected, actual)

		expected = "g"
		actual = GeoHashExtensions.getAdjacent("u", Adjacent.LEFT)
		@Assert(expected, actual)

		expected = "dr"
		actual = GeoHashExtensions.getAdjacent("dq", Adjacent.TOP)
		@Assert(expected, actual)

		expected = "dw"
		actual = GeoHashExtensions.getAdjacent("dq", Adjacent.RIGHT)
		@Assert(expected, actual)

		expected = "u1x0v54rmjwem"
		actual = GeoHashExtensions.getAdjacent(geohash, "top")
		@Assert(expected, actual)

		expected = "u1x0v54rmjwdv"
		actual = GeoHashExtensions.getAdjacent(geohash, "bottom")
		@Assert(expected, actual)

		expected = "u1x0v54rmjwen"
		actual = GeoHashExtensions.getAdjacent(geohash, "right")
		right = actual
		@Assert(expected, actual)

		expected = "u1x0v54rmjweh"
		actual = GeoHashExtensions.getAdjacent(geohash, "left")
		left = actual
		@Assert(expected, actual)

		expected = "u1x0v54rmjwek"
		actual = GeoHashExtensions.getAdjacent(left, "top")
		@Assert(expected, actual)

		expected = "u1x0v54rmjweq"
		actual = GeoHashExtensions.getAdjacent(right, "top")
		@Assert(expected, actual)

		expected = "u1x0v54rmjwdy"
		actual = GeoHashExtensions.getAdjacent(right, "bottom")
		@Assert(expected, actual)

		expected = "u1x0v54rmjwdu"
		actual = GeoHashExtensions.getAdjacent(left, "bottom")
		@Assert(expected, actual)
	}

	@TestCase
	func testGetAdjacentStringStringArray()
	{
		var expected:String
		var actual:String
		var geohash:String
		var subGeohash:String

		geohash = GeoHashExtensions.encode(53.5526394, 10.0067103)


		var geohash_arr:Array<Rune>=geohash.toRuneArray()
      
		var subGeohash_arr:Array<Rune>=geohash_arr[0..7]

		subGeohash=String(subGeohash_arr)


		expected = "u1x0etp"
		actual = GeoHashExtensions.getAdjacent(subGeohash, Adjacent.TOP, Adjacent.RIGHT)
		@Assert(expected, actual)

		expected = "u1x0etj"
		actual = GeoHashExtensions.getAdjacent(subGeohash, Adjacent.TOP, Adjacent.LEFT)
		@Assert(expected, actual)
		expected = "u1x0etq"
		actual = GeoHashExtensions.getAdjacent(subGeohash, Adjacent.TOP, Adjacent.TOP)
		@Assert(expected, actual)

		expected = "j"
		actual = GeoHashExtensions.getAdjacent("u", Adjacent.TOP, Adjacent.RIGHT)
		@Assert(expected, actual)

		expected = "t"
		actual = GeoHashExtensions.getAdjacent("u", Adjacent.BOTTOM, Adjacent.RIGHT)
		@Assert(expected, actual)

		expected = "e"
		actual = GeoHashExtensions.getAdjacent("u", Adjacent.BOTTOM, Adjacent.LEFT)
		@Assert(expected, actual)

		expected = "5"
		actual = GeoHashExtensions.getAdjacent("u", Adjacent.LEFT, Adjacent.TOP)
		@Assert(expected, actual)
	}

	@TestCase
	func testGetAdjacentStringStringDirectionEmptyValue()
	{
		@ExpectThrows[IllegalArgumentException](GeoHashExtensions.getAdjacent("u", ""))//抛出空值异常
	}

	@TestCase
	func testGetAdjacentStringStringGeohashEmptyValue()
	{
		@ExpectThrows[IllegalArgumentException](GeoHashExtensions.getAdjacent("", Adjacent.TOP))
	}

	@TestCase
	func testGetAllAdjacentAreasList()
	{
		var expected:ArrayList<String>
		var actual:ArrayList<String>
		var geohash:String
		var subGeohash:String

		geohash = GeoHashExtensions.encode(53.5526394, 10.0067103)

		var geohash_arr:Array<Rune>=geohash.toRuneArray()
    
		var subGeohash_arr:Array<Rune>=geohash_arr[0..7]
		subGeohash = String(subGeohash_arr)

		actual = GeoHashExtensions.getAllAdjacentAreasList(subGeohash)
		expected = ArrayList("u1x0esy", "u1x0etn", "u1x0etp", "u1x0esz", "u1x0esx",
			"u1x0esw", "u1x0est", "u1x0esv", "u1x0etj")

		var i:Int=0
		while(i<actual.size)
		{
			@Assert(expected.get(i), actual.get(i))
			i++
		}

	}

	@TestCase
	func testGetAllAdjacentAreasListWithEmptyValue()
	{
		@ExpectThrows[IllegalArgumentException](GeoHashExtensions.getAllAdjacentAreasList(""))
	}

	@TestCase
	func testGetAllAdjacentAreasMap()
	{
		var expected:HashMap<String, String>
		var actual:HashMap<String, String>
		var geohash:String
		var subGeohash:String

		geohash = GeoHashExtensions.encode(53.5526394, 10.0067103)

		var geohash_arr:Array<Rune>=geohash.toRuneArray()
		var subGeohash_arr:Array<Rune>=geohash_arr[0..7]
		subGeohash = String(subGeohash_arr)

		actual = GeoHashExtensions.getAllAdjacentAreasMap(subGeohash)

		expected = HashMap(9)
		expected.put("center", "u1x0esy")
		expected.put("top", "u1x0etn")
		expected.put("bottom", "u1x0esw")
		expected.put("right", "u1x0esz")
		expected.put("left", "u1x0esv")
		expected.put("topleft", "u1x0etj")
		expected.put("topright", "u1x0etp")
		expected.put("bottomright", "u1x0esx")
		expected.put("bottomleft", "u1x0est")

		//遍历哈希表比较
		for ((k, v) in expected) {
			var value2 = actual.get(k)
			@Assert(value2,v)
    	} 
    } 

	
	@TestCase
	func testGetAllAdjacentAreasMapWithEmptyValue()
	{
		@ExpectThrows[IllegalArgumentException](GeoHashExtensions.getAllAdjacentAreasMap(""))
	}

	@TestCase
	func testGetFirstAndSecondRingRegion()
	{
		var actual:FirstAndSecondRingRegion
		var expected:FirstAndSecondRingRegion
		var geohash:String

		geohash = GeoHashExtensions.encode(53.5526394, 10.0067103)
		actual = GeoHashExtensions.getFirstAndSecondRingRegion(geohash)
	
		expected = FirstAndSecondRingRegion(geohash)
		var judge:Bool= actual.isEqual(expected) 
		@Assert(judge, true)
	}

	@TestCase
	func testGetFirstRingRegion()
	{
		var actual:FirstRingRegion 
		var expected:FirstRingRegion 
		var geohash:String

		geohash = GeoHashExtensions.encode(53.5526394, 10.0067103)
		actual = GeoHashExtensions.getFirstRingRegion(geohash)
		expected = FirstRingRegion(geohash)
		var judge:Bool= actual.isEqual(expected)
		@Assert(judge, true)
	}

	@TestCase
	func testGetLatitude()
	{
		var actual:Float64
		var expected:Float64
		var geohash:String

		geohash = GeoHashExtensions.encode(53.5526394, 10.0067103)

		actual = GeoHashExtensions.getLatitude(geohash)
		expected = 53.552639
		@Assert(expected, actual)
	}

	@TestCase
	func testGetLongitude()
	{
		var actual:Float64
		var expected:Float64
		var geohash:String

		geohash = GeoHashExtensions.encode(53.5526394, 10.0067103)

		actual = GeoHashExtensions.getLongitude(geohash)
		expected = 10.006710
		@Assert(expected, actual)
	}
}