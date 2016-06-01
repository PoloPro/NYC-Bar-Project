class NomadBarRelocator

  def self.relocate(nomad_bar)
    nomad_bar.latitude = Faker::Base.rand_in_range(-34.0, 70.0)
    nomad_bar.longitude = Faker::Base.rand_in_range(-17.0, 142.0)
    nomad_bar.address = Faker::Address.street_address
    nomad_bar.zipcode = Faker::Address.zip
    nomad_bar.save
  end

end