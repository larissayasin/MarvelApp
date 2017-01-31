//
//  ViewController.swift
//  PersonagensMarvel
//
//  Created by Larissa Gonçalves on 27/01/17.
//  Copyright © 2017 LarissaYasin. All rights reserved.
//

import UIKit

class ListaViewController: UIViewController,  UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
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
            marvelAPI.buscarPesonagens(busca: searchText)
            self.resultado.reloadData()
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
        //   cell.publicacoes.text = dadosBusca[row].listaHQ.publicacoes ?? "0"
        
        
        return cell;
    }
    
    
}

