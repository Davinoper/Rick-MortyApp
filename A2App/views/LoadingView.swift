import UIKit

class LoadingView: UIView {
    
    lazy var loading: UIImageView = {
    
        loading = UIImageView(frame: CGRect(x: 100, y: 100, width: 200, height: 200))
        loading.image = UIImage(named: "Portal")
 
        return loading
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
        
        startRotationAnimation()
    }
    
    func startRotationAnimation() {
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
                rotationAnimation.fromValue = 0
                rotationAnimation.toValue = CGFloat.pi * 2.0
                rotationAnimation.duration = 4.0
                rotationAnimation.repeatCount = .infinity
                rotationAnimation.isRemovedOnCompletion = false
                
        self.loading.layer.add(rotationAnimation, forKey: "continuousRotation")
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
