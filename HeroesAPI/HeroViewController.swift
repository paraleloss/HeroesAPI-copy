//
//  HeroViewController.swift
//  HeroesAPI
//
//  Created by Saúl Pérez on 07/02/22.
//

import UIKit


extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}

class HeroViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var atributeLbl: UILabel!

    @IBOutlet weak var attackLbl: UILabel!
    @IBOutlet weak var legsLbl: UILabel!
    

    var hero: HeroStats?
    
    override func viewDidLoad() {
        print("llegamos")
        super.viewDidLoad()
        nameLbl.text = hero?.localized_name
        atributeLbl.text =  hero?.primary_attr
        attackLbl.text = hero?.attack_type
        legsLbl.text =  "\((hero?.legs)!)"
        
        let urlString = "https://api.opendota.com" + (hero?.img)!
        let url = URL(string: urlString)
        
        imageView.downloaded(from: url!)
    }
    

}
