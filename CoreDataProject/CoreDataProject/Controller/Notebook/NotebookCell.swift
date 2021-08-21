//
//  NotebookCell.swift
//  CoreDataProject
//
//  Created by Marc Perelló Sapiña on 20/8/21.
//

import UIKit

protocol NotebookCellDelegate: AnyObject {
    func showDelete(notebook: NotebookMO)
}

class NotebookCell: UITableViewCell {
    
    weak var delegate: NotebookCellDelegate?
    
    @IBOutlet var notebookTitle: UILabel!
    @IBOutlet var notebookDate: UILabel!
    
    private var notebook: NotebookMO?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.notebookTitle.text = nil
        self.notebookDate.text = nil
        self.notebook = nil
    }
    
    func configureNotebook(notebook: NotebookMO) {
        self.notebook = notebook
        self.notebookTitle.text = notebook.title
        guard let createdAt = notebook.createdAt else { return }
        self.notebookDate.text = HelperDateFormatter.textFrom(date: createdAt)
    }
    
    @IBAction func deleteNotebook(_ sender: Any) {
        guard let notebook = notebook else { return }
        self.delegate?.showDelete(notebook: notebook)
    }
    
}
