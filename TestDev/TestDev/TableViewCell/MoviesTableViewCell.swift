//
//  MoviesTableViewCell.swift
//  TestDev
//
//  Created by Raghavendra Daramwar on 02/03/24.
//

import UIKit

class MoviesTableViewCell: UITableViewCell {
    
    //MARK: cell properties
    @IBOutlet weak var viewVote: UIView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblPercentage: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    var movie :Result?
    
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
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    //MARK: To setup initial view
    func setUpView(){
        self.imgView.layer.cornerRadius = 10
        self.viewVote.layer.cornerRadius = viewVote.frame.width / 2
        self.lblDate.layer.backgroundColor = UIColor.white.cgColor
        self.lblName.layer.backgroundColor = UIColor.white.cgColor
        
    }
    //MARK: To setup progress view
    func setupViewProgressView(movie: Result) {
        viewVote.backgroundColor = UIColor.black
        
        let centre = CGPoint(x:68, y:245)
        let per = Double(movie.vote_average * 10)
       
        let factor = Double((2 * per) / 100)
        let circlePath = UIBezierPath(arcCenter: centre,
                                      radius: 35,
                                      startAngle: 0,
                                      endAngle: factor * CGFloat.pi,
                                      clockwise: true)
        
        let backgroundCircularPath = UIBezierPath(arcCenter: centre,
                                                  radius: 35,
                                                  startAngle: 0,
                                                  endAngle: 2 * CGFloat.pi,
                                                  clockwise: true)
        
        progressLyr.path = backgroundCircularPath.cgPath
        progressLyr.opacity = 0.5
        progressLyr.fillColor = UIColor.clear.cgColor
        progressLyr.strokeColor = progressClr.cgColor
        progressLyr.lineWidth = 5.0
        progressLyr.strokeEnd = 1.0
        layer.addSublayer(progressLyr)
        
        trackLyr.path = circlePath.cgPath
        trackLyr.fillColor = UIColor.clear.cgColor
        trackLyr.strokeColor = trackClr.cgColor
        trackLyr.lineWidth = 5.0
        trackLyr.strokeEnd = 1.0
        
        layer.addSublayer(trackLyr)
        
    }
    
}
