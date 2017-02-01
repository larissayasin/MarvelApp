//
//  ViewController.swift
//  PersonagensMarvel
//
//  Created by Larissa Gonçalves on 27/01/17.
//  Copyright © 2017 LarissaYasin. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON

class ListaViewController: UIViewController,  UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var carregando: UIActivityIndicatorView!
    @IBOutlet weak var pesquisa: UISearchBar!
    @IBOutlet weak var resultado: UITableView!
    var pesquisaAtiva : Bool = false
    var dadosBusca = [Personagem]()
    let marvelAPI = MarvelApi()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pesquisa.delegate = self
        resultado.delegate = self
        resultado.dataSource = self
        
        resultado.backgroundView = UIImageView(image: UIImage(named: "marvelstudio"))
        carregando.isHidden = true
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        pesquisaAtiva = true;
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        pesquisaAtiva = false;
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        pesquisaAtiva = false;
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        pesquisaAtiva = false;
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if(!pesquisaAtiva){
            carregando.isHidden = false
            carregando.startAnimating()
            self.dadosBusca.removeAll()
            let url = marvelAPI.buscarURL(busca: searchText)
            Alamofire.request(url, method: .get).validate().responseJSON { response in
                switch response.result {
                case .success(let value):
                    
                    let json = JSON(value)
                    //json["data"]["results"][0]
                    if let items = json["data"]["results"].array {
                        for item in items {
                            let id = item["id"].int
                            let nome = item["name"].string
                            let descricao = item["description"].string
                            let imagem = item["thumbnail"]["path"].string! + self.marvelAPI.imageSize + item["thumbnail"]["extension"].string!
                            let publicacoes = item["comics"]["available"].int
                            
                            let person = Personagem(id: id, nome: nome, descricao: descricao, imagem: imagem, publicacoes: publicacoes)
                            self.dadosBusca += [person]
                        }
                        
                        self.resultado.reloadData()
                        
                        self.carregando.isHidden = true
                        self.carregando.stopAnimating()
                    }
                    print("JSON: \(json)")
                case .failure(let error):
                    self.carregando.isHidden = true
                    self.carregando.stopAnimating()
                    let alertController = UIAlertController(title: "", message: "Tente novamente", preferredStyle: .alert)
                    
                    let OKAction = UIAlertAction(title: "OK", style: .default) { action in
                    }
                    alertController.addAction(OKAction)
                    
                    self.present(alertController, animated: true)
                    print("ERRO:  \(error)")
                }
            }
        }
    }
    
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dadosBusca.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "personagemCell") as! PersonagemTableViewCell;
        let row = indexPath.row
        
        cell.nome.text = dadosBusca[row].nome
        
        let url = URL(string:  dadosBusca[row].imagem!)!
        //    let placeholderImage = UIImage(named: "placeholder")!
        
        cell.imagem.af_setImage(withURL: url)
        
        // cell.imagem = marvelAPI.buscarImagemPersonagem(urlImg: dadosBusca[row].imagem!, imgView: cell.imagem)
        
        cell.publicacoes.text = String(describing: dadosBusca[row].publicacoes!)
        
        
        return cell;
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! PersonagemTableViewCell // or your cell subclass
        let indexPath = self.resultado.indexPath(for: cell)
        let p = dadosBusca[(indexPath?.row)!]
        let viewController = segue.destination as! PersonagemViewController
        viewController.personagem = p
    }
    
    
    
}

