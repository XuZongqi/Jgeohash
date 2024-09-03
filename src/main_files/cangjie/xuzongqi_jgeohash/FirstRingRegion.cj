package jgeohash.main_files.cangjie.xuzongqi_jgeohash


public open class FirstRingRegion
{

	/** The center. */
	private let center:String 

	/** The east. */
	private let east:String 

	/** The north. */
	private let north:String

	/** The north east. */
	private let northEast:String

	/** The north west. */
	private let northWest:String

	/** The south. */
	private let south:String

	/** The south east. */
	private let southEast:String

	/** The south west. */
	private let southWest:String

	/** The west. */
	private let west:String

	public init(geohash:String)
	{
		this.center = geohash

		this.east = GeoHashExtensions.getAdjacent(geohash, Adjacent.RIGHT)
		this.west = GeoHashExtensions.getAdjacent(geohash, Adjacent.LEFT)
		this.north = GeoHashExtensions.getAdjacent(geohash, Adjacent.TOP)
		this.south = GeoHashExtensions.getAdjacent(geohash, Adjacent.BOTTOM)
		this.southEast = GeoHashExtensions.getAdjacent(this.south, Adjacent.RIGHT)
		this.northEast = GeoHashExtensions.getAdjacent(this.north, Adjacent.RIGHT)
		this.northWest = GeoHashExtensions.getAdjacent(this.north, Adjacent.LEFT)
		this.southWest = GeoHashExtensions.getAdjacent(this.south, Adjacent.LEFT)
	}

	public open func isEqual(expected:FirstRingRegion):Bool
	{
		var judge:Bool
		if (expected.center==this.center&&expected.east==this.east&&expected.north==this.north&&expected.northEast==this.northEast
		&&expected.northWest==this.northWest&&expected.south==this.south&&expected.southEast==this.southEast&&expected.southWest==this.southWest&&expected.west==this.west) 
		{
			return true
		}
		else
		{
			return false
		}
  	}
}
