import UIKit

class RepositoryDetailViewController: UIViewController {
    
    @IBOutlet var webView: UIWebView?
    
    var viewModel: RepositoryDetailViewModel?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.title = viewModel?.title()

        if let viewModel = viewModel,
            let url = NSURL(string: viewModel.URLString()) {
          let request = NSURLRequest(url: url as URL)
          webView?.loadRequest(request as URLRequest)
        }
    }
}
