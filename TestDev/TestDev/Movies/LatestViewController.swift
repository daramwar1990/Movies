//
//  LatestViewController.swift
//  TestDev
//
//  Created by Raghavendra Daramwar on 02/03/24.
//

import UIKit
import revDevModule

class LatestViewController: UIViewController {

    //MARK: controller properties
    @IBOutlet weak var latestTblView: UITableView!
    var tempMovie : Movie?
    var movie : Movie?
    var arrPopuMovies = [Result]()
    var currentPage = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Router.movieType = .latest
        Router.imageType = .basePathForImageOriginal
        latestTblView.dataSource = self
        latestTblView.delegate = self
        latestTblView.register(UINib(nibName: "MoviesTableViewCell", bundle: nil), forCellReuseIdentifier: "MoviesTableViewCell")
        //MARK: Method to fetch movies
        NetworkManager.fetch(urlString: Router.rootURL(), memberType: Movie.self, accessToken: "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJmMmQ5ZTc1YzYzNmZjNmU0OGUzZTExMzY5ZmQxZTg5NyIsInN1YiI6IjY1ZTJlN2ViYjdhMTU0MDE2Mzc3YzhjNiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.sw6TN7Hj1c-jB5lUdFe4EreaFetjCbr7R-IB8tMXW6A", page: currentPage, completion: {response in
            switch response{
            case .success(let movie):
                self.tempMovie = movie
                self.movie = movie
                self.arrPopuMovies = movie.results
                DispatchQueue.main.async {
                    self.latestTblView.reloadData()
                }
                
            case .failure(let err):
                print("Popular moview get list err",err.localizedDescription)
            }

        })
    }
}
//MARK: Extension for table view data source methods
extension LatestViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if arrPopuMovies.count == 0 {
            return 0
        }else {
            return arrPopuMovies.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MoviesTableViewCell", for: indexPath) as! MoviesTableViewCell
        cell.movie = arrPopuMovies[indexPath.row]
        let popularityString = String(Int(arrPopuMovies[indexPath.row].vote_average * 10))
        cell.lblPercentage.text = popularityString
        cell.lblName.text = arrPopuMovies[indexPath.row].title
        cell.lblName.textColor = .black
        cell.lblDate.text = arrPopuMovies[indexPath.row].release_date
        cell.lblDate.textColor = .black
        
        Utility.displayMoviePic(movie_pic_url: Router.imageURL() + (arrPopuMovies[indexPath.row].poster_path), activityIndicator: cell.activityIndicator, imageViewMoviePic: cell.imgView, imageType: .basePathForImageOriginal)
        
        cell.setupViewProgressView(movie: arrPopuMovies[indexPath.row])
        return cell
    }
    
    
}
//MARK: Extension for table view delegate methods
extension LatestViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        380
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = NewMovieDetailsViewController(nibName: "NewMovieDetailsViewController", bundle: nil)
        vc.movie = arrPopuMovies[indexPath.row]
        self.present(vc, animated: true, completion: nil)
    }
}


//MARK: Pagination
extension LatestViewController{
    /*
     func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
     if indexPath.row == (movie?.results.count)! - 1 && currentPage < movie!.totalPages {
     self.currentPage = self.currentPage + 1
     print("currentPage",currentPage)
     if self.currentPage <= movie!.totalPages {
     //self.activityIndiatorStartLoading()
     NetworkHandler.shared.fetchMovies(url: "", accessToken: "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJmMmQ5ZTc1YzYzNmZjNmU0OGUzZTExMzY5ZmQxZTg5NyIsInN1YiI6IjY1ZTJlN2ViYjdhMTU0MDE2Mzc3YzhjNiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.sw6TN7Hj1c-jB5lUdFe4EreaFetjCbr7R-IB8tMXW6A", page: currentPage, completion: { movie in
     
     self.tempMovie?.results = movie.results
     
     //  activityIndiatorStopLoading()
     
     if self.movie!.results.count != 0{
     
     for tempMovieObj in self.tempMovie!.results {
     //self.movie!.results.append(tempMovieObj)
     self.arrPopuMovies.append(tempMovieObj)
     }
     }
     DispatchQueue.main.async {
     self.popularTblView.reloadData()
     }
     })
     }
     }
     }
     */
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let pos = scrollView.contentOffset.y
        if pos > latestTblView.contentSize.height-100 - scrollView.frame.size.height{
            self.currentPage = self.currentPage + 1
            print("currentPage",currentPage)
            if self.currentPage <= movie!.totalPages {
                NetworkManager.fetch(urlString: Router.rootURL(), memberType: Movie.self, accessToken: "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJmMmQ5ZTc1YzYzNmZjNmU0OGUzZTExMzY5ZmQxZTg5NyIsInN1YiI6IjY1ZTJlN2ViYjdhMTU0MDE2Mzc3YzhjNiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.sw6TN7Hj1c-jB5lUdFe4EreaFetjCbr7R-IB8tMXW6A", page: currentPage, completion: {response in
                    switch response{
                    case .success(let movie):
                        self.tempMovie?.results = movie.results
                        
                        if self.movie!.results.count != 0{
                            
                            for tempMovieObj in self.tempMovie!.results {
                                self.arrPopuMovies.append(tempMovieObj)
                            }
                        }
                        DispatchQueue.main.async {
                            self.latestTblView.reloadData()
                        }
                        
                    case .failure(let err):
                        print("Popular moview get list err while pagination",err.localizedDescription)
                    }

                })
               /* NetworkHandler.shared.fetchMovies(url: Router.rootURL(), accessToken: "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJmMmQ5ZTc1YzYzNmZjNmU0OGUzZTExMzY5ZmQxZTg5NyIsInN1YiI6IjY1ZTJlN2ViYjdhMTU0MDE2Mzc3YzhjNiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.sw6TN7Hj1c-jB5lUdFe4EreaFetjCbr7R-IB8tMXW6A", page: currentPage, completion: { movie in
                    
                    self.tempMovie?.results = movie.results
                    if self.movie!.results.count != 0{
                        
                        for tempMovieObj in self.tempMovie!.results {
                            //self.movie!.results.append(tempMovieObj)
                            self.arrPopuMovies.append(tempMovieObj)
                        }
                    }
                    DispatchQueue.main.async {
                        self.latestTblView.reloadData()
                    }
                })
                */
            }
        }
    }
}

