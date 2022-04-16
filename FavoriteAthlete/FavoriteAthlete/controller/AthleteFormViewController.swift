//
//  AthleteFormViewController.swift
//  FavoriteAthlete
//
//  Created by Edgar on 13.04.22.
//

import UIKit

class AthleteFormViewController: UIViewController {
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var leagueTextField: UITextField!
    @IBOutlet weak var teamTextField: UITextField!
    
    var athlete: Athlete?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateView()
    }
    
    init?(coder: NSCoder, athlete: Athlete?) {
        super.init(coder: coder)
        self.athlete = athlete
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.athlete = nil
    }
    
    
    @IBAction func saveButtonClicked(_ sender: UIButton) {
        guard let name = nameTextField.text,
              let ageStr = ageTextField.text,
              let age = UInt(ageStr),
              let league = leagueTextField.text,
              let team = teamTextField.text
        else {
            return
        }
        athlete = Athlete(name: name, age: age, league: league, team: team)
        
        performSegue(withIdentifier: "unwindIdentifier", sender: self)
    }
    
    func updateView() {
        if let athlete = athlete {
            nameTextField.text = athlete.name
            ageTextField.text = String(athlete.age)
            leagueTextField.text = athlete.league
            teamTextField.text = athlete.team
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
