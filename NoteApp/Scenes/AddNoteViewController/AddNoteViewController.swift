//
//  AddNoteViewController.swift
//  NoteApp
//
//  Created by Mariam Joglidze on 05.11.23.
//

import UIKit
protocol AddNewNoteDelegate: AnyObject {
    func addNoteToList()
}

class AddNoteViewController: UIViewController {
    
    // MARK: Properties
    private let presentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = 8
        return stackView
    }()
    
    private var noteTitleTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Add note title here"
        textField.backgroundColor = UIColor(hexString: "#F8F8F8")
        textField.layer.cornerRadius = 16
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private var noteDescriptionTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Add note content here"
        textField.backgroundColor = UIColor(hexString: "#F8F8F8")
        textField.layer.cornerRadius = 16
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private var saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Save", for: .normal)
        button.addTarget(self, action: #selector(saveItemTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    weak var delegate: AddNewNoteDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpStackView()
    }
    
    func setUpStackView() {
        view.addSubview(saveButton)
        view.addSubview(presentStackView)
        
        presentStackView.addArrangedSubview(noteTitleTextField)
        presentStackView.addArrangedSubview(noteDescriptionTextField)
        presentStackView.addArrangedSubview(saveButton)
        
        NSLayoutConstraint.activate([
            presentStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            presentStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            
            noteTitleTextField.widthAnchor.constraint(equalTo: view.widthAnchor),
            noteDescriptionTextField.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
    }
    
    @objc func saveItemTapped() {
        guard let title = noteTitleTextField.text,
              let text = noteDescriptionTextField.text else { return }
        
        if var savedItems = StorageManager.shared.getTupleArray() {
            savedItems.append((title, text))
            StorageManager.shared.saveTupleArray(savedItems)
        } else {
            StorageManager.shared.saveTupleArray([(title, text)])
        }
        delegate?.addNoteToList()
        self.navigationController?.popViewController(animated: true)
    }
}
