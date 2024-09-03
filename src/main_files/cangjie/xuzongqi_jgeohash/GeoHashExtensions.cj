package jgeohash.main_files.cangjie.xuzongqi_jgeohash
import jgeohash.main_files.cangjie.xuzongqi_jgeohash.api.Position

import std.math.*
import std.unittest.*
import std.collection.*
import std.unicode.*

//UtilityClass
public class GeoHashExtensions
{
    private static let BASE_32: Array<String> = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "b",
    "c", "d", "e", "f", "g", "h", "j", "k", "m", "n", "p", "q", "r", "s", "t", "u", "v",
    "w", "x", "y", "z"]

    private static var DECODE_MAP: HashMap<String,Int64>= HashMap<String, Int64>()
    
    private static let precision:Int = 12
    private static let bits:Array<Int>=[16, 8, 4, 2, 1]

    public static func decode(geohash:String):Array<Float64>
    {
        var counter:Int64 = 0
        for(c in BASE_32)
        {
            DECODE_MAP.put(c, counter)
            counter++
        }
        if(geohash.isEmpty())
        {
            throw IllegalArgumentException("Argument geohash should not be null.")
        }
        else
        {
            var even:Bool = true
            var latitudeError:Float64 = 90.0
            var longitudeError:Float64 = 180.0
            var latitude:Float64
            var longitude:Float64
            let latitudeInterval:Array<Float64> = [ -90.0, 90.0 ]
            let longitudeInterval:Array<Float64> = [ -180.0, 180.0 ]

            var geohash_arr:Array<Rune>=geohash.toRuneArray()
            for(i in geohash_arr)
            {
                let i_Rune:String=String(i)
                let cd=DECODE_MAP.get(i_Rune)
                if(cd==None)
                {
                    throw IllegalArgumentException("Invalid character in geohash:  ${i_Rune}")
                }
                else
                {
                    for(j in bits)
                    {
                        let mask:Option<Int64>=j
                        if(even)
                        {
                            longitudeError/=2.0
                            //转换
                            var cd_a:Int64=cd ?? 0
                            var mask_a:Int64=mask ?? 0
                            if((cd_a&mask_a)!=0)
                            {
                                longitudeInterval[0]=(longitudeInterval[0]+longitudeInterval[1])/2.0
                            }
                            else
                            {
                                longitudeInterval[1]=(longitudeInterval[0]+longitudeInterval[1])/2.0
                            }

                        }
                        else
                        {
                            latitudeError /=2.0
                            var cd_a=cd ?? 0
                            var mask_a=mask ?? 0
                            if((cd_a&mask_a)!=0)
                            {
                                latitudeInterval[0]=(latitudeInterval[0]+latitudeInterval[1])/2.0
                            }
                            else
                            {
                                latitudeInterval[1]=(latitudeInterval[0]+latitudeInterval[1])/2.0
                            }
                        }
                        even=!even
                    }
                }
            }
            latitude=(latitudeInterval[0]+latitudeInterval[1])/2.0
            longitude=(longitudeInterval[0]+longitudeInterval[1])/2.0
            var target:Array<Float64>=[latitude,longitude,latitudeError,longitudeError]
            return target
            
        }

    }

//将给定的 GeoHash 字符串解码成经纬度，并根据解码过程中得到的经纬度误差来对这些经纬度值进行四舍五入到适当的精度。
    //TODO:geohash为final类型
    public static func decodeAndRound(geohash:String):Array<Float64>  
    {  
        // 首先，调用 decode 方法将 GeoHash 字符串解码成包含经纬度及其误差的数组  
        let ge:Array<Float64> = decode(geohash)
        
        // 从解码结果中提取经度和纬度  
        var latitude:Float64 = ge[0]  
        var longitude:Float64 = ge[1]  
        
        // 提取经度和纬度的误差（这些误差表示解码结果的精确度）  
        let latitudeError:Float64 = ge[2] 
        let longitudeError:Float64 = ge[3]
        
        // 计算纬度的精确度。这里使用误差的负对数（以10为底）来估算应该保留的小数位数，然后减去1（因为对数计算的是位数加一）  
        // Math.max(1, ...) 确保精确度至少为1（即至少保留一位小数）  
         
        let latitudePrecision:Float64 = max(1.0, round(-log10(latitudeError))) - 1.0 
        
        // 同上，计算经度的精确度  
        let longitudePrecision:Float64 = max(1.0, round(-log10(longitudeError))) - 1.0
        
        // 使用自定义的 getPrecision 方法（该方法未在代码段中给出）来根据计算出的精确度四舍五入经度和纬度  
        latitude = getPrecision(latitude, latitudePrecision)
        longitude = getPrecision(longitude, longitudePrecision)  
        
        // 返回一个包含四舍五入后的经度和纬度的数组
        var target_arr:Array<Float64>=[latitude, longitude]
        return target_arr
    }

    //这段代码实现了一个GeoHash编码器的核心逻辑，用于将给定的经纬度（latitude 和 longitude）转换为一个GeoHash字符串。
    //GeoHash是一种将二维的经纬度坐标编码为一维字符串的方法，常用于地理位置的快速检索和比较。
    public static func encode(latitude:Float64, longitude:Float64):String
    {
        var geohash:String=""
		var even:Bool = true
		var bit:Int = 0
		var ch:Int = 0

		let latitudeInterval:Array<Float64> = [ -90.0, 90.0 ]
		let longitudeInterval:Array<Float64> = [ -180.0, 180.0 ]

            // 循环直到GeoHash达到所需的精度（这里假设precision是类的成员变量，但在代码片段中未显示）  
    while (geohash.size < precision)  
    {  
        var mid:Float64 = 0.0
        // 如果是偶数迭代，处理经度  
        if (even)  
        {  
            mid = (longitudeInterval[0] + longitudeInterval[1]) / 2.0 // 计算经度的中点  
            if (longitude > mid)  
            {  
                // 如果当前经度大于中点，设置相应的位，并更新经度区间  
                ch |= bits[bit]; // 假设bits是包含GeoHash编码位的数组（未在代码片段中定义）  
                longitudeInterval[0] = mid  
            }  
            else  
            {  
                // 否则，不设置位，只更新经度区间  
                longitudeInterval[1] = mid
            }  
  
        }  
        // 如果是奇数迭代，处理纬度  
        else  
        {  
            mid = (latitudeInterval[0] + latitudeInterval[1]) / 2.0 // 计算纬度的中点  
            if (latitude > mid)  
            {  
                // 如果当前纬度大于中点，设置相应的位，并更新纬度区间  
                //从数组 bits 中取出索引为 bit 的元素。
                //将 ch 的当前值与 bits[bit] 进行位或操作。
                //将位或操作的结果赋值回 ch。
                ch |= bits[bit];  
                latitudeInterval[0] = mid
            }  
            else  
            {  
                // 否则，不设置位，只更新纬度区间  
                latitudeInterval[1] = mid
            }  
        }  
  
        // 切换处理经度和纬度的标志  
        even = !even;  
  
        // 如果已经收集了足够的位来形成一个字符（GeoHash使用Base32编码），则添加到结果字符串中  
        if (bit < 4)  
        {  
            bit++;  
        }  
        else  
        {  
            // 使用BASE_32数组（未在代码片段中定义）将收集到的位转换为Base32字符  

            // geohash.append(BASE_32[ch]);  
            geohash= geohash+BASE_32[ch]
            // 重置位计数器和字符变量，以便收集下一个字符的位  
            bit = 0
            ch = 0
        }  
    }  
  
    // 返回生成的GeoHash字符串  
    return geohash

    }  

    //根据给定的GeoHash（一种编码地理位置的字符串）和一个方向（如'top', 'bottom', 'left', 'right'等），计算出相邻GeoHash的编码。
    public static func getAdjacent(geohash:String, direction:String):String  
    {  
        if (geohash.isEmpty())  
        {  
            throw IllegalArgumentException("Argument geohash should not be null.")
            // fail("Argument geohash should not be empty.")
        }  
        // 检查方向是否为空或null  
        if (direction.isEmpty())  
        {  
            throw IllegalArgumentException("Argument direction should not be null or empty.")
            // fail("Argument direction should not be null or empty.")
        }  
        
        // 将geohash转换为小写  
        let lowerCaseGeohash:String = geohash.toLower()
        
        // 获取geohash的最后一个字符  
        //字符串先要变成字符数组
        var lowerCaseGeohash_arr:Array<Rune>=lowerCaseGeohash.toRuneArray()
        let lastChar:Rune = lowerCaseGeohash_arr[lowerCaseGeohash_arr.size-1]
        
        // 计算geohash长度的奇偶性  
        let modulo:Int64 = lowerCaseGeohash_arr.size % 2

        // 根据奇偶性确定类型（假设Adjacent.ODD和Adjacent.EVEN是预定义的字符串常量） 
        let length_type:String
        if(modulo == 0)
        {
            length_type=Adjacent.ODD
        }
        else
        {
            length_type=Adjacent.EVEN
        }  
        var base:String
        if(lowerCaseGeohash_arr.size-1>0)
        {
            // 去掉geohash的最后一个字符，作为基础部分 
            var base_arr_pro:Array<Rune>=lowerCaseGeohash_arr[0..lowerCaseGeohash_arr.size-1]//处理生成中括号的问题
            // var base:String = lowerCaseGeohash.substring(0, lowerCaseGeohash.length() - 1)  
            // fromUtf8Unchecked()
            base = String(base_arr_pro) 

            // 从某个映射中获取给定方向的边界字符映射（假设Adjacent.Borders.borders是预定义的）  
            // let  borderDirection:HashMap<String, String> = Adjacent.Borders.borders.get(direction)
            let borderDirection:HashMap<String, String> = Borders.border_put(direction)
            // 获取当前类型对应的边界字符  
            let borderDirectionType:String = borderDirection.get(length_type).getOrThrow()
            // 检查最后一个字符是否在边界字符中，并递归处理基础部分（如果基础部分非空）  
            let borderDirectionType_arr:Array<Rune>=borderDirectionType.toRuneArray()

            if(borderDirectionType_arr.indexOf(lastChar)!=None)
            {
                let indexOfLastChar:Int64 = borderDirectionType_arr.indexOf(lastChar).getOrThrow()
                if ((indexOfLastChar != 0) && !base.isEmpty())  
                {  
                    base = getAdjacent(base, direction)
                }  
            }
        }

        else
        {
            // 去掉geohash的最后一个字符，作为基础部分 
            base=""
            // 从某个映射中获取给定方向的边界字符映射（假设Adjacent.Borders.borders是预定义的）  
            let borderDirection:HashMap<String, String> = Borders.border_put(direction)
 
            // 获取当前类型对应的边界字符  
            let borderDirectionType:String = borderDirection.get(length_type).getOrThrow()
            // 检查最后一个字符是否在边界字符中，并递归处理基础部分（如果基础部分非空）  
            let borderDirectionType_arr:Array<Rune>=borderDirectionType.toRuneArray()

            var indexOfLastChar:Int64
            if(borderDirectionType_arr.indexOf(lastChar)!=None)
            {
                indexOfLastChar = borderDirectionType_arr.indexOf(lastChar).getOrThrow()
            }
            else
            {
                indexOfLastChar=-1
                if ((indexOfLastChar != -1) && !base.isEmpty())  
                {  
                    base = getAdjacent(base, direction)
                }  
            }
            
        }

        let neighborsDirection:HashMap<String, String> = Neighbors.neighbor_put(direction)

        // 获取当前类型对应的相邻字符  
        let neighborsDirectionType:String = neighborsDirection.get(length_type).getOrThrow()
        // 在相邻字符中找到最后一个字符的索引  
        let neighborsDirectionType_arr:Array<Rune>=neighborsDirectionType.toRuneArray()
        let i:Int64 = neighborsDirectionType_arr.indexOf(lastChar).getOrThrow()
        // 根据索引从BASE_32（假设是预定义的32个字符数组）中获取新的字符  
        let r:String = BASE_32[i]
        // 返回新的GeoHash（基础部分 + 新的字符）  
        return base + r
        


    }


	public static func getAdjacent(geohash:String, directions:Array<String>):String
	{
		var geohashresult:String = geohash
		for (direction in directions)
		{
			geohashresult = getAdjacent(geohashresult, direction)
		}
		return geohashresult
	}

	public static func getAllAdjacentAreasList(geohash:String):ArrayList<String>
	{
		if (geohash.isEmpty())
		{
            throw IllegalArgumentException("Argument geohash should not be null.")
		}

		var adjacentAreas:ArrayList<String> = ArrayList<String>()
		let top:String = GeoHashExtensions.getAdjacent(geohash, Adjacent.TOP)
		let bottom:String = GeoHashExtensions.getAdjacent(geohash, Adjacent.BOTTOM)
		let right:String = GeoHashExtensions.getAdjacent(geohash, Adjacent.RIGHT)
		let left:String = GeoHashExtensions.getAdjacent(geohash, Adjacent.LEFT)
		let topleft:String = GeoHashExtensions.getAdjacent(left, Adjacent.TOP)
		let topright:String = GeoHashExtensions.getAdjacent(right, Adjacent.TOP)
		let bottomright:String = GeoHashExtensions.getAdjacent(right, Adjacent.BOTTOM)
		let bottomleft:String = GeoHashExtensions.getAdjacent(left, Adjacent.BOTTOM)
		adjacentAreas.append(geohash)
		adjacentAreas.append(top)
		adjacentAreas.append(topright)
		adjacentAreas.append(right)
		adjacentAreas.append(bottomright)
		adjacentAreas.append(bottom)
		adjacentAreas.append(bottomleft)
		adjacentAreas.append(left)
		adjacentAreas.append(topleft)
		return adjacentAreas
	}

	public static func getAllAdjacentAreasMap(geohash:String):HashMap<String, String>
	{
		if (geohash.isEmpty())
		{
            throw IllegalArgumentException("Argument geohash should not be null.")
		}
		let top:String = GeoHashExtensions.getAdjacent(geohash, Adjacent.TOP)
		let bottom:String  = GeoHashExtensions.getAdjacent(geohash, Adjacent.BOTTOM)
		let right:String  = GeoHashExtensions.getAdjacent(geohash, Adjacent.RIGHT)
		let left:String  = GeoHashExtensions.getAdjacent(geohash, Adjacent.LEFT)
		let topleft:String  = GeoHashExtensions.getAdjacent(left, Adjacent.TOP)
		let topright:String  = GeoHashExtensions.getAdjacent(right, Adjacent.TOP)
		let bottomright:String  = GeoHashExtensions.getAdjacent(right, Adjacent.BOTTOM)
		let bottomleft:String  = GeoHashExtensions.getAdjacent(left, Adjacent.BOTTOM)
        
		var adjacentAreas:HashMap<String, String> = HashMap<String, String>()
		adjacentAreas.put(Adjacent.CENTER, geohash)
		adjacentAreas.put(Adjacent.TOP, top)
		adjacentAreas.put(Adjacent.BOTTOM, bottom)
		adjacentAreas.put(Adjacent.RIGHT, right)
		adjacentAreas.put(Adjacent.LEFT, left)
		adjacentAreas.put(Adjacent.TOP_LEFT, topleft)
		adjacentAreas.put(Adjacent.TOP_RIGHT, topright)
		adjacentAreas.put(Adjacent.BOTTOM_RIGHT, bottomright)
		adjacentAreas.put(Adjacent.BOTTOM_LEFT, bottomleft)

		return adjacentAreas
	}


	public static func getFirstAndSecondRingRegion(geohash:String):FirstAndSecondRingRegion
	{
        var geohash_firsecr:FirstAndSecondRingRegion=FirstAndSecondRingRegion(geohash)
		return geohash_firsecr
	}

	public static func getFirstRingRegion(geohash:String):FirstRingRegion
	{
		var geohash_firr:FirstRingRegion=FirstRingRegion(geohash)
		return geohash_firr
	}

	public static func getLatitude(geohash:String):Float64
	{
		return decodeAndRound(geohash)[0]
	}

	public static func getLongitude(geohash:String):Float64
	{
		return decodeAndRound(geohash)[1]
	}

    private static func getPrecision(x:Float64, precision:Float64):Float64
	{
        //意图是计算10的-precision次幂，用于确定要保留到的小数点后的位数
        //截断后的值=⌊x*10^n ⌋÷10^n 其中，n 是你想要保留的小数位数，⌊⋅⌋ 表示向下取整
        var cur_x=x*pow(10.0,precision)
        cur_x=floor(cur_x)
        cur_x/=(pow(10.0,precision))
		return cur_x
	}

}