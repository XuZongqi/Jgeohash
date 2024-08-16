package jgeohash.main_files.cangjie.xuzongqi.jgeohash.api
import serialization.serialization.*
interface Position { 
    // func f(): Unit
    /**
	 * Gets the latitude.
	 *
	 * @return the latitude
	 */
	func getLatitude():Float64

	/**
	 * Gets the longitude.
	 *
	 * @return the longitude
	 */
	func getLongitude():Float64

	/**
	 * Sets the latitude.
	 *
	 * @param latitude
	 *            the new latitude
	 */
    // 无参时返回类型是Unit
	func setLatitude(latitude:Float64):Unit

	/**
	 * Sets the longitude.
	 *
	 * @param longitude
	 *            the new longitude
	 */
	func setLongitude(longitude:Float64):Unit

}