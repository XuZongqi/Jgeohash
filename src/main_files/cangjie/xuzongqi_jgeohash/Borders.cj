package jgeohash.main_files.cangjie.xuzongqi_jgeohash
import jgeohash.main_files.cangjie.xuzongqi_jgeohash.api.Position
import std.math
import std.unittest
import std.collection.*

public class Borders
{

    /** The Constant borders. */
    public static let borders:HashMap<String, HashMap<String, String>>=HashMap<String, HashMap<String, String>>()

    /** The Constant BOTTOM_LEFT. */
    private static let BOTTOM_LEFT:String = "028b"

    /** The Constant LEFT_BOTTOM. */
    private static let LEFT_BOTTOM:String = "0145hjnp"

    /** The Constant RIGHT_TOP. */
    private static let RIGHT_TOP:String = "bcfguvyz"

    /** The Constant TOP_RIGHT. */
    private static let TOP_RIGHT:String  = "prxz"

        /**
        * Initializes the borders map.
        **/
    static var right:HashMap<String, String> = HashMap<String, String>()

    static var left:HashMap<String, String> = HashMap<String, String>()

    static var top:HashMap<String, String> = HashMap<String, String>()

    static var bottom:HashMap<String, String> = HashMap<String, String>()

    public static func border_put(direction:String):HashMap<String, String>
    {
        right.put(Adjacent.EVEN, Borders.RIGHT_TOP)
        right.put(Adjacent.ODD, Borders.TOP_RIGHT)

        left.put(Adjacent.EVEN, Borders.LEFT_BOTTOM)
        left.put(Adjacent.ODD, Borders.BOTTOM_LEFT)

        top.put(Adjacent.EVEN, Borders.TOP_RIGHT)
        top.put(Adjacent.ODD, Borders.RIGHT_TOP)

        bottom.put(Adjacent.EVEN, Borders.BOTTOM_LEFT)
        bottom.put(Adjacent.ODD, Borders.LEFT_BOTTOM)

        borders.put(Adjacent.TOP, right)
        borders.put(Adjacent.BOTTOM, left)
        borders.put(Adjacent.RIGHT, top)
        borders.put(Adjacent.LEFT, bottom)
        let target:HashMap<String, String>=Borders.borders.get(direction).getOrThrow()
        return target
    }
}