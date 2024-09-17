//
//  MovieDetailViewController.swift
//  Practice
//
//  Created by iApple Basement on 15/05/2024.
//

import UIKit

class MovieDetailViewController: UIViewController {

    @IBOutlet weak var imgOutlet: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDetail: UILabel!
    
    var movie: Movie?
    var movieImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setData()
       
    }
    
    func setData() {
        if let movie = movie {
            lblTitle.text = movie.name ?? movie.title ?? ""
            lblDetail.text = movie.overview ?? ""
        }
        
        if let image = movieImage {
            imgOutlet.image = image
        }
    }

}
