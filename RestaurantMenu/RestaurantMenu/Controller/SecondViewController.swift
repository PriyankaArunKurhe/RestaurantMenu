
import UIKit
class SecondViewController: UIViewController {
    //MARK: Outlets
    @IBOutlet weak var menuNameTF: UITextField!
    @IBOutlet weak var menuDescriptionTF: UITextField!
    @IBOutlet weak var menuPriceTF: UITextField!
    
    //MARK: Delegate Variable
    weak var delegeteSVC: BackwardDataPassingProtocol?
    //MARK: Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        self.view.backgroundColor = UIColor.cyan
    }
    //MARK: Button Action Method
    @IBAction func saveData(_ sender: Any) {
        guard let delegate = delegeteSVC else
        {
            return
        }
        if(menuNameTF.text != "" && menuDescriptionTF.text != "" && menuPriceTF.text != "" )  {
            let dataToPassL1 = self.menuNameTF.text
            let dataToPassL2 = self.menuDescriptionTF.text
            let dataToPassL3 = self.menuPriceTF.text
            var total = delegate.passData(menu: dataToPassL1, description: dataToPassL2, price: dataToPassL3)
            let alert = UIAlertController(title: "Succeeded", message: "Data Save Successfully...", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: { action in
                self.navigationController?.popViewController(animated: true)}))
            self.present(alert, animated: true, completion: nil)
        }
        else {
            let alert = UIAlertController(title: "Cancelled", message: "Fill the data", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)    }
    }
    
}

