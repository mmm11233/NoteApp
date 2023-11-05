//
//  TableViewCell.swift
//  NoteApp
//
//  Created by Mariam Joglidze on 05.11.23.
//

import UIKit

class TableViewCell: UITableViewCell, UITextFieldDelegate {
    
    // MARK: - Properties
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.contentMode = .center
        return stackView
    }()
    
    private let titleTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont(name: "Helvetica-Bold", size: 16)
        textField.textColor = .black
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private let descriptionTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont(name: "Helvetica", size: 14)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        return textField
    }()
        
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .blue
        titleTextField.delegate = self
        descriptionTextField.delegate = self
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - PrepareForReuse
    override func prepareForReuse() {
        super.prepareForReuse()
        
        titleTextField.text = "dasda"
        descriptionTextField.text = nil
    }
    
    // MARK: - Configure
    func configure(with model: (String, String)) {
        //        titleTextField.becomeFirstResponder()
        titleTextField.text = model.0
        descriptionTextField.text = model.1
    }
    
    // MARK: - Private Methods
    private func setupUI() {
        setupView()
        addSubviews()
        setupConstraints()
    }
    
    private func setupView() {
        layer.shadowColor = UIColor.systemYellow.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 4
    }
    
    private func addSubviews() {
        addSubview(mainStackView)
        mainStackView.addArrangedSubview(titleTextField)
        mainStackView.addArrangedSubview(descriptionTextField)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: self.topAnchor),
            mainStackView.leftAnchor.constraint(equalTo: self.leftAnchor),
            mainStackView.rightAnchor.constraint(equalTo: self.rightAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
