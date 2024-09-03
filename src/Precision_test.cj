package jgeohash

// import jgeohash.*
import jgeohash.main_files.cangjie.xuzongqi_jgeohash.distance.DistanceCalculator
import jgeohash.main_files.cangjie.xuzongqi_jgeohash.GeoHashPoint
import jgeohash.main_files.cangjie.xuzongqi_jgeohash.Point
import jgeohash.main_files.cangjie.xuzongqi_jgeohash.GeoHashExtensions
import jgeohash.main_files.cangjie.xuzongqi_jgeohash.Adjacent
import jgeohash.main_files.cangjie.xuzongqi_jgeohash.api.Position

import std.unittest.*
import std.unittest.testmacro.*
import std.collection.*
import std.math.*
import std.format.*
import encoding.json.*
import serialization.serialization.*

@Test
public class Precision
{
    @TestCase
    func precision1()
    {
        var a:Float64=1.2345678901234567890123456789
        var b:Float64=9.8765432109876543210987654321
        var c:Float64=a*b
        println(c)//12.193263
        println("\"${c.format("30.30")}\"")//"12.193263113702178 301878120691981" 
    }
    @TestCase
    func precision2()
    {
        var a:Float64=1.2345678901234567890123456789
        var b:Float64=9.8765432109876543210987654321
        var c:Float64=a/b
        println(c)//0.125000
        println("c = \"${c.format("30.30")}\"")//c = "0.1249999988609374 89020273005735" 
    }
    @TestCase
    func precision3()
    {
        var a:Float64=1.2345678901234567890123456789
        var c:Float64=pow(a,2)
        println(c)//1.524158
        println("c = \"${c.format("30.30")}\"")//c = "1.524157875323883359897081390955"
    }

}