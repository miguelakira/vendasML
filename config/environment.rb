# Load the rails application
require File.expand_path('../application', __FILE__)

# variavel global dos estados
ESTADOS = %w{ AC AL AP AM BA CE DF ES GO MA MT MS MG PA PB PR PE PI RJ RN RS RO RR SC SP SE TO }

# Initialize the rails application
Vendasml::Application.initialize!

