//
//  ViewModelAlimentos.swift
//  AulaTeste
//
//  Created by Turma02-27 on 24/07/25.
//

import Foundation

class ViewModelAlimentos: ObservableObject {
    @Published var food: [alimentacao] = []
    @Published var isLoading = false
    
    func fetch() {
        guard let url = URL(string: "http://192.168.128.92:1880/alimentos") else {
            return
        }
        
        DispatchQueue.main.async {
            self.isLoading = true
        }

        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            DispatchQueue.main.async {
                self?.isLoading = false
            }
            
            guard let data = data, error == nil else {
                return
            }

            do {
                let parsed = try JSONDecoder().decode([alimentacao].self, from: data)
                DispatchQueue.main.async {
                    self?.food = parsed
                }
            } catch {
                print(error)
            }
        }

        task.resume()
    }
}

