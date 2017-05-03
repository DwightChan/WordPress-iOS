import Foundation
import WordPressShared

// Extension on WPStyleGuide to use Dynamic Type fonts
//
extension WPStyleGuide {

    static let notoLoaded = { () -> Bool in
        WPFontManager.loadNotoFontFamily()
        return true
    }()

    // Default font for text displayed on a TableView
    // Use this instead of tableviewTextFont or tableviewSubtitleFont 
    // since those return UIFontTextStyleBody and that grows like crazy with Dynamic Type
    //
    static func tableViewDefaultTextFont() -> UIFont {
        return UIFont.preferredFont(forTextStyle: .callout)
    }

    // Default TableViewCell configuration method
    //
    static func configureDefaultTableViewCell(_ cell: UITableViewCell?) {
        guard let cell = cell else {
            return
        }

        cell.textLabel?.font = WPStyleGuide.tableViewDefaultTextFont()
        cell.textLabel?.sizeToFit()

        cell.detailTextLabel?.font = WPStyleGuide.tableViewDefaultTextFont()
        cell.detailTextLabel?.sizeToFit()

        cell.textLabel?.textColor = darkGrey()
        cell.detailTextLabel?.textColor = grey()

        cell.imageView?.tintColor = greyLighten10()
    }

    // Default ActionTableViewCell configuration method
    //
    static func configureDefaultTableViewActionCell(_ cell: UITableViewCell?) {
        guard let cell = cell else {
            return
        }

        configureDefaultTableViewCell(cell)
        cell.textLabel?.textColor = WPStyleGuide.tableViewActionColor()
    }

    // Default DestructiveActionTableViewCell configuration method
    //
    static func configureDefaultTableViewDestructiveActionCell(_ cell: UITableViewCell?) {
        guard let cell = cell else {
            return
        }

        configureDefaultTableViewCell(cell)
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.textColor = WPStyleGuide.errorRed()
    }

    // Configures a table to automatically resize its rows according to their content
    //
    static func configureAutomaticHeightRowsForTableView(_ tableView: UITableView) {
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = WPTableViewDefaultRowHeight
    }

    // Configures a label with the default system font with the specified style
    //
    static func configureLabel(_ label: UILabel, forTextStyle style: UIFontTextStyle) {
        label.font = UIFont.preferredFont(forTextStyle: style)
        label.adjustsFontForContentSizeCategory = true
    }

    // Configures a label with the default system font with the specified style and traits
    //
    static func configureLabel(_ label: UILabel, forTextStyle style: UIFontTextStyle, withTraits traits: UIFontDescriptorSymbolicTraits) {
        label.font = self.fontForTextStyle(style, withTraits: traits)
        label.adjustsFontForContentSizeCategory = true
    }

    // Configures a label with the default system font with the specified style and weight
    //
    static func configureLabel(_ label: UILabel, forTextStyle style: UIFontTextStyle, withWeight weight: CGFloat) {
        label.font = self.fontForTextStyle(style, withWeight: weight)
        label.adjustsFontForContentSizeCategory = true
    }

    // Configures a label with the regular Noto font with the specified style
    //
    static func configureLabelForNotoFont(_ label: UILabel, forTextStyle style: UIFontTextStyle) {
        label.font = self.notoFontForTextStyle(style)
        label.adjustsFontForContentSizeCategory = true
    }

    // Returns the default system font for the specified style and traits
    //
    static func fontForTextStyle(_ style: UIFontTextStyle, withTraits traits: UIFontDescriptorSymbolicTraits) -> UIFont {
        var fontDescriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: style)
        fontDescriptor = fontDescriptor.withSymbolicTraits(traits) ?? fontDescriptor
        return UIFont(descriptor: fontDescriptor, size: CGFloat(0.0))
    }

    // Returns the default system font for the specified style
    //
    static func fontForTextStyle(_ style: UIFontTextStyle) -> UIFont {
        let fontDescriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: style)
        return UIFont(descriptor: fontDescriptor, size: CGFloat(0.0))
    }

    // Returns the system font size for the specified style
    //
    static func fontSizeForTextStyle(_ style: UIFontTextStyle) -> CGFloat {
        let fontDescriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: style)
        let font = UIFont(descriptor: fontDescriptor, size: CGFloat(0.0))
        return font.pointSize
    }

    // Returns the system font for the specified style and weight
    //
    // Possible weight values are: UIFontWeightUltraLight, UIFontWeightThin, UIFontWeightLight,
    // UIFontWeightRegular, UIFontWeightMedium, UIFontWeightSemibold, UIFontWeightBold,
    // UIFontWeightHeavy, UIFontWeightBlack
    //
    static func fontForTextStyle(_ style: UIFontTextStyle, withWeight weight: CGFloat) -> UIFont {
        var fontDescriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: style)
        let traits = [UIFontWeightTrait: weight]
        fontDescriptor = fontDescriptor.addingAttributes([UIFontDescriptorTraitsAttribute: traits])
        return UIFont(descriptor: fontDescriptor, size: CGFloat(0.0))
    }

    // Returns the Noto Regular font for the specified style
    //
    static func notoFontForTextStyle(_ style: UIFontTextStyle) -> UIFont {
        return self.customNotoFontNamed("NotoSerif", forTextStyle: style)
    }

    // Returns the Noto Bold font for the specified style
    //
    static func notoBoldFontForTextStyle(_ style: UIFontTextStyle) -> UIFont {
        return self.customNotoFontNamed("NotoSerif-Bold", forTextStyle: style)
    }

    // Returns the Noto Italic font for the specified style
    //
    static func notoItalicFontForTextStyle(_ style: UIFontTextStyle) -> UIFont {
        return self.customNotoFontNamed("NotoSerif-Italic", forTextStyle: style)
    }

    // Returns a custom Noto font for the given name and style
    //
    static func customNotoFontNamed(_ fontName: String, forTextStyle style: UIFontTextStyle) -> UIFont {
        _ = notoLoaded
        let fontDescriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: style)
        return UIFont(name: fontName, size: fontDescriptor.pointSize)!
    }
}
