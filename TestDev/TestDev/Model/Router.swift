//
//  Router.swift
//  TestDev
//
//  Created by Raghavendra Daramwar on 04/03/24.
//

import Foundation

enum MovieTypes{
    case popular
    case latest
    case basePathForImagew500
    case basePathForImageOriginal
}


//MARK: For selecting proper url to get data from server
class Router {
    static var movieType: MovieTypes = .popular
    static var imageType: ImageTypes = .basePathForImageOriginal
    
    //MARK: For choosing the movieType
    static func rootURL() -> String{
        
        switch movieType{
            
        case .popular :
            return "https://api.themoviedb.org/3/movie/popular?language=en-US&page="
            
        case .latest:
            return "https://api.themoviedb.org/3/movie/now_playing?language=en-US&page="
        case .basePathForImageOriginal:
            return "https://image.tmdb.org/t/p/original"
        
        case .basePathForImagew500:
            return "https://image.tmdb.org/t/p/w500"
        }
    }
    //MARK: For choosing the imgeType
    static func imageURL() -> String{
        
        switch imageType{
            
        case .basePathForImageOriginal:
            return "https://image.tmdb.org/t/p/original"
        
        case .basePathForImagew500:
            return "https://image.tmdb.org/t/p/w500"
        }
    }
}

enum ImageTypes{
    case basePathForImagew500
    case basePathForImageOriginal
}
