package jgeohash.main_files.cangjie.xuzongqi_jgeohash.distance
import std.math.*
import std.format.*
//必须得先插入具体的类且public才能调用
import jgeohash.main_files.cangjie.xuzongqi_jgeohash.api.Position
import jgeohash.main_files.cangjie.xuzongqi_jgeohash.GeoHashPoint

//import lombok.experimental.UtilityClass;
//TODO：应该@UtilityClass
//应该是final class
// public let pi=3.1415926535897932384626433832795028841971
public let pi=3.1415926535897932
public class DistanceCalculator
{

	public static func precision_convert(x:Float64,y:Float64,measuringUnit:String):Bool
	{
		var precision:Int
		//单位转换
		match(measuringUnit)
		{
			case "MILE"=>precision=5
			case "METER"=>precision=3
			case "KILOMETER"=>precision=6
			case "PRECISION"=>precision=5
			//类似于default
			case _=>
			precision=0
			print("输入的长度类型有误")
		}
		if(abs(x-y)<=0.5*pow(10.0,-precision))
		{
			return true
		}
		else
		{
			return false
		}
	}
	public static func my_atan2(y:Float64, x:Float64):Float64
	{
		if (x > 0.0) 
		{
			return atan(y / x)
		}
		else if(x < 0.0)
		{
			if(y >= 0.0)
			{
				return atan(y / x) + pi
			} 
				  
			else
			{
				return atan(y / x) - pi
			}	  
		} 
		else if(y > 0.0)
		{
			return pi / 2.0
		}  
		else if(y < 0.0)  
		{
			return -pi / 2.0
		}
			  
		else
		{
			return 0.0
		} 
			  
	}

	//角度转弧度
    public static func degrees_to_radians(degrees:Float64):Float64
    {
        return degrees*pi/180.0
    }
	//给两个点的位置算球面距离，西经为负，南纬为负
    public static func distance(startLatitude:Float64,startLongitude:Float64,endLatitude:Float64,endLongitude:Float64,measuringUnit:String):Float64
     {
		//地球半径/公里
		let R_earth=6371.0

        //求弧度,值获取时分成固定和不固定两种
		//经度差
		let lon1=degrees_to_radians(startLongitude)
		let lon2=degrees_to_radians(endLongitude)
		let lon=abs(lon1-lon2)

		//纬度差
		let latitudePoint1=degrees_to_radians(startLatitude)
		let latitudePoint2=degrees_to_radians(endLatitude)
		let lat=abs(latitudePoint1-latitudePoint2)


		//Haversine公式大致为：a = sin²(Δlat/2) + cos(lat1) * cos(lat2) * sin²(Δlon/2)
		let distance=pow(sin(lat/2.0),2)+cos(latitudePoint1)*cos(latitudePoint2)*pow(sin(lon/2.0),2)
		//计算距离：c = 2 * atan2(√(a), √(1-a)) * R
		
		let distance_2=2.0*my_atan2(sqrt(distance),sqrt(1.0-distance))
		//劣弧
		let distance_3=min(distance_2,2.0*pi-distance)

		//目标值
		var targetDistance=distance_3*R_earth
		//单位转换
		match(measuringUnit)
		{
			case "MILE"=>targetDistance*= 1.60934
			case "METER"=>targetDistance*=1000.0
			case "KILOMETER"=>targetDistance*=1.0
			//类似于default
			case _=>print("输入的长度类型有误")
		}
        return targetDistance
     }

	//给两个点的位置算球面距离，西经为负，南纬为负
	 public static func distanceBetweenPoints(start:Position,end:Position,measuringUnit:String):Float64
	 {
		var targetDistance:Float64
		targetDistance=distance(start.getLatitude(),start.getLongitude(),end.getLatitude(),end.getLongitude(),measuringUnit)
		return targetDistance
	 }

	
	 public static func distanceBetweenPoints(startGeohashValue:String,endGeohashValue:String, measuringUnit:String):Float64
	{
		let geo_startGeohashValue:GeoHashPoint=GeoHashPoint(startGeohashValue)
		let geo_endGeohashValue:GeoHashPoint=GeoHashPoint(endGeohashValue)
		var target_distance:Float64=distanceBetweenPoints(geo_startGeohashValue, geo_endGeohashValue, measuringUnit)
		return target_distance	
	}

}