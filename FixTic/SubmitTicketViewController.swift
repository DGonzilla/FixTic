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
        
        
        
        //*** Verifies if following fields contain inputs
        if (self.selectedTicketCategory == "" || self.selectedTicketCategory == "Please Select Category" || self.studentTicketNotes.text! == "Hello, I’m currently locked out (application name). Please assist in unlocking my account..."){
            
            print("Conditions weren't met\n", selectedTicketCategory, self.studentTicketNotes.text!)
            //*** Segue to error screen if conditions aren't met
            self.performSegue(withIdentifier: "StudentSubmitTicketError", sender: self)
        }
            
        else{
            
            
            //*** Creates database Document
            // Declares database
            let db = Firestore.firestore()
            let settings = db.settings
            settings.areTimestampsInSnapshotsEnabled = true
            db.settings = settings
            
            
            let dictionary : [String : Any] = ["Assigned Technician Name" : "Not Assigned",
                                               "Category" : self.selectedTicketCategory,
                                               "Date Submitted" : self.dateSubmitted,
                                               "Description" : self.studentTicketNotes.text!,
                                               "Student Username" : self.userEmail,
                                               "Technician Notes" : "A Technician will be assigned shortly",
                                               "Ticket Status" : self.ticketStatus]
            // Writes info to database
            db.collection("fix_tickets").document().setData(dictionary)

           // Segues to Student Confirmation View
            self.performSegue(withIdentifier: "StudentConfirmationViewSegue", sender: self)
        }
        
        
        
        
        
        
    }
    
    
    // Declares variables to be used
    var userEmail = ""
    var userFirstName = ""
    var userLastName = ""
    var userType = ""
    var dateSubmitted = ""
    var ticketStatus = "Open"
    
    // Declares variables used to grab current date
    var date = Date()
    var formatter = DateFormatter()
    
    
    
    
    
    
    
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
        
        // Grabs date
        getCurrentDate()
        
        
        
    }
    
    
    
    
    // Sends SubmitTicketViewController, StudentTicketSubmittedReturnToStudentMainView, or
    // StudentFixTicErrorViewController the user's information depending on thier selection
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ReturnToStudentMenuView" {
            
            
            let studentMainViewController = segue.destination as! StudentMainViewController
            studentMainViewController.userEmail = userEmail
            studentMainViewController.userFirstName = userFirstName
            studentMainViewController.userLastName = userLastName
            studentMainViewController.userType = userType
        }
            
        else if segue.identifier == "StudentSubmitTicketError" {
            
            
            let studentFixTicErrorViewController = segue.destination as! StudentFixTicErrorViewController
            studentFixTicErrorViewController.userEmail = userEmail
            studentFixTicErrorViewController.userFirstName = userFirstName
            studentFixTicErrorViewController.userLastName = userLastName
            studentFixTicErrorViewController.userType = userType
        }
        
        else if segue.identifier == "StudentConfirmationViewSegue" {
            
            
            let studentConfirmationViewController = segue.destination as! StudentConfirmationViewController
            studentConfirmationViewController.userEmail = userEmail
            studentConfirmationViewController.userFirstName = userFirstName
            studentConfirmationViewController.userLastName = userLastName
            studentConfirmationViewController.userType = userType
        }

    }
    
    
    
    
    
    // Function to grab current date
    func getCurrentDate(){
        formatter.dateFormat = "MM/dd"
        dateSubmitted = formatter.string(from: date)
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

