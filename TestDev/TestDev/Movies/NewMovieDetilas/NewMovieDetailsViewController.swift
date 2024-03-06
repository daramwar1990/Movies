//
//  NewMovieDetailsViewController.swift
//  TestDev
//
//  Created by Raghavendra Daramwar on 04/03/24.
//

import UIKit

class NewMovieDetailsViewController: UIViewController {
    //MARK: controller properties
    @IBOutlet weak var bntBack: UIButton!
    @IBOutlet weak var imgViewBackground: UIImageView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblMovieName: UILabel!
    @IBOutlet weak var lblMovieDetails: UILabel!
    @IBOutlet weak var lblUserScore: UILabel!
    @IBOutlet weak var lblMovieSpecial: UILabel!
    @IBOutlet weak var lblOverview: UILabel!
    @IBOutlet weak var lblDirectorName: UILabel!
    @IBOutlet weak var viewPercentage: UIView!
    @IBOutlet weak var lblDesignation1: UILabel!
    
    @IBOutlet weak var activityIndi: UIActivityIndicatorView!
    var movie : Result?
    var progressLyr = CAShapeLayer()
    var trackLyr = CAShapeLayer()
    var progressClr = UIColor.green {
        didSet {
            progressLyr.strokeColor = progressClr.cgColor
        }
    }
    var trackClr = UIColor.green {
        didSet {
            trackLyr.strokeColor = trackClr.cgColor
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        setupViewProgressView()
    }
    //MARK: Method to setup progress view
    func setupViewProgressView() {
        viewPercentage.backgroundColor = UIColor.black
        
        let centre = CGPoint(x:viewPercentage.frame.size.width/2, y:viewPercentage.frame.size.height/2)
        let per = Double((movie?.vote_average ?? 0) * 10)
       
        let factor = Double((2 * per) / 100)
        let circlePath = UIBezierPath(arcCenter: centre,
                                      radius: 35,
                                      startAngle: 0,
                                      endAngle: factor * CGFloat.pi,
                                      clockwise: true)
        
        trackLyr.path = circlePath.cgPath
        trackLyr.fillColor = UIColor.clear.cgColor
        trackLyr.strokeColor = trackClr.cgColor
        trackLyr.lineWidth = 5.0
        trackLyr.strokeEnd = 1.0
        
        let backgroundCircularPath = UIBezierPath(arcCenter: centre,
                                                  radius: 35,
                                                  startAngle: 0,
                                                  endAngle: 2 * CGFloat.pi,
                                                  clockwise: true)
        
        progressLyr.path = backgroundCircularPath.cgPath
        progressLyr.opacity = 0.4
        progressLyr.fillColor = UIColor.clear.cgColor
        progressLyr.strokeColor = progressClr.cgColor
        progressLyr.lineWidth = 5.0
        progressLyr.strokeEnd = 1.0
        viewPercentage.layer.addSublayer(progressLyr)
        
        viewPercentage.layer.addSublayer(trackLyr)
    }
    //MARK: MEthod to setUp initial view
    func setUpView(){
        self.imgView.layer.cornerRadius = 10
        self.lblDirectorName.isHidden = true
        self.lblDesignation1.isHidden = true
        self.viewPercentage.layer.cornerRadius = viewPercentage.frame.width / 2
        lblMovieDetails.text = movie?.release_date ?? ""
        lblMovieName.text = movie?.title ?? "no name"
        lblOverview.text = movie?.overview ?? "-"
        let popularityString = String(Int((movie?.vote_average ?? 0) * 10))
    
        self.lblUserScore.text = popularityString
        Utility.displayMoviePic(movie_pic_url: (movie?.backdrop_path ?? ""), activityIndicator: activityIndi, imageViewMoviePic: imgViewBackground, imageType: .basePathForImagew500)
        
        Utility.displayMoviePic(movie_pic_url: (movie?.poster_path ?? ""), activityIndicator: activityIndi, imageViewMoviePic: imgView, imageType: .basePathForImageOriginal)
    }
    
    @IBAction func btnBackClicked(_ sender: Any) {
        self.dismiss(animated: true)
    }
}
