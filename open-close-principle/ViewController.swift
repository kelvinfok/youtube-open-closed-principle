//
//  ViewController.swift
//  open-close-principle
//
//  Created by Kelvin Fok on 28/1/23.
//

import UIKit
import FirebaseAnalytics

class ViewController: UIViewController {
  
  private lazy var submitButton: UIButton = {
    let button = UIButton()
    button.addTarget(self, action: #selector(submitButtonTapped), for: .touchUpInside)
    return button
  }()
  
  private lazy var anotherButton: UIButton = {
    let button = UIButton()
    button.addTarget(self, action: #selector(anotherButtonTapped), for: .touchUpInside)
    return button
  }()
  
  private let closedTracker = ClosedTracker.shared
  private let openTracker = OpenTracker.shared
  
  override func viewDidLoad() {
    super.viewDidLoad()
    closedTracker.track(event: .viewLoaded, params: nil)
    // 1. track event
  }
  
  @objc private func submitButtonTapped() {
    closedTracker.track(event: .submitButtonTapped, params: nil)
    // 2. track event
  }

  @objc private func anotherButtonTapped() {
    // 3. track event
    openTracker.track(event: .init(name: "anotherButtonTapped"), params: nil)
  }
}

enum CloseAnalyticEvent: String {
  case viewLoaded
  case submitButtonTapped
}

class ClosedTracker {
  // Non-Open close principle here
  typealias FIRAnalytics = FirebaseAnalytics.Analytics
  
  static let shared = ClosedTracker()
  private init() {}
  
  func track(event: CloseAnalyticEvent, params: [String: Any]?) {
    FIRAnalytics.logEvent(event.rawValue, parameters: params)
  }
  
}

struct OpenAnalyticEvent {
  let name: String
  static let viewLoaded: Self = .init(name: "viewLoaded")
  static let submitButtonTapped: Self = .init(name: "submitButtonTapped")
}

class OpenTracker {
  // Open close principle here
  typealias FIRAnalytics = FirebaseAnalytics.Analytics

  static let shared = OpenTracker()
  private init() {}
  
  func track(event: OpenAnalyticEvent, params: [String: Any]?) {
    FIRAnalytics.logEvent(event.name, parameters: params)
  }
}
