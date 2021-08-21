//
//  NoteCell.swift
//  CoreDataProject
//
//  Created by Marc Perelló Sapiña on 20/8/21.
//

import UIKit

protocol NoteCellDelegate: AnyObject {
    func showDelete(note: NoteMO)
}

class NoteCell: UITableViewCell {
    weak var delegate: NoteCellDelegate?
    
    @IBOutlet var noteDate: UILabel!
    @IBOutlet var noteTitle: UILabel!
    
    private var note: NoteMO?
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.noteTitle.text = nil
        self.noteDate.text = nil
        self.note = nil
    }
    
    func configureNote(note: NoteMO) {
        self.note = note
        self.noteTitle.text = note.title
        guard let createdAt = note.createdAt else { return }
        self.noteDate.text = HelperDateFormatter.textFrom(date: createdAt)
    }
    
    @IBAction func deleteButtonTapped(_ sender: Any) {
        guard let note = self.note else { return }
        self.delegate?.showDelete(note: note)
    }
    
    
}
