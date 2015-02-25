Pod::Spec.new do |s|
  s.name         = "VLRTextField"
  s.version      = "0.0.2"
  s.summary      = "VLRTextField enlarge floating and autocompleting text field power with input validation."

  s.description  = <<-DESC
                   This class intention is to provide an extension to the power of two great libraries on `UITextField`:

  - [`JVFloatLabeledTextField`](https://github.com/jverdi/JVFloatLabeledTextField) which purpose is to nicely display the place holder on top on the textfield when inserting text
  - [`HTAutocompleteTextField`](https://github.com/hoteltonight/HTAutocompleteTextField) which purpose is to provide autocompletion (for example: emails, company names, ...)

`VLRTextfield` adds a new layer: **validation** (for example, it is great on forms). You can then specify several check behaviors like:

  - check content with regex (@see `regex`) AND/OR
  - fill optional or not (@see `fillRequired`) AND/OR
  - minimum number of characters to enter (for example: 8 characters for password) (@see `minimumNumberOfCharacters`) AND/OR
  - custom validation block (@see `validateBlock`).

All of these tests can be run on demand or while editing.
                   DESC

  s.homepage     = "https://github.com/rezzza/VLRTextField"
  s.screenshots  = "http://i.imgur.com/9DRdZ71.png", "http://i.imgur.com/mss3Gwe.png"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "Rezzza" => "contact@verylastroom.com" }
  s.source       = { :git => "https://github.com/rezzza/VLRTextField.git", :tag => "0.0.2" }
  s.source_files = "Files/*.{h,m}"
  s.requires_arc = true
  s.platform     = 'ios'
  s.ios.deployment_target = "6.0"
  s.dependency "PPHelpMe", "~> 1.0.2"
  s.dependency "VLRJVFloatLabeledTextField", "~> 1.0.3"

end
