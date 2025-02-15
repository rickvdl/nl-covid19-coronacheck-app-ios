/*
* Copyright (c) 2021 De Staat der Nederlanden, Ministerie van Volksgezondheid, Welzijn en Sport.
*  Licensed under the EUROPEAN UNION PUBLIC LICENCE v. 1.2
*
*  SPDX-License-Identifier: EUPL-1.2
*/

import UIKit

class BirthdateEntryViewModel: Logging {

	var loggingCategory: String = "BirthdateEntryViewModel"

	/// Coordination Delegate
	weak var coordinator: (BirthdateCoordinatorDelegate & Dismissable)?

	/// The title of the button
	@Bindable private(set) var isButtonEnabled: Bool = false

	/// The error message
	@Bindable private(set) var errorMessage: String?

	/// DescriptionInitializer
	/// - Parameters:
	///   - coordinator: the coordinator delegate
	init(coordinator: (BirthdateCoordinatorDelegate & Dismissable)) {
		
		self.coordinator = coordinator
	}

	/// User tapped on the send button
	func sendButtonTapped() {
		
		guard let year = year, let month = month, let day = day,
			  !year.isEmpty, !month.isEmpty, !day.isEmpty else {
			isButtonEnabled = false
			return
		}

		let dateString = "\(year)-\(month)-\(day)"
		if let date = parseDateFormatter.date(from: dateString) {
			logDebug("Birthdate : \(date)")
			if validateBirthdate(date, year: year) {
				coordinator?.navigateToBirthdayConfirmation(date)
			} else {
				errorMessage = .holderBirthdayEntryInvaliddDate
			}

		} else {
			errorMessage = .holderBirthdayEntryInvaliddDate
		}
	}

	func validateBirthdate(_ date: Date, year: String?) -> Bool {

		let now = Date()
		if date > now {
			return false
		}

		if let year = year,
		   let intYear = Int(year),
		   intYear < 1900 {
			return false
		}

		return true
	}

	var day: String?
	var month: String?
	var year: String?

	func setDay(_ input: String?) {

		day = input
		setButtonState()
	}

	func setMonth(_ input: String?) {

		month = input
		setButtonState()
	}

	func setYear(_ input: String?) {

		year = input
		setButtonState()
	}

	func setButtonState() {
		guard let year = year, let month = month, let day = day,
			  !year.isEmpty, !month.isEmpty, !day.isEmpty else {
			isButtonEnabled = false
			return
		}
		isButtonEnabled = true
	}

	private lazy var parseDateFormatter: DateFormatter = {

		let dateFormatter = DateFormatter()
		dateFormatter.calendar = .current
		dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
		dateFormatter.dateFormat = "yyyy-M-d"
		return dateFormatter
	}()

	func dismiss() {

		coordinator?.dismiss()
	}
}
