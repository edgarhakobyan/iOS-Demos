//
//  EmojiTableViewCell.swift
//  EmojiReader
//
//  Created by Edgar on 10/25/20.
//  Copyright © 2020 Edgar. All rights reserved.
//

import UIKit

class EmojiTableViewCell: UITableViewCell {
    @IBOutlet weak var emojiLabel: UILabel!
    @IBOutlet weak var emojiName: UILabel!
    @IBOutlet weak var emojiDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func set(emoji: Emoji) {
        self.emojiLabel.text = emoji.emoji
        self.emojiName.text = emoji.name
        self.emojiDescription.text = emoji.description
    }
}
