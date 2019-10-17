import UIKit

class RepositoriesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  

  
  let viewModel = RepositoriesViewModel()
  @IBOutlet var tableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let cellNib = UINib(nibName: "TableViewCell", bundle: nil)
    tableView.register(cellNib, forCellReuseIdentifier: "cell")
    viewModel.refresh { [unowned self] in
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    if let selectedRow = tableView.indexPathForSelectedRow {
      tableView.deselectRow(at: selectedRow, animated: true)
    }
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.numberOfRows()
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath) as! TableViewCell
    cell.name?.text = viewModel.titleForRowAtIndexPath(indexPath as IndexPath)
    cell.summary?.text = viewModel.summaryForRowAtIndexPath(indexPath: indexPath as NSIndexPath)
      return cell
  }
  
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let detailVC = segue.destination as? RepositoryDetailViewController,
      let indexPath = sender as? IndexPath {
      detailVC.viewModel = viewModel.detailViewModelForRowAtIndexPath(indexPath)
    }
  }

}


