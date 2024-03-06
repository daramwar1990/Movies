//
//  NetworkHandler.swift
//  TestDev
//
//  Created by Raghavendra Daramwar on 02/03/24.
//
/*
import Foundation
//MARK: Class to handle network calls with the server
class NetworkHandler {
    public static let shared : NetworkHandler = NetworkHandler()
    private init(){
        
    }
    //MARK: Method the put get request to the server to fetch data
    public func fetchMovies(url: String,accessToken: String,page:Int,completion : @escaping (Movie) -> Void) {
        let headers = [
            "accept": "application/json",
            "Authorization": "Bearer" + " " + (accessToken),
        ]
        print("url",url + String(page))
        let request = NSMutableURLRequest(url: NSURL(string: url + String(page))! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error as Any)
            } else {
                do {
                    let  movie =  try JSONDecoder().decode(Movie.self,from: data!)
                    completion(movie)
                }catch{
                    print("error while decoding")
                }
                
                let resultData = String(data: data!, encoding: String.Encoding.utf8) ?? "Data could not be printed"
                print(resultData)
            }
        })
        dataTask.resume()
    }
}
*/
