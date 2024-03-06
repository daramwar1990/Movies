//
//  MovieModel.swift
//  TestDev
//
//  Created by Raghavendra Daramwar on 02/03/24.
//

import Foundation


// MARK: - Model for movie data
struct Movie: Codable {
    let dates: Dates?
    let page: Int?
    var results: [Result]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case dates,page,results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Dates
struct Dates: Codable {
    let maximum, minimum: String
}
struct Result: Codable{
    var adult:Bool
    let backdrop_path:String
    var genre_ids:[Int]
    var id:Int
    var original_language:String
    var original_title:String
    var overview:String
    var popularity: Double
    var poster_path:String
    var release_date:String
    var title:String
    var video:Bool
    var vote_average:Double
    var vote_count:Int
}
