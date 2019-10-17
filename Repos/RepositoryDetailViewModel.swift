import Foundation

class RepositoryDetailViewModel {
  let repo: Repository
    
  init(_ repository: Repository){
    self.repo = repository
  }
  
  func title() -> String {
    return repo.name
  }
  
  func URLString() -> String {
    return repo.htmlURL!
  }
}
