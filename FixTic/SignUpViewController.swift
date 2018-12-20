import UIKit
import Firebase
import FirebaseFirestore

class SignUpViewController: UIViewController, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    
    
    
    //*** Textfields (email, passwords, names, and type)
    @IBOutlet weak var userEmailField: UITextField!
    @IBOutlet weak var userPasswordField: UITextField!
    @IBOutlet weak var userConfirmPasswordField: UITextField!
    @IBOutlet weak var userFirstNameField: UITextField!
    @IBOutlet weak var userLastNameField: UITextField!
    @IBOutlet weak var userTypeField: UITextField!
    
    
    // Declares user type variable (Student or Technician) for UIPicker to display
    let userTypes = ["Please Select","Student","Technician"]
    var selectedUserType = ""
    
    
    
    
    
    //*** Button Pressed *** Attempts to Create user account
    @IBAction func createUserAccount(_ sender: UIButton) {
        
        
        
        //*** Verifies if following fields contain inputs and/or is a match
        if (self.userPasswordField.text! != self.userConfirmPasswordField.text! || self.userEmailField.text! == "" || self.userFirstNameField.text! == "" || self.userLastNameField.text! == "" || self.userTypeField.text! == "" || self.userTypeField.text! == "Please Select"){
            
            //*** Segue to error screen if conditions aren't met
            self.performSegue(withIdentifier: "SignUpErrorViewSegue", sender: self)
        }
            
        else{
            
            //*** Authentication process
            Auth.auth().createUser(withEmail: userEmailField.text!, password: userPasswordField.text!, completion: {
                user, error in
                
                if error != nil {
                    
                    
                    self.login()
                }
                else{
                    
                    //*** Everything went smoothly
                    print("User created successfully :)")
                    self.login()
                    
                    
                    
                    
                    //*** Creates database Document
                    // Declares database
                    let db = Firestore.firestore()
                    let settings = db.settings
                    settings.areTimestampsInSnapshotsEnabled = true
                    db.settings = settings
                    
                    
                    let dictionary : [String : Any] = ["First Name" : self.userFirstNameField.text!,
                                                       "Last Name" : self.userLastNameField.text!,
                                                       "Email" : self.userEmailField.text!,
                                                       "Account Type" : self.userTypeField.text!]
                    // Writes info to database
                    db.collection("users").document(self.userEmailField.text!).setData(dictionary)
                    
                    
                    
                    
                    
                    
                    // Determines whether User is Student or Technician... Segues accordingly
                    if (self.userTypeField.text! == "Student"){
                        self.performSegue(withIdentifier: "StudentMainViewSegue", sender: self)
                        
                    }
                    else if (self.userTypeField.text! == "Technician"){
                        
                        self.performSegue(withIdentifier: "TechMainViewSegue", sender: self)
                    }
                    
                    
                    print(self.userTypeField.text!)
                }
            })
            
        }
        
        
        
    }
    
    
    //*** Function to log user in
    func login(){
        
        Auth.auth().signIn(withEmail: userEmailField.text!, password: userPasswordField.text!, completion: {
            user, error in
            
            if error != nil {
                
                //*** Error message displayed & segue to Sign Up/In Error View
                print("Error in login Attempt!")
                self.performSegue(withIdentifier: "SignUpErrorViewSegue", sender: self)
                
            }
            else{
                print("It Worked!")
            }
            
        })
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.userEmailField.delegate = self
        self.userPasswordField.delegate = self
        self.userConfirmPasswordField.delegate = self
        self.userFirstNameField.delegate = self
        self.userLastNameField.delegate = self
        
        // Used for UIPicker
        createUserTypePicker()
        createToolBar()
        
        
        
        
        
    }
    
    
    
    
    
    //*** Creates userType Picker
    func createUserTypePicker(){
        let userTypePicker = UIPickerView()
        userTypePicker.delegate = self
        
        userTypeField.inputView = userTypePicker
        userTypePicker.backgroundColor = .white
    }
    
    //*** Creates userType Toolbar
    func createToolBar(){
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(SignUpViewController.dismissKeyboard))
        
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        userTypeField.inputAccessoryView = toolBar
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
    
    
    
    
    //*** Functions for PickerView
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return userTypes[row]
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return userTypes.count
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        selectedUserType = userTypes[row]
        userTypeField.text = selectedUserType
    }
    
    
    
    
    
    
    //*** Prepares information to provide to StudentMainViewController or TechMainViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "StudentMainViewSegue") {
            
            let studentMainViewController = segue.destination as! StudentMainViewController
            studentMainViewController.userFirstName = userFirstNameField.text!
            studentMainViewController.userLastName = userLastNameField.text!
            studentMainViewController.userEmail = userEmailField.text!
            studentMainViewController.userType = userTypeField.text!
            
        }
        else if (segue.identifier == "TechMainViewSegue") {
            
            let techMainViewController = segue.destination as! TechMainViewController
            techMainViewController.userFirstName = userFirstNameField.text!
        }
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    
    
    
    
    
    /////////////////   Keyboard Functions ////////////////////////
    
    //*** Hides keyboard when user touches outside keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
    }
    
    //*** Hides keyboard when user presses return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        userEmailField.resignFirstResponder()
        userPasswordField.resignFirstResponder()
        userConfirmPasswordField.resignFirstResponder()
        userFirstNameField.resignFirstResponder()
        userLastNameField.resignFirstResponder()
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
    
    /////////////////   Keyboard Functions Ending ////////////////////////
    
}



