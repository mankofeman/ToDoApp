//
//  SceneDelegate.swift
//  ToDo
//
//  Created by Alex Smith on 11.02.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
	
	var window: UIWindow?
	
	func scene(_ scene: UIScene,
			   willConnectTo session: UISceneSession,
			   options connectionOptions: UIScene.ConnectionOptions) {
		
		guard let windowScene = (scene as? UIWindowScene) else { return }
		
		let window = UIWindow(windowScene: windowScene)
		let navigation = UINavigationController(rootViewController: assembly())
		let appearance = UINavigationBarAppearance()
		
		navigation.navigationBar.scrollEdgeAppearance = appearance
		appearance.backgroundColor = .lightGray
		
		window.rootViewController = navigation
		window.makeKeyAndVisible()
		self.window = window
	}
	
	func assembly() -> UIViewController {
		let view = ToDoTableViewController()
		
		let taskManager = OrderedTaskManager(taskManager: TaskManager())
		let repository: ITaskRepository = TaskRepositoryStub()
		taskManager.addTasks(tasks: repository.getTasks())
		let sections = TaskManagerSectionsAdapter(taskManager: taskManager)
		let presenter = ToDoPresenter(view: view, sectionManager: sections)
		view.presenter = presenter
		return view
	}
	
	func sceneDidDisconnect(_ scene: UIScene) { }
	
	func sceneDidBecomeActive(_ scene: UIScene) { }
	
	func sceneWillResignActive(_ scene: UIScene) { }
	
	func sceneWillEnterForeground(_ scene: UIScene) { }

	func sceneDidEnterBackground(_ scene: UIScene) { }
}

