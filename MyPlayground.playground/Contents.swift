import UIKit
import PlaygroundSupport
import Lottie

// ▼ Myplayground.playground
//   ▼ Sources
//   ▼ Resources
//     ▼ add my lottie files(*.json and image/*) here.

class MyViewController : UIViewController {

    var displayLink: CADisplayLink?
    let animationView = AnimationView(frame: .zero)
    let slider = UISlider(frame: .zero)

    override func viewDidLoad() {
        super.viewDidLoad()

        // if needed, set background color
        // view.backgroundColor = .red

        addLottieView(animationJsonFileName: "LottieLogo1", speed: 10)

        setupSlider()
        startAnimation()
    }

    private func addLottieView(animationJsonFileName: String, speed: CGFloat) {
        let animation = Animation.named(animationJsonFileName)

        animationView.animation = animation
        animationView.contentMode = .scaleAspectFit
        animationView.animationSpeed = speed
        view.addSubview(animationView)

        animationView.backgroundBehavior = .pauseAndRestore
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        animationView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        animationView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        animationView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        animationView.setContentCompressionResistancePriority(.fittingSizeLevel, for: .horizontal)
    }

    private func setupSlider() {
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.minimumValue = 0
        slider.maximumValue = 1
        slider.value = 0
        view.addSubview(slider)

        /// Slider
        slider.heightAnchor.constraint(equalToConstant: 40).isActive = true
        slider.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor).isActive = true
        slider.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor).isActive = true
        slider.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -12).isActive = true
        slider.addTarget(self, action: #selector(updateAnimation(sender:)), for: .valueChanged)
    }

    private func startAnimation() {
        animationView.reloadImages()

        displayLink = CADisplayLink(target: self, selector: #selector(animationCallback))
        displayLink?.add(to: .current,
                         forMode: RunLoop.Mode.default)
    }

    @objc func updateAnimation(sender: UISlider) {
        animationView.currentProgress = CGFloat(sender.value)
    }

    @objc func animationCallback() {
        if animationView.isAnimationPlaying {
            slider.value = Float(animationView.realtimeAnimationProgress)
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animationView.play(fromProgress: 0,
                           toProgress: 1,
                           loopMode: LottieLoopMode.loop,
                           completion: { (finished) in
                            if finished {
                                print("Animation Complete")
                            } else {
                                print("Animation cancelled")
                            }
        })
    }

}

PlaygroundPage.current.liveView = MyViewController()
