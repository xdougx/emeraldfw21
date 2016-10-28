describe EmeraldFW  do 

  context 'Attributes' do

    it 'has a version number' do
      expect(EmeraldFW::VERSION).not_to be nil
    end

  end

  context 'Submodules' do 

  	it 'has a EmeraldFW::Entity submodule' do 
  	  expect(EmeraldFW::Entity).not_to be nil
  	end

  end

end