//
//  ViewController.swift
//  HeroesAPI
//
//  Created by Saúl Pérez on 07/02/22.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    @IBOutlet weak var tableView: UITableView!
    
    var heroes = [HeroStats]()
    var libros = [LibroData]()
    var libroTitulo = [VolumeInfo?]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        parse()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return libros.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = libroTitulo[indexPath.row]?.title.capitalized //titulo del libro
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetails", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? HeroViewController {
            destination.hero = heroes[(tableView.indexPathForSelectedRow?.row)! ]
        }
    }
    
//    func downloadJSON(completed: @escaping () -> ()){
//        let url = URL(string: "https://api.opendota.com/api/heroStats")
//
//        URLSession.shared.dataTask(with: url!){
//            (data, response, error) in
//            if error == nil {
//                do{
//                    self.heroes = try JSONDecoder().decode([HeroStats].self, from: data!)
//                    DispatchQueue.main.async {
//                        completed()
//                    }
//                }catch {
//                    print("JSON EROROR heroes")
//                }
//            }
//
//        }.resume()
//    }
    
    func downloadJSONBook(completed: @escaping () -> ()){
        let url = URL(string: "https://www.googleapis.com/books/v1/volumes?q=baldor")
        
        URLSession.shared.dataTask(with: url!){
            (data, response, error) in
            if error == nil {
                do{
                    self.libros = try JSONDecoder().decode([LibroData].self, from: data!)
                    DispatchQueue.main.async {
                        completed()
                    }
                }catch {
                    print("JSON EROROR libros")
                }
            }
            
        }.resume()
    }// func
    
    
    func parse(bookData: Data) -> LibroModelFinal? {
        let api = URL(string: "https://www.googleapis.com/books/v1/volumes?q=baldor")
        
        URLSession.shared.dataTask(with: api!){
            data, response, error in
            
        if error != nil{
            print(error?.localizedDescription)
            print("no funcionó")
            return
        }
        do{
            let result = try JSONDecoder().decode(VolumeInfo.self, from: data!)

            print("Parse func result:")
            print(result)
            
            
            let titleLibroFinal = result.title
            //let authorsLibro = result.authors
            let publishedDateLibro = result.publishedDate
            //let categoriesLibro = result.categories
           // let thumbnailLibro = result
            //let descriptionLibro: String?
            
            let bookId = LibroModelFinal(titleLibro: titleLibroFinal, publishedDateLibro: publishedDateLibro)
            print(titleLibroFinal)
            
         return
        } catch{print("error")
            
        }
            } .resume()
    }// func parse
    
    
    
    
    
//    enum LibrosError:Error {
//        case noDataAvailable
//        case canNotProcessData
//    }
//    var resourceURL = URL(string: "https://www.googleapis.com/books/v1/volumes?q=baldor")
//
//    func getHolidays (completion: @escaping(Result<[VolumeInfo], LibrosError>) -> Void) {
//        let dataTask = URLSession.shared.dataTask(with: resourceURL) { data, _, _ in
//            guard let jsonData = data else {
//                completion(.failure(.noDataAvailable))
//                return
//            }
//
//            do {
//                let decoder = JSONDecoder()
//                let bookResponse = try decoder.decode(VolumeInfo.self, from: jsonData)
//                let bookDetails = bookResponse.response.volumeInfo
//                completion(.success(bookResponse))
//            }catch{
//                completion(.failure(.canNotProcessData))
//            }
//
//        }
//        dataTask.resume()
//    }

}

