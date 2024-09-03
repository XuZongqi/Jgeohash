package jgeohash.main_files.cangjie.xuzongqi_jgeohash
import jgeohash.main_files.cangjie.xuzongqi_jgeohash.api.Position
import std.math
import std.unittest
import std.collection.*


/**
	 * The static class Neighbors.
	 */
public class Neighbors
{
    
    /** The Constant BOTTOM_LEFT. */
    private static let BOTTOM_LEFT:String  = "14365h7k9dcfesgujnmqp0r2twvyx8zb"

    /** The Constant LEFT_BOTTOM. */
    private static let LEFT_BOTTOM:String  = "238967debc01fg45kmstqrwxuvhjyznp"

    /** The Constant neighbors. */
    public static var neighbors:HashMap<String, HashMap<String, String>> = HashMap<String, HashMap<String, String>>()

    /** The Constant RIGHT_TOP. */
    private static let RIGHT_TOP:String  = "bc01fg45238967deuvhjyznpkmstqrwx"

    /** The Constant TOP_RIGHT. */
    private static let TOP_RIGHT:String  = "p0r21436x8zb9dcf5h7kjnmqesgutwvy"
   
    static var right:HashMap<String, String> = HashMap<String, String>()
    static var left:HashMap<String, String> = HashMap<String, String>()
    static var top:HashMap<String, String> = HashMap<String, String>()
    static var bottom:HashMap<String, String> = HashMap<String, String>()

    public static func neighbor_put(direction:String):HashMap<String, String>
    {
        right.put(Adjacent.EVEN, Neighbors.RIGHT_TOP)
        right.put(Adjacent.ODD, Neighbors.TOP_RIGHT)

        left.put(Adjacent.EVEN, Neighbors.LEFT_BOTTOM)
        left.put(Adjacent.ODD, Neighbors.BOTTOM_LEFT)

        top.put(Adjacent.EVEN, Neighbors.TOP_RIGHT)
        top.put(Adjacent.ODD, Neighbors.RIGHT_TOP)

        bottom.put(Adjacent.EVEN, Neighbors.BOTTOM_LEFT)
        bottom.put(Adjacent.ODD, Neighbors.LEFT_BOTTOM)
        neighbors.put(Adjacent.TOP, right)
        neighbors.put(Adjacent.BOTTOM, left)
        neighbors.put(Adjacent.RIGHT, top)
        neighbors.put(Adjacent.LEFT, bottom)
        let target:HashMap<String, String>=Neighbors.neighbors.get(direction).getOrThrow()
        return target
    }

    
    
}
