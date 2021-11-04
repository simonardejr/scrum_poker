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
        return RxAlamofire.requestDecodable(.post, "\(kBaseURL)/sprint").map { (response, sprint: Sprint) in
            return sprint
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
