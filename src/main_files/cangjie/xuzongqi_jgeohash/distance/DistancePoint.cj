package jgeohash.main_files.cangjie.xuzongqi_jgeohash.distance
import std.math.*
//必须得先插入具体的类且public才能调用
import jgeohash.main_files.cangjie.xuzongqi_jgeohash.api.Position
import jgeohash.main_files.cangjie.xuzongqi_jgeohash.GeoHashPoint

public class DistancePoint
{

	
	private let distance:Float64
	private let point:Position

	public init(distance:Float64, point:Position)
	{
		this.distance = distance
		this.point = point
	}

	public init(point:Position, distance:Float64)
	{
		this.point = point;
		this.distance = distance;
	}


	public func compareTo(o:DistancePoint):Int
	{
        if(this.distance>o.distance)
        {
            return 1
        }
        else if(this.distance==o.distance)
        {
            return 0
        }
        else
        {
            return -1
        }
	}

}