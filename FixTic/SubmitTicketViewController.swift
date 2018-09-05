import UIKit
import Firebase
import FirebaseFirestore

class SubmitTicketViewController: UIViewController, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate {

    
    @IBOutlet weak var studentTicketNotes: UITextView!
    @IBOutlet weak var studentTicketCategory: UITextField!
    
    
    @IBAction func studentTicketSubmit(_ sender: UIButton) {
        
        
        
    }
    
    
    
    // Declares user type variable (Student or Technician) for UIPicker to display
    let ticketCategories = ["Hardware","Application Issue", "Password Reset", "Email Issue", "Connectivity", "Other"]
    var selectedTicketCategory = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()



        self.studentTicketCategory.delegate = self
        studentTicketNotes.delegate = self as? UITextViewDelegate

        
        
        // Used for UIPicker
        createUserTypePicker()
        createToolBar()


    }
    
    

    
    
    
    
    
    //*** Creates userType Picker
    func createUserTypePicker(){
        let userTypePicker = UIPickerView()
        userTypePicker.delegate = self

        studentTicketCategory.inputView = userTypePicker
        userTypePicker.backgroundColor = .white
    }

    //*** Creates userType Toolbar
    func createToolBar(){

        let toolBar = UIToolbar()
        toolBar.sizeToFit()

        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(SubmitTicketViewController.dismissKeyboard))

        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true

        studentTicketCategory.inputAccessoryView = toolBar
    }

    @objc func dismissKeyboard(){
        view.endEditing(true)
    }




    //*** Functions for PickerView
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return ticketCategories[row]
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return ticketCategories.count
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

        selectedTicketCategory = ticketCategories[row]
        studentTicketCategory.text = selectedTicketCategory
    }


    
    
    
    
    

    
    
    
    
    
    
    
    //*** Hides keyboard when user touches outside keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
    }
    
    //*** Hides keyboard when user presses return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        
        studentTicketCategory.resignFirstResponder()
        studentTicketNotes.resignFirstResponder()
        return true
    }

}
