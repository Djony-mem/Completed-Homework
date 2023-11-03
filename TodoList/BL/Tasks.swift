//
//  Tasks.swift

import Foundation

enum Task {
	case regular(RegularTask)
	case important(ImportantTask)
}

// Призма для упрощенного доступа к completed и title
extension Task {
	var completed: Bool {
		switch self {
		case .regular(let task):
			return task.completed
		case .important(let task):
			return task.completed
		}
	}

	var title: String {
		switch self {
		case .regular(let task):
			return task.title
		case .important(let task):
			return task.title
		}
	}
}

struct RegularTask {
	var title: String
	var completed = false
}

struct ImportantTask {
	enum TaskPriority: Int {
		case low
		case medium
		case high
	}

	enum TaskStatus {
		case notStarted
		case completed
		case canceled
		case paused
	}

	var deadLine: Date {
		switch taskPriority {
		case .low:
			return Calendar.current.date(byAdding: .day, value: 3, to: date)! // swiftlint:disable:this force_unwrapping
		case .medium:
			return Calendar.current.date(byAdding: .day, value: 2, to: date)! // swiftlint:disable:this force_unwrapping
		case .high:
			return Calendar.current.date(byAdding: .day, value: 1, to: date)! // swiftlint:disable:this force_unwrapping
		}
	}

	var date: Date
	var taskPriority: TaskPriority
	var title: String
	var status: TaskStatus

	init(title: String, date: Date, taskPriority: TaskPriority) {
		self.title = title
		self.taskPriority = taskPriority
		self.date = date
		status = .notStarted
	}
}

// Призма для вычисления статуса в виде completed
extension ImportantTask {
	var completed: Bool {
		status == .completed
	}
}

// Протокол для реализации сравнения двух RegularTask. Чтобы они были равны, их поля должны быть равны.
extension RegularTask: Equatable {
	static func == (lhs: RegularTask, rhs: RegularTask) -> Bool {
		return lhs.title == rhs.title && lhs.completed == rhs.completed
	}
}

// Протокол для реализации сравнения двух ImportantTask. Чтобы они были равны, их поля должны быть равны.
extension ImportantTask: Equatable {
	static func == (lhs: ImportantTask, rhs: ImportantTask) -> Bool {
		return lhs.title == rhs.title &&
		lhs.date == rhs.date &&
		lhs.taskPriority == rhs.taskPriority &&
		lhs.status == rhs.status
	}
}

// Сравнение двух вариантов задач с учетм постановки ранних ДЗ.
extension Task: Comparable {
	static func < (lhs: Task, rhs: Task) -> Bool {
		switch (lhs, rhs) {
		case (.important(let leftImportant), .important(let rightImportant)):
			return leftImportant.taskPriority.rawValue > rightImportant.taskPriority.rawValue
		case (.important, .regular):
			return true
		default:
			return false
		}
	}
}

struct Person {
	let name: String
	let surname: String
}
