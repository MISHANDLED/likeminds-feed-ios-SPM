// swift-tools-version:5.7
import PackageDescription

let package = Package(
    name: "LikeMindsFeedClient",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "LikeMindsFeedCore",
            targets: ["LikeMindsFeedCore"]
        ),
        .library(
            name: "LikeMindsFeedUI",
            targets: ["LikeMindsFeedUI"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/aws-amplify/aws-sdk-ios-spm.git", from: "2.33.0"),
        .package(url: "https://github.com/mikaoj/BSImagePicker.git", from: "3.3.3"),
        .package(url: "https://github.com/firebase/firebase-ios-sdk.git", from: "8.0.0"),
        .package(url: "https://github.com/MISHANDLED/SPMSupportCheck.git", .upToNextMajor(from: "2.0.0"))
    ],
    targets: [
        .target(
            name: "LikeMindsFeedCore",
            dependencies: [
                .product(name: "AWSCore", package: "aws-sdk-ios-spm"),
                .product(name: "AWSS3", package: "aws-sdk-ios-spm"),
                .product(name: "BSImagePicker", package: "BSImagePicker"),
                .product(name: "Alamofire", package: "Alamofire"),
                .product(name: "LikeMindsFeed", package: "SPMSupportCheck"),
                .product(name: "FirebaseMessaging", package: "firebase-ios-sdk"),
                "LikeMindsFeedUI"
            ],
            path: "lm-feedCore-iOS/lm-feedCore-iOS/Source"
        ),
        .target(
            name: "LikeMindsFeedUI",
            dependencies: [],
            path: "lm-feedUI-iOS/lm-feedUI-iOS/Source",
            resources: [
                .process("Assets")
            ]
        )
    ]
)
