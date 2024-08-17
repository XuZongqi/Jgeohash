package jgeohash.test.distance

// import jgeohash.*
import jgeohash.main_files.cangjie.xuzongqi_jgeohash.distance.DistanceCalculator

import std.unittest.*
import std.unittest.testmacro.*
import encoding.json.*
import serialization.serialization.*


@Test
class TestDistanceCalculator {

    @TestCase
    func distance_test() {
        let startLatitude = 40.7128
        let startLongitude = -74.0060 
        let endLatitude = 34.0522
        let endLongitude = -118.2437
        
        let dc=DistanceCalculator()
        let actual=dc.distance(startLatitude,startLongitude,endLatitude,endLongitude,"MILE")
        // assertEqual("Expected Wrapper", "Actual Wrapper", 10.0, actual)
        @Assert(actual,10.0)
        
    }

    // @TestCase
    // func serialize() {
    //     let dm = DaprException("ERR_DAPR", "msg").serialize()
    //     let dms = match (dm) {
    //         case d: DataModelStruct => d
    //         case _ =>
    //             @Assert(false)
    //             return
    //     }

    //     @Assert(
    //         String.deserialize(dms.get("errorCode")),
    //         "ERR_DAPR"
    //     )
    //     @Assert(
    //         String.deserialize(dms.get("message")),
    //         "msg"
    //     )
    // }

    // @TestCase
    // func deserialize() {
    //     let dms = DataModelStruct()
    //         .add(field<String>("errorCode", "ERR_DAPR"))
    //         .add(field<String>("message", "msg"))
    //     let e = DaprException.deserialize(dms)
    //     @Assert(e.errorCode, "ERR_DAPR")
    //     @Assert(e.msg, "msg")
    // }

    // @TestCase
    // func deserialize_throwException() {
    //     let dms = DataModelStruct()
    //         .add(field<String>("errorCode1", "ERR_DAPR"))
    //         .add(field<String>("message", "msg"))

    //     @AssertThrows(DaprException.deserialize(dms))

    //     @AssertThrows(DaprException.deserialize("".serialize()))
    // }
}