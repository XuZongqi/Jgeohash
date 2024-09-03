package jgeohash.main_files.cangjie.xuzongqi_jgeohash
import jgeohash.main_files.cangjie.xuzongqi_jgeohash.api.Position
import std.math
import std.unittest
public open class Point <: Position
{
    // private static let serialVersionUID = -4799959551221362673L
    private var latitude:Float64
    private var longitude:Float64

    public init(latitude:Float64, longitude:Float64) { 
        //关键字显式调用父类 
        super(latitude,longitude)
        if (!(math.abs(latitude) > 90.0) && !(math.abs(longitude) > 180.0)) {  
            this.latitude = latitude
            this.longitude = longitude
        } else {
            if(math.abs(latitude) > 90.0)
            {
                throw IllegalArgumentException("The given coordinates ${latitude} are out of range.")
            }  
            if(math.abs(longitude) > 180.0)
            {
                throw IllegalArgumentException("The given coordinates ${longitude}  are out of range.")
            }
            //错误后的初始化
            this.latitude=0.0
            this.longitude=0.0 
        }  
    }

    public func compareTo(other:Point):Int {
        if (this.latitude==other.latitude&&this.longitude==other.longitude) {
            return 0
        } else if (this.latitude < other.latitude) {
            return -1
        } else if (this.latitude > other.latitude) {
            return 1
        } else if (this.longitude < other.longitude) {
            return -1
        } else if (this.longitude > other.longitude) {
            return 1
        } else {
            throw IllegalArgumentException("compareTo inconsistent with equals.")
            return 0;
        }
    }
    //
    
    public override func setLatitude(latitude:Float64):Unit {
        println("latitude = ${latitude}")
        if(math.abs(latitude) > 90.0)
        {
            throw IllegalArgumentException("The given coordinates ${latitude} are out of range.")
        }  
        else {
            this.latitude = latitude
            println("this.latitude = ${this.latitude}")
        }
    }

    public override func setLongitude(longitude:Float64):Unit {
        if(math.abs(longitude) > 180.0)
        {
            throw IllegalArgumentException("The given coordinates ${longitude}  are out of range.")
        }else {
            this.longitude = longitude
        }
    }

    public override func getLatitude():Float64
    {
        return latitude
    }
    public override func getLongitude():Float64
    {
        return longitude
    }

    public func toString():String {
        return "Latitude :   ${this.latitude}    , Longitude  :   ${this.longitude}"
    }


}