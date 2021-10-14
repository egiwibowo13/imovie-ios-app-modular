//
//  LandingPresenter.swift
//  imovie
//
//  Created by Egi Wibowo on 27/09/21.
//

import Foundation
import SwiftUI

class LandingPresenter: ObservableObject {
  @Published var isActive = false
  
  init() {
    goToAppWithDelay()
  }
  
  func goToAppWithDelay() {
    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) { // Change `2.0` to the desired number of seconds.
       // Code you want to be delayed
      self.isActive = true
    }
  }
}

struct Project {
  let projectId: String
  let status: String
  let detailProject: String
}

protocol ActivityUser {
  func edit(activity: Activity)
  
}

struct Activity: ActivityUser {
  func edit(activity: Activity) {
    
  }
  
  let activityId: String
  let description: String
}

protocol User {
  func update(projectId: String)
}

struct Coba {
  let activity = Activity(activityId: "1", description: "description")
  func a() {
    activity.edit(activity: activity)
  }
}
