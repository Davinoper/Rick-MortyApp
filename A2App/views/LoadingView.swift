
import UIKit

class LoadingView: UIView {
    
    lazy var loading: UIActivityIndicatorView = {
    
        let loadingView = UIActivityIndicatorView()
        loadingView.startAnimating()
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        loadingView.color = .systemBlue
        return loadingView
    }()
    
    lazy var labelTitle: UILabel = {
       
        let label = UILabel()
        label.text = "C A R R E G A N D O"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
        setConstraints()
    }
    
    private func initView() {
        self.backgroundColor = .green
        self.addSubview(loading)
        self.addSubview(labelTitle)
    }
    
    private func setConstraints() {
        let safeArea = self.safeAreaLayoutGuide
        let constraints:[NSLayoutConstraint] = [
            
            loading.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            loading.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor),
            
            labelTitle.centerXAnchor.constraint(equalTo: loading.centerXAnchor),
            labelTitle.topAnchor.constraint(equalTo: loading.bottomAnchor, constant: 30.0)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Erro ao carregar a view")
    }

}
