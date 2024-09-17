import Foundation
import UIKit

// Protocol defining the Coordinator responsibilities
protocol Coordinator {
    func start()
}

// MainCoordinator class conforming to the Coordinator protocol
class MainCoordinator: Coordinator {
    
    let navigationController: UINavigationController
    
    // Initializer to inject the navigation controller
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // Start method to initiate the navigation flow
    func start() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let controller = storyboard.instantiateViewController(identifier: "ViewController") as? MovieListViewController else {
            fatalError("MovieListViewController could not be instantiated")
        }
        controller.coordinator = self  // Inject the coordinator
        navigationController.pushViewController(controller, animated: true)
    }
    
    // Overloaded start method to navigate to MovieDetailViewController
    func start(movie: Movie, movieImage: UIImage?) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let detailViewController = storyboard.instantiateViewController(withIdentifier: "MovieDetailViewController") as? MovieDetailViewController else {
            fatalError("MovieDetailViewController could not be instantiated")
        }
        detailViewController.movie = movie
        detailViewController.movieImage = movieImage
        navigationController.pushViewController(detailViewController, animated: true)
    }
}
