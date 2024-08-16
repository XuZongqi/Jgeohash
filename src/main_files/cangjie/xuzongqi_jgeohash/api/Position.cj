package jgeohash.main_files.cangjie.xuzongqi_jgeohash.api
import serialization.serialization.*
public abstract class Position { 
	private var latitude:Float64
	private var longitude:Float64

	public init(latitude:Float64,longitude:Float64) {
        this.latitude = latitude
        this.longitude = longitude
    }

	public func getLatitude():Float64
	{
		return latitude
	}


	public func getLongitude():Float64
	{
		return longitude
	}

    // 无参时返回类型是Unit
	public func setLatitude(latitude:Float64):Unit
	{
		this.latitude=latitude
	}

	public func setLongitude(longitude:Float64):Unit
	{
		this.longitude=longitude
	}

}