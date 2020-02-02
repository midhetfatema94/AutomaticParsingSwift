//
//  ViewController.swift
//  AutomatincParsing
//
//  Created by Waveline Media on 2/2/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var profileTF: UITextField!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var imageUrlLbl: UILabel!
    @IBOutlet weak var locationLbl: UILabel!
    @IBOutlet weak var followersLbl: UILabel!
    @IBOutlet weak var repoCountLbl: UILabel!
    
    var profile: GithubProfile?
    
    @IBAction func showDetails(_ sender: UIButton) {
        fetchProfile(username: profileTF.text ?? "", completionHandler: {[weak self] profileDetails in
            DispatchQueue.main.async {
                self?.profile = profileDetails
                self?.configureProfile()
            }
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    func fetchProfile(username: String, completionHandler: @escaping (GithubProfile?) -> Void) {
        
        let endPoint = "https://api.github.com/users/\(username)"
        
        guard let url = URL(string: endPoint) else {
            print("Error in creating url")
            return
        }
        
        let urlRequest = URLRequest(url: url)
        let session = URLSession(configuration: .default)
        session.dataTask(with: urlRequest) {(data, responseURL, error) in
            if error != nil {
                return
            }
            
            if let responseData = data {
                do {
                    let decoder = JSONDecoder()
                    let profileData = try decoder.decode(GithubProfile.self, from: responseData)
                    completionHandler(profileData)
                } catch let error {
                    print("Error: ", error.localizedDescription)
                }
            }
        }.resume()
    }
    
    func configureProfile() {
        nameLbl.text = profile?.name
        imageUrlLbl.text = profile?.avatarUrl?.absoluteString
        locationLbl.text = profile?.location
        followersLbl.text = "\(profile?.followers ?? 0)"
        repoCountLbl.text = "\(profile?.repos ?? 0)"
    }
}

