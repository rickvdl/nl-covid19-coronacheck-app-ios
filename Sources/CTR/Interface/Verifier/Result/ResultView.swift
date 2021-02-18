/*
* Copyright (c) 2021 De Staat der Nederlanden, Ministerie van Volksgezondheid, Welzijn en Sport.
*  Licensed under the EUROPEAN UNION PUBLIC LICENCE v. 1.2
*
*  SPDX-License-Identifier: EUPL-1.2
*/

import UIKit

class ResultView: BaseView {

	/// The display constants
	private struct ViewTraits {

		// Dimensions
		static let buttonHeight: CGFloat = 52
		static let buttonWidth: CGFloat = 212.0

		// Margins
		static let margin: CGFloat = 20.0
		static let largeMargin: CGFloat = UIDevice.current.isSmallScreen ? 20 : 40.0
	}

	let imageView: UIImageView = {

		let view = UIImageView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.contentMode = .center
		return view
	}()

	/// The title label
	private let titleLabel: Label = {

		return Label(title1: nil).multiline()
	}()

	/// The message label
	let messageLabel: Label = {

		return Label(body: nil).multiline()
	}()

	/// the scan button
	private let primaryButton: Button = {

		let button = Button(title: "Button 1", style: .secondary)
		button.translatesAutoresizingMaskIntoConstraints = false
		button.rounded = true
		return button
	}()

	/// setup the views
	override func setupViews() {

		super.setupViews()
		backgroundColor = .gray // Theme.colors.viewControllerBackground
		titleLabel.textAlignment = .center
		messageLabel.textAlignment = .center
		primaryButton.touchUpInside(self, action: #selector(primaryButtonTapped))
	}

	/// Setup the hierarchy
	override func setupViewHierarchy() {

		super.setupViewHierarchy()

		addSubview(imageView)
		addSubview(titleLabel)
		addSubview(messageLabel)
		addSubview(primaryButton)
	}

	/// Setup the constraints
	override func setupViewConstraints() {

		NSLayoutConstraint.activate([

			// Image
			imageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: ViewTraits.margin),
			imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
			imageView.leadingAnchor.constraint(
				equalTo: leadingAnchor,
				constant: ViewTraits.margin
			),
			imageView.trailingAnchor.constraint(
				equalTo: trailingAnchor,
				constant: -ViewTraits.margin
			),

			// Title
			titleLabel.topAnchor.constraint(
				equalTo: imageView.bottomAnchor
			),
			titleLabel.leadingAnchor.constraint(
				equalTo: leadingAnchor,
				constant: ViewTraits.margin
			),
			titleLabel.trailingAnchor.constraint(
				equalTo: trailingAnchor,
				constant: -ViewTraits.margin
			),
			titleLabel.bottomAnchor.constraint(
				equalTo: messageLabel.topAnchor,
				constant: UIDevice.current.isSmallScreen ? 0 : -ViewTraits.margin
			),

			// Message
			messageLabel.leadingAnchor.constraint(
				equalTo: leadingAnchor,
				constant: ViewTraits.largeMargin
			),
			messageLabel.trailingAnchor.constraint(
				equalTo: trailingAnchor,
				constant: -ViewTraits.largeMargin
			),

			// Button
			primaryButton.heightAnchor.constraint(equalToConstant: ViewTraits.buttonHeight),
			primaryButton.centerXAnchor.constraint(equalTo: centerXAnchor),
			primaryButton.widthAnchor.constraint(equalToConstant: ViewTraits.buttonWidth),
			primaryButton.bottomAnchor.constraint(
				equalTo: safeAreaLayoutGuide.bottomAnchor,
				constant: -ViewTraits.margin
			)
		])
	}

	var primaryTitle: String = "" {
		didSet {
			primaryButton.setTitle(primaryTitle, for: .normal)
		}
	}

	/// The  title
	var title: String? {
		didSet {
			titleLabel.text = title
		}
	}

	/// The message
	var message: String? {
		didSet {
			messageLabel.text = message
		}
	}

	/// Underline part ot the message
	/// - Parameter text: the text to underline
	func underline(_ text: String?) {

		guard let underlinedText = text,
			  let messageText = message else {
			return
		}

		let attributedUnderlined = messageText.underline(underlined: underlinedText, with: Theme.colors.dark)
		messageLabel.attributedText = attributedUnderlined
	}

	/// User tapped on the primary button
	@objc func primaryButtonTapped() {

		primaryButtonTappedCommand?()
	}

	// MARK: Public Access

	/// The user tapped on the primary button
	var primaryButtonTappedCommand: (() -> Void)?
}
