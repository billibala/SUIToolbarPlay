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
    
    /**
     Mostly base on Apple sample code: https://developer.apple.com/documentation/appkit/touch_bar/integrating_a_toolbar_and_touch_bar_into_your_app
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
        /**
         You don't need to set a `target` if you know what you are doing.
         
         In this example, AppDelegate is also the toolbar delegate.
         
         Since AppDelegate is not a responder, implementing an IBAction in the AppDelegate class has no effect. Try using a subclass of NSWindow or NSWindowController to implement your action methods and use them as the toolbar delegate instead.
         
         Ref: https://developer.apple.com/documentation/appkit/nstoolbaritem/1525982-target
         
         From doc:
         
         If target is nil, the toolbar will call action and attempt to invoke the action on the first responder and, failing that, pass the action up the responder chain.
         */
//        toolbarItem.target = self
//        toolbarItem.action = #selector(methodName)
        
        toolbarItem.view = itemContent
        
        // We actually need an NSMenuItem here, so we construct one.
        let menuItem: NSMenuItem = NSMenuItem()
        menuItem.submenu = nil
        menuItem.title = label
        toolbarItem.menuFormRepresentation = menuItem
        
        return toolbarItem
    }

}
