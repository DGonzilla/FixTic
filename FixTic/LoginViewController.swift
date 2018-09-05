import UIKit
import Firebase
import FirebaseFirestore


class LoginViewController: UIViewController, UITextFieldDelegate {
    
    //*** Connects email and password fields
    @IBOutlet weak var userEmailField: UITextField!
    @IBOutlet weak var userPasswordField: UITextField!
    
    
    
    //*** Signs User into account
    @IBAction func signUserIn(_ sender: UIButton) {
        
        
        self.login()
        
    }
    
    
    
    //*** Function used to login
    func login(){
        
        Auth.auth().signIn(withEmail: userEmailField.text!, password: userPasswordField.text!, completion: {
            user, error in
            
            if error != nil {
                
                //*** Error message displayed & segue to Sign Up/In Error View
                print("Error in login Attempt!")
                self.performSegue(withIdentifier: "SignInErrorViewSegue", sender: self)
            }
            else{
                print("It Worked!")
                
                
                
                
                //*** Declares database to access
                let db = Firestore.firestore()
                let settings = db.settings
                settings.areTimestampsInSnapshotsEnabled = true
                db.settings = settings
                
                
                
                //*** Queries Data from database to prepare for segue
                db.collection("users").document(self.userEmailField.text!).getDocument { (document, error) in
                    if let document = document, document.exists {
                        _ = document.data().map(String.init(describing:)) ?? "nil"
                        let account: String = document.data()!["Account Type"] as! String
                        
                        
                        
                        
                        //*** Determines whether User is Student or Technician... Segues accordingly
                        if (account == "Student"){
                            self.performSegue(withIdentifier: "LoginStudentMainViewSegue", sender: self)
                            
                        }
                        else if (account == "Technician"){
                            
                            self.performSegue(withIdentifier: "LoginTechMainViewSegue", sender: self)
                        }
                        
                    } else {
                        print("Document does not exist")
                    }
                }
            }
        })
    }
    
    
    
    
    //*** Sign-Up button // Transitions to Sign-up View
    @IBAction func SignUpButtonPressed(_ sender: Any) {
        
        print ("Button pressed")
        self.performSegue(withIdentifier: "SignUpViewSegue", sender: self)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //*** Simple print statement to ensure screen loaded
        print("Login Screen has loaded :)")
        
        self.userEmailField.delegate = self
        self.userPasswordField.delegate = self
    }
    
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    //*** Hides keyboard when user touches outside keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //*** Hides keyboard when user presses return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        userEmailField.resignFirstResponder()
        userPasswordField.resignFirstResponder()
        return (true)
    }
    
    
    
    
    
}


