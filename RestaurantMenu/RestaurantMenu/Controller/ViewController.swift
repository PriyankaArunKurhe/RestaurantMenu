
import UIKit
class ViewController: UIViewController, UITableViewDelegate{
    //MARK: Outlet
    @IBOutlet weak var menuTableView: UITableView!
    //MARK: Variable Declaration
    var nameArray = [String]()
    var descArray = [String]()
    var pricearray = [String]()
    //MARK: Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.menuTableView.dataSource = self
        let nibFile = UINib(nibName: "MenuTableViewCell", bundle: nil)
        self.menuTableView.register(nibFile, forCellReuseIdentifier: "MenuTableViewCell")
    }
    //MARK: Button Action Methods
    @IBAction func addMenu(_ sender: Any) {
        if let secondVc = self.storyboard?.instantiateViewController(withIdentifier: "SecondViewController") as? SecondViewController{
            secondVc.delegeteSVC = self
            self.navigationController?.pushViewController(secondVc, animated: true)
        }
    }
}
//MARK: DataSource MEthod
extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if nameArray.count == 0 && descArray.count == 0 && pricearray.count == 0   {
            let label: UILabel = UILabel()
            label.text = "Data Is not available"
            label.font = .systemFont(ofSize: 16)
            label.textColor = .black
            label.textAlignment = .center
            label.numberOfLines = 1
            menuTableView.backgroundView = label
            return 0
        } else {
            menuTableView.backgroundView = nil
            return nameArray.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.menuTableView.dequeueReusableCell(withIdentifier: "MenuTableViewCell") as?  MenuTableViewCell else{
            return UITableViewCell()
        }
        cell.menuNameLabel.text = nameArray[indexPath.row]
        cell.menuDescriptionLabel.text = descArray[indexPath.row]
        cell.menuPriceLabel.text = pricearray[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            menuTableView.beginUpdates()
            nameArray.remove(at: indexPath.row)
            descArray.remove(at: indexPath.row)
            pricearray.remove(at: indexPath.row)
            menuTableView.deleteRows(at: [indexPath], with: .fade)
            menuTableView.endUpdates()
        }
    }
}
//MARK: Backward Data Passing Protocol
extension ViewController: BackwardDataPassingProtocol
{
    func passData(menu: String?, description: String?, price: String?)  {
        nameArray.append(menu ?? "")
        descArray.append(description ?? "")
        pricearray.append(price ?? "")
        menuTableView.reloadData()
    }
}



