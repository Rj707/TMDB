//
//  ViewController.swift
//  Practice
//
//  Created by iApple Basement on 09/05/2024.
//

import UIKit

class MovieListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    // In your view controller or wherever you create the ViewModel

    private var movieViewModel: MovieViewModel!

    var coordinator: MainCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create the data source and repository
        let dataSource = MovieDataSourceImplementation(movieAPIService: MovieAPIService())
        let repository = DefaultMovieRepository(dataSource: dataSource)
        
        // Initialize the ViewModel with the repository
        movieViewModel = MovieViewModel(movieRepository: repository)
        
        setupTableView()
        movieViewModel.getMoviesDataFromAPI()
        
        movieViewModel.movies.bind { [weak self] _ in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        let nib = UINib(nibName: "MovieTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "MovieTableViewCell")
        
    }
    
}

extension MovieListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieViewModel.movies.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell") as! MovieTableViewCell
        cell.lblName.text = movieViewModel.movies.value[indexPath.row].getMovieName()
        cell.lblDate.text = movieViewModel.movies.value[indexPath.row].getReleaseDate()
        cell.lblScore.text = "\(movieViewModel.movies.value[indexPath.row].voteAverage)/10"
        
        movieViewModel.downloadImageFromAPI(endpoint: movieViewModel.movies.value[indexPath.row].posterPath ?? "" ) { result in
            switch result {
                
            case .success(let data):
                let image = UIImage(data: data)
                
                DispatchQueue.main.async {
                    cell.imgOutlet.image = image
                }
                
            case .failure(let error):
                print(error)
                DispatchQueue.main.async {
                    cell.imgOutlet.image = nil
                }
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! MovieTableViewCell
        coordinator?.start(movie:  movieViewModel.movies.value[indexPath.row], movieImage: cell.imgOutlet.image)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
}
