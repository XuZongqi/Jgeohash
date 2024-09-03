package jgeohash.main_files.cangjie.xuzongqi_jgeohash
import jgeohash.main_files.cangjie.xuzongqi_jgeohash.api.Position
import std.math
import std.unittest
public class GeoHashPoint <:Point
{
    //    // 定义了一个常量 GEOHASH_KEY  
    //public static final String GEOHASH_KEY = "GEOHASH_KEY";  
  
    // 序列化版本号  
    //private static final long serialVersionUID = -3580536765079661097L; 
    //
    public init(latitude:Float64, longitude:Float64) {  
        super(latitude, longitude)
    }

    public init(position:Position) {  
        this(position.getLatitude(), position.getLongitude())
    }

        // 构造器：使用 Geohash 编码字符串初始化 GeoHashPoint，通过解码得到纬度和经度  
    public init(geohash:String) {  
        super(GeoHashExtensions.decode(geohash)[0], GeoHashExtensions.decode(geohash)[1])
    }  
  
    // 构造器：使用 String 类型的纬度和经度初始化 GeoHashPoint，这里先将 String 转为 double  
    // public init(lat:String, lng:String) {  
    //     super(Double.parseDouble(lat), Double.parseDouble(lng))  
    // }  
  
    // 覆盖 Object 类的 clone 方法，创建并返回 GeoHashPoint 的一个浅拷贝  
    
    public func clone():GeoHashPoint {  
        var geo:GeoHashPoint=GeoHashPoint(getLatitude(), getLongitude())
        return geo
    }  
  
    // 获取当前点的 Geohash 编码  
    public func getGeohash():String {  
        return GeoHashExtensions.encode(getLatitude(), getLongitude());  
    }  
  
    // 获取纬度作为 BigDecimal 对象  
    // public func getLat():Float64 {  
    //     return BigDecimal.valueOf(getLatitude());  
    // }  
  
    // // 获取经度作为 BigDecimal 对象  
    // public BigDecimal getLng() {  
    //     return BigDecimal.valueOf(getLongitude());  
    // }  
  
    // 覆盖 toString 方法，提供 GeoHashPoint 的字符串表示形式，包括 Geohash 编码   
    // public func toString():String {  
    //     final StringBuilder buffer = new StringBuilder();  
    //     buffer.append("[GeoHashPoint:");  
    //     buffer.append(super.toString()); // 调用父类的 toString 方法  
    //     buffer.append("   Geohash : ");  
    //     buffer.append(getGeohash());  
    //     buffer.append("]");  
    //     return buffer.toString();  
    // }
}