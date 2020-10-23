Swagger::Docs::Config.register_apis({
  "1.0" => {
    # the extension used for the API
    # the output location where your .json files are written to
    :api_file_path => "public/",
    # the URL base path to your API
    :base_path => ENV['URL'],
    # if you want to delete all .json files at each generation
    :clean_directory => false,
    # Ability to setup base controller for each api version. Api::V1::SomeController for example.
    :attributes => {
      :info => {
        "title" => "Cargapp API",
        "description" => "API used to cargapp administration and mobile app",
      }
    }
  }
})