import UIKit

class UIStyle {
    static let shared = UIStyle()

    let mainColor = UIColor(red: 52/255, green: 152/255, blue: 219/255, alpha: 1.0) // Blue color
    let backgroundColor = UIColor.white
    let textColor = UIColor.black
    let buttonCornerRadius: CGFloat = 8.0
    let buttonHeight: CGFloat = 50.0
    
    private init() {}
}

extension UIView {
    func applyCustomUIViewStyle() {
        let customStyle = UIStyle.shared
        self.backgroundColor = customStyle.backgroundColor
    }
}

extension UILabel {
    func applyCustomLabelStyle() {
        let customStyle = UIStyle.shared
        self.textColor = customStyle.textColor
        self.font = UIFont.systemFont(ofSize: 16.0, weight: .regular)
    }
}

extension UIButton {
    func applyCustomButtonStyle() {
        let customStyle = UIStyle.shared
        self.setTitleColor(customStyle.mainColor, for: .normal)
        self.backgroundColor = customStyle.mainColor.withAlphaComponent(0.1)
        self.layer.cornerRadius = customStyle.buttonCornerRadius
        self.titleLabel?.font = UIFont.systemFont(ofSize: 18.0, weight: .semibold)
    }
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    func setupUI() {
        view.backgroundColor = UIStyle.shared.backgroundColor

        let titleLabel = UILabel()
        titleLabel.text = "Welcome to My App"
        titleLabel.applyCustomLabelStyle()
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50.0)
        ])

        let loginButton = UIButton()
        loginButton.setTitle("Login", for: .normal)
        loginButton.applyCustomButtonStyle()
        view.addSubview(loginButton)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.heightAnchor.constraint(equalToConstant: UIStyle.shared.buttonHeight),
            loginButton.widthAnchor.constraint(equalToConstant: 200.0),
            loginButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 50.0)
        ])
    }
}
