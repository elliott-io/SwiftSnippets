//
//  SnippetManager.swift
//  StoryboardSnippets
//
//  Created by Elliott Io on 4/25/20.
//  Copyright © 2020 elliott io. All rights reserved.
//

import Foundation

class SnippetManager {
    
    static let shared = SnippetManager()
    
    func readDataFromFile(_ fileName: String, type: String = "json") -> Data?
    {
        if let path = Bundle.main.path(forResource: fileName, ofType: type) {
            do {
                let fileUrl = URL(fileURLWithPath: path)
                // Getting data from the file using the file URL
                let data = try Data(contentsOf: fileUrl)
                return data
            } catch {
                // Handle error here
                print("error: ", error)
            }
        }
        return nil
    }
    
    func loadSnippets() -> [Snippet] {
        guard let jsonData = readDataFromFile("snippets") else { return [] }
        let decoder = JSONDecoder()
        var snippets: [Snippet]?
        do {
            snippets = try decoder.decode([Snippet].self, from: jsonData)
        } catch let DecodingError.dataCorrupted(context) {
            print(context)
        } catch let DecodingError.keyNotFound(key, context) {
            print("Key '\(key)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch let DecodingError.valueNotFound(value, context) {
            print("Value '\(value)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch let DecodingError.typeMismatch(type, context)  {
            print("Type '\(type)' mismatch:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch {
            print("error: ", error)
        }
        
        return snippets ?? []
    }
}
