import UIKit
import Firebase
import FirebaseFirestore

class SubmitTicketViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    
    
    @IBOutlet weak var studentTicketCategory: UITextField!
    @IBOutlet weak var studentTicketNotes: UITextView!
    
    @IBAction func returnToStudentMainView(_ sender: UIButton) {
        
        print("Return to student button pressed")
        performSegue(withIdentifier: "ReturnToStudentMenuView", sender: self)
    }
    
    
    @IBAction func studentTicketSubmit(_ sender: UIButton) {
        
        
        
        
        
    }
    
    
    // Declares variables to be used
    var userEmail = ""
    var userFirstName = ""
    var userLastName = ""
    var userType = ""
    
    
    
    
    // Declares user type variable (Student or Technician) for UIPicker to display
    let ticketCategories = ["Please Select Category","Hardware","Application Issue", "Password Reset", "Email Issue", "Connectivity", "Other"]
    var selectedTicketCategory = ""
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.studentTicketCategory.delegate = self
        self.studentTicketNotes.delegate = self
        
        
        // Changes to studentTicketNotes TextView
        studentTicketNotes.text = "Hello, I’m currently locked out (application name). Please assist in unlocking my account..."
        studentTicketNotes.textColor = .lightGray
        studentTicketCategory.textAlignment = .center
        
        
        // Used for UIPicker
        createUserTypePicker()
        createToolBar()
        
        
        // Testing user info to be printed
        print("Submit Ticket loaded: ", userFirstName, userLastName, userType, userEmail)
        
        
        
        
    }
    
    
    
    
    // Sends SubmitTicketViewController the user's information
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ReturnToStudentMenuView" {
        
        
            let studentMainViewController = segue.destination as! StudentMainViewController
            studentMainViewController.userEmail = userEmail
            studentMainViewController.userFirstName = userFirstName
            studentMainViewController.userLastName = userLastName
            studentMainViewController.userType = userType
        }
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
        
        
        
        
        
        
        
        
        
        
        
        
        
        /////////////////   Keyboard Functions ////////////////////////
        
        
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
        
        
        // Raises view when keyboard is called
        func textFieldDidBeginEditing(_ textField: UITextField) {
            
            UIView.animate(withDuration: 0.3, animations: {
                self.view.frame = CGRect(x:self.view.frame.origin.x, y:self.view.frame.origin.y - 225, width:self.view.frame.size.width, height:self.view.frame.size.height);
            })
        }
        
        
        
        // Lowers view when finished using keyboard
        func textFieldDidEndEditing(_ textField: UITextField,
                                    reason: UITextField.DidEndEditingReason){
            
            UIView.animate(withDuration: 0.3, animations: {
                self.view.frame = CGRect(x:self.view.frame.origin.x, y:self.view.frame.origin.y + 225, width:self.view.frame.size.width, height:self.view.frame.size.height);        })
        }
        
        
        
        // Raises view when keyboard is called for TextView
        func textViewDidBeginEditing(_ textView: UITextView) {
            
            
            
            // Animation to raise keyboard
            UIView.animate(withDuration: 0.3, animations: {
                self.view.frame = CGRect(x:self.view.frame.origin.x, y:self.view.frame.origin.y - 225, width:self.view.frame.size.width, height:self.view.frame.size.height);
            })
            
            
            // Placeholder for studentTicketNotes
            if (studentTicketNotes.text == "Hello, I’m currently locked out (application name). Please assist in unlocking my account..."
                && studentTicketNotes.textColor == .lightGray)
            {
                studentTicketNotes.text = ""
                studentTicketNotes.textColor = .black
            }
            studentTicketNotes.becomeFirstResponder()
            
        }
        
        
        // Lowers view when finished using keyboard for TextView
        func textViewDidEndEditing(_ textView: UITextView) {
            
            // Animation to lower keyboard
            UIView.animate(withDuration: 0.3, animations: {
                self.view.frame = CGRect(x:self.view.frame.origin.x, y:self.view.frame.origin.y + 225, width:self.view.frame.size.width, height:self.view.frame.size.height);        })
            
            
            // Placeholder for studentTicketNotes when nothing within textfield
            if (studentTicketNotes.text == ""){
                
                studentTicketNotes.text = "Hello, I’m currently locked out (application name). Please assist in unlocking my account..."
                studentTicketNotes.textColor = .lightGray
            }
            
            studentTicketNotes.resignFirstResponder()
        }
        
        /////////////////   Keyboard Functions Ending ////////////////////////
        
        
}

