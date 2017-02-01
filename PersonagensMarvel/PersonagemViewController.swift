//
//  PersonagemViewController.swift
//  PersonagensMarvel
//
//  Created by Larissa Gonçalves on 01/02/17.
//  Copyright © 2017 LarissaYasin. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class PersonagemViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate  {
    
    var personagem : Personagem!
    
    @IBOutlet weak var imagem: UIImageView!
    @IBOutlet weak var nome: UILabel!
    @IBOutlet weak var publicacoes: UILabel!
    
    @IBOutlet weak var header: UIView!
    
    @IBOutlet weak var colecao: UICollectionView!
    var hqsCapas = [String]();
    
    let marvelAPI = MarvelApi()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colecao.delegate = self
        self.header.backgroundColor = UIColor(patternImage: UIImage(named: "comics")!)
        
        
        let url = URL(string: personagem.imagem!)
        //    let placeholderImage = UIImage(named: "placeholder")!
        
        imagem.af_setImage(withURL: url!)
        
        nome.text = personagem.nome
        publicacoes.text = String(personagem.publicacoes ?? 0)
        carregarCapas()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func carregarCapas(){
        let url = marvelAPI.buscarHqsURL(idPersonagem: personagem.id!)
        Alamofire.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                
                let json = JSON(value)
                //json["data"]["results"][0]
                if let items = json["data"]["results"].array {
                    for item in items {
                        let imagem = item["thumbnail"]["path"].string! + self.marvelAPI.imagePortraitSize + item["thumbnail"]["extension"].string!
                        self.hqsCapas += [imagem]
                    }
//                    var indexPaths = [IndexPath]()
//                    self.colecao.reloadItems(at: indexPaths)
                    self.colecao.reloadData()
                }
                print("JSON: \(json)")
            case .failure(let error):
                print("ERRO:  \(error)")
            }
            
        }
        
    }
    
    // tell the collection view how many cells to make
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.hqsCapas.count
    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "hqCell", for: indexPath as IndexPath) as! HqCollectionViewCell
        cell.revista = marvelAPI.buscarImagemPersonagem(urlImg: self.hqsCapas[indexPath.item], imgView: cell.revista)
        return cell
    }
    
    // MARK: - UICollectionViewDelegate protocol
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
