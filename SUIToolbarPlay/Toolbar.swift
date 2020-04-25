//
//  Toolbar.swift
//  SUIToolbarPlay
//
//  Created by Bill So on 4/23/20.
//  Copyright © 2020 Bill So. All rights reserved.
//

import AppKit

extension NSImage.Name {
    static let calendar = "calendar"
    static let today = "clock"
}

extension NSToolbarItem.Identifier {
    static let calendar = NSToolbarItem.Identifier(rawValue: "ShowCalendar")
    static let today = NSToolbarItem.Identifier(rawValue: "GoToToday")
}

extension NSToolbar {
    static let taskListToolbar: NSToolbar = {
        let toolbar = NSToolbar(identifier: "TaskListToolbar")
        toolbar.displayMode = .iconOnly
        
        return toolbar
    }()
}

extension AppDelegate: NSToolbarDelegate {
    func toolbarDefaultItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
        [.today, .calendar]
    }
    
    func toolbarAllowedItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
        [.today, .calendar]
    }
    
    func toolbar(_ toolbar: NSToolbar, itemForItemIdentifier itemIdentifier: NSToolbarItem.Identifier, willBeInsertedIntoToolbar flag: Bool) -> NSToolbarItem? {
        switch itemIdentifier {
        case NSToolbarItem.Identifier.calendar:
            let button = NSButton(image: NSImage(named: .calendar)!, target: nil, action: nil)
            button.bezelStyle = .texturedRounded
            return customToolbarItem(itemIdentifier: .calendar, label: "Calendar", paletteLabel: "Calendar", toolTip: "Show day picker", itemContent: button)
        case NSToolbarItem.Identifier.today:
            let button = NSButton(title: "Today", target: nil, action: nil)
            button.bezelStyle = .texturedRounded
            return customToolbarItem(itemIdentifier: .calendar, label: "Today", paletteLabel: "Today", toolTip: "Go to today", itemContent: button)
        default:
            return nil
        }
    }
    
    /** Custom factory method to create NSToolbarItems.
     
         All NSToolbarItems have a unique identifier associated with them, used to tell your
         delegate/controller what toolbar items to initialize and return at various points.
         Typically, for a given identifier, you need to generate a copy of your "master" toolbar item,
         and return. The function creates an NSToolbarItem with a bunch of NSToolbarItem parameters.
     
         It's easy to call this function repeatedly to generate lots of NSToolbarItems for your toolbar.
     
         The label, palettelabel, toolTip, action, and menu can all be nil, depending upon what
         you want the item to do.
     */
    func customToolbarItem(
        itemIdentifier: NSToolbarItem.Identifier,
        label: String,
        paletteLabel: String,
        toolTip: String,
        itemContent: NSButton) -> NSToolbarItem? {
        
        let toolbarItem = NSToolbarItem(itemIdentifier: itemIdentifier)
        
        toolbarItem.label = label
        toolbarItem.paletteLabel = paletteLabel
        toolbarItem.toolTip = toolTip
        toolbarItem.target = self
        
        // Set the right attribute, depending on if we were given an image or a view.
//        if itemContent is NSImage {
//            if let image = itemContent as? NSImage {
//                toolbarItem.image = image
//            }
//        } else if itemContent is NSView {
//            if let view = itemContent as? NSView {
//                toolbarItem.view = view
//            }
//        } else {
//            assertionFailure("Invalid itemContent: object")
//        }
        toolbarItem.view = itemContent
        
        // We actually need an NSMenuItem here, so we construct one.
        let menuItem: NSMenuItem = NSMenuItem()
        menuItem.submenu = nil
        menuItem.title = label
        toolbarItem.menuFormRepresentation = menuItem
        
        return toolbarItem
    }

}
