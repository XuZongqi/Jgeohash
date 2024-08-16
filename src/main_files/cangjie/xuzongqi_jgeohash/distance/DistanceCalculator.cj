package jgeohash.main_files.cangjie.xuzongqi_jgeohash.distance
import std.math
//必须得先插入具体的类且public才能调用
import jgeohash.main_files.cangjie.xuzongqi_jgeohash.api.Position

//import lombok.experimental.UtilityClass;
//TODO：应该@UtilityClass
//应该是final class
public let pi=3.1415926535
public class DistanceCalculator
{
    /**
	 * Returns the distance from the given coordinates values.
	 *
	 * @param startLatitude
	 *            the latitude from start point.
	 * @param startLongitude
	 *            the longitude from start point.
	 * @param endLatitude
	 *            the latitude from end point.
	 * @param endLongitude
	 *            the longitude from end point.
	 * @param unit
	 *            the measurement unit
	 * @return the distance between the given coordinates values.
	 */
	
	//角度转弧度
    func degrees_to_radians(degrees:Float64):Float64
    {
        return degrees*pi/180.0
    }
	//给两个点的位置算球面距离，西经为负，南纬为负
    public func distance(startLatitude:Float64,startLongitude:Float64,endLatitude:Float64,endLongitude:Float64,measuringUnit:String):Float64
     {

        //求弧度,值获取时分成固定和不固定两种
		//经度差
        let theta=degrees_to_radians(math.abs(startLongitude - endLongitude))
		//纬度1
		let latitudePoint1=degrees_to_radians(startLatitude)
		//纬度2
		let latitudePoint2=degrees_to_radians(endLatitude)
		//纬度差
		let lat=math.abs(latitudePoint1-latitudePoint2)
		//Haversine公式大致为：a = sin²(Δlat/2) + cos(lat1) * cos(lat2) * sin²(Δlon/2)
		let distance=math.pow(math.sin(theta/2.0),2)+math.cos(latitudePoint1)*math.cos(latitudePoint2)*math.pow(math.sin(lat/2.0),2)
		//计算距离：c = 2 * atan2(√(a), √(1-a)) * R
		let Distance=2.0*math.atan(math.sqrt(distance)/math.sqrt(math.abs(1.0-distance)))
		//地球半径/公里
		let R_earth=6371.0
		//目标值
		var targetDistance=Distance*R_earth
		//单位转换
		// if(let Some("MILE")<-MeasuringUnit)
		// {
		// 	print("成功，返回值为"+)
		// }
		
		match(measuringUnit)
		{
			case "MILE"=>targetDistance*= 0.621371
			case "METER"=>targetDistance*=1000.0
			case "KILOMETER"=>targetDistance*=1.0
			//类似于default
			case _=>print("输入的长度类型有误")
		}
        return targetDistance
     }

	 public func distanceBetweenPoints(start:Position,end:Position,measuringUnit:String):Float64
	 {
		// if(start.getLatitude()!=&&start.getLongitude!=None&&end.getLatitude!=None&&end.getLongitude!=None)
		var targetDistance:Float64
		targetDistance=distance(start.getLatitude(),start.getLongitude(),end.getLatitude(),end.getLongitude(),measuringUnit)
		return targetDistance
	 }
}