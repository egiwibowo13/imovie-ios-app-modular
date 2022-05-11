# Uncomment the next line to define a global platform for your project
platform :ios, '14.0'

$source = 'https://github.com/egiwibowo13/imovie-abstract-spec'

# Comment the next line if you don't want to use dynamic frameworks
# use_frameworks!
use_modular_headers!

workspace 'iMovies Modularization'

def abstract
  pod 'Abstract', :source => $source
end

def linter
  pod 'SwiftLint'
end

def di
  pod 'Resolver'
end

def image
  pod 'SDWebImage'
  pod 'SDWebImageSwiftUI'
end

def networking
  pod 'Alamofire'
end

def crypto
  pod 'CryptoSwift'
end

def database
  pod 'RealmSwift', '~>10'
end




target 'imovie' do

  #use_frameworks!

  # Pods for imovie
  image
  linter
  di
  networking
  database
  abstract

  target 'imovieTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'imovieUITests' do
    # Pods for testing
  end
end


target 'Core' do
  project './Modules/Core/Core'
  networking
  crypto
  database
  abstract
end

target 'CommonUI' do
  project './Modules/CommonUI/CommonUI'
  image
  abstract
end

target 'Home' do
  project './Modules/Home/Home'
  networking
  image
  di
  database
  abstract
  
  target 'HomeTests' do
  end

  target 'HomeUITests' do
    pod 'Cucumberish'
  end
end


target 'Movie' do
  project './Modules/Movie/Movie'
  networking
  image
  di
  database
  abstract
  
  target 'MovieTests' do
  end
end

target 'Favorite' do
  project './Modules/Favorite/Favorite'
  image
  networking
  crypto
  database
  abstract

  target 'FavoriteTests' do
  end
end

target 'Account' do
  project './Modules/Account/Account'
  image
  abstract
  
  target 'AccountTests' do
  end
end


