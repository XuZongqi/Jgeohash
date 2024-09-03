package jgeohash.main_files.cangjie.xuzongqi_jgeohash
// import jgeohash.main_files.cangjie.xuzongqi_jgeohash.GeoHashExtensions
// import jgeohash.main_files.cangjie.xuzongqi_jgeohash.Adjacent


public class FirstAndSecondRingRegion <: FirstRingRegion
{

	/** The Constant serialVersionUID. */
	// private static let serialVersionUID:Int64 = -6668301917974379694L;

	/** The east east. */
	private var eastEast:String

	/** The east north east. */
	private var eastNorthEast:String

	/** The east south east. */
	private var eastSouthEast:String

	/** The north east north east. */
	private var northEastNorthEast:String

	/** The north north. */
	private var northNorth:String

	/** The north north east. */
	private var northNorthEast:String

	/** The north north west. */
	private var northNorthWest:String

	/** The north west north west. */
	private var northWestNorthWest:String

	/** The south east south east. */
	private var southEastSouthEast:String

	/** The south south. */
	private var southSouth:String

	/** The south south east. */
	private var southSouthEast:String

	/** The south south west. */
	private var southSouthWest:String

	/** The south west south west. */
	private var southWestSouthWest:String

	/** The west north west. */
	private var westNorthWest:String

	/** The west south west. */
	private var westSouthWest:String

	/** The west west. */
	private var westWest:String

	/**
	 * Instantiates a new FirstAndSecondRingRegion from the given geohash value.
	 *
	 * @param geohash
	 *            the geohash
	 */
	public init(geohash:String)
	{
		super(geohash)
		northNorth = GeoHashExtensions.getAdjacent(geohash, Adjacent.TOP, Adjacent.TOP)
		northNorthWest = GeoHashExtensions.getAdjacent(geohash, Adjacent.TOP, Adjacent.LEFT,
			Adjacent.TOP)
		northWestNorthWest = GeoHashExtensions.getAdjacent(geohash, Adjacent.TOP, Adjacent.LEFT,
			Adjacent.TOP, Adjacent.LEFT)
		westNorthWest = GeoHashExtensions.getAdjacent(geohash, Adjacent.TOP, Adjacent.LEFT,
			Adjacent.LEFT)
		northNorthEast = GeoHashExtensions.getAdjacent(geohash, Adjacent.TOP, Adjacent.RIGHT,
			Adjacent.TOP)
		northEastNorthEast = GeoHashExtensions.getAdjacent(geohash, Adjacent.TOP, Adjacent.RIGHT,
			Adjacent.TOP, Adjacent.RIGHT)
		eastNorthEast = GeoHashExtensions.getAdjacent(geohash, Adjacent.TOP, Adjacent.RIGHT,
			Adjacent.RIGHT)
		eastEast = GeoHashExtensions.getAdjacent(geohash, Adjacent.RIGHT, Adjacent.RIGHT);
		eastSouthEast = GeoHashExtensions.getAdjacent(geohash, Adjacent.BOTTOM, Adjacent.RIGHT,
			Adjacent.RIGHT)
		southSouthEast = GeoHashExtensions.getAdjacent(geohash, Adjacent.BOTTOM, Adjacent.RIGHT,
			Adjacent.BOTTOM)
		southEastSouthEast = GeoHashExtensions.getAdjacent(geohash, Adjacent.BOTTOM, Adjacent.RIGHT,
			Adjacent.BOTTOM, Adjacent.RIGHT)
		southSouth = GeoHashExtensions.getAdjacent(geohash, Adjacent.BOTTOM, Adjacent.BOTTOM);
		southSouthWest = GeoHashExtensions.getAdjacent(geohash, Adjacent.BOTTOM, Adjacent.LEFT,
			Adjacent.BOTTOM)
		southWestSouthWest = GeoHashExtensions.getAdjacent(geohash, Adjacent.BOTTOM, Adjacent.LEFT,
			Adjacent.BOTTOM, Adjacent.LEFT)
		westSouthWest = GeoHashExtensions.getAdjacent(geohash, Adjacent.BOTTOM, Adjacent.LEFT,
			Adjacent.LEFT)
		westWest = GeoHashExtensions.getAdjacent(geohash, Adjacent.LEFT, Adjacent.LEFT)
	}

	public func isEqual(expected:FirstAndSecondRingRegion):Bool
	{
		var judge:Bool
		if (expected.eastEast==this.eastEast&&expected.eastNorthEast==this.eastNorthEast&&expected.eastSouthEast==this.eastSouthEast
		&&expected.northEastNorthEast==this.northEastNorthEast&&expected.northNorth==this.northNorth&&expected.northNorthEast==this.northNorthEast
		&&expected.northNorthWest==this.northNorthWest&&expected.northWestNorthWest==this.northWestNorthWest
		&&expected.southEastSouthEast==this.southEastSouthEast&&expected.southSouth==this.southSouth&&expected.southSouthEast==this.southSouthEast
		&&expected.southSouthWest==this.southSouthWest&&expected.southWestSouthWest==this.southWestSouthWest&&expected.westNorthWest==this.westNorthWest
		&&expected.westSouthWest==this.westSouthWest&&expected.westWest==this.westWest) 
		{
			return true
		}
		else
		{
			return false
		}
  	}
}
