import Foundation
import UIKit

class CharactersDataSource {
    var favoriteCharacter: [ImageItem] = []
    
    func loadItems(url: String,
                   success: @escaping ([ImageItem]) -> (),
                   error: @escaping () -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            guard let url = URL(string: url) else {
                error()
                return
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                guard error == nil else {
                    fatalError("Erro na requisição HTTP: \(error!)")
                }
                
                guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                    fatalError("Resposta HTTP inválida")
                }
                
                guard let data = data else {
                    fatalError("Dados inválidos")
                }
                
                do {
                    let decoder = JSONDecoder()
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                    
                    if let results = json?["results"] as? [[String: Any]] {
                        let postData = try JSONSerialization.data(withJSONObject: results, options: [])
                        let posts = try decoder.decode([ImageItem].self, from: postData)
                        success(posts)
                    } else {
                        fatalError("Formato de JSON inválido")
                    }
                } catch {
                    fatalError("Erro na decodificação do JSON: \(error)")
                }
            }.resume()
        }
    }
    
    func setData(favoriteCharacter: [ImageItem]) {
        self.favoriteCharacter = favoriteCharacter
    }
    
    func addItem(character: ImageItem){
        self.favoriteCharacter.append(character)
    }
}
