//
//  NoteListViewController.swift
//  NoteApp
//
//  Created by Mariam Joglidze on 05.11.23.
//

import UIKit

class NoteListViewController: UIViewController, AddNewNoteDelegate, UpdateNoteDelegate  {
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private var notes: [(String, String)] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        view.addSubview(tableView)
        setupUI()
        updateNotes()
    }
    
    func setupUI() {
        setupTableViewConstraints()
        setupTableView()
        setUpNavBar()
    }
    
    private func setUpNavBar() {
        title = "Note List"
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItemTapped))
        navigationItem.rightBarButtonItem = addButton
    }
    
    @objc func addItemTapped() {
        let addNoteViewController = AddNoteViewController()
        addNoteViewController.delegate = self
        self.navigationController?.pushViewController(addNoteViewController, animated: true)
    }
    
    private func updateNotes() {
        if let notes = StorageManager.shared.getTupleArray() {
            self.notes = notes
        }
    }
    
    func changedSomeNotesToList() {
        updateNotes()
        tableView.reloadData()
    }
    
    func addNoteToList() {
        updateNotes()
        tableView.reloadData()
    }
    
    private func setupTableViewConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "cell")
    }
}


extension NoteListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let note = notes[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        cell.configure(with: note)
        return cell
    }
}

extension NoteListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let note = notes[indexPath.row]
        let noteDetailsViewController = NoteDetailsViewController()
        noteDetailsViewController.delegate = self
        noteDetailsViewController.note = note
        noteDetailsViewController.noteIndex = indexPath.row
        
        navigationController?.pushViewController(noteDetailsViewController, animated: true)
    }
}
