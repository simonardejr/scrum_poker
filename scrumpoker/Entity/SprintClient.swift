//
//  SprintClient.swift
//  scrumpoker
//
//  Created by Simonarde Lima on 02/11/21.
//

import Foundation
import RxSwift
import RxAlamofire

struct SprintClient {
    
    static let kBaseURL = "https://scrum-deck-backend.herokuapp.com"
    
    static func fetchAllSprints() -> Observable<[Sprint]> {
        print("Fetch all Sprints SprintClient")
        return RxAlamofire.requestDecodable(.get, "\(kBaseURL)/sprint").map { (response, sprints: [Sprint]) in
            return sprints
        }
    }
    
    static func fetchSprint(by id: Int) -> Observable<Sprint> {
        return RxAlamofire.requestDecodable(.get, "\(kBaseURL)/sprint/\(id)").map { (response, sprint: Sprint) in
            return sprint
        }
    }
    
    static func addSprint(sprint: Sprint) -> Observable<Sprint> {
        print(sprint.nome)
        let jsonData = try? JSONEncoder().encode(sprint)
        var request = URLRequest(url: URL(string: "\(kBaseURL)/sprint")!)
            request.httpBody = jsonData
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return RxAlamofire.request(request).responseJSON().map { (response) in
            print(response.result)
            return try response.result.get() as? Sprint ?? sprint
        }
    }

    static func deleteSprint(by id: Int) -> Observable<Sprint> {
        print("Delete sprint Client")
        print(id)
        return RxAlamofire.requestDecodable(.delete, "\(kBaseURL)/sprint/\(id)").map { (response, sprint: Sprint) in
            return sprint
        }
    }

}
