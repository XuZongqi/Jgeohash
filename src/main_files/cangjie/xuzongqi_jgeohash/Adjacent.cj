package jgeohash.main_files.cangjie.xuzongqi_jgeohash
import jgeohash.main_files.cangjie.xuzongqi_jgeohash.api.Position
import std.math
import std.unittest


/**
 * The class {@link Adjacent}.
 */
public abstract class Adjacent
{
	/** The Constant BOTTOM. */
	public static let BOTTOM:String  = "bottom"

	/** The Constant BOTTOM_BOTTOM. */
	public static let BOTTOM_BOTTOM:String  = "bottom_bottom"

	/** The Constant BOTTOM_LEFT. */
	public static let BOTTOM_LEFT:String = "bottomleft"

	/** The Constant BOTTOM_LEFT_BOTTOM. */
	public static let BOTTOM_LEFT_BOTTOM:String  = "bottomleft_bottom"

	/** The Constant BOTTOM_LEFT_BOTTOM_LEFT. */
	public static let BOTTOM_LEFT_BOTTOM_LEFT:String = "bottomleft_bottom_left"

	/** The Constant BOTTOM_LEFT_LEFT. */
	public static let BOTTOM_LEFT_LEFT:String = "bottomleft_left"

	/** The Constant BOTTOM_RIGHT. */
	public static let BOTTOM_RIGHT:String  = "bottomright"

	/** The Constant BOTTOM_RIGHT_BOTTOM. */
	public static let BOTTOM_RIGHT_BOTTOM:String = "bottomright_bottom"

	/** The Constant BOTTOM_RIGHT_BOTTOM_RIGHT. */
	public static let BOTTOM_RIGHT_BOTTOM_RIGHT:String  = "bottomright_bottom_right"

	/** The Constant BOTTOM_RIGHT_RIGHT. */
	public static let BOTTOM_RIGHT_RIGHT:String  = "bottomright_right"

	/** The Constant CENTER. */
	public static let CENTER:String  = "center"

	/** The Constant EVEN. */
	public static let EVEN:String = "even"

	/** The Constant LEFT. */
	public static let LEFT:String = "left"

	/** The Constant LEFT_LEFT. */
	public static let LEFT_LEFT:String  = "left_left"

	/** The Constant ODD. */
	public static let ODD:String = "odd"

	/** The Constant RIGHT. */
	public static let RIGHT:String = "right"

	/** The Constant RIGHT_RIGHT. */
	public static let RIGHT_RIGHT:String  = "right_right"

	/** The Constant TOP. */
	public static let TOP:String  = "top"

	/** The Constant TOP_LEFT. */
	public static let TOP_LEFT:String  = "topleft"

	/** The Constant TOP_LEFT_LEFT. */
	public static let TOP_LEFT_LEFT:String = "topleft_left"

	/** The Constant TOP_LEFT_TOP. */
	public static let TOP_LEFT_TOP:String  = "topleft_top"

	/** The Constant TOP_LEFT_TOP_LEFT. */
	public static let TOP_LEFT_TOP_LEFT:String = "topleft_top_left"

	/** The Constant TOP_RIGHT. */
	public static let TOP_RIGHT:String = "topright"

	/** The Constant TOP_RIGHT_RIGHT. */
	public static let TOP_RIGHT_RIGHT:String  = "topright_right"

	/** The Constant TOP_RIGHT_TOP. */
	public static let TOP_RIGHT_TOP:String  = "topright_top"

	/** The Constant TOP_RIGHT_RIGHT_TOP. */
	public static let TOP_RIGHT_TOP_RIGHT:String  = "topright_top_right"

	/** The Constant TOP_TOP. */
	public static let TOP_TOP:String  = "top_top"
}