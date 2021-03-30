class Wine < ApplicationRecord
  has_many :wine_strains, dependent: :destroy
  has_many :strains, through: :wine_strains 

  accepts_nested_attributes_for :wine_strains, reject_if: lambda {|a| a[:percentage].blank?}, allow_destroy: true

end

# aqui anidamos un formulario el de wine_strains con la tabla intermedia.en el formulario de vino agregamos la informacion de la tabla intermedia. y que nos acepten los strongs params. 