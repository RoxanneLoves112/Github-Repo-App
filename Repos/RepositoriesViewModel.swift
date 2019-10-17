import Foundation

class RepositoriesViewModel {
  var repos = [Repository]()
  
  let client = SearchRepositoriesClient()
  let parser = RepositoriesParser()
  
  func numberOfRows() -> Int {    
    return repos.count
  }
  
  func titleForRowAtIndexPath(_ indexPath: IndexPath) -> String {
    guard indexPath.row >= 0 && indexPath.row < repos.count else {
        return ""
    }
    return repos[indexPath.row].name
  }
  
  func detailViewModelForRowAtIndexPath(_ indexPath: IndexPath) -> RepositoryDetailViewModel {
    
    return RepositoryDetailViewModel(repos[indexPath.row])
  }
  
  func summaryForRowAtIndexPath(indexPath: NSIndexPath) -> String {
     guard indexPath.row >= 0 && indexPath.row < repos.count else {
       return ""
     }
      
      return repos[indexPath.row].description
   }
  
  func refresh(completion: @escaping () -> Void) {
    client.fetchRepositories { [unowned self] data in
      if let repositories = self.parser.repositoriesFromSearchResponse(data) {
        self.repos = repositories
      }
      completion()
    }
  }
  
}
