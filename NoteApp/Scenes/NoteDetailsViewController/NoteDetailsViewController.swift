//
//  NoteDetailsViewController.swift
//  NoteApp
//
//  Created by Mariam Joglidze on 05.11.23.
//

import UIKit
protocol UpdateNoteDelegate: AnyObject {
    func changedSomeNotesToList()
}

class NoteDetailsViewController: UIViewController {
    
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
    
    private var noteDetailsTextField: UITextField = {
        let textField = UITextField()
        
        textField.backgroundColor = UIColor(hexString: "#F8F8F8")
        textField.layer.cornerRadius = 16
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private var noteTitleTextField: UITextField = {
        let textField = UITextField()
        
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
    
    private var deleteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Delete", for: .normal)
        button.addTarget(self, action: #selector(deleteItemTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var note: (String, String)?
    var noteIndex: Int?
    weak var delegate: UpdateNoteDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpStackView()
        configureViews()
    }
    
    func configureViews() {
        guard let note else { return }
        noteTitleTextField.text = note.0
        noteDetailsTextField.text = note.1
    }
    
    func setUpStackView() {
        view.addSubview(saveButton)
        view.addSubview(deleteButton)
        view.addSubview(presentStackView)
        
        presentStackView.addArrangedSubview(noteTitleTextField)
        presentStackView.addArrangedSubview(noteDetailsTextField)
        presentStackView.addArrangedSubview(saveButton)
        presentStackView.addArrangedSubview(deleteButton)
        
        NSLayoutConstraint.activate([
            presentStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            presentStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            
            noteDetailsTextField.widthAnchor.constraint(equalTo: view.widthAnchor),
            noteTitleTextField.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
    }
    
    @objc func saveItemTapped() {
        guard let title = noteTitleTextField.text, let text = noteDetailsTextField.text else { return }
        
        var savedItems = StorageManager.shared.getTupleArray() ?? []
        if let noteIndex = noteIndex {
            savedItems.remove(at: noteIndex)
            savedItems.insert((title, text), at: noteIndex)
        }
        StorageManager.shared.saveTupleArray(savedItems)
        
        delegate?.changedSomeNotesToList()
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func deleteItemTapped() {
        var savedItems = StorageManager.shared.getTupleArray() ?? []
        if let noteIndex = noteIndex {
            savedItems.remove(at: noteIndex)
        }
        StorageManager.shared.saveTupleArray(savedItems)
        
        delegate?.changedSomeNotesToList()
        self.navigationController?.popViewController(animated: true)
        
    }
}
