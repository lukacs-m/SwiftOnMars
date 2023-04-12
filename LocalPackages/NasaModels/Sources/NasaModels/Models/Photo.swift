//
//  Photo.swift
//  
//
//  Created by Martin Lukacs on 10/04/2023.
//

// MARK: - Photos
public struct Photos: Codable {
    public let photos: [Photo]
}

// MARK: - Photo
public struct Photo: Codable, Identifiable, Equatable, Hashable, Sendable {
    public let id, sol: Int
    public let camera: Camera
    public let imgSrc: String
    let earthDate: String
    let rover: Rover

    enum CodingKeys: String, CodingKey {
        case id, sol, camera
        case imgSrc = "img_src"
        case earthDate = "earth_date"
        case rover
    }
}


//
//{
//"id": 102693,
//"sol": 1000,
//"camera": {
//"id": 20,
//"name": "FHAZ",
//"rover_id": 5,
//"full_name": "Front Hazard Avoidance Camera"
//},
//"img_src": "http://mars.jpl.nasa.gov/msl-raw-images/proj/msl/redops/ods/surface/sol/01000/opgs/edr/fcam/FLB_486265257EDR_F0481570FHAZ00323M_.JPG",
//"earth_date": "2015-05-30",
//"rover": {
//"id": 5,
//"name": "Curiosity",
//"landing_date": "2012-08-06",
//"launch_date": "2011-11-26",
//"status": "active"
//}
//},
